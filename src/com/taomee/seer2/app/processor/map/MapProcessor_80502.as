package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ShengJiaDiLeiAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_80502 extends MapProcessor {


    public function MapProcessor_80502(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ShengJiaDiLeiAct.getInstance().setUp();
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            ModuleManager.showAppModule("ShengJiaDiLeiAlertPanel");
        }
    }

    override public function dispose():void {
        ShengJiaDiLeiAct.getInstance().dispose();
        super.dispose();
    }
}
}
