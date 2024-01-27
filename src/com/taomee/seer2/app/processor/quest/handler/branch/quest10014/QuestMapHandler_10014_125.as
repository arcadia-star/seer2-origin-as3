package com.taomee.seer2.app.processor.quest.handler.branch.quest10014 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10014_125 extends QuestMapHandler {


    public function QuestMapHandler_10014_125(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (_quest.status == QuestStatus.ACCEPTABLE) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
        } else {
            this.processSteps();
        }
    }

    private function onQuestAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onQuestAccept);
            this.processSteps();
        }
    }

    private function processSteps():void {
        if (_quest.isStepCompletable(1)) {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10014_0"), 3, [[1, 0]], function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "每天晚上18:00出现？偷吃同样几个料理？这可是重要线索！你之前是怎么埋伏它的呢？"]], ["剧情回顾"], [function ():void {
                    MovieClipUtil.getSwfContent(URLUtil.getQuestFullScreenAnimation("10014_0"), function (param1:MovieClip):void {
                        var mc:MovieClip = param1;
                        LayerManager.topLayer.addChild(mc);
                        hideForQuest();
                        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                            showForQuest();
                            DisplayObjectUtil.removeFromParent(mc);
                            NpcDialog.show(314, "舒尔", [[0, "我发现，好像只要在锅子里放入它喜欢吃的料理，那家伙就会出现！！！每吃饱一次它的移动速度就会变慢！！这些食材给你做料理用！"]], [" 好！我知道啦！今晚18:00见"], [function ():void {
                                QuestManager.completeStep(_quest.id, 1);
                            }]);
                        }, true);
                    }, "加载任务资源");
                }]);
            });
        }
    }

    private function hideForQuest():void {
        ActorManager.getActor().hide();
        MobileManager.getMobile(314, MobileType.NPC).visible = false;
    }

    private function showForQuest():void {
        ActorManager.getActor().show();
        MobileManager.getMobile(314, MobileType.NPC).visible = true;
    }

    override public function processMapDispose():void {
        this.showForQuest();
        super.processMapDispose();
    }
}
}
