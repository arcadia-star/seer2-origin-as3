package com.taomee.seer2.app.component {
import flash.display.DisplayObjectContainer;
import flash.display.MovieClip;
import flash.events.Event;
import flash.text.TextField;

public class TextScroller extends Scroller {


    private var _textField:TextField;

    private var _container:DisplayObjectContainer;

    private var _isScrolling:Boolean;

    public function TextScroller(param1:MovieClip) {
        super(param1);
        this._container = param1;
    }

    public function setTextField(param1:TextField):void {
        this._textField = param1;
        this._textField.mouseEnabled = false;
        this._textField.mouseWheelEnabled = false;
        this.initTextScollEventListener();
        this.initScrollEventListener();
    }

    private function initTextScollEventListener():void {
        this._textField.addEventListener(Event.SCROLL, this.onTextScroll);
    }

    private function onTextScroll(param1:Event):void {
        if (this._isScrolling == false) {
            this.update();
        }
    }

    private function update():void {
        this.maxScrollPosition = this._textField.maxScrollV + this.pageSize - 1;
        this.scrollPosition = this.maxScrollPosition - this.pageSize;
    }

    private function initScrollEventListener():void {
        addEventListener(Scroller.START, this.onScrollStart);
        addEventListener(Scroller.MOVE, this.onScrollerMove);
        addEventListener(Scroller.END, this.onScrollEnd);
    }

    private function onScrollStart(param1:Event):void {
        this._isScrolling = true;
    }

    private function onScrollEnd(param1:Event):void {
        this._isScrolling = false;
    }

    private function onScrollerMove(param1:Event):void {
        this._textField.scrollV = this.scrollPosition + 1;
    }

    override public function dispose():void {
        this._textField.removeEventListener(Event.SCROLL, this.onTextScroll);
        super.dispose();
    }
}
}
