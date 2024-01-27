package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.inventory.item.SpecialItem;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.ui.Mouse;

import org.taomee.utils.DisplayUtil;

public class PlantMouse {

    private static var _item:SpecialItem;

    private static var _icon:IconDisplayer;

    private static var _mouse:MovieClip;

    public static var isMouse:Boolean = false;


    public function PlantMouse() {
        super();
    }

    public static function getMouse(param1:SpecialItem):MovieClip {
        _item = param1;
        var _loc2_:uint = uint(PlantContent.getType(_item));
        return UIManager.getMovieClip("plantMouse" + _loc2_);
    }

    public static function getRemove():MovieClip {
        return UIManager.getMovieClip("plantMouse1");
    }

    public static function startSwapMouse(param1:MovieClip):void {
        _mouse = param1;
        isMouse = true;
        _mouse.mouseChildren = false;
        _mouse.mouseEnabled = false;
        _mouse.x = LayerManager.stage.mouseX - _mouse.width / 2;
        _mouse.y = LayerManager.stage.mouseY - _mouse.height / 2;
        LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
        LayerManager.stage.addChild(_mouse);
    }

    private static function onMove(param1:MouseEvent):void {
        _mouse.x = LayerManager.stage.mouseX - _mouse.width / 2;
        _mouse.y = LayerManager.stage.mouseY - _mouse.height / 2;
    }

    public static function endSwapMouse():void {
        isMouse = false;
        DisplayUtil.removeForParent(_mouse);
        LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        Mouse.show();
    }

    public static function startMouse(param1:MovieClip):void {
        _mouse = param1;
        isMouse = true;
        Mouse.hide();
        _mouse.x = LayerManager.stage.mouseX - _mouse.width / 2;
        _mouse.y = LayerManager.stage.mouseY - _mouse.height / 2;
        LayerManager.stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
    }

    public static function endMouse():void {
        isMouse = false;
        LayerManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
        Mouse.show();
    }
}
}
