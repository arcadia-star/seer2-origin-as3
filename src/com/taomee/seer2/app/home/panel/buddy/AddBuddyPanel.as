package com.taomee.seer2.app.home.panel.buddy {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.group.UserGroupManager;
import com.taomee.seer2.app.actor.group.UserGroupType;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.LittleEndianByteArray;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.Util;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.utils.StringUtil;

public class AddBuddyPanel extends Sprite {


    private var _container:MovieClip;

    private var _userIdTxt:TextField;

    private var _confirmBtn:SimpleButton;

    private var _cancelBtn:SimpleButton;

    private var _dragMc:MovieClip;

    public function AddBuddyPanel() {
        super();
        this.createChildren();
        this.initEventListener();
    }

    private function createChildren():void {
        this.x = 330;
        this.y = 210;
        this._container = UIManager.getMovieClip("UI_AddBuddyPanel");
        this._userIdTxt = this._container["userId"];
        this._userIdTxt.restrict = "0-9";
        this._confirmBtn = this._container["confirm"];
        this._cancelBtn = this._container["cancel"];
        this._dragMc = this._container["drag"];
    }

    private function initEventListener():void {
        this._confirmBtn.addEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.addEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._dragMc.buttonMode = true;
        this._dragMc.addEventListener(MouseEvent.MOUSE_DOWN, this.onDragStart);
        this._dragMc.addEventListener(MouseEvent.MOUSE_UP, this.onDragEnd);
    }

    private function disposeEventListener():void {
        this._confirmBtn.removeEventListener(MouseEvent.CLICK, this.onConfirmClick);
        this._cancelBtn.removeEventListener(MouseEvent.CLICK, this.onCancelClick);
        this._dragMc.buttonMode = false;
        this._dragMc.removeEventListener(MouseEvent.MOUSE_DOWN, this.onDragStart);
        this._dragMc.removeEventListener(MouseEvent.MOUSE_UP, this.onDragEnd);
    }

    private function onConfirmClick(param1:MouseEvent):void {
        var _loc3_:uint = 0;
        var _loc2_:String = String(StringUtil.trim(this._userIdTxt.text));
        if (Util.verifyUserID(_loc2_)) {
            _loc3_ = parseInt(_loc2_);
            if (this.verifyUser(_loc3_)) {
                this.hide();
                Connection.send(CommandSet.BUDDY_ADD_1024, _loc3_, LittleEndianByteArray.writeIntergerAsUnsignedByte(0));
            }
        }
    }

    private function onDragStart(param1:MouseEvent):void {
        DisplayObjectUtil.bringToTop(this);
        this.startDrag();
    }

    private function onDragEnd(param1:MouseEvent):void {
        this.stopDrag();
    }

    private function verifyUser(param1:uint):Boolean {
        var _loc2_:Boolean = true;
        var _loc3_:uint = ActorManager.actorInfo.id;
        if (param1 == _loc3_) {
            _loc2_ = false;
        } else if (UserGroupManager.containsUser(UserGroupType.BUDDY, param1)) {
            _loc2_ = false;
        }
        return _loc2_;
    }

    private function onCancelClick(param1:MouseEvent):void {
        this.hide();
    }

    public function hide():void {
        DisplayObjectUtil.removeFromParent(this._container);
    }

    public function show():void {
        this._userIdTxt.text = "";
        this.addChild(this._container);
    }

    public function dispose():void {
        this.disposeEventListener();
    }
}
}
