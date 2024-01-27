package com.taomee.seer2.app.actor.bubble {
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

public class Bubble extends Sprite {

    private static const MAX_LIFETIME:int = 100;

    private static const MAX_WIDTH:int = 140;

    private static const MIN_WIDTH:int = 80;


    private var _lifetime:int = 100;

    private var _elapsed:int = 0;

    private var _bubbleMc:Sprite;

    private var _msgText:TextField;

    private var _bubbleBack:MovieClip;

    private var _emotionRegExp:RegExp;

    private var _emotion:MovieClip;

    public function Bubble() {
        super();
        this.initialize();
    }

    public function show(param1:String, param2:Boolean = false):void {
        if (param1 == null) {
            param1 = "";
        }
        var _loc3_:Boolean = this.isEmotion(param1);
        if (_loc3_ == true) {
            this.showEmotion(param1);
        } else {
            this._msgText.text = param1;
            this._msgText.textColor = param2 ? 6750207 : 16777215;
            this.deployBubble();
        }
        this.startCountDown();
    }

    public function reset():void {
        removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        this._msgText.width = MAX_WIDTH;
        this._elapsed = 0;
        this._lifetime = MAX_LIFETIME;
        this.removeEmotion();
    }

    private function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
        this.initEmotionRegExp();
        this.createChildren();
    }

    private function initEmotionRegExp():void {
        this._emotionRegExp = /^\[e_\d{1,2}\]$/;
    }

    private function createChildren():void {
        this._bubbleMc = UIManager.getMovieClip("UI_ChatBubble");
        this._bubbleBack = this._bubbleMc["mcBack"];
        this._msgText = this._bubbleMc["txtMsg"];
        this._msgText.autoSize = TextFieldAutoSize.LEFT;
        this._msgText.width = MAX_WIDTH;
        this._msgText.wordWrap = true;
        addChild(this._bubbleMc);
    }

    private function isAlive():Boolean {
        return this._elapsed < this._lifetime;
    }

    private function update():void {
        ++this._elapsed;
    }

    private function isEmotion(param1:String):Boolean {
        return this._emotionRegExp.test(param1);
    }

    private function startCountDown():void {
        addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
    }

    private function onEnterFrame(param1:Event):void {
        this.update();
        if (this.isAlive() == false) {
            removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
            dispatchEvent(new Event(Event.CLOSE));
        }
    }

    private function deployBubble():void {
        if (this._msgText.textWidth > MAX_WIDTH) {
            this._msgText.wordWrap = true;
            this._msgText.width = MAX_WIDTH;
        } else if (this._msgText.textWidth < MIN_WIDTH) {
            this._msgText.width = MIN_WIDTH;
        }
        this._bubbleBack.width = this._msgText.width + 10;
        this._bubbleBack.height = this._msgText.height + 25;
    }

    private function removeEmotion():void {
        DisplayObjectUtil.removeFromParent(this._emotion);
        this._emotion = null;
    }

    private function showEmotion(param1:String):void {
        var _loc2_:String = param1.substring(3, param1.length - 1);
        this._emotion = UIManager.getMovieClip("UI_Emotion" + _loc2_);
        this._emotion.x = 20;
        this._emotion.y = -20;
        this._bubbleBack.width = 60;
        this._bubbleBack.height = 63;
        addChild(this._emotion);
    }
}
}
