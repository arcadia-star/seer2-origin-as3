package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actives.fireClaw.FireClawFreeMode;
import com.taomee.seer2.app.actives.fireClaw.FireClawPayMode;
import com.taomee.seer2.core.scene.SceneManager;

public class FireClawAct {

    public static var pay_act:FireClawPayMode = new FireClawPayMode();

    private static var free_act:FireClawFreeMode = new FireClawFreeMode();

    private static var mapId:int;


    public function FireClawAct() {
        super();
    }

    public static function setup():void {
        mapId = SceneManager.active.mapID;
        if (mapId == 80042) {
            pay_act.setup();
        } else {
            free_act.setup();
        }
    }

    public static function dispose():void {
        if (mapId == 80042) {
            pay_act.dispose();
        } else {
            free_act.dispose();
        }
    }
}
}
