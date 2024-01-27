package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.gameRule.spt.SptFanErNiSupport;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3830 extends MapProcessor {


    public function MapProcessor_3830(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        if (this.isQuestProcess(79) || this.isQuestProcess(92) || this.isQuestProcess(93)) {
            _map.content["npc"].visible = false;
            _map.content["sptFanErNi"].visible = false;
        } else {
            SptFanErNiSupport.getInstance().init(_map);
        }
    }

    private function isQuestProcess(param1:uint):Boolean {
        if (QuestManager.isAccepted(param1)) {
            return true;
        }
        return false;
    }

    override public function dispose():void {
        super.dispose();
        SptFanErNiSupport.getInstance().dispose();
    }
}
}
