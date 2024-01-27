package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.KingCarZhangManager;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.deliciousFood.DeliciousFoodOne;
import com.taomee.seer2.app.processor.activity.guoNianFangBianPao.GuoNianBianPao;
import com.taomee.seer2.app.processor.activity.heroTieAct.HeroTieAct;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_90 extends TitleMapProcessor {


    private var _teleport2:Teleport;

    private var _deliciousFoodOne:DeliciousFoodOne;

    private var _kingCar:KingCarZhangManager;

    private var bianpao:GuoNianBianPao;

    private var mcCar:MovieClip;

    private var index:int;

    private var _heroTieAct:HeroTieAct;

    private var _carpetMc:MovieClip;

    private var _carpetTrigger:MovieClip;

    public function MapProcessor_90(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._teleport2 = AnimateElementManager.getElement(2) as Teleport;
        this.hideTeleport();
        this.initCarpet();
        this.initDeliciousFood();
        StatisticsManager.sendNovice(StatisticsManager.map_entry_90);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_120);
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

    private function hideTeleport():void {
        if (this._teleport2 != null) {
            this._teleport2.visible = false;
        }
    }

    private function showTeleport():void {
        if (this._teleport2 != null) {
            this._teleport2.visible = true;
        }
    }

    private function initCarpet():void {
        this._carpetMc = _map.content["carpetMc"];
        this._carpetTrigger = _map.content["carpetTrigger"];
        closeInteractor(this._carpetMc);
        initInteractor(this._carpetTrigger);
        this._carpetMc.addEventListener(Event.ENTER_FRAME, this.onCarpetEnterFrame);
        this._carpetTrigger.addEventListener(MouseEvent.CLICK, this.onCarpetTriggerClick);
    }

    private function onCarpetEnterFrame(param1:Event):void {
        if (this._carpetMc.currentFrameLabel == "swayend") {
            this._carpetMc.gotoAndPlay("常态动画");
        } else if (this._carpetMc.currentFrameLabel == "end") {
            this._carpetMc.stop();
            this.showTeleport();
            initInteractor(this._carpetTrigger);
        }
    }

    private function onCarpetTriggerClick(param1:MouseEvent):void {
        if (this._carpetMc.currentFrame < 10) {
            this._carpetMc.gotoAndPlay("点击");
            closeInteractor(this._carpetTrigger);
        } else {
            this.hideTeleport();
            this._carpetMc.gotoAndPlay("常态动画");
            initInteractor(this._carpetTrigger);
        }
    }

    private function initDeliciousFood():void {
        this._deliciousFoodOne = new DeliciousFoodOne(_map);
    }

    override public function dispose():void {
        this._carpetMc.removeEventListener(Event.ENTER_FRAME, this.onCarpetEnterFrame);
        this._carpetMc.removeEventListener(MouseEvent.CLICK, this.onCarpetTriggerClick);
        this._carpetMc = null;
        this._carpetTrigger = null;
        if (this._deliciousFoodOne) {
            this._deliciousFoodOne.dispose();
            this._deliciousFoodOne = null;
        }
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
