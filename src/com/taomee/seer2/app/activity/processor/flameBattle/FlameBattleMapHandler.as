package com.taomee.seer2.app.activity.processor.flameBattle {
import com.taomee.seer2.app.activity.ActivityManager;
import com.taomee.seer2.app.activity.processor.ActivityMapHandler;
import com.taomee.seer2.app.activity.processor.ActivityProcessor;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class FlameBattleMapHandler extends ActivityMapHandler {

    protected static const ACTIVITY_MONSTER_NUM:uint = 3;

    protected static var troop:int = 0;

    protected static var blueFraction:uint = 0;

    protected static var redFraction:uint = 0;


    public function FlameBattleMapHandler(param1:ActivityProcessor) {
        super(param1);
    }

    override protected function getLeavAnimationPath():String {
        if (blueFraction > redFraction) {
            return _activityProcessor.getActivityID() + "/2";
        }
        return _activityProcessor.getActivityID() + "/3";
    }

    override protected function processActivityEnd():void {
        this.showLeavingDialog();
    }

    private function showLeavingDialog():void {
        var _loc1_:XML = null;
        if (blueFraction > redFraction) {
            _loc1_ = new XML("<dialog npcId=\"31\" npcName=\"巴拉卡\" transport=\"300,400\">" + "<branch id=\"default\">" + "<node emotion=\"2\"><![CDATA[你得勇敢为我们照亮了前进的道路，我尊重你这样的英雄！]]></node>" + "<reply action=\"close\" ><![CDATA[点击关闭]]></reply>" + "</branch>" + "</dialog>");
        } else {
            _loc1_ = new XML("<dialog npcId=\"32\" npcName=\"洛克\" transport=\"300,400\">" + "<branch id=\"default\">" + "<node emotion=\"4\"><![CDATA[只要跟着我混，保管你吃香的喝辣的！下次还要来帮我哦！]]></node>" + "<reply action=\"close\" ><![CDATA[点击关闭]]></reply>" + "</branch>" + "</dialog>");
        }
        var _loc2_:DialogDefinition = new DialogDefinition(_loc1_);
        DialogPanel.addCloseEventListener(this.onLeavingDialogClosed);
        DialogPanel.showForCommon(_loc2_);
    }

    private function onLeavingDialogClosed(param1:DialogCloseEvent):void {
        DialogPanel.removeCloseEventListener(this.onLeavingDialogClosed);
        ActivityManager.removeActivityProcessor(_activityProcessor.getActivityID());
        SceneManager.changeScene(SceneType.LOBBY, 261, 470, 390);
    }
}
}
