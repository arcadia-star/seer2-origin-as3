package com.taomee.seer2.app.processor.quest.handler.main.quest117 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_117_80594 extends QuestMapHandler {


    public function QuestMapHandler_117_80594(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        this.initStep1();
    }

    private function initStep1():void {
        var mv:MovieClip = null;
        var mc:MovieClip = null;
        mv = SceneManager.active.mapModel.content["mv"];
        mv.gotoAndStop(1);
        mc = mv.getChildByName("mc") as MovieClip;
        NpcDialog.showDialogsByText("quest/dialog/117/1.json", function ():void {
            MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                NpcDialog.showDialogsByText("quest/dialog/117/2.json", function ():void {
                    mv.gotoAndStop(2);
                    mc = mv.getChildByName("mc") as MovieClip;
                    MovieClipUtil.playMc(mc, 2, mc.totalFrames, function ():void {
                        NpcDialog.showDialogsByText("quest/dialog/117/3.json", function ():void {
                            QuestManager.completeStep(questID, 1);
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                        });
                    });
                });
            });
        });
    }
}
}
