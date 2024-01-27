package org.taomee.manager {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.core.DragSource;
import org.taomee.events.DragEvent;
import org.taomee.utils.DisplayUtil;

public class DragManager {

    public static const NONE:String = "none";

    private static var _dragImage:Bitmap;

    private static var _dragSource:DragSource;

    public static const MOVE:String = "move";

    private static var _mouseTarget:InteractiveObject;

    private static var _isDragging:Boolean = false;

    private static var _dragInitiator:InteractiveObject;

    private static var _dropAction:String;

    private static var _offset:Point;

    public static const COPY:String = "copy";

    public static const LINK:String = "link";

    private static var _allowMove:Boolean = true;

    private static var _dropTarget:InteractiveObject;


    public function DragManager() {
        super();
    }

    public static function acceptDragDrop(param1:InteractiveObject):void {
        _dropTarget = param1;
    }

    public static function get dropAction():String {
        return _dropAction;
    }

    private static function upDateImageMove():void {
        if (_dragImage) {
            _dragImage.x = TaomeeManager.stage.mouseX - _offset.x;
            _dragImage.y = TaomeeManager.stage.mouseY - _offset.y;
        }
    }

    public static function set dropAction(param1:String):void {
        _dropAction = param1;
    }

    private static function clear():void {
        _dragInitiator = null;
        _dropTarget = null;
        _mouseTarget = null;
        _dragSource = null;
        _offset = null;
        _dropAction = NONE;
        if (_dragImage) {
            if (_dragImage.bitmapData) {
                _dragImage.bitmapData.dispose();
            }
            DisplayUtil.removeForParent(_dragImage);
            _dragImage = null;
        }
    }

    private static function onStageOver(param1:MouseEvent):void {
        (param1.target as InteractiveObject).dispatchEvent(new DragEvent(DragEvent.DRAG_ENTER, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
    }

    public static function get isDragging():Boolean {
        return _isDragging;
    }

    public static function get dragInitiator():InteractiveObject {
        return _dragInitiator;
    }

    public static function doDrag(param1:InteractiveObject, param2:DragSource, param3:BitmapData = null, param4:Point = null, param5:Boolean = true):void {
        if (_isDragging) {
            return;
        }
        _isDragging = true;
        _dropAction = NONE;
        _offset = new Point();
        _dragInitiator = param1;
        _dragSource = param2;
        if (param3) {
            if (_dragImage == null) {
                _dragImage = new Bitmap();
            }
            _dragImage.bitmapData = param3;
            if (param4) {
                _offset = param4;
            }
            TaomeeManager.stage.addChild(_dragImage);
            upDateImageMove();
        }
        _allowMove = param5;
        TaomeeManager.stage.addEventListener(MouseEvent.MOUSE_OVER, onStageOver);
        TaomeeManager.stage.addEventListener(MouseEvent.MOUSE_OUT, onStageOut);
        TaomeeManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMove);
        TaomeeManager.stage.addEventListener(MouseEvent.MOUSE_UP, onStageUp);
        _dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_START, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
    }

    private static function onStageUp(param1:MouseEvent):void {
        endDrag();
    }

    private static function onStageOut(param1:MouseEvent):void {
        (param1.target as InteractiveObject).dispatchEvent(new DragEvent(DragEvent.DRAG_EXIT, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
    }

    public static function endDrag():void {
        _isDragging = false;
        TaomeeManager.stage.removeEventListener(MouseEvent.MOUSE_OVER, onStageOver);
        TaomeeManager.stage.removeEventListener(MouseEvent.MOUSE_OUT, onStageOut);
        TaomeeManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMove);
        TaomeeManager.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageUp);
        if (_dragInitiator) {
            _dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_COMPLETE, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
        }
        if (Boolean(_dropTarget) && Boolean(_mouseTarget)) {
            if (_dropTarget == _mouseTarget) {
                _dropTarget.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
            }
        }
        clear();
    }

    private static function onStageMove(param1:MouseEvent):void {
        upDateImageMove();
        _dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_UPEATE, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
        _mouseTarget = param1.target as InteractiveObject;
        _mouseTarget.dispatchEvent(new DragEvent(DragEvent.DRAG_OVER, _dragInitiator, _dropTarget, _dragSource, _dropAction, _allowMove));
    }
}
}
