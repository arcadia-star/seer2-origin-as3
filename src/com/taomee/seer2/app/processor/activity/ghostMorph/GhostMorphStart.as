package com.taomee.seer2.app.processor.activity.ghostMorph {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.MovieClip;

public class GhostMorphStart {


    public function GhostMorphStart() {
        super();
    }

    public static function startMorph(param1:Actor):void {
        var _loc2_:MovieClip = null;
        if (param1.getInfo().activityData != null && param1.getInfo().activityData.length >= 3 && param1.getInfo().activityData[2] == 1 && param1.getInfo().morphInfo.numberId == 0) {
            _loc2_ = UIManager.getMovieClip("UI_Morph");
            _loc2_.y = -110;
            _loc2_.x = -20;
            param1.addMorph(_loc2_);
            param1.getInfo().morphInfo.numberId = 1;
        }
        if (param1.getInfo().activityData != null && param1.getInfo().activityData.length >= 3 && param1.getInfo().activityData[2] == 0) {
            param1.removeMorph();
            param1.getInfo().morphInfo.numberId = 0;
        }
    }
}
}
