package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootGridPanel;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MeshBeastReviveManager {

    private static var _instance:MeshBeastReviveManager;


    private var followNum:int;

    public var rewardCount:int;

    public var preTimeArr:Array;

    public var shootIndex:int;

    private var carriedArr:Vector.<Mobile>;

    private var petMap:Array;

    private var pretendPetVec:Vector.<MovieClip>;

    private var appearsPet:MovieClip;

    private var followPet:MovieClip;

    private var escapePet:MovieClip;

    private var _map:MapModel;

    private var npc:Mobile;

    private var startP:int;

    private var currNum:int;

    public function MeshBeastReviveManager() {
        this.preTimeArr = [0, 0, 0];
        this.petMap = [90, 123, 124];
        this.pretendPetVec = new Vector.<MovieClip>(3);
        super();
    }

    public static function get instance():MeshBeastReviveManager {
        if (!_instance) {
            _instance = new MeshBeastReviveManager();
        }
        return _instance;
    }

    public function setup():void {
        this.carriedArr = new Vector.<Mobile>();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
        if (Boolean(DateUtil.isInHourScope(13, 14, 30, 30)) && Boolean(DateUtil.isDay(2012, 8, 17))) {
            ServerBufferManager.getServerBuffer(ServerBufferType.MESH_QUEST, this.getFollowNum);
            ShootController.addEventListener(ShootEvent.PLAY_END, this.chekTarget);
        }
    }

    private function dispose():void {
        this.carriedArr = null;
        this.petMap = null;
        this._map = null;
        this.npc = null;
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
    }

    private function onMapSwitchComplete(param1:SceneEvent):void {
        var _loc2_:Date = null;
        if (Boolean(DateUtil.isInHourScope(13, 14, 30, 30)) && Boolean(DateUtil.isDay(2012, 8, 17))) {
            this._map = SceneManager.active.mapModel;
            if (this._map.id == 100) {
                this.initMap100();
            }
            if (this.petMap.indexOf(this._map.id) != -1) {
                this.initMapPet();
            }
        } else {
            _loc2_ = new Date(2012, 8, 17, 14, 30);
            if (TimeManager.getServerTime() * 1000 > _loc2_.getTime()) {
                this.dispose();
            }
        }
    }

    private function getFollowNum(param1:ServerBuffer):void {
        this.rewardCount = param1.readDataAtPostion(0);
        this.followNum = param1.readDataAtPostion(1);
        this.createFollowPet();
    }

    private function createFollowPet():void {
        var _loc2_:Mobile = null;
        if (ActorManager.getActor().hasFollowingPet()) {
            this.startP = 100;
        }
        var _loc1_:int = 0;
        while (_loc1_ < this.followNum) {
            _loc2_ = new Mobile();
            _loc2_.resourceUrl = URLUtil.getPetSwf(252);
            this.carriedArr.push(_loc2_);
            ActorManager.getActor().addCarriedMobile(_loc2_, this.startP + 30 * _loc1_);
            _loc1_++;
        }
    }

    private function initMapPet():void {
        if (!this.pretendPetVec[0]) {
            QueueLoader.load(URLUtil.getQuestAnimation("sceneAnimation/30025"), LoadType.SWF, this.onResLoaded);
        } else {
            this.addPetToMap();
        }
    }

    private function chekTarget(param1:ShootEvent):void {
        var _loc3_:int = 0;
        if (!this.pretendPetVec[0] || this._map.id == 100) {
            return;
        }
        var _loc2_:ShootInfo = param1.info;
        if (_loc2_.userID == ActorManager.actorInfo.id && _loc2_.id == 8) {
            _loc3_ = 0;
            while (_loc3_ < this.pretendPetVec.length) {
                if (this.pretendPetVec[_loc3_].hitTestPoint(_loc2_.endPos.x, _loc2_.endPos.y)) {
                    ShootController.close();
                    ShootGridPanel.instance.hide();
                    DisplayUtil.removeForParent(this.pretendPetVec[_loc3_]);
                    this.appearsPet.x = this.pretendPetVec[_loc3_].x;
                    this.appearsPet.y = this.pretendPetVec[_loc3_].y;
                    this._map.content.addChild(this.appearsPet);
                    MovieClipUtil.playMc(this.appearsPet, 1, this.appearsPet.totalFrames, this.playResult, true);
                    break;
                }
                _loc3_++;
            }
        }
    }

    private function playResult():void {
        var resultNum:int = Math.random() * 2;
        if (resultNum == 0) {
            if (this.followNum >= 5) {
                AlertManager.showAlert("你不能携带更多的精灵了，快去信奉广场交给目灵兽吧。");
                return;
            }
            DisplayUtil.removeForParent(this.appearsPet);
            this.followPet.x = this.appearsPet.x;
            this.followPet.y = this.appearsPet.y;
            this._map.content.addChild(this.followPet);
            MovieClipUtil.playMc(this.followPet, 1, this.followPet.totalFrames, function ():void {
                DisplayUtil.removeForParent(followPet);
                ++followNum;
                ServerBufferManager.updateServerBuffer(ServerBufferType.MESH_QUEST, 1, followNum);
                var _loc1_:Mobile = new Mobile();
                _loc1_.resourceUrl = URLUtil.getPetSwf(252);
                carriedArr.push(_loc1_);
                ActorManager.getActor().addCarriedMobile(_loc1_, startP + 30 * (carriedArr.length - 1));
                ModuleManager.toggleModule(URLUtil.getAppModule("MeshBeastPanel"), "打开中");
            }, true);
        } else {
            DisplayUtil.removeForParent(this.appearsPet);
            this.escapePet.x = this.appearsPet.x;
            this.escapePet.y = this.appearsPet.y;
            this._map.content.addChild(this.escapePet);
            MovieClipUtil.playMc(this.escapePet, 1, this.escapePet.totalFrames, function ():void {
                DisplayUtil.removeForParent(escapePet);
            }, true);
        }
    }

    private function onResLoaded(param1:ContentInfo):void {
        var _loc2_:int = 0;
        while (_loc2_ < this.pretendPetVec.length) {
            this.pretendPetVec[_loc2_] = DomainUtil.getMovieClip("PretendPet", param1.domain);
            this.pretendPetVec[_loc2_].addEventListener(MouseEvent.CLICK, this.onTips);
            _loc2_++;
        }
        this.appearsPet = DomainUtil.getMovieClip("AppearsPet", param1.domain);
        this.escapePet = DomainUtil.getMovieClip("EscapePet", param1.domain);
        this.followPet = DomainUtil.getMovieClip("FollowPet", param1.domain);
        this.addPetToMap();
    }

    private function addPetToMap():void {
        var _loc1_:int = 0;
        while (_loc1_ < this.pretendPetVec.length) {
            this.pretendPetVec[_loc1_].gotoAndPlay(int(Math.random() * 100));
            this._map.content.addChild(this.pretendPetVec[_loc1_]);
            _loc1_++;
        }
        if (this._map.id == 90) {
            this.pretendPetVec[0].x = 174;
            this.pretendPetVec[0].y = 334;
            this.pretendPetVec[1].x = 520;
            this.pretendPetVec[1].y = 310;
            this.pretendPetVec[2].x = 666;
            this.pretendPetVec[2].y = 400;
        }
        if (this._map.id == 123) {
            this.pretendPetVec[0].x = 270;
            this.pretendPetVec[0].y = 370;
            this.pretendPetVec[1].x = 590;
            this.pretendPetVec[1].y = 290;
            this.pretendPetVec[2].x = 750;
            this.pretendPetVec[2].y = 310;
        }
        if (this._map.id == 124) {
            this.pretendPetVec[0].x = 390;
            this.pretendPetVec[0].y = 300;
            this.pretendPetVec[1].x = 590;
            this.pretendPetVec[1].y = 190;
            this.pretendPetVec[2].x = 650;
            this.pretendPetVec[2].y = 430;
        }
    }

    protected function onTips(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(18, "斯力普", [[0, "打开头部射击功能，用深海漩涡射击它试试看。（到我这里可以领取深海漩涡道具哦”）"]], ["领取深海漩涡道具", "知道了"], [function ():void {
            ItemManager.requestItemList(getNum1);
        }]);
    }

    private function initMap100():void {
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onQuestDia);
        var _loc1_:XML = <npc id="406" resId="406" name="目灵兽" dir="0" width="166" height="203" pos="475,320"
                              actorPos="700,310" path=""/>;
        this.npc = MobileManager.createNpc(new NpcDefinition(_loc1_));
        this.npc.buttonMode = true;
        this.npc.addEventListener(MouseEvent.CLICK, this.showNpcDia);
        if (this.followNum > 0) {
            this.npc.addOverHeadMark(new AcceptableMark());
        }
        ItemManager.requestItemList(this.getNum);
    }

    private function showNpcDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this.followNum == 0) {
            NpcDialog.show(406, "目灵兽", [[0, "我依然感觉很虚弱…也许只有神秘精灵的歌声才能让我完全恢复。"]], ["好的！"]);
        } else {
            NpcDialog.show(406, "目灵兽", [[0, "这种歌声让我感觉体内的能量在慢慢的提升，去带来更多的精灵吧。我感觉我就快完全恢复了！"]], ["好的！"], [function ():void {
                npc.removeOverHeadMark();
                updateCount();
                ModuleManager.toggleModule(URLUtil.getAppModule("MeshBeastPanel"), "打开中");
            }]);
        }
    }

    private function onQuestDia(param1:NpcEvent):void {
        var _loc2_:XML = null;
        if (param1.npcDefinition.id == 18) {
            _loc2_ = <node type="quest" name="领取道具（目灵兽的复苏）" params="getBullet"/>;
            param1.npcDefinition.resetFunctionalityData();
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 0);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function updateCount():void {
        this.rewardCount += this.carriedArr.length;
        var _loc1_:int = 0;
        while (_loc1_ < this.carriedArr.length) {
            ActorManager.getActor().removeCarriedMobile(this.carriedArr[_loc1_]);
            _loc1_++;
        }
        this.carriedArr.length = 0;
        this.followNum = 0;
        ServerBufferManager.updateServerBuffer(ServerBufferType.MESH_QUEST, 0, this.rewardCount);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MESH_QUEST, 1, this.followNum);
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == "getBullet") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            NpcDialog.show(18, "斯力普", [[0, "这是伊娃博士交给我的新发明深海漩涡，带上它用头部射击可疑的东西，能够让一切伪装还原。"]], ["领取20颗", "骗人的吧"], [function ():void {
                ItemManager.requestItemList(getNum1);
            }]);
        }
    }

    private function getNum1():void {
        this.currNum = ItemManager.getItemQuantityByReferenceId(400227);
        if (this.currNum > 10) {
            AlertManager.showAlert("背包最多容纳30颗,容量不足，使用后再来找我吧！");
        } else {
            SwapManager.swapItem(534, 1, this.onSwapSuccess);
        }
    }

    private function getNum():void {
        var _loc1_:Mobile = null;
        this.currNum = ItemManager.getItemQuantityByReferenceId(400227);
        if (this.currNum < 10) {
            _loc1_ = MobileManager.getMobile(18, MobileType.NPC);
            _loc1_.addOverHeadMark(new AcceptableMark());
        }
    }

    private function onSwapSuccess(param1:IDataInput):void {
        var data:IDataInput = param1;
        var swapInfo:SwapInfo = new SwapInfo(data);
        NpcDialog.show(18, "斯力普", [[0, "放在你的射击工具栏啦，对着荆棘小道，异蘑谷、草系主城场景中可疑的东西射击，就有机会找到神秘草系精灵"]], ["好的我去试试看吧！"], [function ():void {
            if (petMap.indexOf(_map.id) == -1) {
                SceneManager.changeScene(SceneType.LOBBY, petMap[int(Math.random() * 3)]);
            }
        }]);
    }
}
}
