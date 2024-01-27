package com.taomee.seer2.app.processor.quest.handler.branch.quest10126 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.gameRule.fish.FishEventDispatcher;
import com.taomee.seer2.app.gameRule.fish.FishingEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_10126_220 extends QuestMapHandler {


    private var _mobile:Mobile;

    private var mouseHit:MouseClickHintSprite;

    public function QuestMapHandler_10126_220(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        FishEventDispatcher.getInstance().removeEventListener(FishingEvent.FISHING, this.onFishing);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(2) && Boolean(DateUtil.isInTime(new Date(2012, 8, 21, 23), new Date(2012, 8, 25, 23)))) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        this._mobile = new Mobile();
        this._mobile.resourceUrl = URLUtil.getPetSwf(51);
        ActorManager.getActor().addCarriedMobile(this._mobile, 80);
        this.mouseHit = new MouseClickHintSprite();
        this.mouseHit.x = 315;
        this.mouseHit.y = 160;
        _map.content.addChild(this.mouseHit);
        FishEventDispatcher.getInstance().addEventListener(FishingEvent.FISHING, this.onFishing);
    }

    private function onFishing(param1:FishingEvent):void {
        var event:FishingEvent = param1;
        DisplayObjectUtil.removeFromParent(this.mouseHit);
        ActorManager.getActor().removeCarriedMobile(this._mobile);
        if (event.itemId != 400806) {
            AlertManager.showAlert("呕耶，我们太厉害啦，没有哪条鱼是我们的对手！", function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                QuestManager.completeStep(_quest.id, 2);
            });
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 2) {
            ModuleManager.closeAll();
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            ModuleManager.toggleModule(URLUtil.getAppModule("ABaoExercisePanel"));
        }
    }
}
}
