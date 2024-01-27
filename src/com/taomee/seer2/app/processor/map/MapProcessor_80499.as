package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ShengJiaLeiMingAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_80499 extends CopyMapProcessor {


    public function MapProcessor_80499(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ShengJiaLeiMingAct.getInstance().setUp();
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            ModuleManager.showAppModule("ShengJiaLeiMingAlertPanel");
        }
    }

    override public function dispose():void {
        ShengJiaLeiMingAct.getInstance().dispose();
        super.dispose();
    }
}
}
