package com.taomee.seer2.app.processor.quest.handler.activity.quest30026 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_30026_510 extends QuestMapHandler {


    public function QuestMapHandler_30026_510(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                ServerBufferManager.getServerBuffer(ServerBufferType.OPEN_SCROOL, this.onQuest);
            }
        }
    }

    private function onQuest(param1:ServerBuffer):void {
        var server:ServerBuffer = param1;
        var count:uint = uint(server.readDataAtPostion(0));
        count++;
        if (count < 5) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL, 0, count);
            ServerMessager.addMessage("获得1个刷子");
        } else {
            if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.OPEN_SCROOL, 0, 10);
                QuestManager.completeStep(_quest.id, 1);
            }
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "5把刷子已经抢回来咯！现在返回传送室吧！"]], ["返回传送室！"], [function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 70);
            }]);
        }
    }

    override public function processMapDispose():void {
    }
}
}
