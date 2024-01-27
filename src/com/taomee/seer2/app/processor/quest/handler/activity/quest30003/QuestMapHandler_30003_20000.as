package com.taomee.seer2.app.processor.quest.handler.activity.quest30003 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30003_20000 extends QuestMapHandler {


    private var _fightStatusFirst:Boolean = false;

    private var _fightStatusSecond:Boolean = false;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_30003_20000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.onStep();
        }
        if (QuestManager.isStepComplete(_quest.id, 5) && QuestManager.isStepComplete(_quest.id, 6) == false) {
            this.fightFirst();
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 5) && QuestManager.isStepComplete(_quest.id, 6) == false) {
            if (this._fightStatusFirst) {
                this._fightStatusFirst = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.winFirst();
                } else {
                    this.noWinFirst();
                }
                return;
            }
            if (this._fightStatusSecond) {
                this._fightStatusSecond = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.winSecond();
                } else {
                    this.noWinSecond();
                }
                return;
            }
        }
    }

    private function onStep():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_0);
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "住手！！！不然我就叫了！！"]], ["我真的要叫咯！！！"], [function ():void {
            NpcDialog.show(108, "坏人", [[0, "你叫破喉咙都不会有人来阻止我们的！这里的族民们都已经被我们迷晕啦！！"]], [" ……尴尬的场面了！"], [function ():void {
                DisplayUtil.removeForParent(_mc_0);
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30003_0"), function ():void {
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "求人不如求己！我来搞定你们！！！！！（时间紧迫！进度条达到100，破坏魔可能就会出现！）"]], ["（点击他们进行对战）"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep5Handler);
                        QuestManager.completeStep(_quest.id, 5);
                    }]);
                }, true, false, 2);
            }]);
        }]);
    }

    private function onStep5Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep5Handler);
        this.fightFirst();
    }

    private function fightFirst():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_7");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_6");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onFirstMan);
    }

    private function onFirstMan(param1:MouseEvent):void {
        this._mc_1.removeEventListener(MouseEvent.CLICK, this.onFirstMan);
        this._fightStatusFirst = true;
        FightManager.startFightWithWild(76);
    }

    private function winFirst():void {
        this.fightSecond();
    }

    private function noWinFirst():void {
        this.fightSecond();
    }

    private function fightSecond():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_9");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_8");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onSecondMan);
    }

    private function onSecondMan(param1:MouseEvent):void {
        this._fightStatusSecond = true;
        FightManager.startFightWithWild(76);
    }

    private function winSecond():void {
        this.fightThird();
    }

    private function noWinSecond():void {
        this.fightThird();
    }

    private function fightThird():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_11");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_10");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onThirdMan);
    }

    private function onThirdMan(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_2 = _processor.resLib.getMovieClip("mc_12");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, this._mc_2.totalFrames, function ():void {
            if (_mc_0) {
                DisplayUtil.removeForParent(_mc_0);
            }
            if (_mc_1) {
                DisplayUtil.removeForParent(_mc_1);
            }
            if (_mc_2) {
                DisplayUtil.removeForParent(_mc_2);
            }
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30003_1"), function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "什么…………这是真的吗？雷神？雷伊？书本上的雷伊真的出现了？这……这……喂喂喂！快回过神来！快去告诉娜威拉!"]], ["（前往资料室娜威拉）"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep6Handler);
                    QuestManager.completeStep(_quest.id, 6);
                }]);
            }, true, false, 2);
        }, true);
    }

    private function onStep6Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep6Handler);
        SceneManager.changeScene(SceneType.LOBBY, 30);
    }
}
}
