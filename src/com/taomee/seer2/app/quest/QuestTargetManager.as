package com.taomee.seer2.app.quest {
import com.taomee.seer2.app.quest.target.BaseQuestStepTarget;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.quest.data.TargetDefinition;

import org.taomee.ds.HashMap;

public class QuestTargetManager {

    private static var _targetMap:HashMap = new HashMap();

    private static var _target:BaseQuestStepTarget;


    public function QuestTargetManager() {
        super();
    }

    public static function initTarget(param1:Quest):void {
        var _loc2_:TargetDefinition = param1.getCurrentOrNextStep().target;
        if (!_targetMap.containsKey(_loc2_)) {
            _target = BaseQuestStepTarget.createTarget(param1, _loc2_);
            _target.start();
            _targetMap.add(_loc2_, _target);
        }
    }

    public static function disposeTarget(param1:Quest):void {
        var _loc2_:TargetDefinition = param1.getCurrentOrNextStep().target;
        if (_targetMap.containsKey(_loc2_)) {
            (_targetMap.getValue(_loc2_) as BaseQuestStepTarget).finish();
            _targetMap.remove(_loc2_);
        }
    }
}
}
