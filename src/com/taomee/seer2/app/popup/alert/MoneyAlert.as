package com.taomee.seer2.app.popup.alert {
import com.adobe.crypto.MD5;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.events.UserInfoEvent;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.IDataInput;

public class MoneyAlert extends Sprite implements IAlert {


    private var _ui:MovieClip;

    private var _leftBtn:SimpleButton;

    private var _rightBtn:SimpleButton;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _currCount:uint;

    private var _currContentTxt:TextField;

    private var _tip1Txt:TextField;

    private var _tip2Txt:TextField;

    private var _currMITxt:TextField;

    private var _currZuanTxt:TextField;

    private var _chpherMC:MovieClip;

    private var _entryTxt:TextField;

    private var _okBtn:SimpleButton;

    private var _chpherCancelBtn:SimpleButton;

    private var _confirmHandler:Function;

    private var _cancelHandler:Function;

    public function MoneyAlert() {
        super();
        this.setup();
    }

    private function setup():void {
        this._ui = UIManager.getMovieClip("UI_MoneyAlert");
        this._leftBtn = this._ui["leftBtn"];
        this._rightBtn = this._ui["rightBtn"];
        this._currContentTxt = this._ui["contentTxt"];
        this._currContentTxt.maxChars = 3;
        this._currContentTxt.restrict = "0-9";
        this._tip1Txt = this._ui["tip1Txt"];
        this._tip2Txt = this._ui["tip2Txt"];
        this._confirmBtn = this._ui["confirmBtn"];
        this._cancelBtn = this._ui["cancelBtn"];
        this._chpherMC = this._ui["chpherMC"];
        this._entryTxt = this._chpherMC["entryTxt"];
        this._entryTxt.maxChars = 16;
        this._entryTxt.displayAsPassword = true;
        this._okBtn = this._chpherMC["okBtn"];
        this._chpherCancelBtn = this._chpherMC["cancelBtn"];
        this._currMITxt = this._ui["currMITxt"];
        this._currZuanTxt = this._ui["currZuanTxt"];
        this._okBtn.addEventListener(MouseEvent.CLICK, this.onOk);
        this._chpherCancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelBtn);
        this._currContentTxt.addEventListener(Event.CHANGE, this.onChangeTxt);
        this._leftBtn.addEventListener(MouseEvent.CLICK, this.onLeft);
        this._rightBtn.addEventListener(MouseEvent.CLICK, this.onRight);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._ui["goBtn"].addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            dispose();
            ModuleManager.showAppModule("DiamondSendGiftPanel");
        });
        addChild(this._ui);
    }

    private function onOk(param1:MouseEvent):void {
        var _loc6_:String = null;
        var _loc7_:int = 0;
        var _loc2_:LittleEndianByteArray = new LittleEndianByteArray();
        var _loc3_:String = String(MD5.hash(this._entryTxt.text));
        var _loc4_:int = _loc3_.length;
        var _loc5_:int = 0;
        while (_loc5_ < _loc4_) {
            _loc6_ = _loc3_.substr(_loc5_, 2);
            _loc7_ = parseInt(_loc6_, 16);
            _loc2_.writeByte(_loc7_);
            _loc5_ += 2;
        }
        this.sendMoney(_loc2_);
    }

    private function onCancelBtn(param1:MouseEvent):void {
        this._chpherMC.visible = false;
    }

    private function onLeft(param1:MouseEvent):void {
        this._currCount = uint(this._currContentTxt.text);
        if (this._currCount > 1) {
            --this._currCount;
            this.updateCurrCount();
        }
    }

    private function onRight(param1:MouseEvent):void {
        this._currCount = uint(this._currContentTxt.text);
        if (this._currCount < 999) {
            ++this._currCount;
            this.updateCurrCount();
        }
    }

    private function onChangeTxt(param1:Event):void {
        this._currCount = uint(this._currContentTxt.text);
        this._tip1Txt.text = this._currCount.toString();
        this._tip2Txt.text = (this._currCount * 10).toString();
    }

    private function onConfirmBtnClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._currCount = uint(this._currContentTxt.text);
        if (this._currCount == 0) {
            AlertManager.showAlert("兑换数量不能为0");
            return;
        }
        PayManager.checkSetopChpher(function (param1:Boolean):void {
            var b:Boolean = param1;
            if (b) {
                ActiveCountManager.requestActiveCount(202148, function (param1:uint, param2:uint):void {
                    var _loc3_:LittleEndianByteArray = null;
                    var _loc4_:String = null;
                    var _loc5_:int = 0;
                    var _loc6_:int = 0;
                    var _loc7_:String = null;
                    var _loc8_:int = 0;
                    if (param2 != 0) {
                        _chpherMC.visible = true;
                    } else {
                        _loc3_ = new LittleEndianByteArray();
                        _loc5_ = (_loc4_ = String(MD5.hash("0"))).length;
                        _loc6_ = 0;
                        while (_loc6_ < _loc5_) {
                            _loc7_ = _loc4_.substr(_loc6_, 2);
                            _loc8_ = parseInt(_loc7_, 16);
                            _loc3_.writeByte(_loc8_);
                            _loc6_ += 2;
                        }
                        sendMoney(_loc3_);
                    }
                });
            } else {
                AlertManager.showAlert("未设置支付密码，请先设置支付密码", function ():void {
                    VipManager.setChpher();
                });
            }
        });
        event.stopImmediatePropagation();
    }

    private function sendMoney(param1:LittleEndianByteArray):void {
        Connection.addCommandListener(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onCommand);
        Connection.addErrorHandler(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onConnectionError);
        Connection.send(CommandSet.CLI_BUY_MONEY_COUNT_1254, this._currCount, param1);
    }

    private function onConnectionError(param1:MessageEvent):void {
        var event:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onCommand);
        Connection.removeErrorHandler(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onConnectionError);
        this.dispose();
        ModuleManager.showAppModule("MoneyAlertRechargePanel");
    }

    private function onCommand(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onCommand);
        Connection.removeErrorHandler(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onConnectionError);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        ActorManager.actorInfo.moneyCount = uint(_loc3_ / 100);
        if (this._confirmHandler != null) {
            this._confirmHandler();
            this._confirmHandler = null;
        }
        AlertManager.showAlert("星钻兑换成功");
        ActorManager.actorInfo.dispatchEvent(new UserInfoEvent(UserInfoEvent.UPDATE_MONEY));
    }

    private function onCancelBtnClick(param1:MouseEvent):void {
        if (this._cancelHandler != null) {
            this._cancelHandler();
            this._cancelHandler = null;
        }
        this.dispose();
        param1.stopImmediatePropagation();
    }

    private function updateCurrCount():void {
        this._currContentTxt.text = this._currCount.toString();
        this._tip1Txt.text = this._currCount.toString();
        this._tip2Txt.text = (this._currCount * 10).toString();
    }

    public function show(param1:AlertInfo):void {
        this._currCount = 1;
        this._confirmHandler = param1.initInfo.confirmHandler;
        this._cancelHandler = param1.initInfo.cancelHandler;
        this._chpherMC.visible = false;
        this.updateCurrCount();
        Connection.addCommandListener(CommandSet.MEE_COIN_INFO_1202, this.getMeeCoin);
        Connection.send(CommandSet.MEE_COIN_INFO_1202);
        AlertManager.addPopUp(param1, this);
    }

    private function getMeeCoin(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.MEE_COIN_INFO_1202, this.getMeeCoin);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:Number = _loc2_.readUnsignedInt() / 100;
        this._currMITxt.text = _loc3_.toString();
        this._currZuanTxt.text = ActorManager.actorInfo.moneyCount.toString();
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.CLI_BUY_MONEY_COUNT_1254, this.onCommand);
        this._currContentTxt.removeEventListener(Event.CHANGE, this.onChangeTxt);
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmBtnClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelBtnClick);
        this._confirmHandler = null;
        this._cancelHandler = null;
        this._ui = null;
        this._leftBtn = null;
        this._rightBtn = null;
        this._confirmBtn = null;
        this._cancelBtn = null;
        this._currContentTxt = null;
        this._tip1Txt = null;
        this._tip2Txt = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}
