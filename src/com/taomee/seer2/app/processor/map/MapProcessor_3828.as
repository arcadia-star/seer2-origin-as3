package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.npcFight3828.NpcFight3828Manager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

public class MapProcessor_3828 extends MapProcessor {


    private var QuestID:int = 92;

    public function MapProcessor_3828(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        NpcFight3828Manager.init();
    }

    override public function dispose():void {
        NpcFight3828Manager.clear();
        super.dispose();
    }
}
}
