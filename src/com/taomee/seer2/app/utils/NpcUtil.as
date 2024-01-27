package com.taomee.seer2.app.utils {
import com.taomee.seer2.app.actor.ActorManager;

public class NpcUtil {


    public function NpcUtil() {
        super();
    }

    public static function getSeerNpcId():int {
        if (ActorManager.getActor().getInfo().sex == 0) {
            return 502;
        }
        return 501;
    }
}
}
