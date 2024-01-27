package com.taomee.seer2.app.processor.quest.handler.story.quest54 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_54_640 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    private var _scene:LobbyScene;

    public function QuestMapHandler_54_640(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initNpc();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.intMc();
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.intNpc();
        }
    }

    private function initNpc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(49, "冰沁酋长", [[0, "这件事情，要从琳达第一次出现在我们氏族说起……对，琳达，就是我们的“冰后”。"]], ["快告诉我吧！"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("54_0"), 3, [[1, 0]], function ():void {
                NpcDialog.show(49, "冰沁酋长", [[0, "并不擅长打理族内琐事的她将酋长一职任命与我。然而，还有更为重大的使命肩负在我身上，那就是——与萨伦帝国的对抗！！"]], ["难道……就不能没有战争吗……"], [function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("54_1"), 2, [[1, 0]], function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                        QuestManager.accept(_quest.id);
                    });
                }]);
            });
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        this.intMc();
    }

    private function intMc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
            this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkHandler);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkAgainHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
    }

    private function npcTalkAgainHandler(param1:MouseEvent):void {
        this.npcTalk();
    }

    private function npcTalk():void {
        NpcDialog.show(49, "冰沁酋长", [[0, "终于有一天，琳达做出了她的决定……"]], ["是什么？"], [function ():void {
            _scene = SceneManager.active as LobbyScene;
            _scene.hideToolbar();
            _mc_2 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(_mc_2);
            MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                _scene.showToolbar();
                NpcDialog.show(129, "琳达", [[2, "战争令吾族人饱尝心酸和痛苦，而其原因，仅仅是因为敌人想要压制或夺取吾等的力量……！"]], [], [function ():void {
                    NpcDialog.show(49, "冰沁酋长", [[0, "我们应该抵抗到底，终有一天敌人会放弃侵略的！"]], [], [function ():void {
                        NpcDialog.show(129, "琳达", [[2, "无尽的纷争令吾感到绝望。倘若毁去战争的源头，是否就没有战争了？"]], [], [function ():void {
                            NpcDialog.show(129, "琳达", [[2, "战争，无非是少数人因为一己私欲而发动的。为此，他们冠以各种大义凌然的名义，比如正义……但是，最终都会由无辜的人去承担结果。"]], [], [function ():void {
                                NpcDialog.show(49, "冰沁酋长", [[0, "琳达，你的意思是……"]], [], [function ():void {
                                    NpcDialog.show(129, "琳达", [[2, "吾族乃精灵王之心脏，如果心不够坚强，只会永远在痛苦中沉沦。吾要冰封这氏族所有令敌人虎视眈眈的力量。让战争无法延续下去。"]], [], [function ():void {
                                        NpcDialog.show(129, "琳达", [[2, "卡妮亚，请你呼唤暴风雪，将这一切导致战争的源头永冻。沁灵兽，吾明白这永冻无法困住你，就请你默默地、永远守护这氏族……"]], ["（不能，不能这样！！）"], [function ():void {
                                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("54_0"), function ():void {
                                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneCompleteHandler);
                                                QuestManager.completeStep(_quest.id, 1);
                                            }, true, false, 2);
                                        }]);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            });
        }]);
    }

    private function onStepOneCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneCompleteHandler);
        if (this._mc_2) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        this.intNpc();
    }

    private function intNpc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
            this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkAgainHandler);
        }
        if (this._mc_1) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkThirdHandler);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
    }

    private function npcTalkThirdHandler(param1:MouseEvent):void {
        this.NpcTalkAgain();
    }

    private function NpcTalkAgain():void {
        NpcDialog.show(49, "冰沁酋长", [[0, "其实，我们从不怪罪琳达的决定。又有谁愿意眼睁睁看着自己的同胞深陷痛苦？"]], ["但是这个做法不能解决任何问题。"], [function ():void {
            NpcDialog.show(122, "派瑞", [[1, "而今，我们还能站在这里，还能唱起那首歌，还击退了敌人。只要坚持下去，就一定能够看到曙光！"]], ["是，只要还活着，就会有好事发生！"], [function ():void {
                NpcDialog.show(123, "文森特", [[0, "我们总是在不断尝试，在失败中不断变强。我想，如果琳达能够看见今天发生的一切，也一定会感到欣慰。"]], ["（可是，冰后去哪儿了呢。）"], [function ():void {
                    NpcDialog.show(486, "詹姆斯", [[1, "唔！！唔唔唔！！唔……（脸红了的样子）"]], ["啥？想跟我走？（我怎么也听懂了=。=）"], [function ():void {
                        NpcDialog.show(122, "派瑞", [[2, "詹姆斯，虽然你唱歌走调，个子矮……但是，永远是我们的伙伴！和铁皮罐头好好混！害怕的时候，想想我和文森特，还有大家！"]], ["这话说的=。="], [function ():void {
                            NpcDialog.show(49, "冰沁酋长", [[0, "祝福你们，还有更长的战役需要我们一起去面对。另外，如果你有一天遇见琳达，请告诉她，我们都好……"]], ["嗯，一定的！"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestCompleteHandler);
                                QuestManager.completeStep(_quest.id, 2);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onQuestCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestCompleteHandler);
        if (param1.questId == 54) {
            if (this._mc_0) {
                DisplayUtil.removeForParent(this._mc_0);
            }
            if (this._mc_1) {
                DisplayUtil.removeForParent(this._mc_1);
            }
            if (this._mc_2) {
                DisplayUtil.removeForParent(this._mc_2);
            }
        }
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneCompleteHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestCompleteHandler);
    }
}
}
