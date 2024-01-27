package com.taomee.seer2.app.processor.quest.handler.branch.quest10115 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class DreamQuest50000 extends QuestMapHandler {


    protected var seer:MovieClip;

    protected var toSceneId:int;

    protected var isInTime:Boolean = false;

    private var overDay:int;

    public function DreamQuest50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        if (this.seer) {
            this.seer.removeEventListener(MouseEvent.CLICK, this.clickSeer);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        var _loc4_:int = 0;
        super.processMapComplete();
        this.seer = _processor.resLib.getMovieClip("SleepSeer");
        this.isInTime = false;
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc2_:int = int(_quest.id);
        this.overDay = _loc1_.date - 10;
        if (this.overDay <= 0) {
            return;
        }
        var _loc3_:int = 1;
        while (_loc3_ < 6) {
            _loc4_ = 10114 + _loc3_;
            if (this.overDay == _loc3_ && _loc2_ > _loc4_) {
                return;
            }
            _loc3_++;
        }
        this.isInTime = true;
        this.seer.buttonMode = true;
        _map.content.addChild(this.seer);
        this.seer.addEventListener(MouseEvent.CLICK, this.clickSeer);
        ActorManager.hideActor();
    }

    protected function clickSeer(param1:MouseEvent):void {
        this.seer.removeEventListener(MouseEvent.CLICK, this.clickSeer);
        if (!QuestManager.isAccepted(_quest.id) && QuestManager.isCanAccepted(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
            QuestManager.accept(_quest.id);
            return;
        }
        if (!QuestManager.isComplete(_quest.id)) {
            SceneManager.changeScene(SceneType.LOBBY, this.toSceneId);
        }
    }

    protected function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, this.toSceneId);
        }
    }
}
}
