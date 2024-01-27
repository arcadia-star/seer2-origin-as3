package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.Tick;

public class HalloweenShalunStrikeAct {

    private static var _instance:HalloweenShalunStrikeAct;


    private var _actVo:ActVo;

    private var seatArr:Array;

    public var isOver:Boolean = false;

    private var recordSeat:int = 0;

    private var capture:Mobile;

    private var foeArr:Vector.<Mobile>;

    private var isInTime:Boolean;

    private var isAddNum:Boolean;

    private var isPlay:Boolean;

    private var oldShowNum:int;

    public function HalloweenShalunStrikeAct(param1:InsTance) {
        this.seatArr = [{
            "x": 265,
            "y": 310
        }, {
            "x": 260,
            "y": 448
        }, {
            "x": 200,
            "y": 410
        }, {
            "x": 637,
            "y": 447
        }, {
            "x": 533,
            "y": 427
        }, {
            "x": 444,
            "y": 457
        }, {
            "x": 368,
            "y": 443
        }, {
            "x": 470,
            "y": 420
        }, {
            "x": 715,
            "y": 460
        }, {
            "x": 810,
            "y": 410
        }];
        super();
        this._actVo = new ActVo();
        this.foeArr = new Vector.<Mobile>(5);
    }

    public static function get instance():HalloweenShalunStrikeAct {
        if (!_instance) {
            _instance = new HalloweenShalunStrikeAct(new InsTance());
        }
        return _instance;
    }

    public function setup():void {
        this.isAddNum = false;
        this.checkTime();
        Tick.instance.addRender(this.checkTime, 60000);
    }

