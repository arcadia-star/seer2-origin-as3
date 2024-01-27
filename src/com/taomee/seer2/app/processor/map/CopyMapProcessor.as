package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class CopyMapProcessor extends MapProcessor {


    public function CopyMapProcessor(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ActorManager.forceHide = true;
    }

    override public function dispose():void {
        ActorManager.forceHide = false;
    }
}
}
