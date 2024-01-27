package com.taomee.seer2.app.processor.quest.handler.story.quest20 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
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

public class QuestMapHandler_20_550 extends QuestMapHandler {

    public static var flghtIndex:int = 0;


    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _mc_2_1:MovieClip;

    private var _mc_4:MovieClip;

    private var _mc_4_1:MovieClip;

    private var _mc_5:MovieClip;

    private var _mc_5_1:MovieClip;

    private var _mc_6:MovieClip;

    public function QuestMapHandler_20_550(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (flghtIndex == 1) {
                flghtIndex = 0;
                this.showSoldier();
                this.playMC1();
                return;
            }
            if (flghtIndex == 2) {
                this.showSoldier();
                this._mc_1.visible = false;
                this._mc_2_1 = _processor.resLib.getMovieClip("mc_2_1");
                _map.front.addChild(this._mc_2_1);
                this._mc_2_1.gotoAndStop(this._mc_2_1.totalFrames);
                flghtIndex = 0;
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.win();
                } else {
                    this.noWin();
                }
                return;
            }
            if (flghtIndex == 3) {
                this.showSoldier();
                this._mc_1.visible = false;
                this._mc_2_1 = _processor.resLib.getMovieClip("mc_2_1");
                _map.front.addChild(this._mc_2_1);
                this._mc_2_1.gotoAndStop(this._mc_2_1.totalFrames);
                this.noWin();
            }
            if (flghtIndex == 4) {
                flghtIndex = 0;
                this.showSoldier();
                this._mc_4 = _processor.resLib.getMovieClip("mc_4");
                _map.front.addChild(this._mc_4);
                this._mc_4.gotoAndStop(this._mc_4.totalFrames);
                this._mc_2.gotoAndStop(this._mc_2.totalFrames);
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.quest4Win();
                } else {
                    this.quest4NoWin();
                }
                return;
            }
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.showSoldier();
            this.mc2Event();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            ActorManager.getActor().startTransform(2001);
            this.showSoldier();
            this.mc2Event();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.showSoldier();
            this._mc_2.gotoAndStop(this._mc_2.totalFrames);
            this._mc_4 = _processor.resLib.getMovieClip("mc_4");
            _map.front.addChild(this._mc_4);
            this.initQuest4Mc5();
        }
    }

    private function showSoldier():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
        this._mc_2 = _processor.resLib.getMovieClip("mc_2");
        _map.front.addChild(this._mc_2);
    }

    private function playMC1():void {
        this._mc_1.visible = false;
        this._mc_2_1 = _processor.resLib.getMovieClip("mc_2_1");
        _map.front.addChild(this._mc_2_1);
        MovieClipUtil.playMc(this._mc_2_1, 2, this._mc_2_1.totalFrames, function ():void {
            fight(2);
        }, true);
    }

    private function mc2Event():void {
        this._mc_2.buttonMode = true;
        this._mc_2.addEventListener(MouseEvent.CLICK, this.onMC2Click);
    }

    private function onMC2Click(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            NpcDialog.show(32, "小兵", [[0, "喂！你们是……坏了阿修队长好事的铁皮桶！！"]], ["我是来观光旅游的，再见！", "要打架？谁怕谁？"], [null, function ():void {
                _mc_2.removeEventListener(MouseEvent.CLICK, onMC2Click);
                fight(1);
            }]);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            NpcDialog.show(32, "小兵", [[0, "喂！你是新面孔？！这么晃来晃去成何体统？"]], ["（我怎么觉得你们长得一模一样……）"], [function ():void {
                _mc_2.removeEventListener(MouseEvent.CLICK, onMC2Click);
                NpcDialog.show(32, "小兵", [[0, "快说，你是S的人，还是阿修队长的人？"]], ["当然是S的人！", "当然是阿修队长的人！"], [function ():void {
                    NpcDialog.show(32, "小兵", [[0, "咳……喔……咳，那请问您这次过来，有，有什么事？"]], ["我有一些问题要问你！（怎么听到S就那么恭敬……）"], [function ():void {
                        showDialog();
                    }]);
                }, function ():void {
                    NpcDialog.show(32, "小兵", [[0, "哦！那么就是自己人了！！话说，你不觉得那个S很怪里怪气吗？明明是个男人……！也不知道为什么上头那么信任他！"]], ["其实我有一些问题想问……"], [function ():void {
                        showDialog();
                    }]);
                }]);
            }]);
        }
    }

    private function showDialog():void {
        NpcDialog.show(32, "小兵", [[0, "有什么问题问我就对了，不是我说什么，我也是很得阿修队长信赖的人啊！"]], ["我们究竟为什么要解封冰封之轴啊？"], [function ():void {
            NpcDialog.show(32, "小兵", [[0, "这个说来话长！总之你只要记住，那个东西非常厉害！据说因为它的存在，才有了冰沁氏族！后来不知怎么的居然被封印了。"]], ["哦，哦，然后呢？"], [function ():void {
                NpcDialog.show(32, "小兵", [[0, "然后就被阿修队长解封啦！据说那东西彻底暴走的话，可以把整个南半球都冻住！可惜了，沁灵兽居然出现了……"]], ["咳……那，那个目之魂又是？", "太无耻了！！"], [function ():void {
                    showDialog2();
                }, function ():void {
                    NpcDialog.show(32, "小兵", [[0, "你说什么？谁太无耻了？！"]], ["我说沁灵兽！居然阻挡我们的计划！"], [function ():void {
                        NpcDialog.show(32, "小兵", [[0, "不过，区区沁灵兽构不成威胁……反正它的力量也不完整。"]], ["话说，那个目之魂是？"], [function ():void {
                            showDialog2();
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function showDialog2():void {
        NpcDialog.show(32, "小兵", [[0, "不过是个漏网之鱼而已……你知道能源之树吗？那些精魂都是沉眠在那棵树上的。那时候……"]], ["那时候怎么了？"], [function ():void {
            _mc_4 = _processor.resLib.getMovieClip("mc_4");
            _map.front.addChild(_mc_4);
            MovieClipUtil.playMc(_mc_4, 2, _mc_4.totalFrames - 1, function ():void {
                NpcDialog.show(13, "阿修", [[1, "不好好巡逻在闲聊什么？"]], ["（糟糕！阿修居然来了！）"], [function ():void {
                    NpcDialog.show(13, "阿修", [[1, "该问的你都问完了，现在是你付出代价的时候了。"]], ["代价？什么代价呀阿修队长……"], [function ():void {
                        NpcDialog.show(13, "阿修", [[1, "知道了我们的目的，还想活下去吗？那些蠢蛋，我之后再处置。"]], ["哼！既然你已经知道了，我也问得差不多了！"], [function ():void {
                            _mc_5 = _processor.resLib.getMovieClip("mc_5");
                            _map.front.addChild(_mc_5);
                            MovieClipUtil.playMc(_mc_5, 2, _mc_5.totalFrames - 1, function ():void {
                                ActorManager.getActor().stopTransform();
                                NpcDialog.show(49, "冰系酋长", [[0, ActorManager.actorInfo.nick + "，是时候反攻了！我族的命运就此托付于你！"]], ["我知道了！"], [function ():void {
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onQuestStepComplete);
                                    QuestManager.completeStep(_quest.id, 3);
                                }]);
                            }, true);
                        }]);
                    }]);
                }]);
            }, true);
        }]);
    }

    private function initQuest4Mc5():void {
        this._mc_4.buttonMode = true;
        this._mc_4.gotoAndStop(this._mc_4.totalFrames);
        this._mc_4.addEventListener(MouseEvent.CLICK, this.onMC5Click);
    }

    private function onQuestStepComplete(param1:QuestEvent):void {
        if (param1.questId == 20 && QuestManager.isStepComplete(20, 3) && !QuestManager.isStepComplete(20, 4)) {
            this._mc_2.gotoAndStop(this._mc_2.totalFrames);
            this.initQuest4Mc5();
        }
    }

    private function onMC5Click(param1:MouseEvent):void {
        this._mc_6 = _processor.resLib.getMovieClip("mc_6");
        FightQuest20.setup(this._mc_6, this.initQuest4Mc5);
    }

    private function fight(param1:int):void {
        if (PetInfoManager.getFirstPetInfo().hp <= 1) {
            AlertManager.showAlert("您的首发精灵体力不够");
            switch (param1) {
                case 1:
                    _processor.showMouseHintAt(544, 340);
                    this._mc_2.buttonMode = true;
                    this._mc_2.addEventListener(MouseEvent.CLICK, this.onMC2Click);
                    break;
                case 2:
                    _processor.showMouseHintAt(481, 277);
                    this._mc_2_1.buttonMode = true;
                    this._mc_2_1.addEventListener(MouseEvent.CLICK, this.onMC1Click);
            }
            return;
        }
        flghtIndex = param1;
        FightManager.startFightWithWild(10);
    }

    private function onMC1Click(param1:MouseEvent):void {
        this._mc_1.removeEventListener(MouseEvent.CLICK, this.onMC1Click);
        this.fight(2);
    }

    private function win():void {
        this.fight(3);
    }

    private function noWin():void {
        NpcDialog.show(32, "小兵", [[0, "哼！总之别想再靠近这里了！别逼我叫出更多的人来！！"]], ["没办法了，先撤退！（去冰之谷！）"], [function ():void {
            QuestManager.completeStep(_quest.id, 1);
            DisplayUtil.removeForParent(_mc_2);
            DisplayUtil.removeForParent(_mc_2_1);
        }]);
    }

    private function quest4Win():void {
        NpcDialog.show(13, "阿修", [[1, "徒劳的反抗！我主……绝不会轻饶你们！撤退！！"]], ["哼！别嘴硬了！"], [function ():void {
            _mc_4.visible = false;
            _mc_1.visible = false;
            _mc_2.visible = false;
            _mc_4_1 = _processor.resLib.getMovieClip("mc_4_1");
            _map.front.addChild(_mc_4_1);
            MovieClipUtil.playMc(_mc_4_1, 2, _mc_4_1.totalFrames, function ():void {
                NpcDialog.show(49, "冰系酋长", [[0, "我族的抵抗将永远持续下去！"]], ["绝对不放弃！"], [function ():void {
                    NpcDialog.show(444, "目之魂", [[0, "漏网之鱼……能源之树……看来，答案就在能源之树上……"]], ["那棵参天的古树？"], [function ():void {
                        NpcDialog.show(49, "冰系酋长", [[0, "赛尔拥有我们无法想象的先进科技，我想，你们一定能够有办法到达那里。"]], ["嗯！"], [function ():void {
                            if (_mc_5) {
                                _mc_5.visible = false;
                            }
                            _mc_5_1 = _processor.resLib.getMovieClip("mc_5_1");
                            _map.front.addChild(_mc_5_1);
                            MovieClipUtil.playMc(_mc_5_1, 2, _mc_5_1.totalFrames, function ():void {
                                QuestManager.completeStep(_quest.id, 4);
                                restMC();
                                DisplayUtil.removeForParent(_mc_4);
                                DisplayUtil.removeForParent(_mc_1);
                                DisplayUtil.removeForParent(_mc_2);
                                DisplayUtil.removeForParent(_mc_5);
                                DisplayUtil.removeForParent(_mc_4_1);
                                DisplayUtil.removeForParent(_mc_5_1);
                            }, true);
                        }]);
                    }]);
                }]);
            }, true);
        }]);
    }

    private function quest4NoWin():void {
        NpcDialog.show(49, "冰系酋长", [[0, "不要放弃，坚持住！仔细观察，就能找到迎敌的方法！"]], ["绝对不放弃！"], [function ():void {
            onMC5Click(null);
        }]);
    }

    private function restMC():void {
        if (this._mc_1) {
            this._mc_1.visible = true;
        }
        if (this._mc_2) {
            this._mc_2.visible = true;
        }
        if (this._mc_2_1) {
            this._mc_2_1.visible = true;
        }
        if (this._mc_4) {
            this._mc_4.visible = true;
        }
        if (this._mc_5) {
            this._mc_5.visible = true;
        }
        if (this._mc_6) {
            this._mc_6.visible = true;
        }
        if (this._mc_4_1) {
            this._mc_4_1.visible = true;
        }
        if (this._mc_5_1) {
            this._mc_5_1.visible = true;
        }
    }

    override public function processMapDispose():void {
        this.restMC();
        ActorManager.getActor().stopTransform();
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._mc_1);
        DisplayUtil.removeForParent(this._mc_2);
        DisplayUtil.removeForParent(this._mc_2_1);
        DisplayUtil.removeForParent(this._mc_4);
        DisplayUtil.removeForParent(this._mc_5);
        DisplayUtil.removeForParent(this._mc_6);
        DisplayUtil.removeForParent(this._mc_4_1);
        DisplayUtil.removeForParent(this._mc_5_1);
        this._mc_1 = null;
        this._mc_2 = null;
        this._mc_4 = null;
        this._mc_5 = null;
        this._mc_4_1 = null;
        this._mc_5_1 = null;
        this._mc_6 = null;
    }
}
}
