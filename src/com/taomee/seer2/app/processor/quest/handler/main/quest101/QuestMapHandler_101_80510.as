package com.taomee.seer2.app.processor.quest.handler.main.quest101 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

import flash.errors.IllegalOperationError;

public class QuestMapHandler_101_80510 extends QuestMapHandler {


    public function QuestMapHandler_101_80510(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var npc:* = _processor.resLib.getMovieClip("npc");
        _map.front.addChild(npc);
        var _loc_2:* = false;
        npc.mouseEnabled = false;
        npc.mouseChildren = _loc_2;
        NpcDialog.show(3098, "翟", [[0, "尊敬的族长，影灵兽有何吩咐？鄙人必将全力践行，百死不怠。"]], ["......"], [function () : void {
            NpcDialog.show(3097, "乌尔栀", [[0, "尊敬的族长，又有什么有趣的事情发生了么？"]], ["......"], [function () : void {
                NpcDialog.show(3096, "斯卡沃兹", [[0, "尊敬的族长，我来到这里，听从影灵兽的意志，践行暗影氏族的荣光。"]], ["......"], [function () : void {
                    NpcDialog.show(3095, "艾本德", [[0, "尊敬的族长，下达影灵兽的命令吧。"]], ["......"], [function () : void {
                        NpcDialog.show(3020, "弗雷德", [[0, "诸位，这位就是影灵兽所预言的星际使者。接下来，你们要听从他的要求"]], ["......"], [function () : void {
                            NpcDialog.show(3098, "翟", [[0, "星际使者？（欣喜）在下是翟，久仰您的大名，您就是努力地组织北半球抵抗侵略的英雄吧？"]], ["被人这么夸奖还是挺不好意思的……"], [function () : void {
                                NpcDialog.show(400, "小赛尔", [[0, "翟先生你好。我并非什么“英雄”，我只是启发出了他们本就有的一些重要的意志罢了。"]], ["......"], [function () : void {
                                    NpcDialog.show(3097, "乌尔栀", [[0, "星际使者啊，这身行头不错，铁皮的。我是乌尔栀，我认为这种风格正符合了星球战争时期的审美要求呢，在这方面我们也许可以谈谈。"]], ["没想到第七小队队服也会莫名的受欢迎……"], [function () : void {
                                        NpcDialog.show(400, "小赛尔", [[0, "乌尔栀你好。我并非什么时尚达人，还请你多多指教"]], ["......"], [function () : void {
                                            NpcDialog.show(3096, "斯卡沃兹", [[0, "星际使者您好。本人斯卡沃兹，暗影氏族恭迎您的莅临。"]], ["（彬彬有礼，俨然是贵族的气质啊！）"], [function () : void {
                                                NpcDialog.show(400, "小赛尔", [[0, "斯卡沃兹先生，感谢你的欢迎。"]], ["......"], [function () : void {
                                                    NpcDialog.show(3095, "艾本德", [[0, "星际使者，我是艾本德，暗影氏族情报工作者"]], ["你好……"], [function () : void {
                                                        NpcDialog.show(400, "小赛尔", [[0, "……（对于寡言少语的冰山女王我还真不知道该怎么说……）"]], ["......"], [function () : void {
                                                            NpcDialog.show(3020, "弗雷德", [[0, "好的星际使者。现在请你代为转达影灵兽的旨意吧！"]], ["（不行，目前还没有头绪。）"], [function () : void {
                                                                NpcDialog.show(400, "小赛尔", [[0, "（问问巴蒂吧。那么先找个便于通讯的地方，再作下一步的打算。）诸位先在这里等一会吧，等我叫你们的时候再过来。"]], ["......"], [function () : void {
                                                                    NpcDialog.show(400, "小赛尔", [[0, "喂喂，巴蒂么？刚才的情况你们都听到了吗？"]], ["......"], [function () : void {
                                                                        NpcDialog.show(10, "巴蒂", [[0, "……呲啦呲啦……是的队长，信号还算良好，听得清清楚楚。怎么，想不到办法了？"]], ["……你说话还是这么犀利。"], [function () : void {
                                                                            NpcDialog.show(1003, "多罗", [[0, "不要气馁！亮晶晶小队永远在你周围！队长最棒！"]], ["......"], [function () : void {
                                                                                NpcDialog.show(10, "巴蒂", [[0, "多罗你先一边去。队长我跟你说啊，待会儿你告诉撒莱尔………………………………"]], ["......"], [function () : void {
                                                                                    NpcDialog.show(400, "小赛尔", [[0, "好计策！巴蒂你真是个天才啊！"]], ["......"], [function () : void {
                                                                                        NpcDialog.show(10, "巴蒂", [[0, "嘘！队长，声音太大了！现在赶紧召集族人们进入影子密室吧！"]], ["......"], [function () : void {
                                                                                            NpcDialog.show(400, "小赛尔", [[0, "（大声地）四位！以及长老大人！请随我进入影子密室！"]], ["（点击进入影子密室）"], [function () : void {
                                                                                                QuestManager.completeStep(questID, 1);
                                                                                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep);
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
    }

    private function onStep(param1:QuestEvent):void {
        if (param1 == null || param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            SceneManager.changeScene(SceneType.COPY, 80509);
        }
    }
}
}
