package com.taomee.seer2.app.processor.quest.handler.main.quest122 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.events.MouseEvent;

public class QuestMapHandler_122_80615 extends QuestMapHandler {


    public function QuestMapHandler_122_80615(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        SceneManager.active.mapModel.content["badi"].addEventListener(MouseEvent.CLICK, this.onBaDiClick);
    }

    private function onBaDiClick(param1:* = null):void {
        var e:* = param1;
        NpcDialog.showDialogsByText("quest/dialog/122/4.json", function ():void {
            QuestManager.completeStep(questID, 1);
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }, null);
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
