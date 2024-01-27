package com.taomee.seer2.app.processor.quest.handler.main.quest35 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_35_304 extends QuestMapHandler {


    private var _mc_3:MovieClip;

    private var _mc_4:MovieClip;

    private var _mc_5:MovieClip;

    private var _fightStatus:int = 0;

    public function QuestMapHandler_35_304(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this._fightStatus = 0;
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.win();
            } else {
                this.initNpc();
            }
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.playAnimation();
        }
    }

    private function playAnimation():void {
        this._mc_3 = _processor.resLib.getMovieClip("mc_3");
        this._mc_3.x = 270;
        this._mc_3.y = 200;
        _map.content.addChild(this._mc_3);
        MovieClipUtil.playMc(this._mc_3, 1, this._mc_3.totalFrames, function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("35_2"), function ():void {
                DisplayUtil.removeForParent(_mc_3);
                initNpc();
            }, true, false, 2);
        }, true);
    }

    private function initNpc():void {
        this._mc_4 = _processor.resLib.getMovieClip("mc_4");
        _map.content.addChild(this._mc_4);
        this._mc_4.x = 270;
        this._mc_4.y = 200;
        this._mc_4.buttonMode = true;
        this._mc_4.addEventListener(MouseEvent.CLICK, this.onMc4);
    }

    private function onMc4(param1:MouseEvent):void {
        var _loc2_:ButtonPanelData = new ButtonPanelData();
        _loc2_.catchEnabled = false;
        this._fightStatus = 1;
        FightManager.startFightBinaryWild(69, null, null, _loc2_);
    }

    private function win():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("35_3"), function ():void {
            _mc_5 = _processor.resLib.getMovieClip("mc_5");
            _map.front.addChild(_mc_5);
            MovieClipUtil.playMc(_mc_5, 1, _mc_5.totalFrames, function ():void {
                DisplayUtil.removeForParent(_mc_5);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("35_4"), function ():void {
                    QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                    QuestManager.completeStep(_quest.id, 4);
                });
            }, true);
        }, true, false, 2);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        var _loc2_:Object = null;
        if (param1.questId == 35) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            _loc2_ = new Object();
            _loc2_.index = 3;
            ModuleManager.toggleModule(URLUtil.getAppModule("QuestSelectRewardPanel"), "正在打开主线任务奖励面板...", _loc2_);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_3);
        DisplayUtil.removeForParent(this._mc_4);
        DisplayUtil.removeForParent(this._mc_5);
        this._mc_3 = null;
        this._mc_4 = null;
        this._mc_5 = null;
    }
}
}
