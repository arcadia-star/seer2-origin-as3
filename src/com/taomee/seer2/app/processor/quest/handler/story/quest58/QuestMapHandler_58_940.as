package com.taomee.seer2.app.processor.quest.handler.story.quest58 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_58_940 extends QuestMapHandler {


    private var _npc:Mobile;

    private var _npcDefinition:NpcDefinition;

    private var escape_58:MovieClip;

    private var mark:AcceptableMark;

    private var capture:MovieClip;

    public function QuestMapHandler_58_940(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.clickAiLike);
        }
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.playfull2);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.capture) {
            this.capture.removeEventListener(MouseEvent.CLICK, this.clickAiLike);
            this.capture.removeEventListener(MouseEvent.CLICK, this.showGasDia);
        }
    }

    override public function processMapComplete():void {
        var _loc1_:Mobile = null;
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                this.showArenaDia();
            } else {
                this.initQuestStep2();
            }
        }
        if (QuestManager.isAccepted(58) && !QuestManager.isComplete(_quest.id)) {
            _loc1_ = MobileManager.getMobile(155, MobileType.NPC);
            _loc1_.visible = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.initQuestStep3();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
            this.initQuestStep4();
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && !QuestManager.isComplete(_quest.id)) {
            this.initQuestStep5();
        }
    }

    private function initQuestStep5():void {
        this.capture = _processor.resLib.getMovieClip("capture_58");
        _map.content.addChild(this.capture);
        this.capture.buttonMode = true;
        if (!this.mark) {
            this.mark = new AcceptableMark();
        }
        this.mark.x = 266;
        this.mark.y = 220;
        this.capture.addChild(this.mark);
        this.capture.addEventListener(MouseEvent.CLICK, this.showGasDia);
    }

    private function showGasDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(155, "艾力克", [[1, "好！现在我们快把蒸汽全部灌入斯莫克身上吧！只要有足够的蒸汽，斯莫克就能使出惊人的力量！"]], ["好的！"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("58_3"), function ():void {
                capture["killer"].visible = false;
                NpcDialog.show(155, "艾力克", [[0, "现在终于暂时安全了…刚才真是吓死我了…吓死我了……"]], [], [function ():void {
                    NpcDialog.show(400, "我", [[0, "你真的是迷雾杀手吗？"]], [], [function ():void {
                        NpcDialog.show(155, "艾力克", [[0, "这里早已是暗杀者的天下了！为了防止外来无辜的愚民前来送死，我只好制造恐怖迷雾杀手的传闻…"]], [], [function ():void {
                            NpcDialog.show(400, "我", [[0, "难道传闻中的迷雾杀手并不是杀人不眨眼的恶魔而是保护着外来人的英雄？"]], [], [function ():void {
                                NpcDialog.show(155, "艾力克", [[0, "这是最危险的城池，将他理解为世界上最恐怖的地带对外来人来说是最合适不过的了。"]], [], [function ():void {
                                    NpcDialog.show(400, "我", [[0, "看来风系氏族中还有这许多不为人知的秘密"]], [], [function ():void {
                                        NpcDialog.show(155, "艾力克", [[0, "恐怖的迷雾杀手不能消失，传闻也必须继续下去，铁皮，你能帮我守住今天的秘密吗？"]], [], [function ():void {
                                            NpcDialog.show(400, "我", [[0, "身为星级使者超级赛尔号的我给你保守这个秘密没问题，但是……"]], [], [function ():void {
                                                NpcDialog.show(155, "艾力克", [[0, "有什么条件吗？"]], [], [function ():void {
                                                    NpcDialog.show(400, "我", [[0, "要加入到探索和保护风刃氏族的行列当中！"]], [], [function ():void {
                                                        NpcDialog.show(155, "艾力克", [[0, "嗯。刚才我也见识了你的实力！好吧！就答应你了！万事小心！"]], [], [function ():void {
                                                            NpcDialog.show(400, "我", [[0, "那再见吧！恐怖的迷雾杀手！"]], [], [function ():void {
                                                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("58_4"), function ():void {
                                                                    DisplayObjectUtil.removeFromParent(capture);
                                                                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                                                    QuestManager.completeStep(_quest.id, 5);
                                                                }, false);
                                                            }]);
                                                        }]);
                                                    }]);
                                                }]);
                                            }]);
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

    private function onComplete(param1:QuestEvent):void {
        var _loc2_:Mobile = null;
        if (param1.questId == 58) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            _loc2_ = MobileManager.getMobile(155, MobileType.NPC);
            _loc2_.visible = true;
        }
    }

    private function showArenaDia():void {
        var ailismk:MovieClip = null;
        ailismk = _processor.resLib.getMovieClip("ailismk");
        _map.content.addChild(ailismk);
        NpcDialog.show(155, "艾力克", [[1, "见识到恐怖迷雾杀手的厉害了吧？"]], ["看来你也不过如此"], [function ():void {
            NpcDialog.show(155, "艾力克", [[1, "刚刚是我手下留情，看你这个铁皮还没见过什么世面，留你一条小命……啊！不好！快跑！"]], ["谁？"], [function ():void {
                DisplayObjectUtil.removeFromParent(ailismk);
                escape_58 = _processor.resLib.getMovieClip("escape_58");
                _map.content.addChild(escape_58);
                MovieClipUtil.playMc(escape_58, 1, escape_58.totalFrames, function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                    QuestManager.completeStep(_quest.id, 2);
                }, true);
            }]);
        }]);
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            if (param1.stepId == 2) {
                DisplayUtil.removeForParent(this.escape_58);
                this.initQuestStep3();
            } else if (param1.stepId == 3) {
                SceneManager.changeScene(SceneType.LOBBY, 930, 760, 440);
            }
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        }
    }

    private function initQuestStep4():void {
        this.capture = _processor.resLib.getMovieClip("capture_58");
        _map.content.addChild(this.capture);
        MovieClipUtil.playMc(this.capture, 1, this.capture.totalFrames, function ():void {
            capture.buttonMode = true;
            if (!mark) {
                mark = new AcceptableMark();
            }
            DisplayObjectUtil.removeFromParent(mark);
            mark.x = 266;
            mark.y = 220;
            capture.addChild(mark);
            capture.addEventListener(MouseEvent.CLICK, clickAiLike);
        }, true);
    }

    private function clickAiLike(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(155, "艾力克", [[0, "刚才让你走你不走，现在真正的暗杀者来了，他的实力，绝非你想象的那么简单！"]], [], [function ():void {
            NpcDialog.show(400, "我", [[0, "你到底是谁？你为什么要帮我？你不是传闻中恐怖的迷雾杀手吗？"]], [], [function ():void {
                NpcDialog.show(155, "艾力克", [[0, "不要废话了！快去御风中枢，寻找蒸汽罐，采集9个给斯莫克增加蒸汽动力，精灵身上的蒸汽就要被消耗掉了！快！"]], [], [function ():void {
                    NpcDialog.show(400, "我", [[0, "好！好！我马上去！"]], [], [function ():void {
                        if (!QuestManager.isStepComplete(58, 3)) {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                            QuestManager.completeStep(58, 3);
                        } else {
                            SceneManager.changeScene(SceneType.LOBBY, 930, 760, 440);
                        }
                    }]);
                }]);
            }]);
        }]);
    }

    private function initQuestStep3():void {
        var _loc1_:XML = <npc id="145" resId="145" name="" dir="1" width="25" height="90" pos="194,330"
                              actorPos="200,330" path="">
            <dialog npcId="145" npcName="暗杀者" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[嘿嘿嘿！上次放过你了，这次做好面对死亡的觉悟吧，这周围炙热的熔炉将是你此生的尽头！]]></node>
                    <reply action="goToBranch" params="branch1"><![CDATA[你是谁？我不怕你！]]></reply>
                </branch>
                <branch id="branch1">
                    <node emotion="0"><![CDATA[嘿嘿！愚蠢的铁皮！居然敢不自量力的挑战我！不过反正结果都是一样的！哈哈哈哈！]]></node>
                    <reply action="" params="58_940_0"><![CDATA[那就试试看！]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition = new NpcDefinition(_loc1_);
        this._npc = MobileManager.createNpc(this._npcDefinition);
        this._npc.buttonMode = true;
        this._npc.addOverHeadMark(new AcceptableMark());
        this._npc.addEventListener(MouseEvent.CLICK, this.showDia);
    }

    private function showDia(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playfull2);
    }

    private function playfull2(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        var params:String = (evt.content as DialogPanelEventData).params;
        if (params == "58_940_0") {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("58_2"), function ():void {
                MobileManager.removeMobile(_npc, MobileType.NPC);
                initQuestStep4();
            });
        }
    }

    private function initQuestStep2():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("58_1"), function ():void {
            var ailismk:MovieClip = _processor.resLib.getMovieClip("ailismk");
            _map.content.addChild(ailismk);
            NpcDialog.show(400, "我", [[3, "否则怎样！"]], [], [function ():void {
                NpcDialog.show(155, "艾力克", [[3, "否则…否则就……就让你有来无回……我……我可是恐怖的迷雾杀手…今天心情好才放你一马，你可要珍惜机会呀！"]], [], [function ():void {
                    NpcDialog.show(400, "我", [[3, "原来你就是迷雾杀手啊！那就让我看看你有多厉害！"]], [], [function ():void {
                        NpcDialog.show(155, "艾力克", [[3, "你可不要后悔…你确定你要和强大的恐怖的迷雾杀手交手吗？"]], [], [function ():void {
                            NpcDialog.show(400, "我", [[3, "少废话！来吧！"]], [], [function ():void {
                                FightManager.startFightWithWild(164);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        });
    }
}
}
