package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.events.MouseEvent;

public class MapProcessor_80226 extends MapProcessor {


    private const GANEN_FIGHT:uint = 5040;

    private const FIGHT_INDEX:uint = 1100;

    private const NPC_ID:uint = 767;

    private var useCount:uint;

    private var _npc:Mobile;

    public function MapProcessor_80226(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DayLimitManager.getDoCount(this.GANEN_FIGHT, this.getCount);
    }

    private function getCount(param1:uint):void {
        this.useCount = param1;
        this._npc = MobileManager.getMobile(this.NPC_ID, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc, false, 10);
    }

    protected function onNpc(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(this.NPC_ID, "圣灵天尊", [[0, "愿这大地充满感恩，救赎的光芒将带给你们力量"]], ["请允许我和您挑战一下 ", "圣灵真是太美了"], [function ():void {
            if (useCount != 1) {
                FightManager.addEventListener(FightStartEvent.FIGHT_OVER, onOver);
                FightManager.startFightWithBoss(FIGHT_INDEX);
            } else {
                AlertManager.showAlert("每天只能挑战一次哦!");
            }
        }]);
    }

    private function onOver(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.onOver);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onShow);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function onShow(param1:SceneEvent):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onShow);
        ModuleManager.showAppModule("ShengLingTianZunPanel", true);
    }
}
}
