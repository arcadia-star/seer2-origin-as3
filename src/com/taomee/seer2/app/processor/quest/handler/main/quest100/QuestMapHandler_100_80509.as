package com.taomee.seer2.app.processor.quest.handler.main.quest100 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.errors.IllegalOperationError;

public class QuestMapHandler_100_80509 extends QuestMapHandler {


    public function QuestMapHandler_100_80509(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(100)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        } else if (QuestManager.isAccepted(100) && !QuestManager.isComplete(100) && QuestManager.isStepComplete(100, 1) == false) {
            this.initStep1();
        }
    }

    protected function onAccept(param1:QuestEvent):void {
        StatisticsManager.newSendNovice("2016活动", "主线谜团渐进", "谜团渐进任务接取");
        if (_quest.id == param1.questId) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        NpcDialog.show(3020, "弗雷德", [[0, "好的，那我就放心了。接下来我将用暗影能力将我们同撒莱尔的对话加密，这些事情只有我们和撒莱尔知道……"]], ["......"], [function () : void {
            NpcDialog.show(400, "", [[0, "一阵黑雾洗过影子密室，世界似乎变得无比寂静"]], ["......"], [function () : void {
                NpcDialog.show(400, "小赛尔", [[0, "（惊讶）这就是暗影能力么……（原本我和密室外的巴蒂和多罗还保有无线同步，现在所有的联系都被强行中断了……如今这里好似被隔绝在世界之外，成为了一个真正的密室……）"]], ["吓，，它……它说话了……"], [function () : void {
                    NpcDialog.show(400, "小赛尔", [[0, "撒莱尔，能告诉我们暗影法典失踪是怎样的一回事吗？"]], ["........."], [function () : void {
                        NpcDialog.show(3094, "撒莱尔", [[0, "(打量）你就是暗影氏族选中来破解谜题的人么？（沉吟）从星际坠落的使者，真的能带来希望吗？"]], ["......"], [function () : void {
                            NpcDialog.show(3020, "弗雷德", [[0, "(试探着问）难道……暗影法典之上，有这方面的预言记录？"]], ["......"], [function () : void {
                                NpcDialog.show(400, "小赛尔", [[0, "（突发奇想）这样想来，影之法典预言过自己的“失窃”吗？"]], ["......"], [function () : void {
                                    NpcDialog.show(3020, "弗雷德", [[0, "铁皮你果真风趣……（思考）不过这也是个问题。"]], ["......"], [function () : void {
                                        NpcDialog.show(3094, "撒莱尔", [[0, "这我不知道，能看懂这部法典的只有影灵兽大人。但是无论如何，我见识到了暗影法典失窃的全程。"]], ["（莫名严肃）说来听听"], [function () : void {
                                            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("100_0"), 6, [[1, 0]], function () : void {
                                                NpcDialog.show(400, "小赛尔", [[0, "（是这样吗……对啊，您一开始就对我说过，暗影氏族一直以来就隐藏在黑暗之中。可是，当年在能源之潮，我明明看见了影灵兽和萨伦帝国一起行动啊……"]], ["......"], [function () : void {
                                                    NpcDialog.show(3020, "弗雷德", [[0, "（惊讶）这……这是怎么回事？（突然想起了什么）影灵兽大人似乎说过这个地方，那和精灵王约瑟有关……正因为这样，影灵兽更是不会和萨伦帝国同行的……"]], ["......"], [function () : void {
                                                        NpcDialog.show(3020, "弗雷德", [[0, "因为他是约瑟王映在南半球的影子啊……"]], ["......"], [function () : void {
                                                            NpcDialog.show(400, "小赛尔", [[0, "不过说来也是，如果他是奎尔斯的一部分，名号应是“影魂兽”才对……但是这么说来，我的印象中，他确实在能源之潮和萨伦帝国一起行动了……"]], [" 这究竟是怎么回事？……"], [function () : void {
                                                                NpcDialog.show(3094, "撒莱尔", [[0, "世界上有两种黑暗，一种是光芒被遮盖形成的黑暗，一种则是永夜……（情绪似乎有些低落）影灵兽大人应该是有自己的考虑的，所以他才从历史的幕后走到了前台。但是事情发展到这个程度，就连他恐怕也没有料到……"]], ["......"], [function () : void {
                                                                    NpcDialog.show(3020, "弗雷德", [[0, "（叹气）果然变成了这样么？原本在暗处观望这个世界的我们，难道到了明处就会被光芒烧成灰烬？撒莱尔，关于影灵兽大人的情况，你还知道多少？"]], ["......"], [function () : void {
                                                                        NpcDialog.show(3094, "撒莱尔", [[0, "我知道的也许不比你们多，但是，我可以确定——影灵兽大人绝不是萨伦帝国的拥簇，他所做的一切都是为了自己的真相"]], ["......"], [function () : void {
                                                                            NpcDialog.show(3094, "撒莱尔", [[0, "他也许和萨伦帝国或是帝国之中的某个阵营有着利益上的合作，但这种合作必将破裂——或许如今早已破裂了。"]], [" 感觉有更大的黑暗藏在之后……"], [function ():void {
                                                                                NpcDialog.show(400, "小赛尔", [[0, "乍一听我没有理解，但是幕后的黑暗，感觉就像是永夜。"]], ["......"], [function ():void {
                                                                                    NpcDialog.show(3020, "弗雷德", [[0, "影灵兽、能源之潮……小家伙，好好想想吧，暗影氏族，甚至阿卡迪亚的未来，都在你的手中啊！"]], ["......"], [function ():void {
                                                                                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("100_0"), function ():void {
                                                                                            StatisticsManager.newSendNovice("2016活动", "主线谜团渐进", "谜团渐进任务完成");
                                                                                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
                                                                                            QuestManager.completeStep(questID, 1);
                                                                                        });
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
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == 100 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        }
    }
}
}
