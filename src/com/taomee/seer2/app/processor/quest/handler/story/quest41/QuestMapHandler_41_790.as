package com.taomee.seer2.app.processor.quest.handler.story.quest41 {
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

public class QuestMapHandler_41_790 extends QuestMapHandler {


    private var _fightStatusFirst:Boolean;

    private var _fightStatusSecond:Boolean;

    private var _fightStatusThird:Boolean;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _mc_3:MovieClip;

    public function QuestMapHandler_41_790(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false) {
            this.playFirstMovie();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initAllSeers();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initMc();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initMcAgain();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.initMcAgain();
        }
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
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
            if (this._fightStatusThird) {
                this._fightStatusThird = false;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.winThird();
                } else {
                    this.noWinThird();
                }
                return;
            }
        }
    }

    private function playFirstMovie():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onSeerTalk);
    }

    private function onSeerTalk(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(110, "晕眩赛尔", [[0, "看我太空步……啊……好多星星……"]], ["你们这是怎么了？"], [function ():void {
            _mc_1.removeEventListener(MouseEvent.CLICK, onSeerTalk);
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(_quest.id);
        }]);
    }

    private function initAllSeers():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
        this.seerFirstTalk();
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.accept(_quest.id);
        this.seerFirstTalk();
    }

    private function seerFirstTalk():void {
        NpcDialog.show(110, "晕眩赛尔", [[0, "听辛迪船长说，这阶段可以上能源之树瞧瞧……但是看来我们只能到此为止了……"]], ["具体发生什么事情了？"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("41_0"), 2, [[1, 0]], function ():void {
                NpcDialog.show(110, "晕眩赛尔", [[0, "完了，完了……这种失败只要尝过一次就够了……我们没有赢的可能性！"]], ["不多试几次怎么知道？"], [function ():void {
                    _mc_2 = _processor.resLib.getMovieClip("mc_2");
                    _map.front.addChild(_mc_2);
                    MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                        _mc_3 = _processor.resLib.getMovieClip("mc_8");
                        _map.front.addChild(_mc_3);
                        MovieClipUtil.playMc(_mc_3, 1, _mc_3.totalFrames, function ():void {
                            NpcDialog.show(110, "晕眩赛尔", [[0, "糟糕，艾丽希斯吸取了太阳光芒，变得更强大了！我们先撤了！！"]], ["啊，喂！"], [function ():void {
                                if (_mc_0) {
                                    DisplayUtil.removeForParent(_mc_0);
                                }
                                if (_mc_1) {
                                    DisplayUtil.removeForParent(_mc_1);
                                }
                                if (_mc_2) {
                                    DisplayUtil.removeForParent(_mc_2);
                                }
                                _mc_0 = _processor.resLib.getMovieClip("mc_3");
                                _map.front.addChild(_mc_0);
                                MovieClipUtil.playMc(_mc_0, 1, _mc_0.totalFrames, function ():void {
                                    NpcDialog.show(11, "多罗", [[2, "队长！我觉得他做了明智的决定，事不宜迟，咱们撤退吧！"]], ["不行！别忘了我们的任务！"], [function ():void {
                                        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "既然到了这里，不管失败与否，我都要试一试！"]], ["（何况打败光系SPT指日可待……）"], [function ():void {
                                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Handler);
                                            QuestManager.completeStep(_quest.id, 1);
                                        }]);
                                    }]);
                                }, true);
                            }]);
                        }, true);
                    }, true);
                }]);
            });
        }]);
    }

    private function onStep1Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        this.initMc();
        this.BartyTalk();
    }

    private function initMc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_4");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onBartyTalk);
    }

    private function onBartyTalk(param1:MouseEvent):void {
        this.BartyTalk();
    }

    private function BartyTalk():void {
        NpcDialog.show(10, "巴蒂", [[1, "队长，说真的，这时候你终于开始有点英雄气概了！"]], ["（以前也有的好吧！）"], [function ():void {
            NpcDialog.show(11, "多罗", [[1, "队长，效率点，速度上了！！"]], ["站在最后一排的人没资格指手画脚= =b"], [function ():void {
                _fightStatusFirst = true;
                FightManager.startFightWithWild(77);
            }]);
        }]);
    }

    private function winFirst():void {
        this.playFirstFight();
    }

    private function noWinFirst():void {
        this.playFirstFight();
    }

    private function playFirstFight():void {
        this._mc_2 = _processor.resLib.getMovieClip("mc_6");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, this._mc_2.totalFrames, function ():void {
            NpcDialog.show(11, "多罗", [[2, "队长！别继续了，艾丽希斯只要能够汲取太阳光芒，就会越来越强！而我们的体力却是有限的……"]], ["在这里就倒下了，今后怎么办？继续！！"], [function ():void {
                if (_mc_1) {
                    DisplayUtil.removeForParent(_mc_1);
                }
                _processor.mouseHint.x = 442;
                _processor.mouseHint.y = 289;
                _map.content.addChild(_processor.mouseHint);
                _mc_1 = _processor.resLib.getMovieClip("mc_9");
                _map.front.addChild(_mc_1);
                _mc_1.buttonMode = true;
                _mc_1.addEventListener(MouseEvent.CLICK, onFightScond);
                _fightStatusSecond = true;
                FightManager.startFightWithWild(78);
            }]);
        }, true);
    }

    private function onFightScond(param1:MouseEvent):void {
        this._fightStatusThird = true;
        FightManager.startFightWithWild(78);
    }

    private function winSecond():void {
        this.playSecondFight();
    }

    private function noWinSecond():void {
        this.playSecondFight();
    }

    private function playSecondFight():void {
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        this._mc_2 = _processor.resLib.getMovieClip("mc_7");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, this._mc_2.totalFrames, function ():void {
            if (_mc_1) {
                DisplayUtil.removeForParent(_mc_1);
            }
            _processor.mouseHint.x = 442;
            _processor.mouseHint.y = 289;
            _map.content.addChild(_processor.mouseHint);
            _mc_1 = _processor.resLib.getMovieClip("mc_9");
            _map.front.addChild(_mc_1);
            _mc_1.buttonMode = true;
            _mc_1.addEventListener(MouseEvent.CLICK, onFightThird);
            _fightStatusThird = true;
            FightManager.startFightWithWild(79);
        }, true);
    }

    private function onFightThird(param1:MouseEvent):void {
        this._fightStatusThird = true;
        FightManager.startFightWithWild(79);
    }

    private function winThird():void {
        this.playThirdFight();
    }

    private function noWinThird():void {
        this.playThirdFight();
    }

    private function playThirdFight():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("41_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Handler);
            QuestManager.completeStep(_quest.id, 2);
        }, true, false, 2);
    }

    private function onStep2Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Handler);
        this.initMcAgain();
    }

    private function initMcAgain():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.content.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_4");
        _map.front.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onBartyTalkAgain);
    }

    private function onBartyTalkAgain(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(10, "巴蒂", [[4, "队长，你，你今天特别伟岸！！特别帅气！！！就像打不死的……一样！！"]], ["（你想说小强= =？）"], [function ():void {
            NpcDialog.show(209, "艾丽希斯", [[3, "不放弃——为何——"]], ["我必须战胜你，然后去能源之树上层！"], [function ():void {
                NpcDialog.show(209, "艾丽希斯", [[3, "去——有决心—交给你———未来——光——希望"]], [" 哎？？"], [function ():void {
                    NpcDialog.show(10, "巴蒂", [[4, "难道……难道艾丽希斯想放我们过去？！？！"]], ["它说话实在够颠倒的……"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("41_2"), function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                            QuestManager.completeStep(_quest.id, 3);
                        }, true, false, 2);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        if (param1.questId == 41) {
            if (this._mc_0) {
                DisplayUtil.removeForParent(this._mc_0);
            }
            if (this._mc_1) {
                DisplayUtil.removeForParent(this._mc_1);
            }
            if (this._mc_2) {
                DisplayUtil.removeForParent(this._mc_2);
            }
            if (this._mc_3) {
                DisplayUtil.removeForParent(this._mc_3);
            }
        }
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        if (this._mc_3) {
            DisplayUtil.removeForParent(this._mc_3);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
