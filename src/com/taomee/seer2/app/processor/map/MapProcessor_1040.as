package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.common.ResourceLibraryLoader;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.ui.Mouse;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.MathUtil;

public class MapProcessor_1040 extends MapProcessor {

    private static var _Num1:int;

    private static var _Num2:int;

    private static var _Num3:int;

    private static var _Num4:int;

    private static var _keyCount:int;

    private static var _hourNum:int;

    private static var _minNum:int;


    private var _zheMC:MovieClip;

    private var _blackNum1:TextField;

    private var _blackNum2:TextField;

    private var _blackNum3:TextField;

    private var _blackNum4:TextField;

    private var _kacaoMC:MovieClip;

    private var _citieMC:MovieClip;

    private var _qiuMC:MovieClip;

    private var _doorMC:MovieClip;

    private var _btn1MC:MovieClip;

    private var _daiMC:MovieClip;

    private var _lightBtn1MC:MovieClip;

    private var _lightBtn2MC:MovieClip;

    private var _jimuMC:MovieClip;

    private var _hourMC:MovieClip;

    private var _minMC:MovieClip;

    private var _letter1:MovieClip;

    private var _letter2:MovieClip;

    private var _hidePathVec:Vector.<MovieClip>;

    private var _resLib:ResourceLibrary;

    public function MapProcessor_1040(param1:MapModel) {
        super(param1);
    }

    public static function get keyCount():int {
        return _keyCount;
    }

    public static function get hourNum():int {
        return _hourNum;
    }

    public static function get minNum():int {
        return _minNum;
    }

    public static function get blackNum1():int {
        return _Num1;
    }

    public static function get blackNum2():int {
        return _Num2;
    }

    public static function get blackNum3():int {
        return _Num3;
    }

    public static function get blackNum4():int {
        return _Num4;
    }

    override public function dispose():void {
        super.dispose();
    }

