package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.KingCarZhangManager;
import com.taomee.seer2.app.actives.NpcChallenge;
import com.taomee.seer2.app.activity.processor.PrizeCeremony.Map160Prize;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.guoNianFangBianPao.GuoNianBianPao;
import com.taomee.seer2.app.processor.activity.heroTieAct.HeroTieAct;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class MapProcessor_160 extends TitleMapProcessor {


    private var _starHide:MovieClip;

    private var _bubbleMountain:MovieClip;

    private var _glowRock:MovieClip;

    private var _scrollOpen:MovieClip;

    private var _PrizeMC:Map160Prize;

    private var _npc24:Mobile;

    private const ACTION_STAND:String = "站立";

    private var bianpao:GuoNianBianPao;

    private var _kingCar:KingCarZhangManager;

    private var mcCar:MovieClip;

    private var index:int;

    private var _heroTieAct:HeroTieAct;

    private var _scrollCloseBtn:SimpleButton;

    private var _handbook:MovieClip;

    private var npc:Mobile;

    public function MapProcessor_160(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initStar();
        this.initMountain();
        this.initRock();
        this.initScroll();
        this.initHandbook();
        this.iniNpc();
        StatisticsManager.sendNovice(StatisticsManager.map_entry_160);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_133);
        this._kingCar = new KingCarZhangManager(_map);
    }

    private function addKingChar():void {
        if (KingCarZhangManager.go == -1) {
            _map.content["newCar"].visible = false;
            return;
        }
        if (KingCarZhangManager.dayState[KingCarZhangManager.go]) {
            _map.content["newCar"].visible = false;
            KingCarZhangManager.go = -1;
            return;
        }
        _map.content["newCar"].visible = true;
        this.index = KingCarZhangManager.go;
        KingCarZhangManager.go = 0;
        this.mcCar = _map.content["newCar"];
        this.mcCar.gotoAndStop(1);
        this.mcCar.addEventListener(MouseEvent.CLICK, this.onMouseCar);
        this.mcCar.mouseChildren = false;
        this.mcCar.buttonMode = true;
        MovieClipUtil.playMc(this.mcCar, 1, this.mcCar.totalFrames, function ():void {
            mcCar.gotoAndStop(mcCar.totalFrames);
        }, true);
    }

    private function onMouseCar(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this.mcCar.currentFrame == this.mcCar.totalFrames) {
            SwapManager.swapItem(KingCarZhangManager.CarSwap, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                mcCar.visible = false;
                ModuleManager.closeForName("KingCarZhangPanel");
                ModuleManager.showModule(URLUtil.getAppModule("KingCarZhangSmallPanel"), "打开保护的面板...");
            }, null, new SpecialInfo(1, this.index));
            this.mcCar.removeEventListener(MouseEvent.CLICK, this.onMouseCar);
        }
    }

    private function initHeroTieAct():void {
        this._heroTieAct = new HeroTieAct(_map);
    }

    private function disposeHeroTieAct():void {
        if (this._heroTieAct) {
            this._heroTieAct.dispose();
            this._heroTieAct = null;
        }
    }

    private function initGuoNianBianPao():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.month == 1 && (_loc1_.date >= 6 && _loc1_.date <= 13)) {
            this.bianpao = new GuoNianBianPao(this._map);
            this.bianpao.initBianPao();
        }
    }

    private function iniNpc():void {
        NpcChallenge.getInstance().init(24, [237, 238, 239]);
        this._npc24 = MobileManager.getMobile(24, MobileType.NPC);
        if (this._npc24 != null) {
            this._npc24.action = this.ACTION_STAND;
        }
        this.npc = MobileManager.getMobile(23, MobileType.NPC);
        this.npc.addEventListener(MouseEvent.CLICK, this.clickNpc, false, 10);
    }

    protected function clickNpc(param1:MouseEvent):void {
        this.npc.removeEventListener(MouseEvent.CLICK, this.clickNpc);
        SeatTipsManager.removeSeat(new Point(730, 130), 160);
    }

    private function initStar():void {
        this._starHide = _map.content["starHide"];
        initInteractor(this._starHide);
        this._starHide.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function initPrizeMC():void {
        if (DateUtil.inInDateScope(5, 14, 11, 14, 21)) {
            this._PrizeMC = new Map160Prize();
        }
    }

    private function initMountain():void {
        this._bubbleMountain = _map.content["bubbleMountain"];
        initInteractor(this._bubbleMountain);
        this._bubbleMountain.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        closeInteractor(_loc2_);
        _loc2_.gotoAndStop(2);
        _loc2_.removeEventListener(MouseEvent.CLICK, this.onClick);
        _loc2_.addEventListener(Event.ENTER_FRAME, this.onCurrentFrame);
    }

    private function onCurrentFrame(param1:Event):void {
        var _loc3_:MovieClip = null;
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_["currentStarHide"]) {
            _loc3_ = _loc2_["currentStarHide"];
            _loc2_.removeEventListener(Event.ENTER_FRAME, this.onCurrentFrame);
            _loc3_.addFrameScript(15, this.reward);
        }
    }

    private function reward():void {
        if (SwapManager.isSwapNumberMax(4)) {
            SwapManager.entrySwap(4);
        }
    }

    private function initHandbook():void {
        this._handbook = _map.content["handbook"];
        this._scrollCloseBtn = this._handbook["closeBtn"];
        DisplayObjectUtil.enableButton(this._scrollCloseBtn);
        this._handbook.visible = false;
        this._scrollCloseBtn.addEventListener(MouseEvent.CLICK, this.onHandbookClose);
    }

    private function onHandbookClose(param1:MouseEvent):void {
        this._handbook.visible = false;
        this._scrollOpen.gotoAndStop(1);
        LayerManager.resetOperation();
        initInteractor(this._scrollOpen);
    }

    private function initScroll():void {
        this._scrollOpen = _map.content["scrollOpen"];
        initInteractor(this._scrollOpen);
        this._scrollOpen.addEventListener(MouseEvent.CLICK, this.onScrollClick);
    }

    private function onScrollClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.target as MovieClip;
        if (_loc2_.currentFrame == 1) {
            closeInteractor(_loc2_);
            _loc2_.gotoAndStop(2);
            _loc2_.addEventListener(Event.FRAME_CONSTRUCTED, this.onScrollFrameConstructed);
        } else {
            initInteractor(_loc2_);
            _loc2_.gotoAndStop(1);
            LayerManager.resetOperation();
            this._handbook.visible = false;
        }
    }

    private function onScrollFrameConstructed(param1:Event):void {
        var _loc3_:MovieClip = null;
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.removeEventListener(Event.FRAME_CONSTRUCTED, this.onScrollFrameConstructed);
        if (_loc2_.currentFrame == 2) {
            _loc3_ = _loc2_.getChildByName("scrollMc") as MovieClip;
            _loc3_.addEventListener(Event.ENTER_FRAME, this.onScrollChildEnterFrame);
        }
    }

    private function onScrollChildEnterFrame(param1:Event):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        if (_loc2_.currentFrame == _loc2_.totalFrames) {
            _loc2_.stop();
            LayerManager.focusOnTopLayer();
            this._handbook.visible = true;
            LayerManager.topLayer.addChild(this._handbook);
            initInteractor(this._scrollOpen);
            _loc2_.removeEventListener(Event.ENTER_FRAME, this.onScrollChildEnterFrame);
        }
    }

    private function initRock():void {
        this._glowRock = _map.content["glowRock"];
        initInteractor(this._glowRock);
        TooltipManager.addGameTip(this._glowRock, "奇妙的宝石");
        this._glowRock.addEventListener(MouseEvent.MOUSE_OVER, this.onRockOver);
        this._glowRock.addEventListener(MouseEvent.MOUSE_OUT, this.offRockOver);
        this._glowRock.addEventListener(MouseEvent.CLICK, this.onRockClick);
    }

    private function onRockOver(param1:MouseEvent):void {
        this._glowRock.gotoAndStop(2);
    }

    private function offRockOver(param1:MouseEvent):void {
        this._glowRock.gotoAndStop(1);
    }

    private function onRockClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_255);
        SeatTipsManager.removeSeat(new Point(580, 210), 160);
        this._glowRock.gotoAndStop(3);
        ModuleManager.toggleModule(URLUtil.getAppModule("MiniGameIntroPanel"), "正在打开" + "小游戏" + "...", {"gameId": 3});
    }

    private function clearEventListener():void {
        if (this._glowRock.hasEventListener(MouseEvent.MOUSE_OVER)) {
            this._glowRock.removeEventListener(MouseEvent.MOUSE_OVER, this.onRockOver);
            this._glowRock.removeEventListener(MouseEvent.MOUSE_OUT, this.offRockOver);
            this._glowRock.removeEventListener(MouseEvent.CLICK, this.onRockClick);
        }
    }

    override public function dispose():void {
        if (this._PrizeMC) {
            this._PrizeMC.dispose();
        }
        LayerManager.resetOperation();
        NpcChallenge.getInstance().dispose();
        this.clearEventListener();
        TooltipManager.remove(this._glowRock);
        this._starHide = null;
        this._bubbleMountain = null;
        this._glowRock = null;
        this._scrollOpen = null;
        if (this.bianpao) {
            this.bianpao.dispose();
        }
        if (this._kingCar) {
            this._kingCar.dispose();
        }
        super.dispose();
    }
}
}
