package com.taomee.seer2.app.processor.quest.handler.story.quest23 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
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

public class QuestMapHandler_23_3100 extends QuestMapHandler {

    private static const DI_NPC_FIGHT_INDEX:uint = 5;

    private static const SHA_NPC_FIGHT_INDEX:uint = 6;

    private static const XIANZHI_NPC_FIGHT_INDEX:uint = 7;


    private var _mamaNpc:MovieClip;

    private var _dishaNpc:MovieClip;

    private var _xianZhiNpc:MovieClip;

    private var _xianZhiIn:MovieClip;

    private var _showDiShaNpc:MovieClip;

    private var _askMark:MovieClip;

    public function QuestMapHandler_23_3100(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.createMamaNpc();
            this.processStep1();
        } else if (QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.createMamaNpc();
            this.createDiShaNpc();
            this.processStep2();
        } else if (QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.createMamaNpc();
            this.createDiShaNpc();
            this.createXianZhiNpc();
            this.processStep3();
        }
    }

    private function processStep1():void {
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask_mark");
        }
        this._askMark.x = 0;
        this._askMark.y = -(this._mamaNpc["mama"] as MovieClip).height;
        this._askMark.scaleX = 1;
        this._mamaNpc.addChild(this._askMark);
        this._mamaNpc["mama"].addEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
    }

    private function onShowDialogStep1_0(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        this._mamaNpc["mama"].removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
        NpcDialog.show(53, "兰德妈妈", [[2, "我们还是离开这里吧！两个孩子才刚出世……我不希望他们的童年充满阴影！"]], ["（哇！真的回到过去了！）"], [function ():void {
            NpcDialog.show(59, "小兰德", [[0, "哇哇哇哇！！！"]], ["小兰德"], [function ():void {
                NpcDialog.show(60, "小蒂萨特", [[0, "呜呜……呜………………嘤嘤……"]], ["小蒂萨特！"], [function ():void {
                    NpcDialog.show(58, "兰德爸爸", [[0, "你我之间的婚姻本来就打破了地月和沙爪世代仇恨的规矩，更何况我们的孩子，还是一对地月和沙爪的孪生子。"]], ["（等一下！兰德和蒂萨特是孪生兄弟？！）"], [function ():void {
                        NpcDialog.show(58, "兰德爸爸", [[0, "虽然逃跑很懦弱，虽然背井离乡很辛苦……但是为了这两个孩子，我们必须坚强！所以，我赞成离开这里！"]], ["（可怜天下父母心！）"], [function ():void {
                            _showDiShaNpc = _processor.resLib.getMovieClip("mc_1_0");
                            _map.front.addChild(_showDiShaNpc);
                            MovieClipUtil.playMc(_showDiShaNpc, 1, _showDiShaNpc.totalFrames, function ():void {
                                DisplayObjectUtil.removeFromParent(_showDiShaNpc);
                                _showDiShaNpc = null;
                                createDiShaNpc();
                                showDialogStep1_1();
                            }, true);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function showDialogStep1_1():void {
        NpcDialog.show(56, "神爪财团老板", [[0, "所有的族人都是一个氏族的资产，你说作为大老板，我怎么能放任我的资产白白流走呢？"]], ["（你倒是一点都没变嘛……）"], [function ():void {
            NpcDialog.show(55, "神月老大", [[0, "嚯！这不是钱的问题！不听话的人，洒家怎么可能轻易放过？"]], ["（……）"], [function ():void {
                NpcDialog.show(58, "兰德爸爸", [[3, "如果没有商量余地，我就算拼上性命也会离开这里！"]], ["有骨气！我支持你！！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
                    QuestManager.completeStep(_quest.id, 1);
                }]);
            }]);
        }]);
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.processStep2();
        }
    }

    private function processStep2():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == DI_NPC_FIGHT_INDEX && FightManager.fightWinnerSide == FightSide.LEFT) {
            _processor.mouseHint.x = this._dishaNpc["sha"].width / 2;
            _processor.mouseHint.y = 0;
            _processor.mouseHint.scaleX = -1;
            this._dishaNpc["sha"].addChild(_processor.mouseHint);
            this._dishaNpc["sha"].addEventListener(MouseEvent.CLICK, this.onDiNpcClickStep2_1);
            this.showStep2_1();
        } else if (SceneManager.prevSceneType == SceneType.ARENA && (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && (FightManager.currentFightRecord.initData.positionIndex == DI_NPC_FIGHT_INDEX && FightManager.fightWinnerSide == FightSide.RIGHT || FightManager.currentFightRecord.initData.positionIndex == SHA_NPC_FIGHT_INDEX))) {
            this.showStep2_2();
        } else {
            this.showStep2_0();
        }
    }

    private function showStep2_0():void {
        _processor.mouseHint.x = this._dishaNpc["di"].width / 2;
        _processor.mouseHint.y = 0;
        _processor.mouseHint.scaleX = -1;
        this._dishaNpc["di"].addChild(_processor.mouseHint);
        this._dishaNpc["di"].addEventListener(MouseEvent.CLICK, this.onDiNpcClickStep2_0);
    }

    private function onDiNpcClickStep2_0(param1:MouseEvent):void {
        FightManager.startFightWithNPC(DI_NPC_FIGHT_INDEX);
    }

    private function showStep2_1():void {
        NpcDialog.show(56, "神爪财团老板", [[0, "呵呵，地月的族长难道除了挖矿以外就没有别的特长了吗？哎……我本来并不想出手的！"]], [" ……（讨打的人！）"], [function ():void {
            FightManager.startFightWithNPC(SHA_NPC_FIGHT_INDEX);
        }]);
    }

    private function onDiNpcClickStep2_1(param1:MouseEvent):void {
        this.showStep2_1();
    }

    private function showStep2_2():void {
        this._xianZhiIn = _processor.resLib.getMovieClip("mc_2_0");
        _map.front.addChild(this._xianZhiIn);
        MovieClipUtil.playMc(this._xianZhiIn, 1, this._xianZhiIn.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_xianZhiIn);
            _xianZhiIn = null;
            createXianZhiNpc();
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
            QuestManager.completeStep(_quest.id, 2);
        }, true);
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == XIANZHI_NPC_FIGHT_INDEX) {
            this.showStep3_1();
        } else {
            this.showStep3_0();
        }
    }

    private function showStep3_0():void {
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask_mark");
        }
        this._askMark.x = 0;
        this._askMark.y = -this._xianZhiNpc.height;
        this._askMark.scaleX = -1;
        this._xianZhiNpc.addChild(this._askMark);
        this._xianZhiNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep3_0);
    }

    private function onShowDialogStep3_0(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        NpcDialog.show(57, "先知", [[0, "……此人……留不得……必须铲除……"]], ["（喂喂！）"], [function ():void {
            NpcDialog.show(57, "先知", [[0, "违背命运……打破了地月和沙爪世代仇恨的规矩……天谴……"]], ["（……）"], [function ():void {
                FightManager.startFightWithNPC(XIANZHI_NPC_FIGHT_INDEX);
            }]);
        }]);
    }

    private function showStep3_1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("23_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
            QuestManager.completeStep(_quest.id, 3);
        });
    }

    private function onCompleteStep3(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            SceneManager.changeScene(SceneType.LOBBY, 390);
        }
    }

    private function createMamaNpc():void {
        this._mamaNpc = _processor.resLib.getMovieClip("mama_npc_3100");
        this._mamaNpc.x = 404;
        this._mamaNpc.y = 304;
        _map.content.addChild(this._mamaNpc);
        this._mamaNpc["mama"].buttonMode = true;
    }

    private function createDiShaNpc():void {
        this._dishaNpc = _processor.resLib.getMovieClip("disha_npc_3100");
        this._dishaNpc.x = 509;
        this._dishaNpc.y = 409;
        _map.content.addChild(this._dishaNpc);
        this._dishaNpc.buttonMode = true;
    }

    private function createXianZhiNpc():void {
        this._xianZhiNpc = _processor.resLib.getMovieClip("xianzhi_npc_3100");
        this._xianZhiNpc.scaleX = -1;
        this._xianZhiNpc.x = 445;
        this._xianZhiNpc.y = 456;
        _map.content.addChild(this._xianZhiNpc);
        this._xianZhiNpc.buttonMode = true;
    }

    private function clearMamaNpc():void {
        if (this._mamaNpc) {
            this._mamaNpc["mama"].removeEventListener(MouseEvent.CLICK, this.onShowDialogStep1_0);
            DisplayObjectUtil.removeFromParent(this._mamaNpc);
            this._mamaNpc = null;
        }
    }

    private function clearDiShaNpc():void {
        if (this._dishaNpc) {
            DisplayObjectUtil.removeFromParent(_processor.mouseHint);
            this._dishaNpc["sha"].removeEventListener(MouseEvent.CLICK, this.onDiNpcClickStep2_1);
            this._dishaNpc["di"].removeEventListener(MouseEvent.CLICK, this.onDiNpcClickStep2_0);
            DisplayObjectUtil.removeFromParent(this._dishaNpc);
            this._dishaNpc = null;
        }
    }

    private function clearXianZhiNpc():void {
        if (this._xianZhiNpc) {
            this._xianZhiNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep3_0);
            DisplayObjectUtil.removeFromParent(this._xianZhiNpc);
            this._xianZhiNpc = null;
        }
    }

    private function clearShowDiShaNpc():void {
        if (this._showDiShaNpc) {
            DisplayObjectUtil.removeFromParent(this._showDiShaNpc);
            this._showDiShaNpc = null;
        }
    }

    private function clearXianZhiIn():void {
        if (this._xianZhiIn) {
            DisplayObjectUtil.removeFromParent(this._xianZhiIn);
            this._xianZhiIn = null;
        }
    }

    private function clearAskMark():void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
            this._askMark = null;
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
        this.clearXianZhiNpc();
        this.clearMamaNpc();
        this.clearDiShaNpc();
        this.clearShowDiShaNpc();
        this.clearXianZhiIn();
        this.clearAskMark();
        super.processMapDispose();
    }
}
}
