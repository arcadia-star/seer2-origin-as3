package com.taomee.seer2.app.npc {
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;

import flash.geom.Point;

public class ActMobile extends Mobile {


    public function ActMobile() {
        super();
    }

    public function showMobile(param1:String, param2:Point):void {
        this.resourceUrl = param1;
        this.buttonMode = true;
        this.mouseChildren = false;
        this.x = param2.x;
        this.y = param2.y;
        MobileManager.addMobile(this, MobileType.NPC);
    }

    public function clear():void {
        MobileManager.removeMobile(this, MobileType.NPC);
    }
}
}
