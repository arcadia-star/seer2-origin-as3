package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_1331 extends DreamMapProcessor {


    public function MapProcessor_1331(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ActorManager.getActor().alpha = 0.5;
        ActorManager.getActor().getNono().alpha = 0.5;
        if (ActorManager.getActor().getFollowingPet()) {
            ActorManager.getActor().getFollowingPet().alpha = 0.5;
        }
    }
}
}
