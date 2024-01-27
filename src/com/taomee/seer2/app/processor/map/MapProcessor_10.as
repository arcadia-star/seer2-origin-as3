package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actives.MiKaLaoDongJieAct;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.component.teleport.DeferTeleport;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.OnlyFlagManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.activity.guoNianFangBianPao.GuoNianBianPao;
import com.taomee.seer2.app.processor.activity.mascot.Mascot2Manager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;
import flash.utils.clearInterval;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_10 extends TitleMapProcessor {

    private static const MOVESKYCONST:int = 1;

    private static const MOVESKYMAX:int = 0;

    private static const MOVESKYMIN:int = -216;


    private var _captain:Mobile;

    private var _backDoorDeferTeleport:DeferTeleport;

    private var _backDoor:MovieClip;

    private var _leftLCD:MovieClip;

    private var _leftLCDTrigger:MovieClip;

    private var _midLCD:MovieClip;

    private var _midLCDTrigger:MovieClip;

    private var _lawsPoster:MovieClip;

    private var _lawsPosterTrigger:MovieClip;

    private var _npc179:Mobile;

    private var _chirs:MovieClip;

    private var bianpao:GuoNianBianPao;

    private var _starrySky:MovieClip;

    private var _moveSkyType:int;

    private var _skyInterval:int;

    private var _rightLCD:MovieClip;

    private var _rightLCDTrigger:MovieClip;

    private var oilBtn:SimpleButton;

    private var _twoYearNpc:Mobile;

    private var _oldNpc:Mobile;

    private const TASK_FINISH_FOV:int = 202498;

    private var timeId:int;

    public function MapProcessor_10(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initCaptain();
        MiKaLaoDongJieAct.getInstance().setup();
        Mascot2Manager.Instance.init();
    }

    private function initGuoNianBianPao():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.month == 1 && (_loc1_.date >= 6 && _loc1_.date <= 13)) {
            this.bianpao = new GuoNianBianPao(this._map);
            this.bianpao.initBianPao();
        }
    }

    private function initTwoOil():void {
        ActiveCountManager.requestActiveCount(202345, this.getState);
    }

    private function getState(param1:uint, param2:uint):void {
        this.oilBtn = SimpleButton(_map.content["oilBtn"]);
        if (param2 > 0) {
            this.oilBtn.visible = false;
        } else {
            this.oilBtn.addEventListener(MouseEvent.CLICK, this.toOil);
        }
    }

    protected function toOil(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        SwapManager.swapItem(1554, 1, function (param1:IDataInput):void {
            ServerMessager.addMessage("获得一张2周年纪念券");
            new SwapInfo(param1);
            oilBtn.visible = false;
        });
    }

    private function initChirs():void {
        this._chirs = _map.content["click"];
        this._chirs.buttonMode = true;
        this._chirs.addEventListener(MouseEvent.CLICK, this.onChirs);
    }

    private function onChirs(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        OnlyFlagManager.RequestFlag(function ():void {
            if (OnlyFlagManager.getFlag(625) == 0) {
                SwapManager.swapItem(912, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    OnlyFlagManager.updataFlag(625, 1);
                });
            }
        });
    }

    private function onClickBoy(param1:MouseEvent):void {
        if (SwapManager.isSwapNumberMax(617)) {
            SwapManager.entrySwap(617);
        }
    }

    private function initCaptain():void {
        this._captain = MobileManager.getMobile(1, MobileType.NPC);
        this._captain.gotoAndStop(1);
        this._captain.addEventListener(MouseEvent.MOUSE_OVER, this.onCaptainOver);
        this._captain.addEventListener(MouseEvent.MOUSE_OUT, this.onCaptainOut);
        this._npc179 = MobileManager.getMobile(179, MobileType.NPC);
        this._npc179.addEventListener(MouseEvent.CLICK, this.onNpc179);
    }

    private function onNpc179(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_208);
    }

    private function onCaptainOver(param1:MouseEvent):void {
        this._captain.addEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
        this._captain.play();
    }

    private function onCaptainPlay(param1:Event):void {
        if (this._captain.currentFrameIndex == 3) {
            this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
            this._captain.gotoAndStop(3);
        }
    }

    private function onCaptainOut(param1:MouseEvent):void {
        this._captain.removeEventListener(Event.ENTER_FRAME, this.onCaptainPlay);
        this._captain.gotoAndStop(1);
    }

    private function initStarrySky():void {
        this._skyInterval = 0;
        this._starrySky = _map.far["starrySky"];
        this._starrySky.addEventListener(Event.ENTER_FRAME, this.moveSky);
    }

    private function moveSky(param1:Event):void {
        ++this._skyInterval;
        if (this._skyInterval == 2) {
            this._skyInterval = 0;
            if (this._starrySky.x == MOVESKYMAX) {
                this._moveSkyType = 1;
            }
            if (this._starrySky.x == MOVESKYMIN) {
                this._moveSkyType = 0;
            }
            if (this._moveSkyType == 1) {
                this._starrySky.x -= MOVESKYCONST;
            } else {
                this._starrySky.x += MOVESKYCONST;
            }
            return;
        }
    }

    private function initleftLCD():void {
        this._leftLCD = _map.content["leftLCD"];
        this._leftLCDTrigger = _map.content["leftLCDTrigger"];
        this._leftLCD.gotoAndStop(1);
        closeInteractor(this._leftLCD);
        initInteractor(this._leftLCDTrigger);
        this._leftLCDTrigger.addEventListener(MouseEvent.CLICK, this.onLeftLCDTriggerClick);
    }

    private function onLeftLCDTriggerClick(param1:MouseEvent):void {
        param1.stopPropagation();
        if (this._leftLCD.currentFrame == 1) {
            this._leftLCD.gotoAndStop(2);
        } else {
            this._leftLCD.gotoAndStop(1);
        }
    }

    private function initMidLCD():void {
        this._midLCD = _map.content["midLCD"];
        this._midLCD.gotoAndStop(1);
        this._midLCDTrigger = _map.content["midLCDTrigger"];
        closeInteractor(this._midLCD);
        initInteractor(this._midLCDTrigger);
        this._midLCDTrigger.addEventListener(MouseEvent.CLICK, this.onMidLCDTriggerClick);
    }

    private function onMidLCDTriggerClick(param1:MouseEvent):void {
        param1.stopPropagation();
        if (this._midLCD.currentFrame == 1) {
            this._midLCD.gotoAndStop(2);
        } else {
            this._midLCD.gotoAndStop(1);
        }
    }

    private function initLawsPoster():void {
        this._lawsPoster = _map.content["lawsPoster"];
        this._lawsPosterTrigger = _map.content["lawsPosterTrigger"];
        this._lawsPoster.gotoAndStop(1);
        closeInteractor(this._lawsPoster);
        initInteractor(this._lawsPosterTrigger);
        this._lawsPosterTrigger.addEventListener(MouseEvent.MOUSE_OVER, this.onLawsPosterTriggerMouseOver);
        this._lawsPosterTrigger.addEventListener(MouseEvent.MOUSE_OUT, this.onLawsPosterTriggerMouseOut);
    }

    private function onLawsPosterTriggerMouseOver(param1:MouseEvent):void {
        param1.stopPropagation();
        this._lawsPoster.gotoAndStop(2);
    }

    private function onLawsPosterTriggerMouseOut(param1:MouseEvent):void {
        this._lawsPoster.gotoAndStop(1);
        param1.stopPropagation();
    }

    private function initRightLCD():void {
        this._rightLCD = _map.content["rightLCD"];
        this._rightLCDTrigger = _map.content["rightLCDTrigger"];
        this._rightLCD.gotoAndStop(1);
        closeInteractor(this._rightLCD);
        initInteractor(this._rightLCDTrigger);
        this._rightLCDTrigger.addEventListener(MouseEvent.MOUSE_OVER, this.onRightLCDTriggerMouseOver);
        this._rightLCDTrigger.addEventListener(MouseEvent.MOUSE_OUT, this.onRightLCDTriggerMouseOut);
    }

    private function onRightLCDTriggerMouseOver(param1:MouseEvent):void {
        param1.stopPropagation();
        this._rightLCD.gotoAndStop(2);
    }

    private function onRightLCDTriggerMouseOut(param1:MouseEvent):void {
        param1.stopPropagation();
        this._rightLCD.gotoAndStop(1);
    }

    private function initBackDoor():void {
        this._backDoor = _map.content["backDoor"];
        this._backDoor.gotoAndStop(1);
        initInteractor(this._backDoor);
        this._backDoor.addEventListener(MouseEvent.CLICK, this.onDoorClick);
    }

    private function onDoorClick(param1:MouseEvent):void {
        this._backDoorDeferTeleport.actorMoveClose();
    }

    private function initBackDoorDeferTeleport():void {
        this._backDoorDeferTeleport = new DeferTeleport(this._backDoor);
        this._backDoorDeferTeleport.setActorPostion(new Point(820, 280));
        this._backDoorDeferTeleport.setActorTargetMapId(70);
        this._backDoorDeferTeleport.addEventListener(DeferTeleport.ACTOR_ARRIVED, this.onActorArrivedDoor);
    }

    private function clearEventListener():void {
        this._rightLCDTrigger.removeEventListener(MouseEvent.MOUSE_OVER, this.onRightLCDTriggerMouseOver);
        this._rightLCDTrigger.removeEventListener(MouseEvent.MOUSE_OUT, this.onRightLCDTriggerMouseOut);
        this._lawsPosterTrigger.removeEventListener(MouseEvent.MOUSE_OVER, this.onLawsPosterTriggerMouseOver);
        this._lawsPosterTrigger.removeEventListener(MouseEvent.MOUSE_OUT, this.onLawsPosterTriggerMouseOut);
        this._leftLCDTrigger.removeEventListener(MouseEvent.CLICK, this.onLeftLCDTriggerClick);
        this._backDoor.removeEventListener(MouseEvent.CLICK, this.onDoorClick);
    }

    private function onActorArrivedDoor(param1:Event):void {
        this._backDoor.play();
    }

    private function initSuperPrize():void {
        var npc:Mobile = null;
        npc = MobileManager.getMobile(151, MobileType.NPC);
        if (DateUtil.inInDateScope(5, 14, 21, 14, 31)) {
            ServerBufferManager.getServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, function (param1:ServerBuffer):void {
                var _loc2_:int = param1.readDataAtPostion(16);
                if (_loc2_ == 0) {
                    npc.visible = true;
                    npc.buttonMode = true;
                    npc.addEventListener(MouseEvent.CLICK, OnSuperPrizeHandler);
                    ServerBufferManager.updateServerBuffer(ServerBufferType.FIREST_LOGIN_MAP980, 16, 1);
                }
            });
        }
    }

    private function OnSuperPrizeHandler(param1:MouseEvent):void {
        var npc:Mobile = null;
        var evt:MouseEvent = param1;
        npc = MobileManager.getMobile(151, MobileType.NPC);
        SwapManager.swapItem(528, 1, function (param1:IDataInput):void {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            npc.removeEventListener(MouseEvent.CLICK, OnSuperPrizeHandler);
            npc.visible = false;
        });
    }

    private function initTwoYearNpcHandle():void {
        if (DateUtil.isInTime(new Date(2013, 6, 6, 14, 26, 0), new Date(2013, 6, 6, 14, 30, 59))) {
            ActiveCountManager.requestActiveCount(this.TASK_FINISH_FOV, function (param1:int, param2:int):void {
                var type:int = param1;
                var val:int = param2;
                if (val == 1) {
                    return;
                }
                if (!MobileManager.getMobile(1, MobileType.NPC)) {
                    timeId = setTimeout(function ():void {
                        initNpc1();
                    }, 2000);
                } else {
                    initNpc1();
                }
            });
        }
    }

    private function initNpc1():void {
        this._oldNpc = MobileManager.getMobile(1, MobileType.NPC);
        this._oldNpc.visible = false;
        clearInterval(this.timeId);
        this._twoYearNpc = new Mobile();
        this._twoYearNpc.width = this._oldNpc.width;
        this._twoYearNpc.height = this._oldNpc.height;
        this._twoYearNpc.label = this._oldNpc.label;
        this._twoYearNpc.setPostion(new Point(this._oldNpc.x, this._oldNpc.y));
        this._twoYearNpc.resourceUrl = this._oldNpc.resourceUrl;
        this._twoYearNpc.buttonMode = true;
        this._twoYearNpc.gotoAndStop(1);
        this.showMouseHintAtMonster(this._twoYearNpc);
        MobileManager.addMobile(this._twoYearNpc, MobileType.NPC);
        this._twoYearNpc.addEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
    }

    private function onTwoYearNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(1, "船长辛迪", [[0, "辛苦的 " + ActorManager.actorInfo.nick + "，你已经伴随着约瑟传说走过两年了，谢谢你对约瑟传说的支持，作为船长，应该送一个纪念章和气球给你。吼吼吼~"]], ["谢谢船长"], [function ():void {
            ModuleManager.toggleModule(URLUtil.getAppModule("TwoYearBalloonPanel"), "正在打开气球抽奖面板...", {
                "type": 5,
                "callBack": afterFinish
            });
        }]);
    }

    private function afterFinish():void {
        if (this._twoYearNpc) {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
        }
        if (this._oldNpc) {
            this._oldNpc.visible = true;
        }
    }

    private function showMouseHintAtMonster(param1:Mobile):void {
        var _loc2_:MouseClickHintSprite = new MouseClickHintSprite();
        _loc2_.y = -_loc2_.height - 50;
        _loc2_.x = (param1.width - param1.width) / 2;
        param1.addChild(_loc2_);
    }

    private function disposeTwoYearNpcHandle():void {
        if (this._twoYearNpc) {
            this._twoYearNpc.removeEventListener(MouseEvent.CLICK, this.onTwoYearNpcClick);
            DisplayUtil.removeForParent(this._twoYearNpc);
            this._twoYearNpc = null;
        }
        this._oldNpc = null;
        clearInterval(this.timeId);
    }

    override public function dispose():void {
        super.dispose();
        MiKaLaoDongJieAct.getInstance().dispose();
        Mascot2Manager.Instance.dispose();
    }
}
}
