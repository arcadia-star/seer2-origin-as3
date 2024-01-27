package com.taomee.seer2.app.processor.activity.nextyearActivity {
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;

public class ActivityNextyear {


    private var _map:MapModel;

    private var _npc:Mobile;

    private var _startDate:uint;

    private var date:Date;

    public function ActivityNextyear(param1:MapModel) {
        this._startDate = new Date(2014, 8, 9, 14).getTime() / 1000;
        this.date = new Date(TimeManager.getServerTime() * 1000);
        super();
        this._map = param1;
        this.initNpc();
        this.initDialogEvent();
    }

    private function initNpc():void {
        this._npc = MobileManager.getMobile(462, MobileType.NPC);
    }

    private function initDialogEvent():void {
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onDialogShow);
    }

    private function onDialogShow(param1:NpcEvent):void {
        if (param1.npcDefinition.id == 462) {
            if (this.isTimerLater()) {
                param1.npcDefinition.resetFunctionalityData();
            } else {
                param1.npcDefinition.resetFunctionalityData();
                param1.npcDefinition.removeFunctionalityUnit("氏族精华兑换");
            }
        }
    }

    public function isTimerLater():Boolean {
        if (TimeManager.getServerTime() < this._startDate) {
            return false;
        }
        return true;
    }

    public function dispose():void {
        this._map = null;
    }
}
}
