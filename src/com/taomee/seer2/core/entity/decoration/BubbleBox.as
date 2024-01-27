package com.taomee.seer2.core.entity.decoration {
import flash.display.Sprite;

public class BubbleBox extends Sprite {


    public function BubbleBox() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this.mouseChildren = false;
        this.mouseEnabled = false;
    }
}
}
