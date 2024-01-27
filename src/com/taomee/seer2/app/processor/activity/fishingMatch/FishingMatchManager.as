package com.taomee.seer2.app.processor.activity.fishingMatch {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
import com.taomee.seer2.app.gameRule.fish.FishingEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.inventory.Item;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class FishingMatchManager {

    private static var _instance:FishingMatchManager;


    private var currentItem:uint;

    private var _map:MapModel;

    private var sceneArr:Array;

    private var npc:Mobile;

    private var isFirst:Boolean;

    private var parse151:Parser_1060;

    private var parse150:Parser_1060;

    private var swapData:LittleEndianByteArray;

    public function FishingMatchManager() {
        this.sceneArr = [152, 261, 220, 790];
        super();
    }

    public static function getInstance():FishingMatchManager {
        if (_instance == null) {
            _instance = new FishingMatchManager();
        }
        return _instance;
    }

    public function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.changeScene);
    }

    private function changeScene(param1:SceneEvent):void {
        FishingMatchManager.getInstance().dispose();
        FishingMatchManager.getInstance().setup();
        var _loc2_:int = int(SceneManager.active.mapID);
        if (_loc2_ == 470) {
            this.initNpc();
            return;
        }
        var _loc3_:int = 0;
        while (_loc3_ < 4) {
            if (this.sceneArr[_loc3_] == _loc2_) {
                FishEventDispatcher.getInstance().addEventListener(FishingEvent.FISHING, this.onFishing);
                break;
            }
            _loc3_++;
        }
    }

    private function initNpc():void {
        this.npc = MobileManager.getMobile(443, MobileType.NPC);
        this.npc.addOverHeadMark(new AcceptableMark());
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
    }

    private function onNpc(param1:NpcEvent):void {
        if (param1.npcDefinition.id != 443) {
            return;
        }
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        param1.npcDefinition.resetFunctionalityData();
        var _loc2_:XML = <node type="quest" name="钓鱼大赛" params="fishingMatch"/>;
        var _loc3_:XML = <node type="quest" name="提交大赛鱼" params="getReward"/>;
        param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 0);
        param1.npcDefinition.addFunctionalityUnitAt(_loc3_, 1);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
    }

    private function getItemNum():void {
        var _loc1_:int = 0;
        var _loc2_:int = 400813;
        while (_loc2_ < 400817) {
            if (ItemManager.getItemQuantityByReferenceId(_loc2_) > 0) {
                _loc1_++;
            }
            _loc2_++;
        }
        if (_loc1_ == 4) {
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult151);
            Connection.send(CommandSet.DIGGER_MINE_1060, 151);
        } else {
            AlertManager.showAlert("你的鱼还没有收集齐，收集齐了再来找我吧！");
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        if (param1.content.params == "getReward") {
            Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, this.onDailyLimitHandler);
            Connection.send(CommandSet.DAILY_LIMIT_1065, 429);
        } else if (param1.content.params == "fishingMatch") {
            ModuleManager.toggleModule(URLUtil.getAppModule("FishingMatchPanel"), "钓鱼大赛");
        }
    }

    private function onDailyLimitHandler(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onDailyLimitHandler);
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawData());
        if (_loc2_.count > 0) {
            AlertManager.showAlert("你今天已经参加过比赛了，明天再来吧。");
        } else {
            ItemManager.requestItemList(this.getItemNum);
        }
    }

    private function getFirstInfo(param1:MessageEvent):void {
        this.isFirst = false;
        Connection.removeCommandListener(CommandSet.GET_DAYLIMIT_INFO_1220, this.getFirstInfo);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        if (_loc3_ == ActorManager.actorInfo.id) {
            Connection.addCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
            Connection.send(CommandSet.ITEM_EXCHANGE_1055, 450, 1, 0);
            this.isFirst = true;
        } else {
            this.alertResult();
        }
    }

    private function alertResult():void {
        if (this.isFirst) {
            AlertManager.showAlert("恭喜你获得今天钓鱼大赛的第一名,点击确定领取大奖吧！", function ():void {
                parse150.showResult(true);
                var _loc1_:SwapInfo = new SwapInfo(swapData);
                parse151.showResult(true);
            });
        } else {
            AlertManager.showAlert("恭喜你获得今天钓鱼大赛的参与奖,点击确定领取大奖吧！", function ():void {
                parse151.showResult(true);
            });
        }
    }

    private function showResult150(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult150);
        var _loc2_:IDataInput = param1.message.getRawData();
        this.parse150 = new Parser_1060(_loc2_);
        this.alertResult();
    }

    private function onGetReward(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult150);
        Connection.send(CommandSet.DIGGER_MINE_1060, 150);
        this.swapData = param1.message.getRawData();
    }

    private function showResult151(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult151);
        var _loc2_:IDataInput = param1.message.getRawData();
        this.parse151 = new Parser_1060(_loc2_);
        Connection.addCommandListener(CommandSet.GET_DAYLIMIT_INFO_1220, this.getFirstInfo);
        Connection.send(CommandSet.GET_DAYLIMIT_INFO_1220, 1, 1);
    }

    public function dispose():void {
        FishEventDispatcher.getInstance().removeEventListener(FishingEvent.FISHING, this.onFishing);
        Connection.removeCommandListener(CommandSet.ITEM_EXCHANGE_1055, this.onGetReward);
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult151);
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onDailyLimitHandler);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.changeScene);
        this._map = null;
        if (this.npc) {
            this.npc.removeOverHeadMark();
        }
        this.currentItem = 0;
    }

    private function onFishing(param1:FishingEvent):void {
        this.currentItem = param1.itemId;
        ItemManager.requestItemList(this.checkFishNum);
    }

    private function checkFishNum():void {
        var item:Item = null;
        var fishNum:int = 0;
        var i:int = 400813;
        while (i < 400817) {
            if (ItemManager.getItemQuantityByReferenceId(i) > 0) {
                fishNum++;
            }
            i++;
        }
        if (fishNum == 4) {
            AlertManager.showConfirm("你已经将埃卡维特需要的鱼收集齐全了，马上去找他吧。", function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 470);
            });
        } else {
            if (this.currentItem < 400813 || this.currentItem > 400816) {
                return;
            }
            item = ItemManager.getItemByReferenceId(this.currentItem);
            AlertManager.showConfirm("成功钓到任务鱼" + item.name + "赶紧去其它钓鱼点钓取其它任务鱼吧！", function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("FishingMatchPanel"), "钓鱼大赛面板!");
            });
        }
    }
}
}
