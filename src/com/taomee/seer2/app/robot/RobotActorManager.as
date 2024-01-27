package com.taomee.seer2.app.robot {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import org.taomee.ds.HashMap;
import org.taomee.utils.DisplayUtil;

public class RobotActorManager {

    private static var robotActorMap:HashMap = new HashMap();

    private static var curtRobotId:int = 0;


    public function RobotActorManager() {
        super();
    }

    public static function addRobotActor(param1:UserInfo):void {
        var _loc2_:RobotActor = null;
        if (!robotActorMap.containsKey(param1.id)) {
            curtRobotId = param1.id;
            _loc2_ = new RobotActor(param1);
            robotActorMap.add(param1.id, _loc2_);
            _loc2_.stand();
            _loc2_.show();
            if (Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel)) {
                SceneManager.active.mapModel.content.addChild(_loc2_);
            }
        }
    }

    public static function removeRobotActor(param1:int):void {
        var _loc2_:RobotActor = getRobotActor(param1);
        if (_loc2_ != null) {
            DisplayObjectUtil.removeFromParent(_loc2_);
            _loc2_.dispose();
            robotActorMap.remove(param1);
        }
    }

    public static function getRobotActor(param1:int):RobotActor {
        if (robotActorMap.containsKey(param1)) {
            return robotActorMap.getValue(param1) as RobotActor;
        }
        return null;
    }

    public static function removeAllRobotActor():void {
        robotActorMap.eachValue(function (param1:RobotActor):void {
            param1.dispose();
            DisplayUtil.removeForParent(param1);
        });
        robotActorMap.clear();
    }

    public static function update():void {
        robotActorMap.eachValue(function (param1:RobotActor):void {
            param1.update();
        });
    }
}
}
