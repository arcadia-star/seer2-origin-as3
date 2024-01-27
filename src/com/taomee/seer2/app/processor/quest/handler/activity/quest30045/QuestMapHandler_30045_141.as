package com.taomee.seer2.app.processor.quest.handler.activity.quest30045 {
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
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_30045_141 extends QuestMapHandler {


    public function QuestMapHandler_30045_141(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL, this.getServerData);
        }
    }

    private function getServerData(param1:ServerBuffer):void {
        var server:ServerBuffer = param1;
        var count:uint = uint(server.readDataAtPostion(0));
        count += 1;
        if (count < 5) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL, 0, count);
            ServerMessager.addMessage("您获得了一张针织毛纺");
        } else {
            if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.MAKE_SUIT_MATERIAL, 0, 5);
                QuestManager.completeStep(_quest.id, 1);
            }
            AlertManager.showAlert("恭喜你搜集齐所有的针织毛纺", function ():void {
                ModuleManager.toggleModule(URLUtil.getAppModule("MakeBattleSuitPanel"), "");
            });
        }
    }
}
}
