package com.taomee.seer2.app.dialog.functionality {
import flash.display.DisplayObject;
import flash.display.Graphics;
import flash.display.Shape;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFieldType;
import flash.text.TextFormat;

import org.taomee.utils.DisplayUtil;

public class BaseUnit extends Sprite {


    private var _type:String;

    private var _params:String;

    private var _label:String;

    private var _priority:int;

    private var _btn:SimpleButton;

    private var _labelFormat:TextFormat;

    protected var _icon:DisplayObject;

    public function BaseUnit() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseEnabled = false;
    }

    public function set type(param1:String):void {
        this._type = param1;
        this.addIcon();
    }

    public function get type():String {
        return this._type;
    }

    public function set priority(param1:int):void {
        this._priority = param1;
    }

    public function get priority():int {
        return this._priority;
    }

    protected function addIcon():void {
        throw new Error("Should be overrided in subclass");
    }

    public function set label(param1:String):void {
        this._label = param1;
        this.createBtn();
    }

    public function get label():String {
        return this._label;
    }

    public function set params(param1:String):void {
        this._params = param1;
    }

    public function get params():String {
        return this._params;
    }

    private function createBtn():void {
        var _loc1_:Sprite = this.createBtnState(16777113);
        var _loc2_:Sprite = this.createBtnState(9696572);
        var _loc3_:Sprite = this.createBtnState(16777113);
        var _loc4_:Shape = this.createBtnHitState(_loc3_.width);
        this._btn = new SimpleButton(_loc1_, _loc2_, _loc3_, _loc4_);
        this._btn.addEventListener(MouseEvent.CLICK, this.onBtnClick);
        this._btn.y = -20;
        this._btn.x = 30;
        addChild(this._btn);
    }

    public function clearEvent():void {
        this._btn.removeEventListener(MouseEvent.CLICK, this.onBtnClick);
    }

    public function createColorBtn(param1:uint):void {
        DisplayUtil.removeForParent(this._btn);
        var _loc2_:Sprite = this.createBtnState(param1);
        var _loc3_:Sprite = this.createBtnState(param1);
        var _loc4_:Sprite = this.createBtnState(param1);
        var _loc5_:Shape = this.createBtnHitState(_loc4_.width);
        this._btn = new SimpleButton(_loc2_, _loc3_, _loc4_, _loc5_);
        this._btn.addEventListener(MouseEvent.CLICK, this.onBtnClick);
        this._btn.y = -20;
        this._btn.x = 30;
        addChild(this._btn);
    }

    protected function onBtnClick(param1:MouseEvent):void {
        throw new Error("Should be overrided in subclasses");
    }

    private function createBtnState(param1:uint):Sprite {
        if (this._labelFormat == null) {
            this._labelFormat = new TextFormat();
            this._labelFormat.size = 14;
            this._labelFormat.underline = true;
        }
        this._labelFormat.color = param1;
        var _loc2_:Sprite = new Sprite();
        var _loc3_:TextField = new TextField();
        _loc3_.defaultTextFormat = this._labelFormat;
        _loc3_.type = TextFieldType.DYNAMIC;
        _loc3_.selectable = false;
        _loc3_.autoSize = TextFieldAutoSize.LEFT;
        _loc3_.text = this._label;
        _loc2_.addChild(_loc3_);
        return _loc2_;
    }

    private function createBtnHitState(param1:int):Shape {
        var _loc2_:Shape = new Shape();
        var _loc3_:Graphics = _loc2_.graphics;
        _loc3_.beginFill(16777215, 0);
        _loc3_.drawRect(0, 0, param1, 25);
        _loc3_.endFill();
        return _loc2_;
    }
}
}
