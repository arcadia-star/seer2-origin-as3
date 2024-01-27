package com.taomee.seer2.app.component {
import flash.display.Sprite;

public class PetPotentialityIcon extends Sprite {


    private var _potentialIcon:IconDisplayer;

    private var _numContainer:Sprite;

    public function PetPotentialityIcon() {
        super();
        this.createChildren();
    }

    private function createChildren():void {
        this._potentialIcon = new IconDisplayer();
        this._numContainer = new Sprite();
        addChild(this._potentialIcon);
    }

    public function setPotential(param1:uint, param2:Boolean = false):void {
    }

    private function getIconId(param1:uint, param2:Boolean = false):int {
        if (param1 >= 0 && param1 <= 11) {
            return 1;
        }
        if (param1 >= 12 && param1 <= 21) {
            return 2;
        }
        if (param1 >= 22) {
            if (param2) {
                if (param1 >= 22 && param1 <= 23) {
                    return 4;
                }
                if (param1 >= 24 && param1 <= 27) {
                    return 5;
                }
                if (param1 >= 28 && param1 <= 30) {
                    return 6;
                }
                return 7;
            }
            return 3;
        }
        return 0;
    }
}
}
