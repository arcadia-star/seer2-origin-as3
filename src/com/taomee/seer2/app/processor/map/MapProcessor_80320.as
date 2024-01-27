package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.MineManger;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.scene.LobbyPanel;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.text.TextField;
import flash.utils.IDataInput;
import flash.utils.Timer;

import org.taomee.utils.Tick;

public class MapProcessor_80320 extends MapProcessor {


    private const BLOODNUMS:int = 100000;

    private var timeTxt:TextField;

    private var boxBarSp:MovieClip;

    private var boxBar:MovieClip;

    private var progressSp:MovieClip;

    private var progressBar:MovieClip;

    private var boxBtn:SimpleButton;

    private var hintMC:MovieClip;

    private var lastHint:MovieClip;

    private var iceBtn:SimpleButton;

    private var bloodTxt:TextField;

    private var curBlood:int;

    private var PUBLIC_KEY:int = 135;

    private var MineID:int = 333;

    private var dayLimit:Array;

    private var isGetAward:Boolean;

    private var isHammer:Boolean;

    private var cdTime:int;

    private var waitTime:int;

    private var wTimer:Timer;

    private var giftTimer:Timer;

    private var leftTime:int;

    private var curValue:int = 0;

    private var _currentDate:Date;

    private var _endDate:Date;

    private var flag:Boolean = false;

    public function MapProcessor_80320(param1:MapModel) {
        this.dayLimit = [1353, 1354, 1365, 1366];
        this.wTimer = new Timer(100);
        this.giftTimer = new Timer(100);
        this._currentDate = new Date();
        this._endDate = new Date();
        super(param1);
    }

    override public function init():void {
        LobbyPanel.instance.hide();
        this.initMC();
    }

    private function initMC():void {
        this.progressSp = _map.front["progressSp"];
        this.progressBar = this.progressSp["progressBar"];
        this.progressSp.visible = false;
        this.boxBarSp = _map.front["boxBarSp"];
        this.boxBar = this.boxBarSp["boxBar"];
        this.iceBtn = _map.front["iceBtn"];
        this.hintMC = _map.front["hintMC"];
        this.hintMC.gotoAndStop(1);
        this.hintMC.visible = false;
        this.lastHint = _map.front["lastHint"];
        this.bloodTxt = _map.front["bloodTxt"];
        this.lastHint.visible = false;
        this.timeTxt = _map.front["timeTxt"];
        this.boxBtn = _map.front["boxMc"];
        this.boxBtn.addEventListener(MouseEvent.CLICK, this.onClickBox);
        this.iceBtn.addEventListener(MouseEvent.CLICK, this.onIce);
        this.hintMC.addEventListener(MouseEvent.CLICK, this.onHammerMc);
        this.checkStates();
        this.progressSp.addEventListener(Event.ENTER_FRAME, this.onEnter);
        this.wTimer.addEventListener(TimerEvent.TIMER, this.onWaitBar);
        this.giftTimer.addEventListener(TimerEvent.TIMER, this.onGiftBar);
    }

    private function onGiftBar(param1:Event):void {
        ++this.curValue;
        if (this.curValue > 50) {
            this.curValue = 0;
            this.giftTimer.stop();
            this.bloodTxt.visible = false;
            LayerManager.resetOperation();
            if (this.isGetAward) {
                ServerMessager.addMessage("今天已经领取过奖励了，请明天再来~");
                return;
            }
            if (!this.isHammer) {
                AlertManager.showAlert("要参加过凿冰宝箱才能获得宝箱中的奖励哦~明天记得13:00准时参加活动！");
                return;
            }
            this.getAward();
        } else {
            this.boxBar.scaleX = 1 - this.curValue / 50;
        }
    }

    private function onEnter(param1:Event):void {
        this.setPosition();
    }

    private function onWaitBar(param1:Event):void {
        ++this.curValue;
        if (this.curValue > 50) {
            this.curValue = 0;
            this.wTimer.stop();
            this.progressBar.scaleX = 1;
            if (this.flag == true) {
                this.flag = false;
                this.iceBtn.visible = false;
            }
            this.hintMC.visible = false;
            this.hintMC.gotoAndStop(1);
            this.progressSp.visible = false;
            LayerManager.resetOperation();
        } else {
            this.progressBar.scaleX = 1 - this.curValue / 50;
        }
    }

