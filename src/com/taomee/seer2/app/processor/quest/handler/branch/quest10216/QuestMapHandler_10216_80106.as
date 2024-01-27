package com.taomee.seer2.app.processor.quest.handler.branch.quest10216 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10216_80106 extends QuestMapHandler {


    private var _forwardBtn:SimpleButton;

    private var _sceneMove:MovieClip;

    private var _bgMc:MovieClip;

    private var _step:uint = 0;

    public function QuestMapHandler_10216_80106(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(2)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
        if (isNeedCompleteStep(3)) {
            this.initStep3();
        }
        if (isNeedCompleteStep(4)) {
            this.initStep4();
        }
        if (isNeedCompleteStep(5)) {
            this.initStep5();
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._forwardBtn) {
            DisplayUtil.removeForParent(this._forwardBtn);
            DisplayUtil.removeForParent(this._bgMc);
            this._forwardBtn.removeEventListener(MouseEvent.CLICK, this.forwardHandler);
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        var sceneMc:MovieClip = null;
        var event:QuestEvent = param1;
        if (event.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            if (event.stepId == 2) {
                sceneMc = _processor.resLib.getMovieClip("SceneMc1");
                LayerManager.topLayer.addChild(sceneMc);
                MovieClipUtil.playMc(sceneMc, 1, sceneMc.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(sceneMc);
                    initStep3();
                });
            }
            if (event.stepId == 3) {
                this.initStep4();
            }
            if (event.stepId == 4) {
                this.initStep5();
            }
        }
    }

    private function initStep5():void {
        this._step = 5;
        this.createBtn();
    }

    private function initStep4():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
            QuestManager.completeStep(10216, 4);
        }
        this._step = 4;
        this.createBtn();
    }

    private function initStep3():void {
        this._step = 3;
        this.createBtn();
    }

    private function createBtn():void {
        if (!this._forwardBtn) {
            this._forwardBtn = _processor.resLib.getButton("ForwardBtn");
            this._forwardBtn.x = 480;
            this._forwardBtn.y = 435;
        }
        if (!this._bgMc) {
            this._bgMc = _processor.resLib.getMovieClip("BGMc");
        }
        var _loc1_:Mobile = MobileManager.getMobile(684, MobileType.NPC);
        if (_loc1_) {
            _loc1_.visible = false;
        }
        _loc1_ = MobileManager.getMobile(678, MobileType.NPC);
        if (_loc1_) {
            _loc1_.visible = false;
        }
        this._forwardBtn.visible = true;
        ActorManager.hideActor();
        if (!this._forwardBtn.hasEventListener(MouseEvent.CLICK)) {
            this._forwardBtn.addEventListener(MouseEvent.CLICK, this.forwardHandler);
        }
        LayerManager.mapLayer.addChild(this._bgMc);
        LayerManager.topLayer.addChild(this._forwardBtn);
    }

    protected function forwardHandler(param1:MouseEvent):void {
        this._forwardBtn.visible = false;
        if (!this._sceneMove) {
            this._sceneMove = _processor.resLib.getMovieClip("SceneMove");
        }
        LayerManager.topLayer.addChild(this._sceneMove);
        this._sceneMove.gotoAndStop(1);
        MovieClipUtil.playMc(this._sceneMove, 1, this._sceneMove.totalFrames, this.checkResult);
    }

    private function checkResult():void {
        var sceneMc:MovieClip = null;
        DisplayObjectUtil.removeFromParent(this._sceneMove);
        if (this._step == 3) {
            sceneMc = _processor.resLib.getMovieClip("SceneMc2");
            LayerManager.topLayer.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc, 1, sceneMc.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(sceneMc);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(questID, 3);
            });
        } else if (this._step == 4) {
            if (PetInfoManager.getFirstPetInfo().hp <= 0) {
                this._forwardBtn.visible = true;
                AlertManager.showAlert("首发精灵血量不足，加满再来继续呢！");
                return;
            }
            ModuleManager.showAppModule("MeetShaLunPanel");
        } else if (this._step == 5) {
            sceneMc = _processor.resLib.getMovieClip("SceneMc3");
            LayerManager.topLayer.addChild(sceneMc);
            MovieClipUtil.playMc(sceneMc, 1, sceneMc.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(sceneMc);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10216_2"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                    QuestManager.completeStep(10216, 5);
                }, true, true);
            });
        }
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }
}
}
