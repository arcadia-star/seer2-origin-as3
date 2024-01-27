package com.taomee.seer2.app.home {
import com.taomee.seer2.app.home.garbage.HomeGarbageSceneHandler;
import com.taomee.seer2.app.home.training.TrainingPetSceneHandler;
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.SceneHandlerGateWay;

public class HomeSceneHandlerGateWay extends SceneHandlerGateWay {


    public function HomeSceneHandlerGateWay(param1:BaseScene) {
        super(param1);
    }

    override protected function initSceneHandler():void {
        super.initSceneHandler();
        addSceneHandler(new TrainingPetSceneHandler());
        addSceneHandler(new HomeGarbageSceneHandler());
        PetExperenceHelper.startListen();
    }
}
}
