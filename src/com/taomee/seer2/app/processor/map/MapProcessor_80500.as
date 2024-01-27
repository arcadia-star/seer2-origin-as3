package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.ShengJiaHuanTongAct;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_80500 extends MapProcessor {


    public function MapProcessor_80500(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        ShengJiaHuanTongAct.getInstance().setUp();
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            ModuleManager.showAppModule("ShengJiaHuanTongAlertPanel");
        }
    }

    override public function dispose():void {
        ShengJiaHuanTongAct.getInstance().dispose();
        super.dispose();
    }
}
}
