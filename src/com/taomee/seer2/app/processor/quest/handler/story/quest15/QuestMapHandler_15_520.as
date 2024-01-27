package com.taomee.seer2.app.processor.quest.handler.story.quest15 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_15_520 extends QuestMapHandler {

    private static var _flghtIndex:int = 0;


    private var _mc_2:MovieClip;

    private var _mc_3:MovieClip;

    public function QuestMapHandler_15_520(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 1) == false && _flghtIndex == 1) {
            this.showMC2();
            if (FightManager.fightWinnerSide == FightSide.LEFT && _flghtIndex == 1) {
                _flghtIndex = 0;
                this.win();
            } else {
                this.noWin();
            }
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.onAnimation();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.showMC2();
            this.onQuest2();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.addMouseClickHint();
        }
    }

    private function onAnimation():void {
        this._mc_2 = _processor.resLib.getMovieClip("mc_2");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, 57, function ():void {
            NpcDialog.show(434, "皮皮格", [[0, "伊特！别以为你用黑炭抹了脸，俺就认不出你！！快还我的宝贝皮格！！"]], ["你们认错人了！"], [function ():void {
                NpcDialog.show(440, "暗伊特", [[0, "哼！就是你们这群大鼻子乡巴佬欺负了我的宝贝弟弟吗？"]], [" 大，大家都冷静一点！"], [function ():void {
                    startFight();
                }]);
            }]);
        }, true);
    }

    private function showMC2():void {
        if (this._mc_2 == null) {
            this._mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(this._mc_2);
        }
        this._mc_2.gotoAndStop(57);
    }

    private function startFight():void {
        if (PetInfoManager.getFirstPetInfo().hp <= 1) {
            AlertManager.showAlert("您的首发精灵体力不够");
            this._mc_2.buttonMode = true;
            this.addFightMouseClickHint();
            this._mc_2.addEventListener(MouseEvent.CLICK, this.onMC2Click);
            return;
        }
        _flghtIndex = 1;
        FightManager.startFightWithWild(28);
    }

    private function onMC2Click(param1:MouseEvent):void {
        this._mc_2.removeEventListener(MouseEvent.CLICK, this.onMC2Click);
        this.startFight();
    }

    private function win():void {
        NpcDialog.show(440, "暗伊特", [[0, "太弱啦！弟弟到底在想什么？还是回到博士身边好哇！"]], ["（博士？总觉得和那个项圈有关）"], [function ():void {
            NpcDialog.show(434, "皮皮格", [[0, "俺们不管什么哥哥弟弟，总之走得越远越好！只要俺的皮格一天没有找到，俺们就一天不会放过伊特！"]], ["（捣蛋反攻战又要拉开帷幕了？）"], [function ():void {
                NpcDialog.show(440, "暗伊特", [[0, "哼！这么一耽误，我那弟弟早就没影儿了！没准它匆匆忙忙会留下点什么线索，我们找找看。"]], ["呃，好的。"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            }]);
        }]);
    }

    private function noWin():void {
        this._mc_2.buttonMode = true;
        this.addFightMouseClickHint();
        this._mc_2.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            var event:MouseEvent = param1;
            NpcDialog.show(434, "皮皮格", [[0, "把俺的皮格还给俺！"]], ["我还没输呢！继续！"], [function ():void {
                startFight();
            }]);
        });
    }

    private function onQuestStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.onQuest2();
        }
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.addMouseClickHint();
        }
    }

    private function onQuest2():void {
        this._mc_3 = _processor.resLib.getMovieClip("mc_3");
        this._mc_3.x = 331;
        this._mc_3.y = 434;
        _map.front.addChild(this._mc_3);
        this._mc_3.buttonMode = true;
        this._mc_3.addEventListener(MouseEvent.CLICK, this.onMC3Click);
    }

    private function onMC3Click(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_3.removeEventListener(MouseEvent.CLICK, this.onMC3Click);
        NpcDialog.show(440, "暗伊特", [[0, "看那个，地道之路的入口处，有一大块碎钻！这可是我弟弟最喜欢的东西呐！"]], ["看来它往地道之路去了"], [function ():void {
            ServerMessager.addMessage("获得5颗碎钻");
            DisplayUtil.removeForParent(_mc_3);
            _mc_3 = null;
            MovieClipUtil.playMc(_mc_2, 58, _mc_2.totalFrames, function ():void {
                DisplayUtil.removeForParent(_mc_2);
                _mc_2 = null;
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStep);
                QuestManager.completeStep(_quest.id, 2);
            }, true);
        }]);
    }

    private function addMouseClickHint():void {
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isCompletable(_quest.id)) {
            _processor.showMouseHintAt(225, 363);
        }
    }

    private function addFightMouseClickHint():void {
        _processor.showMouseHintAt(420, 220);
    }

    override public function processMapDispose():void {
        _processor.hideMouseClickHint();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onQuestStep);
        DisplayUtil.removeForParent(this._mc_2);
        this._mc_2 = null;
        DisplayUtil.removeForParent(this._mc_3);
        this._mc_3 = null;
    }
}
}
