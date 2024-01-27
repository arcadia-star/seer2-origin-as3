package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_10000 extends DreamMapProcessor {


    public function MapProcessor_10000(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ActorManager.hideActor();
    }
}
}
