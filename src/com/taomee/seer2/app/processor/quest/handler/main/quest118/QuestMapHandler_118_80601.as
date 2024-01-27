package com.taomee.seer2.app.processor.quest.handler.main.quest118 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_118_80601 extends QuestMapHandler {


    public function QuestMapHandler_118_80601(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        var mv:MovieClip = null;
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        mv = SceneManager.active.mapModel.content["mv"];
        NpcDialog.showDialogsByText("quest/dialog/118/3.json", function ():void {
            MovieClipUtil.playMc(mv, 2, mv.totalFrames, function ():void {
                NpcDialog.showDialogsByText("quest/dialog/118/4.json", function ():void {
                    QuestManager.completeStep(questID, 1);
                    SceneManager.changeScene(SceneType.LOBBY, 70);
                });
            });
        }, null);
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
