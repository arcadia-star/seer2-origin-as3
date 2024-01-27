package com.taomee.seer2.app.processor.quest.handler.main.quest78 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_78_80334 extends QuestMapHandler {

    private static var fightNums:int = 0;


    private var fightFirstID:Array;

    private var _npc:Mobile;

    public function QuestMapHandler_78_80334(param1:QuestProcessor) {
        this.fightFirstID = [1320];
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            this.createNpc();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(650, 300));
            this._npc.resourceUrl = URLUtil.getNpcSwf(757);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -80;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep1);
        }
    }

    private function initStep1(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(11, "里格", [[0, "这里应该安全了，让我把前因后果告诉你们吧。"]], [" 好"], [function ():void {
            NpcDialog.show(11, "里格", [[0, "我们都是超能氏族的族人，而我们拥有的超能力，则是源自氏族中那颗巨大的能量水晶。相传，那是五千年前两位精灵王大战后留下的。"]], [" ！"], [function ():void {
                MovieClipUtil.playHahaTalk(URLUtil.getQuestAnimation("4/quest4Animation1"), 2, [770, 475], function ():void {
                    NpcDialog.show(757, "里格", [[2, "能量水晶的结构遭到破坏，因此，它的力量也一天天地衰弱下去。"]], [" 那该怎么办？我们可以帮上什么忙吗？"], [function ():void {
                        NpcDialog.show(757, "里格", [[0, "在萨伦切割水晶的过程中，一些能量碎片从上面脱落下来，现在我们首先要做的，就是收集这些能量碎片。只有收集到足够碎片，用碎片弥补水晶的缺口，让它恢复成一个整体，才能避免它的继续衰弱。"]], ["..."], [function ():void {
                            NpcDialog.show(757, "里格", [[0, "原本，我们正在寻找能量碎片，也已经收集到了一部分。但现在却遭到了萨伦亲信的追踪，不得已东躲西藏，无法收集到其他的碎片。小赛尔，我们需要你的帮助。"]], ["  好的，我愿意！"], [function ():void {
                                NpcDialog.show(10, "巴蒂", [[0, "萨伦帝国做了这么多坏事，现在居然还掠夺超能氏族宝贵的能量，太可恶了！我们愿意帮你们去寻找碎片！"]], [" 对！请您告诉我们该如何寻找碎片"], [function ():void {
                                    NpcDialog.show(757, "里格", [[0, "据我们的调查，能量碎片极有可能存在于广场和军工厂中，但是这两个地方都有萨伦士兵看守。小赛尔，我必须先考察一下你们的实力，以确保你们不会在可能发生的对抗中受到损伤。"]], [" 好的"], [function ():void {
                                        initContinue();
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                });
            }]);
        }]);
    }

    private function initContinue():void {
        NpcDialog.show(757, "里格", [[0, "这是我的精灵XXX（名字待定），（一句对精灵的描述，等wayne童鞋设定）准备好之后，你们可以与它进行对战。"]], ["准备好了", "还没有"], [function ():void {
            initStep3();
        }, null]);
    }

    private function initStep3():void {
        FightManager.startFightWithWild(this.fightFirstID[0]);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
    }

    private function onSwitchComplete(param1:SceneEvent):void {
        var result:uint = 0;
        var e:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this.fightFirstID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                result = FightManager.fightWinnerSide;
                if (result == FightSide.RIGHT) {
                    NpcDialog.show(757, "里格", [[0, "小赛尔，你们的实力还不够啊，这样前往寻找碎片恐怕会有危险！还是再提升一下实力吧。"]], ["我会继续努力的！"], [function ():void {
                        createNpc1();
                    }]);
                } else if (result == FightSide.LEFT) {
                    NpcDialog.show(757, "里格", [[1, "小赛尔，你们的实力真是出乎我的意料！既然如此，寻找能量碎片的事就拜托你们了。我期待你们的好消息！"]], ["好，我们一定不负所托！"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("77_2"), function ():void {
                            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                            QuestManager.completeStep(questID, 2);
                        });
                    }]);
                }
            }
        }
    }

    private function createNpc1():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.setPostion(new Point(650, 300));
            this._npc.resourceUrl = URLUtil.getNpcSwf(757);
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            _loc1_ = new InProgressMark();
            this._npc.addChild(_loc1_);
            _loc1_.y = -80;
            this._npc.addEventListener(MouseEvent.CLICK, this.initContinue);
        }
    }

    override public function processMapDispose():void {
        this._npc.removeEventListener(MouseEvent.CLICK, this.initContinue);
        this._npc.removeEventListener(MouseEvent.CLICK, this.initStep1);
        MobileManager.removeMobile(this._npc, MobileType.NPC);
        this._npc = null;
        super.processMapDispose();
    }
}
}
