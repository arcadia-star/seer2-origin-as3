package com.taomee.seer2.app.processor.quest.handler.branch.quest10222 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10222_80154 extends QuestMapHandler {


    private var _mc3:MovieClip;

    private var _mc4:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10222_80154(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10222) && QuestManager.isStepComplete(10222, 2) == false) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc3 = _processor.resLib.getMovieClip("mc3");
        _map.front.addChild(this._mc3);
        this._mack = new AcceptableMark();
        this._mack.x = 512;
        this._mack.y = 208;
        _map.front.addChild(this._mack);
        this._mc3["sitanyin"].buttonMode = true;
        this._mc3["sitanyin"].addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        DisplayUtil.removeForParent(this._mc3);
        this._mc4 = _processor.resLib.getMovieClip("mc4");
        _map.front.addChild(this._mc4);
        MovieClipUtil.playMc(this._mc4, 2, this._mc4.totalFrames, function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10222_2"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onStepComplete);
                QuestManager.completeStep(10222, 2);
            }, true, true);
        }, true);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc3);
        DisplayUtil.removeForParent(this._mc4);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
