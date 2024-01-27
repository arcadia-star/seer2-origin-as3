package com.taomee.seer2.app.processor.quest.handler.story.quest30 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
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

public class QuestMapHandler_30_390 extends QuestMapHandler {

    private static const NPC_BOSS_1:uint = 9;

    private static const NPC_BOSS_2:uint = 10;


    private var _diNpc:MovieClip;

    private var _shaNpc:MovieClip;

    private var _tinaNpc:MovieClip;

    private var _aXiuNpc:MovieClip;

    private var _sNpc:MovieClip;

    private var _lanNpc:MovieClip;

    private var _surpriseMark:MovieClip;

    private var _askMark:MovieClip;

    private var _tinaIn:MovieClip;

    public function QuestMapHandler_30_390(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && QuestManager.isAccepted(_quest.id) == false) {
            this.createNpc_0();
            this.addSurpriseMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK, this.onAcceptClick);
        } else if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.createNpc_1_0();
            this.processorStep();
        }
    }

    private function processorStep():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_1 && FightManager.fightWinnerSide == FightSide.LEFT) {
            this.createNpc_1_1();
            _quest.setStepData(1, 0, 1);
            QuestManager.setStepBufferServer(_quest.id, 1);
            this._aXiuNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_1);
            this.showDialog_1_1();
        } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_1 && FightManager.fightWinnerSide == FightSide.RIGHT) {
            this.createNpc_1_1();
            this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_0);
            this.showFailDialog_1_0();
        } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_2 && FightManager.fightWinnerSide == FightSide.LEFT) {
            this.createNpc_1_1();
            _quest.setStepData(1, 0, 1);
            QuestManager.setStepBufferServer(_quest.id, 1);
            this._aXiuNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_1);
            this.showDialog_1_1();
        } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord && FightManager.currentFightRecord.initData && FightManager.currentFightRecord.initData.positionIndex && FightManager.currentFightRecord.initData.positionIndex == NPC_BOSS_2 && FightManager.fightWinnerSide == FightSide.RIGHT) {
            this.createNpc_1_1();
            this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_1);
            this.showFailDialog_1_1();
        } else if (_quest.getStepData(1, 0) == 0) {
            this.createNpc_1_1();
            this.addAskMark(this._tinaNpc);
            this._tinaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_0);
        } else if (_quest.getStepData(1, 0) == 1) {
            this.createNpc_1_1();
            this.addAskMark(this._aXiuNpc);
            this._aXiuNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_1);
        } else if (_quest.getStepData(1, 0) == 2) {
            this.createNpc_1_1();
            this.addAskMark(this._tinaNpc);
            this._tinaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_2);
        } else if (_quest.getStepData(1, 0) == 3) {
            this.createNpc_1_1();
            this.addAskMark(this._tinaNpc);
            this._tinaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_3);
        } else if (_quest.getStepData(1, 0) == 4) {
            this.processStep_1_4();
        } else if (_quest.getStepData(1, 0) == 5) {
            this.createLanNpc();
            this.addAskMark(this._diNpc);
            this._diNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_4);
        }
    }

    private function onShowDialog_1_0(param1:MouseEvent):void {
        this.clearAskMark();
        this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_0);
        this.showDialog_1_0();
    }

    private function showDialog_1_0():void {
        NpcDialog.show(39, "缇娜", [[0, "哈哈，吾等很早以前就想尝试一下博士的新技术了……！阿修！"]], ["博士的新技术？"], [function ():void {
            NpcDialog.show(13, "阿修", [[1, "属下明白！"]], ["搞什么？"], [function ():void {
                FightManager.addEventListener(FightStartEvent.START_ERROR, onStartFightError_1_0);
                FightManager.addEventListener(FightStartEvent.START_SUCCESS, onStartFight_1_0);
                FightManager.startFightWithNPC(NPC_BOSS_1);
            }]);
        }]);
    }

    private function onStartFight_1_0(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_0);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_0);
    }

    private function onStartFightError_1_0(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_0);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_0);
        this.addAskMark(this._tinaNpc);
        this._tinaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_0);
    }

    private function onShowFailDialog_1_0(param1:MouseEvent):void {
        this.clearAskMark();
        this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_0);
        this.showFailDialog_1_0();
    }

    private function showFailDialog_1_0():void {
        NpcDialog.show(56, "神爪财团老板", [[3, "退下粗人！你已经受伤了，就去我的专署疗养院躺着！"]], ["（你这是在关心他……？）"], [function ():void {
            FightManager.addEventListener(FightStartEvent.START_ERROR, onStartFightError_1_1);
            FightManager.addEventListener(FightStartEvent.START_SUCCESS, onStartFight_1_1);
            FightManager.startFightWithNPC(NPC_BOSS_2);
        }]);
    }

    private function onStartFight_1_1(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_1);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_1);
    }

    private function onStartFightError_1_1(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_1);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_1);
        this.addAskMark(this._shaNpc);
        this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_0);
    }

    private function onShowFailDialog_1_1(param1:MouseEvent):void {
        this.clearAskMark();
        this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_1);
        this.showFailDialog_1_1();
    }

    private function showFailDialog_1_1():void {
        NpcDialog.show(56, "神爪财团老板", [[3, "我怎么可能……输给人品如此恶劣的混蛋！！"]], [" 大老板加油！！"], [function ():void {
            FightManager.addEventListener(FightStartEvent.START_ERROR, onStartFightError_1_2);
            FightManager.addEventListener(FightStartEvent.START_SUCCESS, onStartFight_1_2);
            FightManager.startFightWithNPC(NPC_BOSS_2);
        }]);
    }

    private function onStartFight_1_2(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_2);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_2);
    }

    private function onStartFightError_1_2(param1:FightStartEvent):void {
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_2);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_2);
        this.addAskMark(this._shaNpc);
        this._shaNpc.addEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_1);
    }

    private function onShowDialog_1_1(param1:MouseEvent):void {
        this.clearAskMark();
        this._aXiuNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_1);
        this.showDialog_1_1();
    }

    private function showDialog_1_1():void {
        NpcDialog.show(13, "阿修", [[1, "不愧是二大酋长，受伤了仍然有这样的势力。看来不用那个……不行了。"]], ["来什么都不怕！！"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30_0"), function ():void {
                _quest.setStepData(1, 0, 2);
                QuestManager.setStepBufferServer(_quest.id, 1);
                _tinaNpc.addEventListener(MouseEvent.CLICK, onShowDialog_1_2);
                showDialog_1_2();
            });
        }]);
    }

    private function onShowDialog_1_2(param1:MouseEvent):void {
        this.clearAskMark();
        this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_2);
        this.showDialog_1_2();
    }

    private function showDialog_1_2():void {
        NpcDialog.show(39, "缇娜", [[0, "哈哈，很好……很好……很好！！博士的新技术果然不错！！吾等踏平世界的愿望……必将实现！！！"]], ["双……精……灵！？！？"], [function ():void {
            NpcDialog.show(55, "神月老大", [[3, "下等的手段！！以多欺少算什么好汉！！"]], ["其实你们也可以联手……！"], [function ():void {
                NpcDialog.show(56, "神爪财团老板", [[0, "和地月的粗人……？"]], ["你们的氏族矛盾本来就是一个骗局啊！"], [function ():void {
                    NpcDialog.show(39, "缇娜", [[0, "对！地月和沙爪有必须敌对的理由……这已经不是一个骗局，因为你们已经无法克制仇恨对方的情绪！"]], ["太卑鄙！"], [function ():void {
                        NpcDialog.show(55, "神月老大", [[1, "哈哈……哈哈哈哈哈哈！！！你错了！！！你不要太低估洒家……！也许洒家只是一个粗人，也许神爪只是一个财奴……！"]], ["喂喂……"], [function ():void {
                            NpcDialog.show(56, "神爪财团老板", [[1, "哈哈，也许我们的确看彼此不顺眼……但是！在面对萨伦帝国的事情上……我们从来都是一致的！！"]], ["太好了！！"], [function ():void {
                                NpcDialog.show(13, "阿修", [[1, "那你们就……试试看！"]], ["上啊！！"], [function ():void {
                                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30_1"), function ():void {
                                        _quest.setStepData(1, 0, 3);
                                        QuestManager.setStepBufferServer(_quest.id, 1);
                                        _tinaNpc.addEventListener(MouseEvent.CLICK, onShowDialog_1_3);
                                        showDialog_1_3();
                                    });
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onShowDialog_1_3(param1:MouseEvent):void {
        this.clearAskMark();
        this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_3);
        this.showDialog_1_3();
    }

    private function showDialog_1_3():void {
        NpcDialog.show(39, "缇娜", [[0, "哼，S，阿修，一起上。懒得陪他们玩了。"]], ["谁怕谁啊！"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30_2"), function ():void {
                _quest.setStepData(1, 0, 4);
                QuestManager.setStepBufferServer(_quest.id, 1);
                processStep_1_4();
            }, true, false, 2);
        }]);
    }

    private function processStep_1_4():void {
        this.clearAXiuNpc();
        this.clearSNpc();
        this.clearTinaNpc();
        this._tinaIn = _processor.resLib.getMovieClip("mc_1_0");
        _map.front.addChild(this._tinaIn);
        MovieClipUtil.playMc(this._tinaIn, 1, this._tinaIn.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_tinaIn);
            _tinaIn = null;
            createLanNpc();
            _quest.setStepData(1, 0, 5);
            QuestManager.setStepBufferServer(_quest.id, 1);
            _diNpc.addEventListener(MouseEvent.CLICK, onShowDialog_1_4);
            showDialog_1_4();
        }, true);
    }

    private function onShowDialog_1_4(param1:MouseEvent):void {
        this.clearAskMark();
        this._diNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_4);
        this.showDialog_1_4();
    }

    private function showDialog_1_4():void {
        NpcDialog.show(55, "神月老大", [[1, "哈哈哈哈，看！洒家说过！两个娃娃不在洒家手上！！"]], ["兰德！蒂萨特！你们回来了！"], [function ():void {
            NpcDialog.show(52, "蒂萨特", [[1, "我和兰德德一开始被关在很黑的地方呢！那时候，有两个声音把身世都告诉我们了！！"]], ["两个声音？守护兽？"], [function ():void {
                NpcDialog.show(51, "兰德", [[1, "没错！原来我和蒂萨特是兄弟！！真是太好了！蒂萨特也有妈妈了！！"]], ["哇，原来你们都知道了！"], [function ():void {
                    NpcDialog.show(52, "蒂萨特", [[1, "那两个声音问我们，能不能……永远都互相信任，互相扶持，面对所有的困难！"]], ["嗯，嗯！"], [function ():void {
                        NpcDialog.show(51, "兰德", [[1, "答案……当然是肯定的！！蒂萨特永远都是我的好兄弟！永远都是！！"]], ["真是太好了！"], [function ():void {
                            NpcDialog.show(55, "神月老大", [[1, "哈哈！洒家……洒家突然很想落泪！！！"]], ["哈哈，这样，地沙是不是就不再敌对了？"], [function ():void {
                                NpcDialog.show(56, "神爪财团老板", [[1, "这个嘛……据说最好的对手就是最好的朋友……"]], ["喂喂……"], [function ():void {
                                    NpcDialog.show(55, "神月老大", [[1, "所以，财奴！洒家也会开始搞经济，这方面绝对不会输给你！等着瞧！！"]], ["这就开始挑衅了？"], [function ():void {
                                        NpcDialog.show(56, "神爪财团老板", [[1, "打架我也不会输给你这个粗人！刚才的胜利多亏了我吧……哈哈哈哈哈哈，我们来日方长！"]], ["哎～真是热闹的两个氏族～"], [function ():void {
                                            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                            QuestManager.completeStep(_quest.id, 1);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 30) {
            this.processMapDispose();
        }
    }

    private function onAcceptClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this.clearSurpriseMark();
        this._diNpc.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
        NpcDialog.show(55, "神月老大", [[3, "胆敢……愚弄洒家！洒家不会饶恕你们！！"]], ["老大你已经受伤了啊！"], [function ():void {
            NpcDialog.show(56, "神爪财团老板", [[3, "哼……受伤又如何？愚弄我族之人，将我族人的未来玩弄于股掌……如果我不击退他们，我怎么保护我的族人？！我还做什么老板？！！"]], ["大老板……！"], [function ():void {
                NpcDialog.show(14, "S", [[1, "哇！要打吗？女王让我来！我忍他们很久了……"]], ["可恶！！"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccepted);
                    QuestManager.accept(_quest.id);
                }]);
            }]);
        }]);
    }

    private function onAccepted(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
            this._tinaNpc.addEventListener(MouseEvent.CLICK, this.onShowDialog_1_0);
            this.showDialog_1_0();
        }
    }

    private function createNpc_0():void {
        this.createDiNpc();
        this.createShaNpc();
        this.createSNpc();
        this.createTinaNpc();
        this.createAXiuNpc();
    }

    private function createNpc_1_0():void {
        this.createDiNpc();
        this.createShaNpc();
    }

    private function createNpc_1_1():void {
        this.createSNpc();
        this.createTinaNpc();
        this.createAXiuNpc();
    }

    private function createDiNpc():void {
        this._diNpc = _processor.resLib.getMovieClip("npc_di");
        this._diNpc.x = 660.9;
        this._diNpc.y = 417.95;
        _map.content.addChild(this._diNpc);
        this._diNpc.buttonMode = true;
    }

    private function createShaNpc():void {
        this._shaNpc = _processor.resLib.getMovieClip("npc_sha");
        this._shaNpc.x = 553.9;
        this._shaNpc.y = 446.6;
        _map.content.addChild(this._shaNpc);
        this._shaNpc.buttonMode = true;
    }

    private function createAXiuNpc():void {
        this._aXiuNpc = _processor.resLib.getMovieClip("npc_aXiu");
        this._aXiuNpc.x = 436.3;
        this._aXiuNpc.y = 473.6;
        _map.content.addChild(this._aXiuNpc);
        this._aXiuNpc.buttonMode = true;
    }

    private function createTinaNpc():void {
        this._tinaNpc = _processor.resLib.getMovieClip("npc_tina");
        this._tinaNpc.x = 697.8;
        this._tinaNpc.y = 383.95;
        _map.content.addChild(this._tinaNpc);
        this._tinaNpc.buttonMode = true;
    }

    private function createSNpc():void {
        this._sNpc = _processor.resLib.getMovieClip("npc_s");
        this._sNpc.x = 571.8;
        this._sNpc.y = 375.9;
        _map.content.addChild(this._sNpc);
        this._sNpc.buttonMode = true;
    }

    private function createLanNpc():void {
        this._lanNpc = _processor.resLib.getMovieClip("npc_lan");
        this._lanNpc.x = 571.8;
        this._lanNpc.y = 375.9;
        _map.content.addChild(this._lanNpc);
        this._lanNpc.buttonMode = true;
    }

    private function addSurpriseMark(param1:MovieClip):void {
        if (this._surpriseMark == null) {
            this._surpriseMark = _processor.resLib.getMovieClip("surprise");
        }
        this._surpriseMark.x = 0;
        this._surpriseMark.y = -param1.height;
        param1.addChild(this._surpriseMark);
    }

    private function addAskMark(param1:MovieClip):void {
        if (this._askMark == null) {
            this._askMark = _processor.resLib.getMovieClip("ask");
        }
        this._askMark.x = 0;
        this._askMark.y = -param1.height;
        param1.addChild(this._askMark);
    }

    private function clearDiNpc():void {
        if (this._diNpc) {
            this._diNpc.removeEventListener(MouseEvent.CLICK, this.onAcceptClick);
            this._diNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_4);
            DisplayObjectUtil.removeFromParent(this._diNpc);
            this._diNpc = null;
        }
    }

    private function clearShaNpc():void {
        if (this._shaNpc) {
            this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_0);
            this._shaNpc.removeEventListener(MouseEvent.CLICK, this.onShowFailDialog_1_1);
            DisplayObjectUtil.removeFromParent(this._shaNpc);
            this._shaNpc = null;
        }
    }

    private function clearSNpc():void {
        if (this._sNpc) {
            DisplayObjectUtil.removeFromParent(this._sNpc);
            this._sNpc = null;
        }
    }

    private function clearLanNpc():void {
        if (this._lanNpc) {
            DisplayObjectUtil.removeFromParent(this._lanNpc);
            this._lanNpc = null;
        }
    }

    private function clearTinaNpc():void {
        if (this._tinaNpc) {
            this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_0);
            this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_2);
            this._tinaNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_3);
            DisplayObjectUtil.removeFromParent(this._tinaNpc);
            this._tinaNpc = null;
        }
    }

    private function clearAXiuNpc():void {
        if (this._aXiuNpc) {
            DisplayObjectUtil.removeFromParent(this._aXiuNpc);
            this._aXiuNpc.removeEventListener(MouseEvent.CLICK, this.onShowDialog_1_1);
            this._aXiuNpc = null;
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

    private function clearTinaIn():void {
        if (this._tinaIn) {
            DisplayObjectUtil.removeFromParent(this._tinaIn);
            this._tinaIn = null;
        }
    }

    override public function processMapDispose():void {
        this.clearLanNpc();
        this.clearTinaIn();
        this.clearSurpriseMark();
        this.clearAskMark();
        this.clearDiNpc();
        this.clearShaNpc();
        this.clearAXiuNpc();
        this.clearSNpc();
        this.clearTinaNpc();
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_0);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_0);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_1);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_1);
        FightManager.removeEventListener(FightStartEvent.START_ERROR, this.onStartFightError_1_2);
        FightManager.removeEventListener(FightStartEvent.START_SUCCESS, this.onStartFight_1_2);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        super.processMapDispose();
    }
}
}
