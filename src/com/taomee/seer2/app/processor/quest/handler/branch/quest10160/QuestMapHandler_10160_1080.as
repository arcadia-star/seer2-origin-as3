package com.taomee.seer2.app.processor.quest.handler.branch.quest10160 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class QuestMapHandler_10160_1080 extends QuestMapHandler {


    private var kelakeMb:Mobile;

    private var badiMb:Mobile;

    private var duoluoMb:Mobile;

    private var sMb:Mobile;

    public function QuestMapHandler_10160_1080(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        if (this.sMb) {
            this.sMb.removeOverHeadMark();
            this.sMb.removeEventListener(MouseEvent.CLICK, this.sDia);
        }
        if (this.kelakeMb) {
            this.kelakeMb.removeEventListener(MouseEvent.CLICK, this.showKelakeDia);
        }
        if (this.badiMb) {
            this.badiMb.removeEventListener(MouseEvent.CLICK, this.fightBadi);
            this.badiMb.removeOverHeadMark();
        }
        if (this.duoluoMb) {
            this.duoluoMb.removeEventListener(MouseEvent.CLICK, this.fightDuoluo);
            this.duoluoMb.removeOverHeadMark();
        }
        if (this.kelakeMb) {
            this.kelakeMb.removeOverHeadMark();
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            if (param1.stepId == 2) {
                this.initStep3();
            } else if (param1.stepId == 3) {
                FightManager.startFightWithWild(249);
            } else if (param1.stepId == 4) {
                FightManager.startFightWithWild(250);
            } else if (param1.stepId == 5) {
                SceneManager.changeScene(SceneType.LOBBY, 1071);
            }
        }
    }

    private function initStep3():void {
        this.badiMb.removeOverHeadMark();
        this.badiMb.addOverHeadMark(new AcceptableMark());
        this.badiMb.buttonMode = true;
        this.badiMb.addEventListener(MouseEvent.CLICK, this.fightBadi);
    }

    private function fightBadi(param1:MouseEvent):void {
        this.duoluoMb.removeOverHeadMark();
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        QuestManager.completeStep(questID, 3);
    }

    override public function processMapComplete():void {
        if (QuestManager.isStepComplete(10160, 1) && !QuestManager.isComplete(10160)) {
            this.createNpc();
        }
        if (isNeedCompleteStep(2)) {
            this.initStep2();
        }
        if (isNeedCompleteStep(3)) {
            this.initStep3();
        }
        if (isNeedCompleteStep(4)) {
            this.initStep4();
        }
        if (isNeedCompleteStep(5)) {
            this.initStep5();
        }
    }

    private function createNpc():void {
        this.kelakeMb = new Mobile();
        this.kelakeMb.resourceUrl = URLUtil.getNpcSwf(191);
        this.kelakeMb.x = 314;
        this.kelakeMb.y = 340;
        this.kelakeMb.height = 100;
        this.kelakeMb.buttonMode = true;
        this.kelakeMb.mouseChildren = false;
        MobileManager.addMobile(this.kelakeMb, MobileType.NPC);
        this.badiMb = new Mobile();
        this.badiMb.resourceUrl = URLUtil.getNpcSwf(10);
        this.badiMb.x = 480;
        this.badiMb.y = 420;
        this.badiMb.height = 100;
        this.badiMb.buttonMode = true;
        this.badiMb.mouseChildren = false;
        MobileManager.addMobile(this.badiMb, MobileType.NPC);
        this.duoluoMb = new Mobile();
        this.duoluoMb.resourceUrl = URLUtil.getNpcSwf(11);
        this.duoluoMb.x = 600;
        this.duoluoMb.y = 420;
        this.duoluoMb.height = 100;
        this.duoluoMb.buttonMode = true;
        this.duoluoMb.mouseChildren = false;
        MobileManager.addMobile(this.duoluoMb, MobileType.NPC);
    }

    private function initStep5():void {
        NpcDialog.show(11, "多罗", [[0, "战斗还没有结束…为了做你们的领袖…我将不惜一切代价！"]], ["痴人说梦！ "], [function ():void {
            NpcDialog.show(11, "多罗", [[0, "你们这群愚蠢而可怜的家伙…让你们活在世上还不如送你们下地狱…"]], ["接招吧！！ "], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_5"), function ():void {
                    sMb = new Mobile();
                    sMb.resourceUrl = URLUtil.getNpcSwf(192);
                    MobileManager.addMobile(sMb, MobileType.NPC);
                    sMb.x = 410;
                    sMb.y = 345;
                    sMb.height = 100;
                    sMb.addOverHeadMark(new AcceptableMark());
                    sMb.buttonMode = true;
                    sMb.mouseChildren = false;
                    sMb.addEventListener(MouseEvent.CLICK, sDia);
                });
            }]);
        }]);
    }

    private function sDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.sMb.removeOverHeadMark();
        NpcDialog.show(192, "新S", [[0, "你们刚才被莫利亚释放的欲望之魂控制了…所以才会自相残杀！"]], ["多亏了你及时赶到！S！ "], [function ():void {
            NpcDialog.show(192, "新S", [[0, "我在之前已经伪装小心探访这个诡异的回廊！这里能够让人们丧失心智，让欲望膨胀到失去意识。你们差点就要了同伴的性命！"]], ["S！想不到你如今你已经成了我们的伙伴了！ "], [function ():void {
                NpcDialog.show(192, "新S", [[0, "我要以一个全新的自我面对这个世界，我还将继续探寻下去，在你们危机时刻，我会帮助你们！这里不宜久留，你们出去吧！我也要走了！"]], ["好！再见S！ "], [function ():void {
                    NpcDialog.show(192, "新S", [[0, "我要以一个全新的自我面对这个世界，我还将继续探寻下去，在你们危机时刻，我会帮助你们！这里不宜久留，你们出去吧！我也要走了！"]], ["好！再见S！ "], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                        QuestManager.completeStep(questID, 5);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep4():void {
        this.duoluoMb.removeOverHeadMark();
        this.duoluoMb.addOverHeadMark(new AcceptableMark());
        this.duoluoMb.addEventListener(MouseEvent.CLICK, this.fightDuoluo);
    }

    private function fightDuoluo(param1:MouseEvent):void {
        this.duoluoMb.removeOverHeadMark();
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        QuestManager.completeStep(questID, 4);
    }

    private function initStep2():void {
        this.kelakeMb.removeOverHeadMark();
        this.kelakeMb.addOverHeadMark(new AcceptableMark());
        this.kelakeMb.addEventListener(MouseEvent.CLICK, this.showKelakeDia);
    }

    private function showKelakeDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.duoluoMb.removeOverHeadMark();
        NpcDialog.show(191, "克拉克的影子", [[0, "吼吼吼，你们终于到了，我知道你们最渴望的是什么……"]], ["你是克拉克教官？ "], [function ():void {
            NpcDialog.show(191, "克拉克的影子", [[0, "当然！我就是你们最尊敬的克拉克教官！"]], ["你怎么会在这里？ "], [function ():void {
                NpcDialog.show(191, "克拉克的影子", [[0, "无须多问，我给你们带来了最强大的力量，就当是送给你们的礼物了！吼吼吼！"]], ["感觉有点不对劲 "], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_3"), function ():void {
                        NpcDialog.show(191, "克拉克的影子", [[0, "吼吼吼吼！我已经把最强大的力量传送给了你们，现在你们变得一样强大了！"]], ["啊…怎么感觉不受自己控制了 "], [function ():void {
                            NpcDialog.show(191, "克拉克的影子", [[0, "别忙着感激我，我突然有一个疑问…你们当中谁才是真正有实力做队长的人选呢？吼吼…吼…"]], ["意识越来越模糊了...你说什么？ "], [function ():void {
                                NpcDialog.show(191, "克拉克的影子", [[0, "你会甘心做一个小小的队员，仍凭无能的队长的愚蠢的差遣么…明明你才是最厉害的那一个！去吧！赛尔们！去拼个你死我活吧……"]], ["意识快消失了...啊！ "], [function ():void {
                                    NpcDialog.show(191, "克拉克的影子", [[0, "你的手下们好像已经不安分了，是时候证明一下了！狠狠地给他们个教训吧！去拼个你死我活吧…去吧…赛尔…这里没人能够阻止你！去吧！"]], ["是的…我才是队长…我才是 "], [function ():void {
                                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10160_4"), function ():void {
                                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                                            QuestManager.completeStep(questID, 2);
                                        }, false, false, 1, false);
                                    }]);
                                }]);
                            }]);
                        }]);
                    }, false, false, 1, false);
                }]);
            }]);
        }]);
    }
}
}
