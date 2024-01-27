package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_80364 extends MapProcessor {


    public var _mc:MovieClip;

    public var _callBack:Function = null;

    private var _npc:Mobile;

    private var dayLimit:int = 1503;

    private var foreverLimit:Array;

    private var fightID:Array;

    private var MAXPIECE:int = 100;

    private var MAXHARM:int = 300000;

    private var fightCount:int;

    private var buyCount:int;

    private var isGetStone:int;

    private var pieceNum:int;

    private var harmVaule:int;

    private var oneHarmVaule:int;

    private var _harmMc:MovieClip;

    private var _swapMc:MovieClip;

    private var _exitTipMc:MovieClip;

    private var _buyBuffBtn:SimpleButton;

    public function MapProcessor_80364(param1:MapModel) {
        this.foreverLimit = [205263, 205264, 205265, 205266, 205268, 205269];
        this.fightID = [1412];
        super(param1);
    }

    override public function init():void {
        RightToolbarConter.instance.hide();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                this.LoadSource(this.initMc);
            }
        } else {
            SwapManager.swapItem(3501, 1, function (param1:IDataInput):void {
            });
            TweenNano.delayedCall(0.5, function ():void {
                LoadSource(initMc);
            });
        }
        this.createNpc();
    }

    private function initMc():void {
        this._harmMc = this.getMc("harmMc");
        this._swapMc = this.getMc("swapMc");
        this._exitTipMc = this.getMc("exitTipMc");
        this._exitTipMc.visible = false;
        this._buyBuffBtn = this.getBtn("buyBuffBtn");
        _map.front.addChild(this._harmMc);
        _map.front.addChild(this._swapMc);
        _map.front.addChild(this._exitTipMc);
        _map.front.addChild(this._buyBuffBtn);
        SimpleButton(this._swapMc["swapBtn"]).addEventListener(MouseEvent.CLICK, this.onSwapStone);
        SimpleButton(this._harmMc["exitBtn"]).addEventListener(MouseEvent.CLICK, this.onExit);
        SimpleButton(this._exitTipMc["closeBtn"]).addEventListener(MouseEvent.CLICK, this.onCloseTip);
        SimpleButton(this._exitTipMc["addBtn"]).addEventListener(MouseEvent.CLICK, this.onAddCount);
        SimpleButton(this._exitTipMc["overBtn"]).addEventListener(MouseEvent.CLICK, this.onOverFight);
        this._buyBuffBtn.addEventListener(MouseEvent.CLICK, this.onBuyBuff);
        this.update();
    }

    private function onBuyBuff(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(500621, function (param1:*):void {
        });
    }

    private function onOverFight(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        SwapManager.swapItem(3502, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            RightToolbarConter.instance.show();
            SceneManager.changeScene(SceneType.LOBBY, 70);
            ModuleManager.showAppModule("SilverRiverOutputPanel");
        });
    }

    private function onAddCount(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(605307, function (param1:*):void {
            update();
        });
    }

    private function onCloseTip(param1:MouseEvent):void {
        this._exitTipMc.visible = false;
    }

    private function update():void {
        ActiveCountManager.requestActiveCountList(this.foreverLimit, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            pieceNum = par.infoVec[0];
            isGetStone = par.infoVec[1];
            harmVaule = par.infoVec[2];
            buyCount = par.infoVec[3];
            oneHarmVaule = par.infoVec[4];
            DayLimitManager.getDoCount(dayLimit, function (param1:int):void {
                fightCount = ActsHelperUtil.getCanNum(param1, buyCount, 3);
                updateShow();
            });
        });
    }

    private function updateShow():void {
        this._exitTipMc.harmTxt.text = this.harmVaule.toString();
        this._harmMc.harmTxt.text = this.harmVaule.toString();
        this._harmMc.turnTxt.text = this.fightCount.toString();
        this._swapMc.pieceTxt.text = this.pieceNum + "/" + this.MAXPIECE;
        this._swapMc.bar.scaleX = this.pieceNum / this.MAXPIECE > 1 ? 1 : this.pieceNum / this.MAXPIECE;
        if (this.isGetStone > 0) {
            DisplayObjectUtil.disableButton(SimpleButton(this._swapMc["swapBtn"]));
        } else if (this.pieceNum >= this.MAXPIECE) {
            DisplayObjectUtil.enableButton(SimpleButton(this._swapMc["swapBtn"]));
        } else {
            DisplayObjectUtil.disableButton(SimpleButton(this._swapMc["swapBtn"]));
        }
    }

    private function onSwapStone(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        SwapManager.swapItem(3503, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            RightToolbarConter.instance.show();
            SceneManager.changeScene(SceneType.LOBBY, 70);
            ModuleManager.showAppModule("SilverRiverOutputPanel");
        });
    }

    private function onExit(param1:MouseEvent):void {
        this._exitTipMc.visible = true;
    }

    override public function dispose():void {
        RightToolbarConter.instance.show();
        _map.front.removeChild(this._harmMc);
        _map.front.removeChild(this._swapMc);
        _map.front.removeChild(this._exitTipMc);
        _map.front.removeChild(this._buyBuffBtn);
    }

    public function LoadSource(param1:Function = null):void {
        this._callBack = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("silverriver"), LoadType.SWF, this.onLoadComplete, null, null, 2);
    }

    private function onLoadComplete(param1:ContentInfo):void {
        this._mc = param1.content as MovieClip;
        if (this._callBack != null) {
            this._callBack();
        }
    }

    public function getMc(param1:String):MovieClip {
        return this._mc[param1];
    }

    public function getBtn(param1:String):SimpleButton {
        return this._mc[param1];
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(500, 400));
            this._npc.resourceUrl = URLUtil.getNpcSwf(834);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onFight);
        }
    }

    private function onFight(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this.fightCount > 0) {
            FightManager.startFightWithWild(this.fightID[0]);
        } else {
            ShopManager.buyItemForId(605307, function (param1:*):void {
                update();
            });
        }
    }
}
}
