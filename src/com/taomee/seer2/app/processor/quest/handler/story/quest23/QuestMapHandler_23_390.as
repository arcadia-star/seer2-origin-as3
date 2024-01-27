package com.taomee.seer2.app.processor.quest.handler.story.quest23 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_23_390 extends QuestMapHandler {


    private var _mamaNpc:MovieClip;

    private var _diNpc:MovieClip;

    private var _shaNpc:MovieClip;

    private var _xianZhiNpc:MovieClip;

    private var _xianZhiIn:MovieClip;

    private var _luluFightXianZhi:MovieClip;

    private var _npcLeave:MovieClip;

    private var _surpriseMark:MovieClip;

    private var _askMark:MovieClip;

    public function QuestMapHandler_23_390(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.createQuestNpc();
        if (QuestManager.isAccepted(_quest.id) == false) {
            this._surpriseMark = _processor.resLib.getMovieClip("surprise_mark");
            this._surpriseMark.x = 0;
            this._surpriseMark.y = 0 - this._mamaNpc.height;
            this._mamaNpc.addChild(this._surpriseMark);
            this._mamaNpc.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
        } else if (QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.processInterimNpc();
        } else if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.processStep4();
        } else if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.processStep5();
        }
    }

    private function onAcceptClick(param1:MouseEvent):void {
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
        }
        this.processAccept();
    }

    private function processAccept():void {
        NpcDialog.show(53, "兰德妈妈", [[3, "我什么都不管！我只知道……两个孩子都失踪了！！"]], ["你是说兰德和蒂萨特吗？"], [function ():void {
            NpcDialog.show(53, "兰德妈妈", [[3, "哼，肯定是你们！你们想像当年一样，抢走我的孩子……抢走我的家人！！这一次，我的擀面杖不会轻饶你们了！"]], ["（当年……？？擀面杖……）"], [function ():void {
                NpcDialog.show(55, "神月老大", [[0, "注意你的态度！洒家最见不得撒泼的妇人！俗话说……子不叫，父之过！"]], ["（是“子不教”，粗人……）"], [function ():void {
                    NpcDialog.show(56, "神爪财团老板", [[0, "哦呵呵呵……地月的人还是那么没文化嘛……也难怪，我们怎么能和文盲为伍呢？"]], ["（……）"], [function ():void {
                        NpcDialog.show(44, "大金牙", [[1, "大老板这句话说得很到位！文化人和文盲就连牙齿都是天差地别的！"]], ["（……）"], [function ():void {
                            NpcDialog.show(53, "兰德妈妈", [[2, "这些事情真的有那么重要吗……这么多年了你们见面就争吵不休……而我们这一辈人的矛盾直接危害了我们的孩子……！！"]], ["当年究竟发生了什么事？！"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.ACCEPT, onAccepted);
                                QuestManager.accept(_quest.id);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onAccepted(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
            this._mamaNpc.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            this.clearSurpriseMark();
            this.processInterimNpc();
            this.onInterimNpcClick(null);
        }
    }

    private function processStep4():void {
        if (_quest.getStepData(4, 0) == 0) {
            if (this._askMark == null) {
                this._askMark = _processor.resLib.getMovieClip("ask_mark");
            }
            this._askMark.x = this._mamaNpc.width / 2;
            this._askMark.y = -this._mamaNpc.height;
            this._askMark.scaleX = 1;
            this._mamaNpc.addChild(this._askMark);
            this._mamaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep4_0);
        } else if (_quest.getStepData(4, 0) == 1) {
            this.createXianZhiNpc();
            if (this._askMark == null) {
                this._askMark = _processor.resLib.getMovieClip("ask_mark");
            }
            this._askMark.x = this._xianZhiNpc.width / 2;
            this._askMark.y = -this._xianZhiNpc.height;
            this._askMark.scaleX = -1;
            this._xianZhiNpc.addChild(this._askMark);
            this._xianZhiNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep4_1);
        } else {
            this.createXianZhiNpc();
            if (this._askMark == null) {
                this._askMark = _processor.resLib.getMovieClip("ask_mark");
            }
            this._askMark.x = 0;
            this._askMark.y = -this._xianZhiNpc.height;
            this._askMark.scaleX = -1;
            this._xianZhiNpc.addChild(this._askMark);
            this._xianZhiNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep4_2);
        }
    }

    private function onShowDialogStep4_0(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(53, "兰德妈妈", [[2, "我已经受够了……！我现在唯一的愿望，只是我的孩子们能够平安！难道连这个都不行？？"]], ["（呜呜……居然是这样的过去！）"], [function ():void {
            NpcDialog.show(55, "神月老大", [[0, "洒家并没有掳走两个娃娃！洒家向来敢作敢当！不敢做的事情从来不去做！"]], ["（什么人啊……）"], [function ():void {
                NpcDialog.show(56, "神爪财团老板", [[0, "哼，我们当然也不知道那两个孩子在哪儿。我每天有成堆的财务报表要看，哪有这个空……"]], ["（什么人啊……）"], [function ():void {
                    _mamaNpc.removeEventListener(MouseEvent.CLICK, onShowDialogStep4_0);
                    _xianZhiIn = _processor.resLib.getMovieClip("mc_4_0");
                    _map.front.addChild(_xianZhiIn);
                    MovieClipUtil.playMc(_xianZhiIn, 1, _xianZhiIn.totalFrames, function ():void {
                        _quest.setStepData(4, 0, 1);
                        QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, onUpdateStepBufferStep4_1);
                        QuestManager.setStepBufferServer(_quest.id, 4);
                    }, true);
                }]);
            }]);
        }]);
    }

    private function onUpdateStepBufferStep4_1(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep4_1);
            DisplayObjectUtil.removeFromParent(this._xianZhiIn);
            this._xianZhiIn = null;
            this.createXianZhiNpc();
            this._xianZhiNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep4_1);
            this.showDialogStep4_1();
        }
    }

    private function onShowDialogStep4_1(param1:MouseEvent):void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        this.showDialogStep4_1();
    }

    private function showDialogStep4_1():void {
        NpcDialog.show(57, "先知", [[0, "禁忌的孪生子……必须铲除……"]], ["（你只会说这句话吗……）"], [function ():void {
            NpcDialog.show(57, "先知", [[0, "二人相认……必颠覆地沙二族……"]], ["等一下，我的鲁卜利娃娃不对劲！"], [function ():void {
                _xianZhiNpc.visible = false;
                _luluFightXianZhi = _processor.resLib.getMovieClip("mc_4_1");
                _map.content.addChild(_luluFightXianZhi);
                MovieClipUtil.playMc(_luluFightXianZhi, 1, _luluFightXianZhi.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_luluFightXianZhi);
                    _luluFightXianZhi = null;
                    _xianZhiNpc.visible = true;
                    _quest.setStepData(4, 0, 2);
                    QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, onUpdateStepBufferStep4_2);
                    QuestManager.setStepBufferServer(_quest.id, 4);
                }, true);
            }]);
        }]);
    }

    private function onUpdateStepBufferStep4_2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep4_2);
            this._xianZhiNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep4_1);
            this._xianZhiNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep4_2);
            this.showDialogStep4_2();
        }
    }

    private function onShowDialogStep4_2(param1:MouseEvent):void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        this.showDialogStep4_2();
    }

    private function showDialogStep4_2():void {
        NpcDialog.show(57, "先知", [[0, "唔……这个该死的……不用再管他们了……该来的总回来的……呵呵呵呵……我们走……"]], ["（……）"], [function ():void {
            processCompleteStep4();
        }]);
    }

    private function processCompleteStep4():void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        this.clearXianZhiNpc();
        this.clearDiNpc();
        this.clearShaNpc();
        this._npcLeave = _processor.resLib.getMovieClip("mc_4_2");
        _map.front.addChild(this._npcLeave);
        MovieClipUtil.playMc(this._npcLeave, 1, this._npcLeave.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_npcLeave);
            _npcLeave = null;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep4);
            QuestManager.completeStep(_quest.id, 4);
        }, true);
    }

    private function onCompleteStep4(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
            this.processStep5();
        }
    }

    private function processStep5():void {
        this.clearDiNpc();
        this.clearShaNpc();
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask_mark");
        }
        this._askMark.x = this._mamaNpc.width / 2;
        this._askMark.y = -this._mamaNpc.height;
        this._mamaNpc.addChild(this._askMark);
        this._mamaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialogStep5);
    }

    private function onShowDialogStep5(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
        }
        NpcDialog.show(53, "兰德妈妈", [[0, "鲁卜利娃娃……真的是它！"]], ["嗯，是蒂萨特送给兰德的！"], [function ():void {
            NpcDialog.show(53, "兰德妈妈", [[2, "为了保护他们，我不惜一切阻止他们见面……是我太傻了吧？他们是兄弟，这就是命运！"]], ["为什么那个娃娃会变成精灵？"], [function ():void {
                NpcDialog.show(53, "兰德妈妈", [[0, "鲁卜哈利是兰德爸爸生前最喜爱的也是唯一的精灵……是啊，连它都没有放弃反抗命运，我怎么能放弃？"]], ["是啊！"], [function ():void {
                    NpcDialog.show(53, "兰德妈妈", [[2, "但是，好不容易恢复精灵形态，却在先知的攻击下化为了沙砾……"]], ["那怎么办？"], [function ():void {
                        NpcDialog.show(53, "兰德妈妈", [[0, "当年，兰德爸爸就是从一堆沙砾中找到小鲁鲁的。他用了一个办法去培育它。我要想一想。等我想明白了，你就来找我吧！"]], ["没问题！！"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                            QuestManager.completeStep(_quest.id, 5);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        if (param1.questId == 23) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            this.clearMamaNpc();
        }
    }

    private function onInterimNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(55, "神月老大", [[0, "这个说来话长……！"]], ["然后呢？"], [function ():void {
            NpcDialog.show(56, "神爪财团老板", [[0, "很长很长……就在很久很久以前……"]], ["（陷入回忆）", "我回去吃个饭睡个觉再来！"], [function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 3100);
            }, null]);
        }]);
    }

    private function processInterimNpc():void {
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask_mark");
        }
        this._askMark.x = 0;
        this._askMark.y = -this._diNpc["di"].height;
        this._diNpc.addChild(this._askMark);
        this._diNpc["di"].addEventListener(MouseEvent.CLICK, this.onInterimNpcClick);
    }

    private function createQuestNpc():void {
        this._mamaNpc = _processor.resLib.getMovieClip("mama_npc_390");
        this._mamaNpc.x = 336.9;
        this._mamaNpc.y = 468.2;
        _map.content.addChild(this._mamaNpc);
        this._mamaNpc.buttonMode = true;
        this._diNpc = _processor.resLib.getMovieClip("di_npc_390");
        this._diNpc.x = 640;
        this._diNpc.y = 466;
        _map.content.addChild(this._diNpc);
        this._diNpc["di"].buttonMode = true;
        this._shaNpc = _processor.resLib.getMovieClip("sha_npc_390");
        this._shaNpc.x = 523;
        this._shaNpc.y = 467;
        _map.content.addChild(this._shaNpc);
    }

    private function createXianZhiNpc():void {
        this._xianZhiNpc = _processor.resLib.getMovieClip("xianzhi_npc_390");
        this._xianZhiNpc.scaleX = -1;
        this._xianZhiNpc.x = 589;
        this._xianZhiNpc.y = 378;
        _map.content.addChild(this._xianZhiNpc);
        this._xianZhiNpc.buttonMode = true;
    }

    private function clearXianZhiNpc():void {
        if (this._xianZhiNpc) {
            this._xianZhiNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep4_2);
            this._xianZhiNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep4_1);
            DisplayObjectUtil.removeFromParent(this._xianZhiNpc);
            this._xianZhiNpc = null;
        }
    }

    private function clearQuestNpc():void {
        this.clearMamaNpc();
        this.clearDiNpc();
        this.clearShaNpc();
    }

    private function clearMamaNpc():void {
        if (this._mamaNpc) {
            this._mamaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep5);
            this._mamaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialogStep4_0);
            this._mamaNpc.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            DisplayObjectUtil.removeFromParent(this._mamaNpc);
            this._mamaNpc = null;
        }
    }

    private function clearDiNpc():void {
        if (this._diNpc) {
            DisplayObjectUtil.removeFromParent(_processor.mouseHint);
            this._diNpc["di"].removeEventListener(MouseEvent.CLICK, this.onInterimNpcClick);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
        }
    }

    private function clearShaNpc():void {
        if (this._shaNpc) {
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
        }
    }

    private function clearSurpriseMark():void {
        if (this._surpriseMark) {
            DisplayObjectUtil.removeFromParent(this._surpriseMark);
            this._surpriseMark = null;
        }
    }

    private function clearAskMark():void {
        if (this._askMark) {
            DisplayObjectUtil.removeFromParent(this._askMark);
            this._askMark = null;
        }
    }

    private function clearAnimation():void {
        if (this._npcLeave) {
            DisplayObjectUtil.removeFromParent(this._npcLeave);
            this._npcLeave = null;
        }
        if (this._luluFightXianZhi) {
            DisplayObjectUtil.removeFromParent(this._luluFightXianZhi);
            this._luluFightXianZhi = null;
        }
        if (this._xianZhiIn) {
            DisplayObjectUtil.removeFromParent(this._xianZhiIn);
            this._xianZhiIn = null;
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep4_2);
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep4_1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep4);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        this.clearQuestNpc();
        this.clearXianZhiNpc();
        this.clearAnimation();
        this.clearAskMark();
        this.clearSurpriseMark();
        super.processMapDispose();
    }
}
}
