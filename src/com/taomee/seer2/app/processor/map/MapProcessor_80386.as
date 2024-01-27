package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.MapTitlePanel;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.VIPHelperHandle;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_80386 extends MapProcessor {


    private var _txtLeftCount:TextField;

    private var _hurtBuy:SimpleButton;

    private var _txtItemNum:TextField;

    private var _leave:SimpleButton;

    private var _miPass:SimpleButton;

    private var _npc:Mobile;

    private const FOR_HURT:uint = 205471;

    private const MI_HURT:uint = 500622;

    private const FOR_LIST:Array = [0, 205222, 0, 205224];

    private const FOR_COUNT:uint = 205469;

    private const DAY_COUNT:uint = 1564;

    private const FREE_COUNT:int = 1;

    private const MI_COUNT:uint = 605374;

    private const FOR_ITEM:uint = 205472;

    private const MI_CLEAR:uint = 605375;

    private const FIGHT_ID:uint = 1449;

    private const TYPE_CANT_USE:Vector.<int> = Vector.<int>([6, 12, 13]);

    private const TIP_POS:Point = new Point(815, 190);

    private var _itemNum:int;

    private var _leftCount:int;

    public function MapProcessor_80386(param1:MapModel) {
        super(param1);
    }

    private function get itemNum():int {
        return this._itemNum;
    }

    private function set itemNum(param1:int):void {
        this._txtItemNum.text = param1.toString();
        this._itemNum = param1;
    }

    private function get leftCount():int {
        return this._leftCount;
    }

    private function set leftCount(param1:int):void {
        this._txtLeftCount.text = param1.toString();
        this._leftCount = param1;
    }

    override public function init():void {
        this.initSet();
    }

    private function getDataHandleNormal():void {
        ActiveCountManager.requestActiveCountList([this.FOR_COUNT, this.FOR_ITEM], function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            itemNum = par.infoVec[1];
            DayLimitManager.getDoCount(DAY_COUNT, function (param1:uint):void {
                leftCount = ActsHelperUtil.getCanNum(param1, par.infoVec[0], FREE_COUNT);
            });
        });
    }

    private function initSet():void {
        this.hideLobbyMenu();
        this._txtLeftCount = _map.front["fightNum"];
        this._miPass = _map.front["miPass"];
        this._hurtBuy = _map.front["hurtBuy"];
        this._txtItemNum = _map.front["itemNum"];
        this._leave = _map.front["leave"];
        new VIPHelperHandle(_map.front["vipTip"], 2);
        this.initEvent();
        this.createNpc();
        this.getDataHandleNormal();
    }

    private function initEvent():void {
        this._miPass.addEventListener(MouseEvent.CLICK, this.onMiPass);
        this._hurtBuy.addEventListener(MouseEvent.CLICK, this.onHurtBuy);
        this._leave.addEventListener(MouseEvent.CLICK, this.onLeave);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }

    private function removeEvent():void {
        if (this._miPass) {
            this._miPass.removeEventListener(MouseEvent.CLICK, this.onMiPass);
            this._miPass = null;
        }
        if (this._hurtBuy) {
            this._hurtBuy.removeEventListener(MouseEvent.CLICK, this.onHurtBuy);
            this._hurtBuy = null;
        }
        if (this._leave) {
            this._leave.removeEventListener(MouseEvent.CLICK, this.onLeave);
            this._leave = null;
        }
    }

    private function onLeave(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        SceneManager.changeScene(SceneType.LOBBY, 70);
        TweenNano.delayedCall(2.5, function ():void {
            ModuleManager.showAppModule("FGPFallenModePanel");
        });
    }

    private function onHurtBuy(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._hurtBuy.mouseEnabled = false;
        ActiveCountManager.requestActiveCount(this.FOR_HURT, function (param1:uint, param2:uint):void {
            var t:uint = param1;
            var c:uint = param2;
            _hurtBuy.mouseEnabled = true;
            if (c > 0) {
                AlertManager.showAlert("瞳之荣耀使用完再来购买吧!");
            } else {
                ShopManager.buyItemForId(MI_HURT, function ():void {
                    ServerMessager.addMessage("快去下一场对战中使用吧！");
                });
            }
        });
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 110;
            this._npc.setPostion(new Point(794, 303));
            this._npc.resourceUrl = URLUtil.getNpcSwf(848);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "鬼瞳";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            SeatTipsManager.registerSeat(this.TIP_POS, _map.id);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var info:PetInfo = null;
        var evt:MouseEvent = param1;
        if (this.itemNum >= 100) {
            AlertManager.showAlert("你已经获得足够多的瞳影了，快去领取精灵吧!");
            return;
        }
        for each(info in PetInfoManager.getAllBagPetInfo()) {
            if (this.TYPE_CANT_USE.indexOf(info.type) != -1) {
                AlertManager.showAlert("不可携带以下系别上场：虫、光、暗影");
                return;
            }
        }
        if (this.leftCount <= 0) {
            ShopManager.buyItemForId(this.MI_COUNT, function ():void {
                FightManager.startFightWithBoss(FIGHT_ID);
            });
        } else {
            FightManager.startFightWithBoss(this.FIGHT_ID);
        }
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
            SeatTipsManager.removeSeat(this.TIP_POS, _map.id);
        }
    }

    private function onMiPass(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ShopManager.buyItemForId(this.MI_CLEAR, function ():void {
            ServerMessager.addMessage("恭喜通关喽!");
            onLeave(null);
        });
    }

    private function onComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            _loc2_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if (_loc2_ == this.FIGHT_ID) {
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
                ModuleManager.showModule(URLUtil.getAppModule("FGPFightResultPanel"), "");
            }
        }
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
        MapTitlePanel.hide();
    }

    private function onActDispose():void {
        this.clearNpc();
        this.removeEvent();
        this._txtLeftCount = null;
        this._txtItemNum = null;
        this._npc = null;
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
