package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.KingCarZhangManager;
import com.taomee.seer2.app.actives.HaniSnowManActivity;
import com.taomee.seer2.app.activity.processor.PrizeCeremony.Map540Prize;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dreamlandchest.DreamlandChestManager;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.manager.OnlyFlagManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.frozen.FrozenManager;
import com.taomee.seer2.app.processor.activity.guoNianFangBianPao.GuoNianBianPao;
import com.taomee.seer2.app.processor.activity.miKaAct.MiKaFindProcessHandle;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.filters.GlowFilter;
import flash.utils.IDataInput;

public class MapProcessor_540 extends MapProcessor {

    private static const FRUITS_REWARD540_0:String = "bingReward540_0";

    private static const FRUITS_REWARD540_1:String = "bingReward540_1";

    private static const FRUITS_REWARD540_2:String = "bingReward540_2";


    private var _PrizeMC:Map540Prize;

    private var _bing1:MovieClip;

    private var _bing2:MovieClip;

    private var _bing3:MovieClip;

    private var _mika:MovieClip;

    private var bianpao:GuoNianBianPao;

    private var _mikaFindHandle:MiKaFindProcessHandle;

    private var _kingCar:KingCarZhangManager;

    private var mcCar:MovieClip;

    private var index:int;

    public function MapProcessor_540(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var _loc2_:GlowFilter = null;
        var _loc1_:Teleport = AnimateElementManager.getElement(4) as Teleport;
        _loc1_.visible = false;
        if (FrozenManager.isActivityTime()) {
            _loc1_.visible = true;
            _loc2_ = new GlowFilter();
            _loc2_.blurX = 25;
            _loc2_.blurY = 25;
            _loc2_.color = 16711680;
            _loc2_.inner = true;
            _loc1_.filters = [_loc2_];
        } else {
            _loc1_.visible = false;
        }
        HaniSnowManActivity.enterMap(_map);
        this.initBingSwap();
        this.initMika();
        this._mikaFindHandle = new MiKaFindProcessHandle(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_174);
        DreamlandChestManager.init(_map);
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
        this.mcCar.mouseChildren = false;
        this.mcCar.buttonMode = true;
        this.mcCar.addEventListener(MouseEvent.CLICK, this.onMouseCar);
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

    private function initGuoNianBianPao():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.month == 1 && (_loc1_.date >= 6 && _loc1_.date <= 13)) {
            this.bianpao = new GuoNianBianPao(this._map);
            this.bianpao.initBianPao();
        }
    }

    private function initMika():void {
        this._mika = _map.content["mikaNpc"];
        this._mika.visible = false;
        this._mika.buttonMode = true;
        ServerBufferManager.getServerBuffer(ServerBufferType.XUE_WA_WA_FU_YONG, this.onGetQuestIndex);
    }

    public function onGetQuestIndex(param1:ServerBuffer):void {
        var serverBuffer:ServerBuffer = param1;
        if (serverBuffer.readDataAtPostion(5) != 0) {
            OnlyFlagManager.reset();
            OnlyFlagManager.RequestFlag(function ():void {
                if (OnlyFlagManager.getFlag(771) == 0) {
                    _mika.visible = true;
                }
            });
            this._mika.addEventListener(MouseEvent.CLICK, this.mikaFight);
        }
        this._mika.visible = false;
    }

    private function mikaFight(param1:MouseEvent):void {
        FightManager.startFightWithWild(236);
    }

    private function initPrizeMC():void {
        if (DateUtil.inInDateScope(5, 14, 51, 15, 1)) {
            this._PrizeMC = new Map540Prize();
        }
    }

    private function initBingSwap():void {
        this._bing1 = _map.front["bing"];
        this._bing1.addEventListener(FRUITS_REWARD540_0, this.onSwap1);
        this._bing2 = _map.content["bing"];
        this._bing2.addEventListener(FRUITS_REWARD540_1, this.onSwap2);
        this._bing3 = _map.content["bing1"];
        this._bing3.addEventListener(FRUITS_REWARD540_2, this.onSwap3);
    }

    private function onSwap1(param1:Event):void {
        this._bing1.removeEventListener(FRUITS_REWARD540_0, this.onSwap1);
        if (SwapManager.isSwapNumberMax(213)) {
            SwapManager.entrySwap(213);
        }
    }

    private function onSwap2(param1:Event):void {
        this._bing2.removeEventListener(FRUITS_REWARD540_1, this.onSwap2);
        if (SwapManager.isSwapNumberMax(213)) {
            SwapManager.entrySwap(213);
        }
    }

    private function onSwap3(param1:Event):void {
        this._bing3.removeEventListener(FRUITS_REWARD540_2, this.onSwap3);
        if (SwapManager.isSwapNumberMax(214)) {
            SwapManager.entrySwap(214);
        }
    }

    override public function dispose():void {
        if (this._bing1) {
            this._bing1.removeEventListener(FRUITS_REWARD540_0, this.onSwap1);
            this._bing1 = null;
        }
        if (this._bing2) {
            this._bing2.removeEventListener(FRUITS_REWARD540_1, this.onSwap2);
            this._bing2 = null;
        }
        if (this._bing2) {
            this._bing2.removeEventListener(FRUITS_REWARD540_2, this.onSwap3);
            this._bing2 = null;
        }
        if (this._PrizeMC) {
            this._PrizeMC.dispose();
        }
        if (this.bianpao) {
            this.bianpao.dispose();
        }
        HaniSnowManActivity.leaveMap();
        if (this._mikaFindHandle) {
            this._mikaFindHandle.dispose();
            this._mikaFindHandle = null;
        }
        if (this._kingCar) {
            this._kingCar.dispose();
        }
        super.dispose();
    }
}
}
