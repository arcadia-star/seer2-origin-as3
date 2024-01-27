package com.taomee.seer2.app.processor.quest.handler.activity.quest30012 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30012_870 extends QuestMapHandler {


    private var npc:MovieClip;

    public function QuestMapHandler_30012_870(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        this.npc = _processor.resLib.getMovieClip("NPC");
        this.npc.x = 572;
        this.npc.y = 256;
        _map.front.addChild(this.npc);
        this.npc.buttonMode = true;
        this.npc.addEventListener(MouseEvent.CLICK, this.clickNpc);
    }

    private function clickNpc(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(120, "老婆婆", [[0, "哟！你这赛小息的帽子不错？能借给婆婆开开眼界吗？这跟我以前孩子的帽子好像……"]], ["可是……米咔……"], [function ():void {
            NpcDialog.show(120, "老婆婆", [[0, "算了算了！婆婆的一个心愿而已……我只是想我孩儿了……555555……55555"]], ["婆婆你别哭！我给你就是！"], [function ():void {
                playAnimation();
            }]);
        }]);
    }

    private function playAnimation():void {
        MovieClipUtil.playMc(this.npc, 11, this.npc.totalFrames, function ():void {
            _map.front.removeChild(npc);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30012_0"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(_quest.id, 2);
            });
        });
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 30012) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.npc) {
            this.npc.removeEventListener(MouseEvent.CLICK, this.clickNpc);
        }
        super.dispose();
    }
}
}
