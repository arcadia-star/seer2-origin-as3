package com.taomee.seer2.app.rightToolbar.toolbar {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbar;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class DreamLandToolBar extends RightToolbar {


    public function DreamLandToolBar() {
        super();
    }

    override protected function onClick(param1:MouseEvent):void {
        if (!QuestManager.isAccepted(10115) && !QuestManager.isComplete(10115)) {
            SceneManager.changeScene(SceneType.HOME, ActorManager.actorInfo.id);
        } else {
            ModuleManager.toggleModule(URLUtil.getAppModule("StonePanel"), "打开中...");
        }
    }
}
}
