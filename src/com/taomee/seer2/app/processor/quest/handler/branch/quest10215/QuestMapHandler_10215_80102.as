package com.taomee.seer2.app.processor.quest.handler.branch.quest10215 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10215_80102 extends QuestMapHandler {


    private var _mc3:MovieClip;

    public function QuestMapHandler_10215_80102(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10215) && QuestManager.isStepComplete(10215, 2) == false) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        NpcDialog.show(678, "战神杰瑞", [[0, "是谁！……啊龙王！你怎么随便带了一个陌生人回来……大胆狂徒！滚出神域！"]], ["……这是上演孙悟空大闹天空吗？"], [function ():void {
            _mc3 = _processor.resLib.getMovieClip("mc3");
            _map.front.addChild(_mc3);
            MovieClipUtil.playMc(_mc3, 2, _mc3.totalFrames, function ():void {
                DisplayUtil.removeForParent(_mc3);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10215_2"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                    QuestManager.completeStep(10215, 2);
                }, true);
            }, true);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 3815);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        DisplayUtil.removeForParent(this._mc3);
    }
}
}
