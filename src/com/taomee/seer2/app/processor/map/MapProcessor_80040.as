package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class MapProcessor_80040 extends MapProcessor {


    private var fightId:uint = 556;

    public function MapProcessor_80040(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DisplayObjectUtil.removeFromParent(_map.content["handbook"]);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.showNpcChallengePanel);
    }

    private function showNpcChallengePanel(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "fightAiLiSi") {
            FightManager.startFightWithWild(this.fightId);
        }
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.showNpcChallengePanel);
        super.dispose();
    }
}
}
