package com.taomee.seer2.app.processor.quest.handler.activity.quest30016 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.door.WarriorDoor;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.warrior.WarriorDoorSuport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.activity.quest30015.FortQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;

public class QuestMapHandler_30016_83 extends FortQuestMapHandler {


    public function QuestMapHandler_30016_83(param1:QuestProcessor) {
        npcId = 126;
        npcName = "勇士之王";
        door = new WarriorDoor(new SimpleButton(), DoorType.Door_NORMAL);
        npcTalkId = "30016_0";
        _supportInstance = WarriorDoorSuport.getInstance();
        battleScene = 404;
        questId = 30016;
        super(param1);
    }

    override protected function toStep1Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "哈哈！我赢了！我才是强者中的强者！"]], ["这次侥幸，再来！"], [door.requestEntry]);
    }

    override protected function showNextQuestDia():void {
        NpcDialog.show(npcId, npcName, [[0, "看来你还是有一些本事的，不过我敢说你绝对赢不了强大的6番队长，那里有更新的打法。"]], ["那我倒要去看看！", "这么厉害还是不要去了"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 84);
        }]);
    }

    override protected function toStep3Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "这不可能……刚才一定是你侥幸，再来，这次如果输了我就把我的全部家当送给你！"]], ["好呀！让你心服口服", "好累啊，改日再战吧"], [door.requestEntry]);
    }

    override protected function showAcceptDia():void {
        NpcDialog.show(npcId, npcName, [[0, "我曾经以为拥有一只强大的精灵就足够了，直到有一天我去挑战6番队长"]], ["好像是发生了什么事……"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(npcTalkId), 3, [[1, 0]], function ():void {
                NpcDialog.show(npcId, npcName, [[0, "所以我从那以后专门练习三精灵的车轮战，怎么样，小家伙，你来的正好，要不要比试比试？不过你要先打败之前的守护者才能见到我。"]], ["好呀！我可是强者中的强者 ", "(⊙o⊙)…我还有别的事"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                    QuestManager.accept(_quest.id);
                }]);
            });
        }]);
    }
}
}
