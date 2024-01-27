package org.taomee.manager {
import flash.display.DisplayObjectContainer;
import flash.display.Stage;

public class TaomeeManager {

    private static var _root:DisplayObjectContainer;

    private static var _stageHeight:int = 560;

    private static var _stageWidth:int = 960;

    private static var _stage:Stage;


    public function TaomeeManager() {
        super();
    }

    public static function set root(param1:DisplayObjectContainer):void {
        _root = param1;
    }

    public static function get stage():Stage {
        return _stage;
    }

    public static function get stageWidth():int {
        return _stageWidth;
    }

    public static function get root():DisplayObjectContainer {
        return _root;
    }

    public static function get stageHeight():int {
        return _stageHeight;
    }

    public static function set stage(param1:Stage):void {
        _stage = param1;
    }

    public static function setup(param1:DisplayObjectContainer, param2:Stage):void {
        _root = param1;
        _stage = param2;
    }

    public static function stageSize(param1:int, param2:int):void {
        _stageWidth = param1;
        _stageHeight = param2;
    }
}
}
