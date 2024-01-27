package com.taomee.seer2.app.pet.data {
import com.taomee.seer2.app.config.SkillConfig;
import com.taomee.seer2.app.config.skill.HideSkillDefinition;

public class HideSkillInfo {


    private var _id:uint;

    private var _definition:HideSkillDefinition;

    public function HideSkillInfo(param1:uint) {
        super();
        this._id = param1;
        this.initialize();
    }

    private function initialize():void {
        this._definition = SkillConfig.getHideSkillDefinition(this._id);
    }

    public function get id():uint {
        return this._id;
    }

    public function get tips():String {
        if (this._definition == null) {
            return "";
        }
        return this._definition.description;
    }
}
}
