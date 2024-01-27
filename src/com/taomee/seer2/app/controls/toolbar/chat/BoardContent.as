package com.taomee.seer2.app.controls.toolbar.chat {
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
import com.taomee.seer2.app.component.TextScroller;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.Sprite;
import flash.events.TextEvent;
import flash.text.TextField;

public class BoardContent extends Sprite {


    private const MAX_SAVED_NUM:uint = 20;

    private const PAGE_SIZE:uint = 10;

    private var _chatTxt:TextField;

    private var _msgContent:String;

    private var _scroller:TextScroller;

    private var _receivedMessageVec:Vector.<ChatReceivedMessage>;

    private var _emotionRegExp:RegExp;

    public function BoardContent(param1:TextField) {
        super();
        this._chatTxt = param1;
        addChild(this._chatTxt);
        this.initialize();
    }

    private function initialize():void {
        this._receivedMessageVec = new Vector.<ChatReceivedMessage>();
        this._emotionRegExp = /^\[e_\d{1,2}\]$/;
        this.createScoller();
        this.initEventListener();
    }

    private function createScoller():void {
        this._scroller = new TextScroller(UIManager.getMovieClip("UI_Toolbar_ScrollerHolder"));
        this._scroller.pageSize = this.PAGE_SIZE;
        this._scroller.x = 200;
        this._scroller.y = 23;
        this._scroller.wheelObject = this;
        this._scroller.setTextField(this._chatTxt);
        addChild(this._scroller);
    }

    private function initEventListener():void {
        this._chatTxt.addEventListener(TextEvent.LINK, this.onTextLink);
    }

    public function appendMessage(param1:ChatReceivedMessage):void {
        if (this.isEmotionToken(param1.message)) {
            return;
        }
        if (this._receivedMessageVec.length == this.MAX_SAVED_NUM) {
            this._receivedMessageVec.shift();
        }
        this._receivedMessageVec.push(param1);
        this.updateText();
    }

    private function isEmotionToken(param1:String):Boolean {
        return this._emotionRegExp.test(param1);
    }

    private function updateText():void {
        var _loc1_:ChatReceivedMessage = null;
        var _loc2_:String = null;
        this.clear();
        for each(_loc1_ in this._receivedMessageVec) {
            _loc2_ = this.formatMessage(_loc1_);
            this.appendText(_loc2_);
        }
        this._chatTxt.htmlText = this._msgContent;
        this._chatTxt.scrollV = this._chatTxt.maxScrollV;
    }

    private function onTextLink(param1:TextEvent):void {
    }

    public function setPosition(param1:Number, param2:Number):void {
        this.x = param1;
        this.y = param2;
    }

    private function formatMessage(param1:ChatReceivedMessage):String {
        var _loc2_:String = param1.senderNick;
        var _loc3_:String = param1.message;
        var _loc4_:String;
        return (_loc4_ = this.convertNameToLink(_loc2_)) + _loc3_;
    }

    private function convertNameToLink(param1:String):String {
        return "<a href = \'event:" + param1 + "#\'><font color=\'#FFFF00\'>" + param1 + "</font></a>: ";
    }

    private function clear():void {
        this._msgContent = "";
    }

    private function appendText(param1:String):void {
        if (this._msgContent == "") {
            this._msgContent += param1;
        } else {
            this._msgContent = this._msgContent + "\n" + param1;
        }
    }
}
}
