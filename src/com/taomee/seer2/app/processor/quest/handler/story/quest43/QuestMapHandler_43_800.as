package com.taomee.seer2.app.processor.quest.handler.story.quest43 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_43_800 extends QuestMapHandler {


    private var _fightStatus:Boolean;

    private var _mc_0:MovieClip;

    public function QuestMapHandler_43_800(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onScarecrowSayHandler);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onScarecrowSayAgainHandler);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onScarecrowThirdHandler);
        }
    }

    private function onScarecrowSayHandler(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "43_0") {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_3"), function ():void {
                fightOver();
            }, true, false, 2);
        }
    }

    private function fightOver():void {
        NpcDialog.show(475, "长腿的稻草人", [[0, "打完之后，仔细看了一下，才发现，你好像……不是乌鸦？"]], [" 你才发现啊！！！"], [function ():void {
            NpcDialog.show(475, "长腿的稻草人", [[1, "哟呵呵呵——眼神儿不好，眼神儿不好——"]], ["来吧，给你机会解释一下，这是怎么回事。"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1Handler);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }]);
    }

    private function onStep1Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        this.scarecrowSay();
    }

    private function onScarecrowSayAgainHandler(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "43_1") {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_1"), function ():void {
                NpcDialog.show(475, "长腿的稻草人", [[1, "哟呵呵呵——就这样，我每天的生活都紧张、刺激——还有很强的使命感——"]], ["您这是悲剧……"], [function ():void {
                    NpcDialog.show(475, "长腿的稻草人", [[1, "能够守护主人的秘宝我吃多大苦都值得~"]], ["好吧好吧……"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Handler);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            }, true, false, 2);
        }
    }

    private function scarecrowSay():void {
        NpcDialog.show(475, "长腿的稻草人", [[1, "既然你不是乌鸦，我就放心了——哟呵呵呵——"]], ["攻击齿轮鹰它们，就因为它们像乌鸦？"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_1"), function ():void {
                NpcDialog.show(475, "长腿的稻草人", [[1, "哟呵呵呵——就这样，我每天的生活都紧张、刺激——还有很强的使命感——"]], ["您这是悲剧……"], [function ():void {
                    NpcDialog.show(475, "长腿的稻草人", [[1, "能够守护主人的秘宝我吃多大苦都值得~"]], ["好吧好吧……"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep2Handler);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            }, true, false, 2);
        }]);
    }

    private function onStep2Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Handler);
        this.ScarecrowSayThird();
    }

    private function onScarecrowThirdHandler(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "43_2") {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_2"), function ():void {
                NpcDialog.show(475, "长腿的稻草人", [[0, "他说：不管怎么样，谢谢你陪伴我度过这些岁月，你是我宝贵的朋友。也许就是从那一天开始，我变成了精灵……"]], ["是这样啊……"], [function ():void {
                    NpcDialog.show(475, "长腿的稻草人", [[0, "那之后没过多久，主人就去世了。他将那些秘宝托付给了我，让我交给那个最后能够拯救这个星球的勇士。"]], ["难道会是和复活精灵王相关的东西？"], [function ():void {
                        NpcDialog.show(475, "长腿的稻草人", [[0, "那群可恶的乌鸦从来都没有放弃，它们很可能就潜伏在周围，等待机会抢走剩下的宝物！"]], ["看来笔记上的内容非同小可。"], [function ():void {
                            NpcDialog.show(475, "长腿的稻草人", [[0, "谢谢你听我说那么多！也许有一天，我能够完成这个使命……将主人的心血交给某个人。"]], ["（看来，我该向这个目标努力呢！）"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                                QuestManager.completeStep(_quest.id, 3);
                            }]);
                        }]);
                    }]);
                }]);
            }, true, false, 2);
        }
    }

    private function ScarecrowSayThird():void {
        NpcDialog.show(475, "长腿的稻草人", [[0, "很久没有人这样听我诉说了——大家都是看见我就逃走了——"]], ["多亏了你的无差别攻击呀！"], [function ():void {
            NpcDialog.show(475, "长腿的稻草人", [[1, "其实我有一个秘密，一直无人倾诉——那么多年来，都埋在心底——今天特别想一吐为快——哟呵呵呵……"]], ["来吧，对我倾诉吧。"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_2"), function ():void {
                    NpcDialog.show(475, "长腿的稻草人", [[0, "他说：不管怎么样，谢谢你陪伴我度过这些岁月，你是我宝贵的朋友。也许就是从那一天开始，我变成了精灵……"]], ["是这样啊……"], [function ():void {
                        NpcDialog.show(475, "长腿的稻草人", [[0, "那之后没过多久，主人就去世了。他将那些秘宝托付给了我，让我交给那个最后能够拯救这个星球的勇士。"]], ["难道会是和复活精灵王相关的东西？"], [function ():void {
                            NpcDialog.show(475, "长腿的稻草人", [[0, "那群可恶的乌鸦从来都没有放弃，它们很可能就潜伏在周围，等待机会抢走剩下的宝物！"]], ["看来笔记上的内容非同小可。"], [function ():void {
                                NpcDialog.show(475, "长腿的稻草人", [[0, "谢谢你听我说那么多！也许有一天，我能够完成这个使命……将主人的心血交给某个人。"]], ["（看来，我该向这个目标努力呢！）"], [function ():void {
                                    QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                                    QuestManager.completeStep(_quest.id, 3);
                                }]);
                            }]);
                        }]);
                    }]);
                }, true, false, 2);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1Handler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep2Handler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
