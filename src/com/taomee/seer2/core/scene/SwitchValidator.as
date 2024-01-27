package com.taomee.seer2.core.scene {
public class SwitchValidator {


    public function SwitchValidator() {
        super();
    }

    public static function validateRepeat(param1:SwitchData):Boolean {
        if (Boolean(SceneManager.active) && Boolean(SceneManager.active.mapModel)) {
            if (SceneManager.active.type == param1.sceneType && SceneManager.active.mapID == param1.mapId) {
                return false;
            }
        }
        return true;
    }

    public static function validateChangeable(param1:SwitchData):Boolean {
        if (SceneManager.active && SceneManager.active.mapModel && SceneManager.active.mapModel.checkable) {
            if (param1.sceneType != SceneType.ARENA) {
                return SceneManager.active.mapModel.mapProcessor.checkChangeable();
            }
        }
        return true;
    }
}
}