    private function checkTime(param1:int = 0):void {
        var time1:Boolean = false;
        var time2:Boolean = false;
        var n:int = param1;
        var currentDate:Date = new Date(TimeManager.getServerTime() * 1000);
        if (currentDate.fullYear == 2013 && currentDate.month == 9 && currentDate.date == 19) {
            time1 = currentDate.hours >= 14 && currentDate.hours < 15;
            time2 = currentDate.hours >= 19 && currentDate.hours < 20;
            if (time1 || time2) {
                ServerBufferManager.getServerBuffer(ServerBufferType.HALLOWEEN_BUFF, this.getServerBuff);
            } else if (currentDate.hours == 15 && currentDate.minutes < 1) {
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("HalloweenOverFirst"), function ():void {
                    var _loc1_:int = 0;
                    while (_loc1_ < 5) {
                        if (foeArr[_loc1_]) {
                            MobileManager.removeMobile(foeArr[_loc1_], MobileType.NPC);
                            foeArr[_loc1_] = null;
                        }
                        _loc1_++;
                    }
                });
            } else if (currentDate.hours >= 20) {
                Tick.instance.removeRender(this.checkTime);
            }
        }
    }

    public function dispose():void {
        var _loc2_:Mobile = null;
        Tick.instance.removeRender(this.checkTime);
        if (this.capture) {
            this.capture.removeEventListener(MouseEvent.CLICK, this.showFailDia);
            MobileManager.removeMobile(this.capture, MobileType.NPC);
            this.capture = null;
        }
        var _loc1_:int = 0;
        while (_loc1_ < this.foeArr.length) {
            _loc2_ = this.foeArr[_loc1_];
            if (_loc2_) {
                MobileManager.removeMobile(_loc2_, MobileType.NPC);
                _loc2_.removeEventListener(MouseEvent.CLICK, this.toFight);
            }
            _loc1_++;
        }
    }

    private function getServerBuff(param1:ServerBuffer):void {
        this._actVo.currentNumArr = [];
        this._actVo.isFirstTo = param1.readDataAtPostion(0);
        this._actVo.currentNumArr[0] = param1.readDataAtPostion(1);
        this._actVo.currentNumArr[1] = param1.readDataAtPostion(2);
        this._actVo.currentNumArr[2] = param1.readDataAtPostion(3);
        this._actVo.currentNumArr[3] = param1.readDataAtPostion(4);
        this._actVo.isGet1 = param1.readDataAtPostion(5);
        this._actVo.isGet2 = param1.readDataAtPostion(6);
        this._actVo.isGet3 = param1.readDataAtPostion(7);
        this._actVo.isGet4 = param1.readDataAtPostion(8);
        this.setVo();
        this.ckeckCreate();
    }

    private function ckeckCreate():void {
        if (this.capture) {
            this.capture.removeEventListener(MouseEvent.CLICK, this.showFailDia);
            MobileManager.removeMobile(this.capture, MobileType.NPC);
        }
        if (this._actVo.currentNum < this._actVo.maxNum) {
            if (this._actVo.isFirstTo != 1 && !this.isPlay) {
                this.isPlay = true;
                MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("HalloweenFirstTo"), this.createFoe);
            } else {
                this.createFoe();
            }
        } else if (this._actVo.currentGet != 1) {
            this.createCapture();
        }
    }

    private function createCapture():void {
        if (!this.capture) {
            this.capture = new Mobile();
        }
        this.capture.buttonMode = true;
        this.capture.mouseChildren = false;
        this.capture.resourceUrl = URLUtil.getNpcSwf(167);
        this.capture.x = 270;
        this.capture.y = 345;
        this.capture.addEventListener(MouseEvent.CLICK, this.showFailDia);
        MobileManager.addMobile(this.capture, MobileType.NPC);
    }

    protected function showFailDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(41, "紫电大兵", [[0, "大哥！别打了别打了！我们这就闪人，离你们这棵树远远的，饶了我们吧。"]], ["哼哼，你是不是忘了一件事情啊……"], [function ():void {
            if (capture) {
                capture.removeEventListener(MouseEvent.CLICK, showFailDia);
                MobileManager.removeMobile(capture, MobileType.NPC);
            }
            if (_actVo.currentSeat == 0) {
                StatisticsManager.sendNovice(StatisticsManager.ui_interact_97);
            } else if (_actVo.currentSeat == 1) {
                StatisticsManager.sendNovice(StatisticsManager.ui_interact_98);
            } else if (_actVo.currentSeat == 2) {
                StatisticsManager.sendNovice(StatisticsManager.ui_interact_99);
            } else if (_actVo.currentSeat == 3) {
                StatisticsManager.sendNovice(StatisticsManager.ui_interact_100);
            }
            ModuleManager.toggleModule(URLUtil.getAppModule("HalloweenWinLotteryPanel"), "", {"buffindex": _actVo.currentSeat + 5});
        }]);
    }

    private function createFoe():void {
        var _loc5_:Mobile = null;
        var _loc6_:int = 0;
        var _loc7_:Object = null;
        var _loc8_:Point = null;
        if (this._actVo.isFirstTo != 1) {
            this._actVo.isFirstTo = 1;
            ServerBufferManager.updateServerBuffer(ServerBufferType.HALLOWEEN_BUFF, 0, 1);
        }
        var _loc1_:int = this._actVo.maxNum - this._actVo.currentNum;
        var _loc2_:int = _loc1_ % 5;
        if (_loc2_ == 0 && _loc1_ != 0) {
            _loc2_ = 5;
        }
        if (this.oldShowNum == _loc2_ && this.foeArr[0].id == this._actVo.npcId && Boolean(this.foeArr[0].parent)) {
            return;
        }
        if (_loc1_ == this._actVo.maxNum && this._actVo.isFirstTo == 1) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("SalunFull"), null, true, false, 1, false);
        }
        this.oldShowNum = _loc2_;
        var _loc3_:Array = [];
        _loc3_ = _loc3_.concat(this.seatArr);
        var _loc4_:int = 0;
        while (_loc4_ < 5) {
            if (_loc4_ < _loc2_) {
                (_loc5_ = new Mobile()).id = this._actVo.npcId;
                _loc5_.buttonMode = true;
                _loc5_.mouseChildren = false;
                _loc5_.resourceUrl = URLUtil.getNpcSwf(this._actVo.npcId);
                _loc6_ = Math.random() * _loc3_.length;
                _loc7_ = _loc3_.splice(_loc6_, 1)[0];
                _loc8_ = new Point(_loc7_.x, _loc7_.y);
                _loc5_.setPostion(_loc8_);
            }
            if (this.foeArr[_loc4_]) {
                MobileManager.removeMobile(this.foeArr[_loc4_], MobileType.NPC);
            }
            if (_loc5_) {
                MobileManager.addMobile(_loc5_, MobileType.NPC);
                _loc5_.addEventListener(MouseEvent.CLICK, this.toFight);
                this.foeArr[_loc4_] = _loc5_;
            }
            _loc4_++;
        }
    }

    protected function toFight(param1:MouseEvent):void {
        FightManager.startFightWithWild(this._actVo.fightId);
    }

    private function setVo():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.minutes <= 15) {
            this._actVo.maxNum = 20;
            this._actVo.currentGet = this._actVo.isGet1;
            this._actVo.npcId = 30;
            this._actVo.currentSeat = 0;
            this._actVo.fightId = 193;
        } else if (_loc1_.minutes <= 30) {
            this._actVo.maxNum = 15;
            this._actVo.currentGet = this._actVo.isGet2;
            this._actVo.npcId = 40;
            this._actVo.currentSeat = 1;
            this._actVo.fightId = 194;
        } else if (_loc1_.minutes <= 45) {
            this._actVo.maxNum = 10;
            this._actVo.currentGet = this._actVo.isGet3;
            this._actVo.npcId = 41;
            this._actVo.currentSeat = 2;
            this._actVo.fightId = 195;
        } else {
            this._actVo.maxNum = 1;
            this._actVo.currentGet = this._actVo.isGet4;
            this._actVo.npcId = 39;
            this._actVo.currentSeat = 3;
            this._actVo.fightId = 196;
        }
        this._actVo.currentNum = this._actVo.currentNumArr[this._actVo.currentSeat];
        if (this._actVo.currentSeat == this.recordSeat) {
            if (FightManager.isJustWinFight() && !this.isAddNum) {
                this.isAddNum = true;
                ++this._actVo.currentNum;
                this._actVo.currentNumArr[this._actVo.currentSeat] = this._actVo.currentNum;
                ServerBufferManager.updateServerBuffer(ServerBufferType.HALLOWEEN_BUFF, this._actVo.currentSeat + 1, this._actVo.currentNum);
            }
        }
        this.recordSeat = this._actVo.currentSeat;
    }
}
}

class InsTance {


    public function InsTance() {
        super();
    }
}

class ActVo {


    public var isFirstTo:int;

    public var currentNum:int;

    public var currentSeat:int;

    public var currentNumArr:Array;

    public var currentGet:int;

    public var npcId:int;

    public var isGet1:int;

    public var isGet2:int;

    public var isGet3:int;

    public var isGet4:int;

    public var fightId:int;

    public var maxNum:int;

    public function ActVo() {
        super();
    }
}
