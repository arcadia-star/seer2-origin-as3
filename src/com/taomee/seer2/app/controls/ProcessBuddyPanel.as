package com.taomee.seer2.app.controls {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.group.UserGroupManager;
import com.taomee.seer2.app.actor.group.UserGroupType;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.Util;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.FocusEvent;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.StringUtil;

public class ProcessBuddyPanel extends Sprite {

    private static const USER_ID_TIPS:String = "请输入对方米米号";

    public static const ADD_BUDDY:int = 0;

    public static const REMOVE_BUDDY:int = 1;

    public static const ADD_BLACK:int = 2;


    private var _container:MovieClip;

    private var _titleMC:MovieClip;

    private var _userIdTxt:TextField;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _processType:int;

    private var _userId:uint;

    public function ProcessBuddyPanel(param1:int, param2:Point) {
        super();
        this.createChildren();
        this.initEventListener();
        this.updateDisplay(param1, param2);
    }

    private function createChildren():void {
        this._container = UIManager.getMovieClip("UI_ProcessBuddyPanel");
        addChild(this._container);
        this._titleMC = this._container["title"];
        this._titleMC.gotoAndStop(1);
        this._userIdTxt = this._container["userID"];
        this._userIdTxt.restrict = "0-9";
        this._confirmBtn = this._container["confirm"];
        this._cancelBtn = this._container["cancel"];
    }

    private function initEventListener():void {
        this._userIdTxt.addEventListener(FocusEvent.FOCUS_IN, this.onUserIdFocusIn);
        this._userIdTxt.addEventListener(FocusEvent.FOCUS_OUT, this.onUserIdFocusOut);
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelClick);
    }

    private function onUserIdFocusIn(param1:FocusEvent):void {
        this._userIdTxt.text = "";
    }

    private function onUserIdFocusOut(param1:FocusEvent):void {
        if (this._userIdTxt.text == "") {
            this.resetUserIdTxt();
        }
    }

    private function onConfirmClick(param1:MouseEvent):void {
        var _loc3_:uint = 0;
        var _loc2_:String = String(StringUtil.trim(this._userIdTxt.text));
        if (Util.verifyUserID(_loc2_)) {
            _loc3_ = parseInt(_loc2_);
            if (this.verifyUser(_loc3_)) {
                this._userId = _loc3_;
                this.processUser();
                return;
            }
        } else {
            AlertManager.showAlert("需要输入有效的米米号");
        }
        this.resetUserIdTxt();
    }

    private function verifyUser(param1:uint):Boolean {
        var _loc2_:Boolean = false;
        switch (this._processType) {
            case ADD_BUDDY:
                _loc2_ = this.verifyAddBuddy(param1);
                break;
            case REMOVE_BUDDY:
                _loc2_ = this.verifyRemoveBuddy(param1);
                break;
            case ADD_BLACK:
                _loc2_ = this.verifyAddBlack(param1);
        }
        return _loc2_;
    }

    private function verifyAddBuddy(param1:uint):Boolean {
        var _loc2_:Boolean = true;
        var _loc3_:uint = ActorManager.actorInfo.id;
        if (param1 == _loc3_) {
            AlertManager.showAlert("不能添加自己为好友");
            _loc2_ = false;
        } else if (UserGroupManager.containsUser(UserGroupType.BUDDY, param1)) {
            AlertManager.showAlert("该用户已经是你的好友了");
            _loc2_ = false;
        }
        return _loc2_;
    }

    private function verifyRemoveBuddy(param1:uint):Boolean {
        var _loc2_:Boolean = true;
        var _loc3_:uint = ActorManager.actorInfo.id;
        if (param1 == _loc3_) {
            AlertManager.showAlert("好友列表中找不到该用户");
            _loc2_ = false;
        } else if (UserGroupManager.containsUser(UserGroupType.BUDDY, param1) == false) {
            AlertManager.showAlert("好友列表中找不到该用户");
            _loc2_ = false;
        }
        return _loc2_;
    }

    private function verifyAddBlack(param1:uint):Boolean {
        var _loc2_:Boolean = true;
        var _loc3_:uint = ActorManager.actorInfo.id;
        if (param1 == _loc3_) {
            AlertManager.showAlert("不能把自己添加到黑名单");
            _loc2_ = false;
        } else if (UserGroupManager.containsUser(UserGroupType.BLACK, param1)) {
            AlertManager.showAlert("该用户已经在你的黑名单中");
            _loc2_ = false;
        }
        return _loc2_;
    }

    private function processUser():void {
        switch (this._processType) {
            case ADD_BUDDY:
                AlertManager.showConfirm("是否要添加" + this._userId + "为你的好友？", this.onAddBuddyConfirm);
                break;
            case REMOVE_BUDDY:
                AlertManager.showConfirm("你是否要从好友列表中删除" + this._userId, this.onRemoveBuddyConfirm);
                break;
            case ADD_BLACK:
                Connection.send(CommandSet.BUDDY_ADD_1024, this._userId, LittleEndianByteArray.writeIntergerAsUnsignedByte(1));
        }
    }

    private function onAddBuddyConfirm():void {
        Connection.send(CommandSet.BUDDY_ADD_1024, this._userId, LittleEndianByteArray.writeIntergerAsUnsignedByte(0));
        this.hide();
    }

    private function onRemoveBuddyConfirm():void {
        Connection.send(CommandSet.BUDDY_REMOVE_1025, this._userId, LittleEndianByteArray.writeIntergerAsUnsignedByte(0));
        this.hide();
    }

    private function onCancelClick(param1:MouseEvent):void {
        this.hide();
    }

    private function resetUserIdTxt():void {
        this._userIdTxt.text = USER_ID_TIPS;
    }

    private function updateDisplay(param1:int, param2:Point):void {
        this._processType = param1;
        this._titleMC.gotoAndStop(param1 + 1);
        this.x = param2.x;
        this.y = param2.y;
        this.resetUserIdTxt();
    }

    public function show():void {
        DisplayObjectUtil.enableSprite(this);
        this.resetUserIdTxt();
    }

    public function hide():void {
        DisplayObjectUtil.disableSprite(this);
        DisplayObjectUtil.removeFromParent(this);
    }

    public function get processType():int {
        return this._processType;
    }

    public function dispose():void {
        this._userIdTxt.removeEventListener(FocusEvent.FOCUS_IN, this.onUserIdFocusIn);
        this._userIdTxt.removeEventListener(FocusEvent.FOCUS_OUT, this.onUserIdFocusOut);
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._confirmBtn = null;
        this._cancelBtn = null;
        this._titleMC = null;
        this._container = null;
    }
}
}
