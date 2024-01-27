package com.taomee.seer2.app.arena.ui.toolbar.sub {
import com.taomee.seer2.app.pet.data.SkillInfo;

public interface ISkillButton {


    function getSkillInfo():SkillInfo;

    function get enabled():Boolean;
}
}
