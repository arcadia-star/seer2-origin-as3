package com.taomee.seer2.app.vip.data {
import flash.events.Event;
import flash.events.EventDispatcher;
import flash.utils.IDataInput;

public class VipInfo extends EventDispatcher {

    public static const ENERGY_CHANGE:String = "energyChange";

    public static const VIP_UPDATE:String = "vipUpdate";

    public static const LUCKY_UPDATE:String = "luckyUpdate";


    public var vipFlag:int;

    public var payFlag:int;

    public var level:uint;

    public var _point:uint;

    public var totalPoint:uint;

    public var leftDay:int;

    private var _currentEnergy:int;

    public var totalEnergy:int;

    public var energyBall:int;

    public var equipeBallCnt:uint;

    public var equipeBallVec:Vector.<uint>;

    public var onceVipFlag:int;

    public var luckyLeftDay:int;

    public var luckyMsgType:int;

    public var luckyFlag:int;

    public function VipInfo() {
        super();
    }

    public function readBase(param1:IDataInput):void {
        var _loc3_:uint = 0;
        this.payFlag = param1.readUnsignedInt();
        this.vipFlag = param1.readUnsignedByte();
        this.setLevel(param1.readUnsignedByte());
        this._point = param1.readUnsignedInt();
        this.leftDay = param1.readUnsignedInt();
        this.equipeBallCnt = param1.readUnsignedInt();
        this.equipeBallVec = new Vector.<uint>();
        var _loc2_:int = 0;
        while (_loc2_ < this.equipeBallCnt) {
            _loc3_ = uint(param1.readUnsignedInt());
            this.equipeBallVec.push(_loc3_);
            _loc2_++;
        }
        this.energyBall = param1.readUnsignedInt();
        this.currentEnergy = param1.readUnsignedInt();
        this.totalEnergy = param1.readUnsignedInt();
        this.onceVipFlag = param1.readUnsignedByte();
        this.luckyLeftDay = param1.readUnsignedByte();
        this.luckyMsgType = param1.readUnsignedByte();
        this.luckyFlag = param1.readUnsignedByte();
    }

    public function set currentEnergy(param1:int):void {
        this.dispatchEvent(new Event(ENERGY_CHANGE));
    }

    public function updateVip():void {
        this.dispatchEvent(new Event(VIP_UPDATE));
    }

    public function get currentEnergy():int {
        return this.currentEnergy;
    }

    public function set point(param1:int):void {
        this._point = param1;
        this.dispatchEvent(new Event(ENERGY_CHANGE));
    }

    public function get point():int {
        return this._point;
    }

    public function paserUserSimpleInfo(param1:IDataInput):void {
        this.vipFlag = param1.readUnsignedByte();
        this.setLevel(param1.readUnsignedByte());
    }

    public function parseVipUpdate(param1:IDataInput):void {
        this.payFlag = param1.readUnsignedInt();
        this.vipFlag = param1.readUnsignedByte();
        this.setLevel(param1.readUnsignedByte());
        this._point = param1.readUnsignedInt();
        this.currentEnergy = param1.readUnsignedInt();
        this.totalEnergy = param1.readUnsignedInt();
        this.leftDay = param1.readUnsignedInt();
        dispatchEvent(new Event(VIP_UPDATE));
    }

    private function setLevel(param1:int):void {
        this.level = param1;
        this.setTotalPoint();
    }

    private function setTotalPoint():void {
        switch (this.level) {
            case 1:
                this.totalPoint = 150;
                break;
            case 2:
                this.totalPoint = 550;
                break;
            case 3:
                this.totalPoint = 1300;
                break;
            case 4:
                this.totalPoint = 2600;
                break;
            case 5:
                this.totalPoint = 2600;
        }
    }

    public function isVip():Boolean {
        return this.vipFlag > 0;
    }

    public function isRealVip():Boolean {
        return this.vipFlag == 1;
    }
}
}
