package com.taomee.seer2.app.plantSystem.tip {
import flash.display.InteractiveObject;

public class PlantTipManager {

    private static var _toolTip:PlantTooltip;


    public function PlantTipManager() {
        super();
    }

    public static function setup():void {
        if (_toolTip == null) {
            _toolTip = new PlantTooltip();
        }
    }

    public static function addExternalTip(param1:InteractiveObject, param2:InteractiveObject, param3:String, param4:String, param5:uint, param6:uint):void {
        _toolTip.add(param1, param2, param3, param4, param5, param6, new PlantTipSkin());
    }

    public static function addItemTip(param1:InteractiveObject, param2:String):void {
        _toolTip.addItem(param1, param2, new PlantItemSkin());
    }

    public static function addIconTip(param1:InteractiveObject, param2:String, param3:uint, param4:Boolean):void {
        _toolTip.addIcon(param1, param2, param3, param4, new PlantIconSkin());
    }

    public static function changeTip(param1:InteractiveObject, param2:InteractiveObject, param3:String, param4:String, param5:uint, param6:uint):void {
        _toolTip.chanegTip(param1, param2, param3, param4, param5, param6);
    }

    public static function changeItemTip(param1:InteractiveObject, param2:String):void {
        _toolTip.chanegItemTip(param1, param2);
    }

    public static function changeIconTip(param1:InteractiveObject, param2:String, param3:uint, param4:Boolean):void {
        _toolTip.chanegIconTip(param1, param2, param3, param4);
    }

    public static function remove(param1:InteractiveObject, param2:InteractiveObject):void {
        _toolTip.remove(param1, param2);
    }

    public static function removeIcon(param1:InteractiveObject):void {
        _toolTip.removeIcon(param1);
    }

    public static function removeItem(param1:InteractiveObject):void {
        _toolTip.removeItem(param1);
    }
}
}