    override public function init():void {
        super.init();
        this.initNPC();
        _keyCount = 0;
        ActorManager.showRemoteActor = false;
        this._zheMC = _map.front["zhezhao"];
        this._blackNum1 = _map.front["blacknum1"];
        this._blackNum2 = _map.front["blacknum2"];
        this._blackNum3 = _map.front["blacknum3"];
        this._blackNum4 = _map.front["blacknum4"];
        this._zheMC.visible = false;
        this._zheMC.mouseChildren = false;
        this._zheMC.mouseEnabled = false;
        this._blackNum1.visible = false;
        this._blackNum2.visible = false;
        this._blackNum3.visible = false;
        this._blackNum4.visible = false;
        this._kacaoMC = _map.content["kacao"];
        this._citieMC = _map.content["citie"];
        this._qiuMC = _map.content["qiu"];
        this._doorMC = _map.content["door"];
        this._btn1MC = _map.content["btn1"];
        this._daiMC = _map.content["dai"];
        this._lightBtn1MC = _map.content["lightBtn1"];
        this._lightBtn2MC = _map.content["lightBtn2"];
        this._jimuMC = _map.content["jimu"];
        this._hourMC = _map.content["hour"];
        this._minMC = _map.content["min"];
        this._lightBtn2MC.visible = false;
        this._hidePathVec = new Vector.<MovieClip>();
        var _loc1_:int = 1;
        while (_loc1_ < 5) {
            this._hidePathVec.push(_map.path["hide" + _loc1_]);
            _loc1_++;
        }
        this.getURL(this.getCurrentStep);
        this.initClock();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_93);
    }

    private function getCurrentStep():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.MAP1041_CLEAR, function (param1:ServerBuffer):void {
            var _loc2_:int = param1.readDataAtPostion(1);
            if (_loc2_ == 0) {
                startPlay();
                return;
            }
            step1Clear();
            clearPath(1);
            if (_loc2_ <= 1) {
                initStep2();
                return;
            }
            step2Clear();
            clearPath(2);
            if (_loc2_ <= 2) {
                initStep3();
                return;
            }
            step3Clear();
            clearPath(3);
            if (_loc2_ <= 3) {
                initStep4();
                return;
            }
            step4Clear();
            clearPath(4);
        });
    }

    private function initNPC():void {
        MobileManager.getMobile(518, MobileType.NPC).buttonMode = true;
        MobileManager.getMobile(518, MobileType.NPC).addEventListener(MouseEvent.CLICK, this.onNPCTalkHandler);
    }

    private function onNPCTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (Boolean(DateUtil.isInTime(new Date(2014, 7, 29, 6), new Date(2014, 8, 11, 23))) && Boolean(DateUtil.isInHourScope(14, 15, 30, 30))) {
            if (_keyCount == 4) {
                SceneManager.changeScene(SceneType.LOBBY, 1041);
            } else {
                NpcDialog.show(518, "狼妖", [[0, "呜哈哈哈！想过来？你得先走过前方的机关才行，只有足够聪明的人才行！"]], ["哼！你等着！我这就杀过去！"]);
            }
        } else {
            NpcDialog.show(518, "狼妖", [[0, "大爷我很忙！8月29日-9月11日13:00—14:30不要命的赛尔可以尝试挑战或者捕捉本大爷！"]], ["乖乖投降吧！", "哼！你等着！"], [function ():void {
                if (_keyCount == 4) {
                    ModuleManager.toggleModule(URLUtil.getAppModule("FightWolfUI"), "正在打开面板...");
                } else {
                    NpcDialog.show(518, "狼妖", [[0, "呜哈哈哈！想过来？你得先走过前方的机关才行，只有足够聪明的人才行！"]], ["哼！你等着！我这就杀过去！"]);
                }
            }]);
        }
    }

    private function initClock():void {
        _hourNum = MathUtil.randomRegion(0, 11);
        _minNum = MathUtil.randomRegion(0, 11);
        this._hourMC.gotoAndStop(_hourNum + 1);
        this._minMC.gotoAndStop(_minNum + 1);
    }

    private function startPlay():void {
        this._citieMC.buttonMode = true;
        this._citieMC.addEventListener(MouseEvent.CLICK, this.onClickCitieHandler);
    }

    private function onClickCitieHandler(param1:MouseEvent):void {
        Mouse.hide();
        this._citieMC.startDrag(true);
        this._kacaoMC.gotoAndStop(2);
        this._citieMC.addEventListener(Event.ENTER_FRAME, this.onIsHitHandler);
    }

    private function onIsHitHandler(param1:Event):void {
        if (this._citieMC.hitTestObject(this._kacaoMC)) {
            this._citieMC.removeEventListener(Event.ENTER_FRAME, this.onIsHitHandler);
            this._citieMC.removeEventListener(MouseEvent.CLICK, this.onClickCitieHandler);
            Mouse.show();
            this._citieMC.stopDrag();
            this.step1Clear();
            setTimeout(this.removeHide, 3500);
        }
    }

    private function step1Clear():void {
        this._citieMC.buttonMode = false;
        this._kacaoMC.visible = false;
        this._citieMC.x = this._kacaoMC.x;
        this._citieMC.y = this._kacaoMC.y;
        this._citieMC.gotoAndPlay(2);
        _keyCount = 1;
        this._qiuMC.gotoAndStop(2);
    }

    private function removeHide():void {
        this.clearPath(1);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAP1041_CLEAR, 1, _keyCount);
        this.initStep2();
    }

    private function clearPath(param1:uint):void {
        var _loc2_:MovieClip = this._hidePathVec[param1 - 1];
        DisplayObjectUtil.removeFromParent(_loc2_);
        _map.recalculatePathData();
    }

    private function initStep2():void {
        this.initDoor();
        this._letter1 = this.getMovie("letter1");
        SceneManager.active.mapModel.content.addChild(this._letter1);
        this._letter1.buttonMode = true;
        this._letter1.addEventListener(MouseEvent.CLICK, this.openLetterHandler);
    }

    private function openLetterHandler(param1:MouseEvent):void {
        var closeBtn:SimpleButton;
        var letterMC:MovieClip = null;
        var evt:MouseEvent = param1;
        letterMC = this.getMovie("letterMC1");
        LayerManager.topLayer.addChild(letterMC);
        closeBtn = letterMC["closeButton"];
        closeBtn.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            DisplayUtil.removeForParent(letterMC);
        });
    }

    private function initDoor():void {
        this._doorMC.buttonMode = true;
        this._doorMC.addEventListener(MouseEvent.CLICK, this.onOpenDoorHandler);
    }

    private function onOpenDoorHandler(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("MachinePasswordPanel"), "正在打开面板...");
        ModuleManager.addEventListener("MachinePasswordPanel", "passwordOK", this.onDisposePanel);
    }

    private function onDisposePanel(param1:ModuleEvent):void {
        if (this._letter1) {
            DisplayUtil.removeForParent(this._letter1);
        }
        ModuleManager.removeEventListener("MachinePasswordPanel", "passwordOK", this.onDisposePanel);
        this.step2Clear();
        this.clearPath(2);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAP1041_CLEAR, 1, _keyCount);
        this.initStep3();
    }

    private function step2Clear():void {
        this._doorMC.gotoAndPlay(2);
        this._doorMC.mouseChildren = false;
        this._doorMC.mouseEnabled = false;
        _keyCount = 2;
    }

    private function initStep3():void {
        this._btn1MC.buttonMode = true;
        this._btn1MC.addEventListener(MouseEvent.CLICK, this.onOpenRoadHandler);
    }

    private function onOpenRoadHandler(param1:MouseEvent):void {
        this._btn1MC.removeEventListener(MouseEvent.CLICK, this.onOpenRoadHandler);
        this.step3Clear();
        this.clearPath(3);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAP1041_CLEAR, 1, _keyCount);
        this.initStep4();
    }

    private function step3Clear():void {
        this._btn1MC.mouseEnabled = false;
        this._btn1MC.mouseChildren = false;
        this._btn1MC.gotoAndPlay(2);
        this._daiMC.gotoAndStop(2);
        _keyCount = 3;
    }

    private function initStep4():void {
        this.initBtn();
        this._letter2 = this.getMovie("letter2");
        SceneManager.active.mapModel.content.addChild(this._letter2);
        this._letter2.buttonMode = true;
        this._letter2.addEventListener(MouseEvent.CLICK, this.openLetter2Handler);
    }

    private function openLetter2Handler(param1:MouseEvent):void {
        var closeBtn:SimpleButton;
        var letterMC:MovieClip = null;
        var evt:MouseEvent = param1;
        letterMC = this.getMovie("letterMC2");
        LayerManager.topLayer.addChild(letterMC);
        closeBtn = letterMC["closeButton"];
        closeBtn.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            DisplayUtil.removeForParent(letterMC);
        });
    }

    private function initBtn():void {
        this._lightBtn1MC.visible = true;
        this._lightBtn1MC.buttonMode = true;
        this._lightBtn1MC.addEventListener(MouseEvent.CLICK, this.onCloseLightHandler);
    }

    private function onCloseLightHandler(param1:MouseEvent):void {
        this._lightBtn1MC.removeEventListener(MouseEvent.CLICK, this.onCloseLightHandler);
        this._lightBtn1MC.mouseEnabled = false;
        this._lightBtn1MC.visible = false;
        this._lightBtn2MC.visible = true;
        this._lightBtn2MC.buttonMode = true;
        this._lightBtn2MC.addEventListener(MouseEvent.CLICK, this.onOnLightHandler);
        this._zheMC.visible = true;
        _Num1 = MathUtil.randomRegion(0, 9);
        this._blackNum1.text = _Num1.toString();
        this._blackNum1.visible = true;
        _Num2 = MathUtil.randomRegion(0, 9);
        this._blackNum2.text = _Num2.toString();
        this._blackNum2.visible = true;
        _Num3 = MathUtil.randomRegion(0, 9);
        this._blackNum3.text = _Num3.toString();
        this._blackNum3.visible = true;
        _Num4 = MathUtil.randomRegion(0, 9);
        this._blackNum4.text = _Num4.toString();
        this._blackNum4.visible = true;
    }

    private function onOnLightHandler(param1:MouseEvent):void {
        this._lightBtn2MC.removeEventListener(MouseEvent.CLICK, this.onOnLightHandler);
        this._lightBtn2MC.mouseEnabled = false;
        this._lightBtn2MC.visible = false;
        this._zheMC.visible = false;
        this._blackNum1.visible = false;
        this._blackNum2.visible = false;
        this._blackNum3.visible = false;
        this._blackNum4.visible = false;
        this.initBtn();
        ModuleManager.toggleModule(URLUtil.getAppModule("MachinePasswordPanel"), "正在打开面板...");
        ModuleManager.addEventListener("MachinePasswordPanel", "passwordSucess", this.onClosePanel);
    }

    private function onClosePanel(param1:ModuleEvent):void {
        if (this._letter2) {
            DisplayUtil.removeForParent(this._letter2);
        }
        this._lightBtn1MC.mouseEnabled = false;
        this._lightBtn1MC.mouseChildren = false;
        ModuleManager.removeEventListener("MachinePasswordPanel", "passwordSucess", this.onClosePanel);
        this.step4Clear();
        this.clearPath(4);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAP1041_CLEAR, 1, _keyCount);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_94);
    }

    private function step4Clear():void {
        this._jimuMC.gotoAndPlay(2);
        _keyCount = 4;
        var _loc1_:Actor = ActorManager.getActor();
        _loc1_.runToLocation(753, 218);
    }

    private function getURL(param1:Function = null):void {
        var callback:Function = param1;
        var url:String = String(URLUtil.getActivityAnimation("machine/letter"));
        var resourceLoader:ResourceLibraryLoader = new ResourceLibraryLoader(url);
        resourceLoader.getLib(function (param1:ResourceLibrary):void {
            _resLib = param1;
            if (callback != null) {
                callback();
            }
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return this._resLib.getMovieClip(param1);
        }
        return null;
    }
}
}
