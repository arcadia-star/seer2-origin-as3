package org.taomee.manager {
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.InteractiveObject;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.ui.Mouse;

import org.taomee.utils.DisplayUtil;

public class CursorManager {

    public static var container:DisplayObjectContainer = TaomeeManager.stage;

    private static var _cursor:DisplayObject;

    private static var _offset:Point;


    public function CursorManager() {
        super();
    }

    public static function removeCursor():void {
        if (!_cursor) {
            return;
        }
        container.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
        DisplayUtil.removeForParent(_cursor);
        _cursor = null;
        Mouse.show();
    }

    public static function bringToFront():void {
        if (_cursor) {
            container.addChild(_cursor);
        }
    }

    private static function onMouseMove(param1:MouseEvent):void {
        _cursor.x = container.mouseX + _offset.x;
        _cursor.y = container.mouseY + _offset.y;
        param1.updateAfterEvent();
    }

    public static function setCursor(param1:DisplayObject, param2:Point = null, param3:Boolean = true):void {
        if (_cursor) {
            removeCursor();
        }
        if (param3) {
            Mouse.hide();
        }
        _cursor = param1;
        if (_cursor is InteractiveObject) {
            InteractiveObject(_cursor).mouseEnabled = false;
            if (_cursor is DisplayObjectContainer) {
                DisplayObjectContainer(_cursor).mouseChildren = false;
            }
        }
        if (param2 == null) {
            param2 = new Point();
        }
        _offset = param2;
        _cursor.x = container.mouseX + _offset.x;
        _cursor.y = container.mouseY + _offset.y;
        container.addChild(_cursor);
        container.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
    }
}
}
