package com.taomee.seer2.app.processor.quest.handler.main.quest94 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_94_3837 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_94_3837(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        } else {
            RightToolbarConter.instance.hide();
            ActorManager.getActor().hide();
            ActorManager.getActor().blockFollowingPet = true;
            ActorManager.getActor().blockNoNo = true;
            if (QuestManager.isStepComplete(94, 2) && !QuestManager.isStepComplete(94, 3)) {
                this._mc1 = _processor.resLib.getMovieClip("Mc94_0");
                this._mc1.x = 615;
                this._mc1.y = 346.4;
                _map.front.addChild(this._mc1);
                this._mc1.gotoAndStop(1);
                MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    NpcDialog.show(400, "赛尔", [[0, "就是那个家伙吧！快追！."]], ["（返回超能广场）"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                        QuestManager.completeStep(questID, 3);
                    }]);
                }, true);
            } else if (QuestManager.isStepComplete(94, 2) && QuestManager.isStepComplete(94, 3)) {
                this.onStep(null);
            }
        }
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 226;
        this._mouseHint.y = 323;
        _map.front.addChild(this._mouseHint);
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
