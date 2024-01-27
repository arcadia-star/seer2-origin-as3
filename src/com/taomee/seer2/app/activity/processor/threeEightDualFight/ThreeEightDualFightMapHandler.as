package com.taomee.seer2.app.activity.processor.threeEightDualFight {
import com.taomee.seer2.app.activity.ActivityManager;
import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
import com.taomee.seer2.app.activity.processor.ActivityProcessor;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class ThreeEightDualFightMapHandler extends ActivityMapHandler {


    public function ThreeEightDualFightMapHandler(param1:ActivityProcessor) {
        super(param1);
    }

    override protected function doLeavMap():void {
        this.showLeavingDialog();
    }

    override protected function processActivityEnd():void {
        this.showLeavingDialog();
    }

    private function showLeavingDialog():void {
        ServerMessager.addMessage("活动现场已经关闭，请于<font color=\'#ffcc00\'> 周六、周日15点-16点 </font>再来参加!");
        ActivityManager.removeActivityProcessor(_activityProcessor.getActivityID());
        if (Boolean(SceneManager.active) && SceneManager.active.mapID != 310) {
            SceneManager.changeScene(SceneType.LOBBY, 310);
        }
    }
}
}
