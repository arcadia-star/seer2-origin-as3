package com.taomee.seer2.app.processor.quest.handler.activity.quest30018 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.door.HeroDoor;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.hero.HeroDoorSupport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.FortQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;

public class QuestMapHandler_30018_85 extends FortQuestMapHandler {


    public function QuestMapHandler_30018_85(param1:QuestProcessor) {
        npcId = 135;
        npcName = "五番队长";
        door = new HeroDoor(new SimpleButton(), DoorType.Door_NORMAL);
        npcTalkId = "30018_0";
        _supportInstance = HeroDoorSupport.getInstance();
        battleScene = 416;
        questId = 30018;
        super(param1);
    }

    override protected function toStep1Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "你太弱了，还能继续吗！"]], ["再来！"], [door.requestEntry]);
    }

    override protected function showNextQuestDia():void {
        NpcDialog.show(npcId, npcName, [[0, "你果然是个强者，但是你若想成为一名强大的赛尔战士还需要去要塞B5那里，找4番队队长西贡，去挑战双子之门！"]], ["我一定会前去挑战的！", "还是不要去了"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 86);
        }]);
    }

    override protected function toStep3Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "再试一次，如果你没有倒下的话我就把我我就承认你的实力！"]], ["好！再来！ ", " 今天累了明再战"], [door.requestEntry]);
    }

    override protected function showAcceptDia():void {
        NpcDialog.show(npcId, npcName, [[0, "事情还要从那次大反击说起"]], ["怎么回事好像很严重的样子"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(npcTalkId), 3, [[1, 0]], function ():void {
                NpcDialog.show(npcId, npcName, [[0, "所以，在这里我要训练出最强的赛尔训练师，阿卡迪亚星就等着你们来保护了。把你的精灵背包装满，我们来进行最强度的训练吧！"]], ["来吧！ ", "我突然头好晕"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                    QuestManager.accept(_quest.id);
                }]);
            });
        }]);
    }
}
}