    private function checkStates():void {
        DayLimitListManager.getDaylimitList(this.dayLimit, function (param1:DayLimitListInfo):void {
            waitTime = param1.getCount(dayLimit[1]);
            isHammer = Boolean(param1.getCount(dayLimit[1]));
            isGetAward = Boolean(param1.getCount(dayLimit[3]));
            if (isGetAward) {
                hintMC.visible = false;
                iceBtn.visible = false;
                lastHint.visible = false;
            }
            _currentDate.setTime(TimeManager.getPrecisionServerTime() * 1000);
            _endDate.fullYear = _currentDate.fullYear;
            _endDate.month = _currentDate.month;
            _endDate.date = _currentDate.date;
            _endDate.hours = 14;
            _endDate.minutes = 0;
            leftTime = (_endDate.getTime() - _currentDate.getTime()) / 1000 - 60;
            if (leftTime > 0) {
                Tick.instance.addRender(updateTime, 1000);
            }
            updateBloodBar();
        });
    }

    private function updateTime(param1:int):void {
        if (this.leftTime <= 0) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
            Tick.instance.removeRender(this.updateTime);
        } else {
            this.updateTimeTxt();
        }
    }

    private function updateTimeTxt():void {
        --this.leftTime;
        var _loc1_:String = String(DateUtil.getMS(this.leftTime));
        this.timeTxt.text = _loc1_;
    }

    private function updateBloodBar():void {
        var dateStr:String = null;
        var curDate:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
        dateStr = curDate.fullYear.toString() + (curDate.month + 1 >= 10 ? (curDate.month + 1).toString() : "0" + (curDate.month + 1).toString()).toString() + (curDate.date >= 10 ? curDate.date.toString() : "0" + curDate.date.toString()).toString();
        Connection.send(CommandSet.GET_TOTAL_VOTE_INFO_1219, this.PUBLIC_KEY, 1, int(dateStr));
        Connection.addCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219, function getCallState(param1:MessageEvent):void {
            var _loc8_:uint = 0;
            var _loc9_:uint = 0;
            Connection.removeCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219, getCallState);
            var _loc2_:IDataInput = param1.message.getRawData();
            var _loc3_:uint = uint(_loc2_.readUnsignedInt());
            var _loc4_:uint = uint(_loc2_.readUnsignedInt());
            var _loc5_:Vector.<uint> = Vector.<uint>([int(dateStr)]);
            var _loc6_:Array = [0];
            var _loc7_:int = 0;
            while (_loc7_ < _loc4_) {
                _loc8_ = uint(_loc2_.readUnsignedInt());
                _loc9_ = uint(_loc2_.readUnsignedInt());
                if (_loc5_.indexOf(_loc8_) != -1) {
                    _loc6_[_loc5_.indexOf(_loc8_)] = _loc9_;
                }
                _loc7_++;
            }
            curBlood = BLOODNUMS - _loc6_[0];
            curBlood = curBlood < 0 ? 0 : curBlood;
            boxBar.scaleX = curBlood / BLOODNUMS;
            bloodTxt.text = curBlood + "/100000";
            if (curBlood == 0) {
                hintMC.visible = false;
                iceBtn.visible = false;
                lastHint.visible = false;
            }
        });
    }

    private function setPosition():void {
        this.progressSp.y = ActorManager.getActor().y - 20;
        this.progressSp.x = ActorManager.getActor().x - 20;
    }

    private function onHammerMc(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (this.hintMC.currentFrame == 1) {
            this.hintMC.gotoAndStop(2);
        } else if (this.hintMC.currentFrame == 2) {
            SwapManager.swapItem(3220, 1, function (param1:IDataInput):void {
                var data:IDataInput = param1;
                new SwapInfo(data);
                LayerManager.focusOnTopLayer();
                if (curBlood == 1) {
                    lastHint.visible = true;
                    hintMC.visible = false;
                    lastHint.gotoAndStop(1);
                    bloodTxt.visible = false;
                    MovieClipUtil.playMc(lastHint, 2, lastHint.totalFrames, function ():void {
                        lastHint.visible = false;
                        progressSp.visible = true;
                        flag = true;
                        wTimer.reset();
                        wTimer.start();
                        checkStates();
                    }, true);
                } else {
                    hintMC.gotoAndPlay(3);
                    progressSp.visible = true;
                    wTimer.reset();
                    wTimer.start();
                    checkStates();
                }
            });
        }
    }

    private function getAward():void {
        SwapManager.swapItem(3231, 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            MineManger.getMineItem(MineID, function (param1:Parser_1060):void {
                param1.showResult(true, null, true);
                checkStates();
            });
        });
    }

    private function onClickBox(param1:MouseEvent):void {
        StatisticsManager.newSendNovice("2015活动", "4周年冰封宝箱", "点击宝箱");
        LayerManager.focusOnTopLayer();
        this.giftTimer.reset();
        this.giftTimer.start();
        this.boxBar.scaleX = 1;
    }

    private function onIce(param1:MouseEvent):void {
        this.hintMC.visible = true;
        this.hintMC.gotoAndStop(2);
    }

    override public function dispose():void {
        this.progressSp.removeEventListener(Event.ENTER_FRAME, this.onEnter);
        this.wTimer.stop();
    }
}
}
