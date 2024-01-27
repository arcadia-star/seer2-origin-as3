package com.taomee.seer2.app.event {
import flash.events.Event;

public class LogicEvent extends Event {

    public static const GOD_FIRE_PK_SELECT:String = "godFirePkSelect";

    public static const GOD_FIRE_PK_BROAD_CAST:String = "godFirePkBroadCast";

    public static const BEST_CATCH_PK_SELECT:String = "bestCatchPkSelect";

    public static const BEST_CATCH_PK_BROAD_CAST:String = "bestCatchPkBroadCast";

    public static const S_LIANYU_CLICK:String = "sLianYuClick";

    public static const S_LIANYU_UPDATE:String = "sLianYuUpdate";

    public static const KING_FIGHT_SELECT:String = "kingFightSelect";

    public static const KING_FIGHT_GET_AWARD:String = "kingFightGetAward";

    public static const WINTER_SIGN_GET_AWARD:String = "winterSignGetAward";

    public static const TRAINER_PK_UPDATE:String = "trainerPkUpdate";

    public static const HOLY_TWOER_CRISIS_UPDATE:String = "holyTowerCrisisUpdate";

    public static const EVIL_BODY_UPDATE:String = "evilBodyUpdate";

    public static const NEW_GUIDE_BROAD1:String = "newGuideBroad1";

    public static const NEW_GUIDE_BROAD2:String = "newGuideBroad2";

    public static const NEW_GUIDE_BROAD3:String = "newGuideBroad3";

    public static const NEW_GUIDE_BROAD4:String = "newGuideBroad4";

    public static const NEW_GUIDE_BROAD5:String = "newGuideBroad5";

    public static const NEW_GUIDE_BROAD6:String = "newGuideBroad6";

    public static const NEW_GUIDE_BROAD7:String = "newGuideBroad7";

    public static const NEW_GUIDE_BROAD8:String = "newGuideBroad8";


    public var obj:Object = null;

    public function LogicEvent(param1:String, param2:Object = null, param3:Boolean = false, param4:Boolean = false) {
        super(param1, param3, param4);
        this.obj = param2;
    }
}
}
