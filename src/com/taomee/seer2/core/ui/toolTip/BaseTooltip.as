package com.taomee.seer2.core.ui.toolTip {
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.toolTip.tipSkins.BaseTipSkin;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.InteractiveObject;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.MouseEvent;

import org.taomee.ds.HashMap;

internal class BaseTooltip extends Sprite {

    private static const VERTICAL_GAP:int = 10;

    private static const LEFT_OFFSET:int = 10;


    private var _map:HashMap;

    private var _currentTipSkin:BaseTipSkin;

    public function BaseTooltip() {
        super();
        this._map = new HashMap();
    }

    public function add(param1:InteractiveObject, param2:String, param3:BaseTipSkin, param4:Function = null, param5:Function = null, param6:* = null):void {
        if (this._map.containsKey(param1)) {
            this.chanegTip(param1, param2);
            return;
        }
        param1.addEventListener(MouseEvent.ROLL_OVER, this.onTargetOver);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.onTargetOut);
        var _loc7_:TipStuct;
        (_loc7_ = new TipStuct()).tip = param2;
        _loc7_.tipSkin = param3;
        _loc7_.over = param4;
        _loc7_.out = param5;
        _loc7_.content = param6;
        this._map.add(param1, _loc7_);
    }

    public function remove(param1:InteractiveObject):void {
        var _loc2_:TipStuct = null;
        if (Boolean(this._map.containsKey(param1)) && this._map.getValue(param1) is TipStuct) {
            param1.removeEventListener(MouseEvent.ROLL_OVER, this.onTargetOver);
            param1.removeEventListener(MouseEvent.ROLL_OUT, this.onTargetOut);
            _loc2_ = this._map.getValue(param1) as TipStuct;
            _loc2_.tipSkin.hide();
            this._map.remove(param1);
        } else if (this._map.containsKey(param1)) {
            param1.removeEventListener(MouseEvent.ROLL_OVER, this.artTipsControl);
            param1.removeEventListener(MouseEvent.ROLL_OUT, this.artTipsControl);
            param1.removeEventListener(MouseEvent.MOUSE_MOVE, this.artTipsControl);
            DisplayObjectUtil.removeFromParent(this._map.getValue(param1));
            this._map.remove(param1);
        }
    }

    public function chanegTip(param1:InteractiveObject, param2:String):void {
        var _loc3_:TipStuct = null;
        if (this._map.containsKey(param1)) {
            _loc3_ = this._map.getValue(param1);
            _loc3_.tip = param2;
        }
    }

    public function setData(param1:InteractiveObject, param2:Object):void {
        var _loc3_:TipStuct = null;
        if (this._map.containsKey(param1)) {
            _loc3_ = this._map.getValue(param1);
            _loc3_.tipSkin.setData(param2);
        }
    }

    public function addArtTips(param1:InteractiveObject, param2:DisplayObject):void {
        if (this._map.containsKey(param1)) {
            return;
        }
        param1.addEventListener(MouseEvent.ROLL_OVER, this.artTipsControl);
        param1.addEventListener(MouseEvent.ROLL_OUT, this.artTipsControl);
        this._map.add(param1, param2);
    }

    private function artTipsControl(param1:MouseEvent):void {
        var _loc2_:InteractiveObject = param1.currentTarget as InteractiveObject;
        var _loc3_:DisplayObject = this._map.getValue(_loc2_) as DisplayObject;
        if (param1.type == MouseEvent.ROLL_OVER) {
            _loc2_.addEventListener(MouseEvent.MOUSE_MOVE, this.artTipsControl);
            this.updateArtTips(_loc3_);
        } else if (param1.type == MouseEvent.ROLL_OUT) {
            _loc2_.removeEventListener(MouseEvent.MOUSE_MOVE, this.artTipsControl);
            DisplayObjectUtil.removeFromParent(_loc3_);
        } else if (param1.type == MouseEvent.MOUSE_MOVE) {
            this.updateArtTips(_loc3_);
        }
    }

    private function updateArtTips(param1:DisplayObject):void {
        var _loc2_:Stage = LayerManager.stage;
        if (!_loc2_.contains(param1)) {
            _loc2_.addChild(param1);
        }
        if (_loc2_.mouseX > _loc2_.stageWidth - param1.width) {
            param1.x = _loc2_.mouseX - param1.width;
        } else {
            param1.x = _loc2_.mouseX;
        }
        if (_loc2_.mouseY > _loc2_.stageHeight - param1.height) {
            param1.y = _loc2_.mouseY - param1.height;
        } else {
            param1.y = _loc2_.mouseY;
        }
    }

    private function onTargetOver(param1:MouseEvent):void {
        var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
        if (_loc2_) {
            _loc2_.tipSkin.show(_loc2_.tip);
            if (_loc2_.over != null) {
                _loc2_.over(_loc2_.content);
            }
            this._currentTipSkin = _loc2_.tipSkin;
            this.deployTooltip(param1.stageX, param1.stageY - VERTICAL_GAP);
        }
        LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.onTooltipMove);
    }

    private function onTargetOut(param1:MouseEvent):void {
        var _loc2_:TipStuct = this._map.getValue(param1.currentTarget as InteractiveObject) as TipStuct;
        _loc2_.tipSkin.hide();
        if (_loc2_.out != null) {
            _loc2_.out();
        }
        this._currentTipSkin = null;
        LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.onTooltipMove);
    }

    private function onTooltipMove(param1:MouseEvent):void {
        this.deployTooltip(param1.stageX, param1.stageY - VERTICAL_GAP);
    }

    private function deployTooltip(param1:int, param2:int):void {
        if (null == this._currentTipSkin) {
            return;
        }
        var _loc3_:Stage = LayerManager.stage;
        if (_loc3_.mouseX > _loc3_.stageWidth - this._currentTipSkin.width) {
            this._currentTipSkin.x = _loc3_.mouseX - this._currentTipSkin.width + 60;
        } else {
            this._currentTipSkin.x = _loc3_.mouseX;
        }
        if (_loc3_.mouseY > _loc3_.stageHeight - this._currentTipSkin.height) {
            if (this._currentTipSkin.parent) {
                this._currentTipSkin.y = this._currentTipSkin.parent.mouseY - this._currentTipSkin.height + 60;
            }
        } else {
            this._currentTipSkin.y = _loc3_.mouseY;
            if (this._currentTipSkin.height > 65) {
                this._currentTipSkin.y -= this._currentTipSkin.height / 2;
            }
        }
    }
}
}

import com.taomee.seer2.core.ui.toolTip.tipSkins.BaseTipSkin;

class TipStuct {


    public var tip:String;

    public var tipSkin:BaseTipSkin;

    public var over:Function;

    public var out:Function;

    public var content:*;

    public function TipStuct() {
        super();
    }
}
