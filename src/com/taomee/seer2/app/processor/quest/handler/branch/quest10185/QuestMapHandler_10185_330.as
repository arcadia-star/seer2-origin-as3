package com.taomee.seer2.app.processor.quest.handler.branch.quest10185 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestMapHandler_10185_330 extends QuestMapHandler {


    private var monkeyMobile:Mobile;

    private var monkeyID:uint = 577;

    private var mark:AcceptableMark;

    private var seerId:int;

    public function QuestMapHandler_10185_330(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this.monkeyMobile) {
            this.monkeyMobile.removeEventListener(MouseEvent.CLICK, this.clickMonkey);
        }
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isStepComplete(2) && !QuestManager.isComplete(10185)) {
            if (ActorManager.actorInfo.sex == 1) {
                this.seerId = 501;
            } else {
                this.seerId = 502;
            }
            this.createMonkey();
        }
    }

    private function createMonkey():void {
        this.monkeyMobile = new Mobile();
        this.monkeyMobile.resourceUrl = URLUtil.getNpcSwf(this.monkeyID);
        this.monkeyMobile.x = 400;
        this.monkeyMobile.y = 360;
        this.monkeyMobile.height = 100;
        this.monkeyMobile.mouseChildren = false;
        this.monkeyMobile.buttonMode = true;
        this.mark = new AcceptableMark();
        this.monkeyMobile.addOverHeadMark(this.mark);
        MobileManager.addMobile(this.monkeyMobile, MobileType.NPC);
        this.monkeyMobile.addEventListener(MouseEvent.CLICK, this.clickMonkey);
    }

    private function clickMonkey(param1:MouseEvent):void {
        if (isNeedCompleteStep(4)) {
            this.toStep4();
        } else if (isNeedCompleteStep(3)) {
            this.toStep3();
        } else if (isNeedCompleteStep(5)) {
            this.toStep5();
        }
    }

    private function toStep3():void {
        NpcDialog.show(this.monkeyID, "火爆猴", [[2, "哦不！为什么你干的所有事情都惹我生气！！ "]], ["我又怎么了，是你自己要跟着我的！"], [function ():void {
            NpcDialog.show(seerId, "小赛尔", [[0, "干嘛？这里不会又有什么你不开心的回忆吧？"]], ["那是我的家……"], [function ():void {
                NpcDialog.show(monkeyID, "火爆猴", [[3, "我太生气了！！我必须要告诉你我的事情！"]], ["请讲"], [function ():void {
                    MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10185_0"), 4, [[1, 0]], function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
                        QuestManager.completeStep(questID, 3);
                    });
                }]);
            }]);
        }]);
    }

    private function toStep4():void {
        NpcDialog.show(this.monkeyID, "火爆猴", [[4, "所以我早就忘记什么叫开心了！没什么好开心的！"]], ["!!!!"], [function ():void {
            NpcDialog.show(seerId, "小赛尔", [[2, "你是说你爸揍你，你就得了愤怒的病了？"]], ["你不信你自己试试看啊?"], [function ():void {
                ModuleManager.addEventListener("HitMonkeyPanel", ModuleEvent.DISPOSE, closePanel);
                ModuleManager.toggleModule(URLUtil.getAppModule("HitMonkeyPanel"));
            }]);
        }]);
    }

    private function closePanel(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("HitMonkeyPanel", ModuleEvent.DISPOSE, this.closePanel);
        if (isNeedCompleteStep(5)) {
            this.toStep5();
        }
    }

    private function toStep5():void {
        NpcDialog.show(this.monkeyID, "火爆猴", [[2, "见识到我爸的“厉害”了吧？！哼！"]], ["原来如此啊。那你爸爸去哪里了呢？"], [function ():void {
            NpcDialog.show(monkeyID, "火爆猴", [[3, "有一次喝酒喝多了，再也没醒过来！死了！死，你懂吗？！"]], ["吃不消啊，这脾气，这个小猴子是孤儿啊，我必须要帮帮它"], [function ():void {
                NpcDialog.show(seerId, "小赛尔", [[0, "愤怒的小猴，嘿嘿，你做我的精灵吧！我会治好你愤怒的毛病！相信我！"]], ["做你的精灵？"], [function ():void {
                    NpcDialog.show(monkeyID, "火爆猴", [[3, "跟着你，你保证饿不着肚子吗？你保证我可以不那么凶吗？你保证不会抛弃我吗？你能吗？！！"]], ["我能！"], [function ():void {
                        NpcDialog.show(seerId, "小赛尔", [[4, "我保证！你一定会成为一个开朗的好猴子的！"]], ["快带我走！快点啊！！"], [function ():void {
                            NpcDialog.show(seerId, "小赛尔", [[4, "那我以后就叫你火爆猴吧！"]], ["走！带你去精灵集训营！"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                QuestManager.completeStep(questID, 5);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10185) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            MobileManager.removeMobile(this.monkeyMobile, MobileType.NPC);
            this.monkeyMobile.removeEventListener(MouseEvent.CLICK, this.clickMonkey);
            ModuleManager.toggleModule(URLUtil.getAppModule("MonkeyTrainPanel"));
        }
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == questID && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
            this.toStep4();
        }
    }
}
}
