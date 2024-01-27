package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_80497 extends MapProcessor {

    private static const FOR_LIST:Array = [206197];

    private static const DAY_LIST:Array = [1850, 1848, 1849];

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([606772]);

    private static const FIGHT_INDEX:int = 1736;


    private var gameCount:int;

    private var _openVip:SimpleButton;

    private var _buyHurtItem:SimpleButton;

    private var _openHelp:SimpleButton;

    private var _leave:SimpleButton;

    private var _hurtNum:TextField;

    private var _npc:Mobile;

    private var _par:Parser_1142;

    private var _info:DayLimitListInfo;

    public function MapProcessor_80497(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.moDiActInit();
    }

    private function moDiActInit():void {
        this.initSet();
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                    var par:Parser_1142 = param1;
                    _info = info;
                    _par = par;
                    _hurtNum.text = _info.getCount(DAY_LIST[0]).toString();
                    gameCount = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[1]), info.getCount(DAY_LIST[2]), 1);
                    if (gameCount > 0) {
                        initAct();
                    } else {
                        TweenNano.delayedCall(1.5, function ():void {
                            ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                        });
                    }
                });
            });
        } else {
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                    _info = info;
                    _par = param1;
                    _hurtNum.text = _info.getCount(DAY_LIST[0]).toString();
                    gameCount = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[1]), info.getCount(DAY_LIST[2]), 1);
                    if (gameCount > 0) {
                        initAct();
                    }
                });
            });
        }
    }

    private function initAct():void {
        this.initEvent();
        this.createNpc();
    }

    private function initSet():void {
        this._openVip = _map.front["openVip"];
        this._buyHurtItem = _map.front["buyHurtItem"];
        this._openHelp = _map.front["openHelp"];
        this._leave = _map.front["leave"];
        this._hurtNum = _map.front["hurtNum"];
        this.hideLobbyMenu();
    }

    private function initEvent():void {
        this._openVip.addEventListener(MouseEvent.CLICK, this.onOpenVip);
        this._buyHurtItem.addEventListener(MouseEvent.CLICK, this.onBuyHurtItem);
        this._openHelp.addEventListener(MouseEvent.CLICK, this.onOpenHelp);
        this._leave.addEventListener(MouseEvent.CLICK, this.onLeave);
    }

    private function onLeave(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("SaTeActDoorThreeLeaveTipPanel"), "正在打开面板...", {"hurtNum": int(this._hurtNum.text)});
    }

    private function onBuyHurtItem(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, function itemHandle(param1:ItemEvent):void {
            var miNum:int;
            var evt:ItemEvent = param1;
            ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, itemHandle);
            miNum = ItemManager.getSpecialItem(MI_ID_LIST[0]) != null ? int(ItemManager.getSpecialItem(MI_ID_LIST[0]).quantity) : 0;
            if (miNum > 0) {
                AlertManager.showAlert("使用完后再来买吧。");
            } else {
                AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻购买此物品吗?", function ():void {
                    PayManager.buyItem(MI_ID_LIST[0], function ():void {
                    });
                });
            }
        });
        ItemManager.requestSpecialItemList(true);
    }

    private function onOpenHelp(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("MedicineShopPanel"), "正在打开面板...");
    }

    private function onOpenVip(param1:MouseEvent):void {
        VipManager.openVip();
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function moDiActDipose():void {
        this.clearNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 140;
            this._npc.setPostion(new Point(620, 470));
            this._npc.resourceUrl = URLUtil.getNpcSwf(3086);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "萨特";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(3086, "萨特", [[0, "我就是绝望之主·萨特！ 绝望来袭受死吧！"]], ["我不怕！", "我好怕你"], [function ():void {
            if (gameCount <= 0) {
                ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                SceneManager.changeScene(SceneType.LOBBY, 70);
                return;
            }
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    override public function dispose():void {
        this.moDiActDipose();
        super.dispose();
    }
}
}
