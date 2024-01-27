package com.taomee.seer2.app.processor.quest.handler.branch.quest10196 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10196_80030 extends QuestMapHandler {


    private var _npc:MovieClip;

    private var _note:MovieClip;

    private var _mc0:MovieClip;

    private var _father:MovieClip;

    private var _fightStatusOne:Boolean;

    private var _fightStatusTwo:Boolean;

    private var _fightStatusThree:Boolean;

    private var _markMc:MouseClickHintSprite;

    public function QuestMapHandler_10196_80030(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(_quest.id)) {
            this.showNpc();
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.addNewNpc();
            if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatusOne) {
                this._fightStatusOne = false;
                this.someoneTalk();
                return;
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.addNewNpc();
            if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatusTwo) {
                this._fightStatusTwo = false;
                this.someoneTalkAgain();
                return;
            }
            this.addNoteTwo();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.addNewNpc();
            if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatusThree) {
                this._fightStatusThree = false;
                this.addFather();
                return;
            }
            this.addNoteThree();
        }
    }

    private function showNpc():void {
        this._npc = _processor.resLib.getMovieClip("npc0");
        _map.content.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpcTalkHandler);
    }

    private function onNpcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(192, "S", [[0, "我终于找到这个地方了！爸爸一定就在这堵墙的后面！"]], [], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10196_0"), function ():void {
                QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                QuestManager.accept(_quest.id);
            }, true, false, 2);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        if (this._npc) {
            DisplayUtil.removeForParent(this._npc);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        this.addNewNpc();
    }

    private function addNewNpc():void {
        if (this._npc) {
            DisplayUtil.removeForParent(this._npc);
        }
        this._npc = _processor.resLib.getMovieClip("npc1");
        _map.content.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onNewNpcTalkHandler);
    }

    private function onNewNpcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            NpcDialog.show(192, "S", [[0, "刚刚发生了什么！这里怎么会突然有浓雾？"]], [], [function ():void {
                NpcDialog.show(192, "S", [[0, "项链！怎么办？我的项链呢？！那是爸爸留给我唯一的信物！"]], ["你看那里是什么！"], [function ():void {
                    addNote();
                    _note.addEventListener(MouseEvent.CLICK, onOpenNoteOneHandler);
                }]);
            }]);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            NpcDialog.show(192, "S", [[0, "前方好像有一个纸条，快捡起来看看."]], ["（点击地上的纸条）"], [function ():void {
                addNote();
                _note.addEventListener(MouseEvent.CLICK, onOpenNoteTwoHandler);
            }]);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            NpcDialog.show(192, "S", [[0, "前方好像有一个纸条，快捡起来看看."]], ["（点击地上的纸条）"], [function ():void {
                addNote();
                _note.addEventListener(MouseEvent.CLICK, onOpenNoteThreeHandler);
            }]);
        }
    }

    private function addNote():void {
        if (this._note) {
            DisplayUtil.removeForParent(this._note);
            DisplayObjectUtil.removeFromParent(this._markMc);
        }
        this._npc.buttonMode = false;
        this._npc.removeEventListener(MouseEvent.CLICK, this.onNewNpcTalkHandler);
        this.addMouse();
        this._note = _processor.resLib.getMovieClip("note");
        _map.front.addChild(this._note);
        this._note.buttonMode = true;
    }

    private function onOpenNoteOneHandler(param1:MouseEvent):void {
        if (this._note) {
            DisplayUtil.removeForParent(this._note);
        }
        DisplayObjectUtil.removeFromParent(this._markMc);
        this._mc0 = _processor.resLib.getMovieClip("mc0");
        _map.front.addChild(this._mc0);
        this._mc0["ans1"].buttonMode = true;
        this._mc0["ans1"].addEventListener(MouseEvent.CLICK, this.onNoteOneAnsOneHandler);
        this._mc0["ans2"].buttonMode = true;
        this._mc0["ans2"].addEventListener(MouseEvent.CLICK, this.onNoteOneAnsTwoHandler);
    }

    private function onNoteOneAnsOneHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(322, "神秘人黑影", [[0, "你很勇敢！请你往前走吧！恶魔就在前方等你！"]], [], [function ():void {
            NpcDialog.show(192, "S", [[0, "我一定会救出你的！爸爸！"]], ["S小心！"], [function ():void {
                playFullMovieOne();
            }]);
        }]);
    }

    private function onNoteOneAnsTwoHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(192, "S", [[0, "赛尔！我总在噩梦中惊醒，我怕我无法战胜这个恶魔……"]], ["你忘了来这里是为了什么吗？！"], [function ():void {
            NpcDialog.show(192, "S", [[0, "可是……万一我战胜不了它怎么办？"]], ["没有必胜的勇气怎么能够救出你的爸爸！"], [function ():void {
                NpcDialog.show(192, "S", [[0, "对！勇气！我要救出我的亲人！我怎么能连这点勇气都没有！来吧让我再重新选择一次吧！"]], ["勇敢的选择挑战恶魔吧！"], [function ():void {
                    playFullMovieOne();
                }]);
            }]);
        }]);
    }

    private function playFullMovieOne():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10196_1"), function ():void {
            _fightStatusOne = true;
            FightManager.startFightWithNPC(49);
        }, true, false, 2);
    }

    private function someoneTalk():void {
        NpcDialog.show(322, "神秘人黑影", [[0, "看来你已经具备了一名战士应有的勇气！愿这份勇气能够让你战胜一切心中的恶魔！来看看下一步吧！"]], [], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneComplete);
            QuestManager.completeStep(_quest.id, 1);
        }]);
    }

    private function onStepOneComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneComplete);
        this.addNoteTwo();
    }

    private function addNoteTwo():void {
        this.addMouse();
        this._note = _processor.resLib.getMovieClip("note");
        _map.front.addChild(this._note);
        this._note.buttonMode = true;
        this._note.addEventListener(MouseEvent.CLICK, this.onOpenNoteTwoHandler);
    }

    private function onOpenNoteTwoHandler(param1:MouseEvent):void {
        if (this._note) {
            DisplayUtil.removeForParent(this._note);
        }
        DisplayObjectUtil.removeFromParent(this._markMc);
        this._mc0 = _processor.resLib.getMovieClip("mc1");
        _map.front.addChild(this._mc0);
        this._mc0["ans1"].buttonMode = true;
        this._mc0["ans1"].addEventListener(MouseEvent.CLICK, this.onNoteTwoAnsOneHandler);
        this._mc0["ans2"].buttonMode = true;
        this._mc0["ans2"].addEventListener(MouseEvent.CLICK, this.onNoteTwoAnsTwoHandler);
    }

    private function onNoteTwoAnsOneHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(322, "神秘人黑影", [[0, "正义的勇士！请你往前走吧！去面对更加强大的恶魔吧！"]], [], [function ():void {
            NpcDialog.show(192, "S", [[0, "没有人能够阻止我！尤其是恶魔！爸爸等我！"]], ["S小心！"], [function ():void {
                playFullMovieTwo();
            }]);
        }]);
    }

    private function onNoteTwoAnsTwoHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(192, "S", [[0, "赛尔！如果恶魔能够让我们父子团聚的话，我为什么不投向它呢……"]], ["想想你的爸爸是被谁囚禁的吧！"], [function ():void {
            NpcDialog.show(192, "S", [[0, "也许恶魔会对我们仁慈一些……"]], ["恶魔只会给人们带来灾难！"], [function ():void {
                NpcDialog.show(192, "S", [[0, "灾难！恶魔！谢谢你赛尔！我们是来寻找正义的，而这正是恶魔所不具有的力量！"]], ["勇敢的选择挑战恶魔吧！"], [function ():void {
                    playFullMovieTwo();
                }]);
            }]);
        }]);
    }

    private function playFullMovieTwo():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10196_1"), function ():void {
            _fightStatusTwo = true;
            FightManager.startFightWithNPC(50);
        }, true, false, 2);
    }

    private function someoneTalkAgain():void {
        NpcDialog.show(322, "神秘人黑影", [[0, "你的正义之心会保佑你今后的每一次战斗！来看看下一步吧！"]], [], [function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepTwoComplete);
            QuestManager.completeStep(_quest.id, 2);
        }]);
    }

    private function onStepTwoComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoComplete);
        this.addNoteThree();
    }

    private function addNoteThree():void {
        this.addMouse();
        this._note = _processor.resLib.getMovieClip("note");
        _map.front.addChild(this._note);
        this._note.buttonMode = true;
        this._note.addEventListener(MouseEvent.CLICK, this.onOpenNoteThreeHandler);
    }

    private function onOpenNoteThreeHandler(param1:MouseEvent):void {
        if (this._note) {
            DisplayUtil.removeForParent(this._note);
        }
        DisplayObjectUtil.removeFromParent(this._markMc);
        this._mc0 = _processor.resLib.getMovieClip("mc2");
        _map.front.addChild(this._mc0);
        this._mc0["ans1"].buttonMode = true;
        this._mc0["ans1"].addEventListener(MouseEvent.CLICK, this.onNoteThreeAnsOneHandler);
        this._mc0["ans2"].buttonMode = true;
        this._mc0["ans2"].addEventListener(MouseEvent.CLICK, this.onNoteThreeAnsTwoHandler);
    }

    private function onNoteThreeAnsOneHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(322, "神秘人黑影", [[0, "勇敢而正义的战士还需要有忠实的伙伴！"]], [], [function ():void {
            NpcDialog.show(192, "S", [[0, "伙伴和亲人一样，都是我誓死守护的东西！恶魔来吧！"]], ["S小心！"], [function ():void {
                playFullMovieThree();
            }]);
        }]);
    }

    private function onNoteThreeAnsTwoHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._mc0) {
            DisplayUtil.removeForParent(this._mc0);
        }
        NpcDialog.show(192, "S", [[0, "赛尔！我该怎么办？你与我并肩作战闯入了炼狱的七层。"]], ["S倾听你内心的声音吧"], [function ():void {
            NpcDialog.show(192, "S", [[0, "内心……友谊……伙伴……牺牲……如果我放弃了伙伴，我与恶魔还有什么分别！赛尔！让我们继续并肩作战吧！"]], ["好的！继续向前！！"], [function ():void {
                playFullMovieThree();
            }]);
        }]);
    }

    private function playFullMovieThree():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10196_1"), function ():void {
            _fightStatusThree = true;
            FightManager.startFightWithNPC(51);
        }, true, false, 2);
    }

    private function addFather():void {
        this._father = _processor.resLib.getMovieClip("father");
        _map.front.addChild(this._father);
        MovieClipUtil.playMc(this._father, 1, this._father.totalFrames, function ():void {
            NpcDialog.show(323, "S爸爸", [[0, "S你长大了！看到你现在的样子我真的很高兴！"]], [], [function ():void {
                NpcDialog.show(192, "S", [[0, "你是……爸爸！爸爸我终于找到你了！"]], [], [function ():void {
                    NpcDialog.show(323, "S爸爸", [[0, "你听好！前面的三个考验你要牢记！勇气、正义和友谊是你今后路上的三样珍宝！时刻都不能忘记！"]], [], [function ():void {
                        NpcDialog.show(192, "S", [[0, "爸爸！妈妈还在等我们！我们回去再说吧！"]], [], [function ():void {
                            NpcDialog.show(323, "S爸爸", [[0, "我的时间不多了！刚刚我用最后的意念幻化成撒旦来考验你，是想看看你能不能够压抑住心中的恶魔"]], [], [function ():void {
                                NpcDialog.show(323, "S爸爸", [[0, "当我的意志彻底消失之时，撒旦内心的恶魔就会复苏！而只有你能够让它恢复平静！"]], [], [function ():void {
                                    NpcDialog.show(192, "S", [[0, "爸爸不要丢下我们！"]], [], [function ():void {
                                        NpcDialog.show(323, "S爸爸", [[0, "我并没有丢下你们，我会一直守护在你们的身边，只是我们要分别一段时间而已，爸爸相信你会是一个真正的男子汉！。"]], [], [function ():void {
                                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10196_2"), function ():void {
                                                QuestManager.addEventListener(QuestEvent.COMPLETE, onStepThreeComplete);
                                                QuestManager.completeStep(_quest.id, 3);
                                            }, true, false, 2);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function onStepThreeComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepThreeComplete);
        if (this._father) {
            DisplayUtil.removeForParent(this._father);
        }
        if (this._npc) {
            DisplayUtil.removeForParent(this._npc);
        }
        SceneManager.changeScene(SceneType.LOBBY, 1071);
    }

    private function addMouse():void {
        this._markMc = new MouseClickHintSprite();
        _map.front.addChild(this._markMc);
        this._markMc.x = 774;
        this._markMc.y = 431;
    }

    override public function processMapDispose():void {
        if (this._npc) {
            DisplayUtil.removeForParent(this._npc);
        }
        if (this._note) {
            DisplayUtil.removeForParent(this._note);
        }
        if (this._father) {
            DisplayUtil.removeForParent(this._father);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoComplete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepThreeComplete);
    }
}
}
