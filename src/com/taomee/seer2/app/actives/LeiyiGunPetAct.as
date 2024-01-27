package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actives.leiyiGun.OutputFree;
import com.taomee.seer2.app.actives.leiyiGun.OutputPay;
import com.taomee.seer2.core.scene.SceneManager;

public class LeiyiGunPetAct {

    public static var pay_act:OutputPay = new OutputPay();

    private static var free_act:OutputFree = new OutputFree();

    private static var mapId:int;


    public function LeiyiGunPetAct() {
        super();
    }

    public static function setup():void {
        mapId = SceneManager.active.mapID;
        if (mapId == 80033) {
            pay_act.setup();
        } else {
            free_act.setup();
        }
    }

    public static function dispose():void {
        if (mapId == 80033) {
            pay_act.dispose();
        } else {
            free_act.dispose();
        }
    }
}
}
