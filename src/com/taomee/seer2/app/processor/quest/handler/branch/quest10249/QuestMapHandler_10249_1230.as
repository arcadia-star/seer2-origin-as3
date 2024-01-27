package com.taomee.seer2.app.processor.quest.handler.branch.quest10249 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_10249_1230 extends QuestMapHandler {


    private var _npc106:Mobile;

    private var _mark:AcceptableMark;

    public function QuestMapHandler_10249_1230(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(10249, 1) && QuestManager.isStepComplete(10249, 2) == false) {
            this.createNpc106();
        }
    }

    private function createNpc106():void {
        this._npc106 = new Mobile();
        this._npc106.setPostion(new Point(529, 365));
        this._npc106.label = "斯坦因博士";
        this._npc106.resourceUrl = URLUtil.getNpcSwf(106);
        this._npc106.buttonMode = true;
        this._mark = new AcceptableMark();
        this._npc106.addChild(this._mark);
        this._mark.y = -100;
        MobileManager.addMobile(this._npc106, MobileType.NPC);
        this._npc106.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(106, "斯坦因博士", [[0, "你看着好眼熟，我们是不是在哪见过？哦！我想起来了。  "]], [" 果然是斯坦因博士！我真是聪明！"], [function ():void {
            NpcDialog.show(400, "赛尔", [[0, "巴金斯日志提示我们有蚀魂兽的信息，博士你有什么情报吗？ "]], ["博士总有第一手消息。"], [function ():void {
                NpcDialog.show(106, "斯坦因博士", [[0, "没错，最近的确有一些迹象指引我来到这里。  "]], ["快告诉我吧！"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("ShiHunFirst_0"), function ():void {
                        NpcDialog.show(106, "斯坦因博士", [[0, "这迹象应该和虫群氏族的灵兽——蚀魂兽有着联系。  "]], ["蚀魂兽已经消失了很多年，为什么现在又出现了？"], [function ():void {
                            NpcDialog.show(106, "斯坦因博士", [[0, "我已经一把年纪了，雷达上的目标跑的太快，只有年轻人才能追的上它们。具体情况等你们去调查一下才能知道！快去快回！  "]], ["那好吧，我这就去！"], [function ():void {
                                if (_mark != null) {
                                    DisplayObjectUtil.removeFromParent(_mark);
                                }
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                QuestManager.completeStep(10249, 2);
                            }]);
                        }]);
                    });
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 10249) {
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
            ModuleManager.showAppModule("BagginsLogPanel", {"idx": 2});
            MonsterManager.showAllMonster();
        }
    }
}
}
