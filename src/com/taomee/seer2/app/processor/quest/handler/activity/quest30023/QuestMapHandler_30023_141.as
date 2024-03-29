package com.taomee.seer2.app.processor.quest.handler.activity.quest30023 {
import com.taomee.seer2.app.actor.attach.PetKingTeamAttach;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30023_141 extends QuestMapHandler {

    public static const TEAM_INDEX:int = 3;


    private var _talkMc:MovieClip;

    private var _peopleMcBegin:MovieClip;

    private var _peopleMcEnd:MovieClip;

    public function QuestMapHandler_30023_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            if (QuestMapHandler_30023_50.isPlayTalkMc && PetKingTeamAttach.myTeamIndex == TEAM_INDEX) {
                this.playTalkMc();
            }
            SceneManager.addEventListener(SceneEvent.SWITCH_START, this.destory);
        }
    }

    private function playTalkMc():void {
        QuestMapHandler_30023_50.isPlayTalkMc = false;
        this._talkMc = _processor.resLib.getMovieClip("talk3");
        this._peopleMcBegin = _processor.resLib.getMovieClip("talk3_1");
        LayerManager.topLayer.addChild(this._peopleMcBegin);
        LayerManager.topLayer.addChild(this._talkMc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(this._talkMc, 1, this._talkMc.totalFrames, function ():void {
            DisplayUtil.removeForParent(_talkMc);
            playCartoon();
        });
    }

    private function playCartoon():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30023_141"), 3, [[1, 0]], function ():void {
            _peopleMcEnd = _processor.resLib.getMovieClip("talk3_2");
            DisplayUtil.removeForParent(_peopleMcBegin);
            LayerManager.mapLayer.addChild(_peopleMcEnd);
            _peopleMcEnd.gotoAndPlay(2);
            MovieClipUtil.playMc(_peopleMcEnd, 1, _peopleMcEnd.totalFrames, function ():void {
                DisplayUtil.removeForParent(_peopleMcEnd);
                finishActivity();
                QuestManager.completeStep(_quest.id, 1);
                QuestManager.addEventListener(QuestEvent.COMPLETE, complateStep);
            });
        });
    }

    private function complateStep(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.complateStep);
        SwapManager.swapItem(477, 1, function (param1:IDataInput):void {
            var _loc2_:SwapInfo = new SwapInfo(param1);
        });
    }

    private function destory(param1:Event):void {
        this.finishActivity();
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.destory);
    }

    private function finishActivity():void {
        DisplayUtil.removeForParent(this._talkMc);
        DisplayUtil.removeForParent(this._peopleMcBegin);
        DisplayUtil.removeForParent(this._peopleMcEnd);
        this._talkMc = null;
        this._peopleMcBegin = null;
        this._peopleMcEnd = null;
        LayerManager.resetOperation();
    }
}
}
