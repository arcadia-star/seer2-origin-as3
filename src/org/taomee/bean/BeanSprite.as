package org.taomee.bean {
import flash.display.Sprite;

public class BeanSprite extends Sprite {


    public function BeanSprite() {
        super();
    }

    public function start():void {
    }

    protected function finish():void {
        BeanManager.initClasses();
    }
}
}
