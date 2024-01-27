package com.taomee.seer2.app.component {
import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class Combobox extends Sprite {


    private var _mainUI:MovieClip;

    private var _listMc:MovieClip;

    private var _dropBtn:SimpleButton;

    private var _editorTxt:TextField;

    private var _listScroller:Scroller;

    private var _stepSize:int = 0;

    private var _pageSize:int = 0;

    private var _maxScrollPosition:int = 0;

    private var _callback:Function = null;

    public function Combobox(param1:MovieClip) {
        super();
        this._mainUI = param1;
        this.initView();
        this.initEvent();
    }

    private function initView():void {
        this._dropBtn = this._mainUI["dropBtn"];
        this._editorTxt = this._mainUI["editorTxt"];
        this._listMc = this._mainUI["listMc"];
        this._listMc.visible = false;
        this._listScroller = new Scroller(this._listMc["scroller"]);
        this._listScroller.wheelObject = this._listMc["contentMc"];
        this._listScroller.x = this._listMc.width - this._listScroller.width;
        this._listMc.addChild(this._listScroller);
    }

    private function initEvent():void {
        this._dropBtn.addEventListener(MouseEvent.CLICK, this.onDropBtn);
    }

    private function onDropBtn(param1:MouseEvent):void {
        if (this._listMc.visible) {
            this._listMc.visible = false;
        } else {
            this._listMc.visible = true;
        }
    }

    public function addScrollerListener(param1:Function):void {
        this._callback = param1;
        this._listScroller.addEventListener(Scroller.END, this.updateItmeInfo);
        this._listScroller.addEventListener(Scroller.MOVE, this.updateItmeInfo);
    }

    private function updateItmeInfo(param1:Event):void {
        if (this._callback != null) {
            this._callback();
        }
    }

    public function set editorTxt(param1:String):void {
        this._editorTxt.text = param1;
        if (this._listMc.visible) {
            this._listMc.visible = false;
        }
    }

    public function get editorTxt():String {
        return this._editorTxt.text;
    }

    public function set pageSize(param1:int):void {
        this._pageSize = param1;
        this._listScroller.pageSize = param1;
    }

    public function get pageSize():int {
        return this._pageSize;
    }

    public function set maxScrollPosition(param1:int):void {
        this._maxScrollPosition = param1;
        this._listScroller.maxScrollPosition = param1;
    }

    public function set stepSize(param1:int):void {
        this._stepSize = param1;
        this._listScroller.stepSize = param1;
    }

    public function get stepSize():int {
        return this._stepSize;
    }

    public function set scrollPosition(param1:int):void {
        this._listScroller.scrollPosition = param1;
    }

    public function get scrollPosition():int {
        return this._listScroller.scrollPosition;
    }

    public function dispose():void {
        this._listScroller.dispose();
        if (this._dropBtn) {
            this._dropBtn.removeEventListener(MouseEvent.CLICK, this.onDropBtn);
            this._dropBtn = null;
        }
    }
}
}
