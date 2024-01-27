package com.taomee.seer2.app.processor.quest.handler.activity.quest30015 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.door.TrailDoor;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;

public class QuestMapHandler_30015_82 extends FortQuestMapHandler {


    public function QuestMapHandler_30015_82(param1:QuestProcessor) {
        npcId = 125;
        npcName = "试炼高手";
        door = new TrailDoor(new SimpleButton(), DoorType.Door_NORMAL);
        npcTalkId = "30015_0";
        _supportInstance = TrailDoorSupport.getInstance();
        battleScene = 400;
        questId = 30015;
        super(param1);
    }

    override protected function toStep1Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "哈哈，看你弱不经风的样子，绝不可能是俺的对手"]], ["继续挑战"], [door.requestEntry]);
    }

    override protected function toStep3Dia():void {
        NpcDialog.show(npcId, npcName, [[0, "额……刚才……刚才是俺故意让着你，再来！这次你若是赢了俺，俺就心服口服！"]], ["好吧！你还真是顽固！", "我累了改日再战"], [door.requestEntry]);
    }

    override protected function showNextQuestDia():void {
        NpcDialog.show(npcId, npcName, [[0, "我输得心服口服，不过你若是真正的勇士就去挑战要塞下一层吧那里有更强大的人等着你呢"]], ["现在就去挑战", "我要先休息一下"], [function ():void {
            SceneManager.changeScene(SceneType.LOBBY, 83);
        }]);
    }

    override protected function showAcceptDia():void {
        NpcDialog.show(npcId, npcName, [[0, "俺可是曾经反击萨伦帝国的先锋官，曾立下战功无数。"]], ["哦？真的吗？"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(npcTalkId), 3, [[1, 0]], function ():void {
                NpcDialog.show(npcId, npcName, [[0, "怎么样，小个子，是不是已经战栗的走不动了？哈哈哈。"]], ["看来你也不是很强大嘛"], [function ():void {
                    NpcDialog.show(npcId, npcName, [[0, "小个子，别小看我，我才不信你能通过试炼之门呢！你若想试试，我就在试炼之门最后一关等着你！"]], ["还真是罗嗦，开始吧！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                        QuestManager.accept(_quest.id);
                    }]);
                }]);
            });
        }]);
    }
}
}
