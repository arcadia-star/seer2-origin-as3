package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;

public class ZhuaChapter3Map extends MapProcessor {


    private const MAP_IDS:Array = [5205, 5105, 4705, 4905, 4805];

    private const FIGHT_IDS:Array = [505, 506, 507, 508, 509];

    private const NPC_IDS:Array = [55, 55, 55, 55, 55];

    private var index:int;

    private var npc:Mobile;

    private var mark:AcceptableMark;

    public function ZhuaChapter3Map(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        DialogPanel.removeCloseEventListener(this.onClose);
    }

    override public function init():void {
        super.init();
        this.index = this.MAP_IDS.indexOf(_map.id);
        DialogPanel.addCloseEventListener(this.onClose);
        this.mark = new AcceptableMark();
        this.npc = MobileManager.getMobile(this.NPC_IDS[this.index], MobileType.NPC);
        this.npc.addOverHeadMark(this.mark);
        if (_map.front["activityDialogPanel"]) {
            DisplayObjectUtil.removeFromParent(_map.front["activityDialogPanel"]);
        }
        if (_map.front["activityVoidPanel"]) {
            DisplayObjectUtil.removeFromParent(_map.front["activityVoidPanel"]);
        }
    }

    private function onClose(param1:DialogCloseEvent):void {
        this.npc.removeOverHeadMark();
        var _loc2_:String = param1.params;
        if (_loc2_ == "fight_monster") {
            DialogPanel.removeCloseEventListener(this.onClose);
            FightManager.addEventListener(FightStartEvent.FIGHT_OVER, this.onOver);
            FightManager.startFightWithWild(this.FIGHT_IDS[this.index]);
        }
    }

    private function onOver(param1:Event):void {
        var event:Event = param1;
        this.npc.removeOverHeadMark();
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, this.onOver);
        if (FightManager.isJustWinFight()) {
            if (this.index == 4) {
                NpcDialog.show(55, "神月老大", [[0, "算了算了，开来你今天非带我去见神爪财团老板，也罢，就陪你去次吧！"]], ["太好了"], [function ():void {
                    AlertManager.showAlert("神月老大终于答应了，赶快去找神爪财团老板！", function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                        QuestManager.completeStep(10197, 1);
                    });
                }]);
            } else {
                NpcDialog.show(55, "神月老大", [[0, "不错，有点身手，但是想要我去见神爪财团老板，门都没有，再见！"]], ["打开约瑟传说"], [function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("ZhuaBeastPanel"), "", "3");
                }]);
            }
        }
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == 10197 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            SceneManager.changeScene(SceneType.LOBBY, 320);
        }
    }
}
}
