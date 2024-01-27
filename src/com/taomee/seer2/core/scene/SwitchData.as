package com.taomee.seer2.core.scene {
import flash.geom.Point;

public class SwitchData {

    public static const SWITCH_SCENE:String = "swtichScene";

    public static const SWITCH_MAP:String = "swtichMap";


    public var sceneType:int;

    public var mapId:int;

    public var resourceId:int;

    public var postion:Point;

    public var switchType:String;

    public var isSkipValidate:Boolean;

    public var userBehavior:int;

    public function SwitchData(param1:int, param2:int, param3:int, param4:int, param5:Boolean, param6:int) {
        super();
        this.sceneType = param1;
        this.mapId = param2;
        this.resourceId = param2;
        if (!(param3 == 0 && param4 == 0)) {
            this.postion = new Point(param3, param4);
        }
        if (Boolean(SceneManager.active) && SceneManager.active.type == param1) {
            this.switchType = SWITCH_MAP;
        } else {
            this.switchType = SWITCH_SCENE;
        }
        this.isSkipValidate = param5;
        this.userBehavior = param6;
    }
}
}
