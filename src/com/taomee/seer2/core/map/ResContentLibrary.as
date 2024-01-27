package com.taomee.seer2.core.map {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.DisplayObject;

public class ResContentLibrary {

    private static var resList:Array = [];

    private static var initList:Array = [];

    private static var pointList:Array = [];

    private static var mouseList:Array = [];

    private static var scaleList:Array = [];

    private static var initYList:Array = [];


    public function ResContentLibrary() {
        super();
    }

    public static function updateRes():void {
        var _loc1_:DisplayObject = null;
        var _loc2_:int = 0;
        while (_loc2_ < resList.length) {
            _loc1_ = resList[_loc2_];
            if (Boolean(_loc1_) && Boolean(_loc1_.parent)) {
                _loc1_.x = 120 - (1200 - LayerManager.stage.stageWidth) / 240 * 120;
                _loc1_.y = 50 - (660 - LayerManager.stage.stageHeight) / 100 * 50;
            }
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < scaleList.length) {
            _loc1_ = scaleList[_loc2_];
            if (Boolean(_loc1_) && Boolean(_loc1_.parent)) {
                _loc1_.scaleX = LayerManager.stage.stageWidth / 1200;
                _loc1_.scaleY = LayerManager.stage.stageHeight / 660;
            }
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < initList.length) {
            _loc1_ = initList[_loc2_];
            if (Boolean(_loc1_) && Boolean(_loc1_.parent)) {
                _loc1_.x = (LayerManager.stage.stageWidth - 1200) / 2;
                _loc1_.y = (LayerManager.stage.stageHeight - 660) / 2;
            }
            _loc2_++;
        }
        _loc2_ = 0;
        while (_loc2_ < initYList.length) {
            _loc1_ = initYList[_loc2_];
            if (Boolean(_loc1_) && Boolean(_loc1_.parent)) {
                _loc1_.y = (LayerManager.stage.stageHeight - 660) / 2;
            }
            _loc2_++;
        }
    }

    public static function setInitYValue(param1:DisplayObject):void {
        if (initYList.indexOf(param1) == -1) {
            initYList.push(param1);
        }
    }

    public static function clearInitYValue(param1:DisplayObject):void {
        if (initYList.indexOf(param1) != -1) {
            initYList.splice(initYList.indexOf(param1), 1);
        }
    }

    public static function setInitValue(param1:DisplayObject):void {
        if (initList.indexOf(param1) == -1) {
            initList.push(param1);
        }
    }

    public static function clearInitValue(param1:DisplayObject):void {
        if (initList.indexOf(param1) != -1) {
            initList.splice(initList.indexOf(param1), 1);
        }
    }

    public static function setValue(param1:DisplayObject):void {
        if (resList.indexOf(param1) == -1) {
            resList.push(param1);
        }
    }

    public static function setScaleValue(param1:DisplayObject):void {
        if (scaleList.indexOf(param1) == -1) {
            clearValue(param1);
            param1.x = 0;
            param1.y = 0;
            param1.scaleX = LayerManager.stage.stageWidth / 1200;
            param1.scaleY = LayerManager.stage.stageHeight / 660;
            scaleList.push(param1);
        }
    }

    public static function clearValue(param1:DisplayObject):void {
        if (resList.indexOf(param1) != -1) {
            resList.splice(resList.indexOf(param1), 1);
        }
    }
}
}
