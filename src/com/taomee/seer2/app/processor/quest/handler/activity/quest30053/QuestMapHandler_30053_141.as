package com.taomee.seer2.app.processor.quest.handler.activity.quest30053 {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_30053_141 extends QuestMapHandler {


    public function QuestMapHandler_30053_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL, this.getServerData);
        }
    }

    private function getServerData(param1:ServerBuffer):void {
        var server:ServerBuffer = param1;
        var count:uint = uint(server.readDataAtPostion(0));
        count += 1;
        if (count < 5) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL, 0, count);
            ServerMessager.addMessage("您获得了一个战盔碎片");
        } else {
            if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_TABARD_MATERIAL, 0, 5);
                QuestManager.completeStep(_quest.id, 1);
            }
            AlertManager.showAlert("恭喜你拿回所有的战盔碎片", function ():void {
                StatisticsManager.newSendNovice("2014活动", "帝王战袍", "完成战盔制作");
                ModuleManager.showAppModule("MakeTabardPanel");
            });
        }
    }
}
}
