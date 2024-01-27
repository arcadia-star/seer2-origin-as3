package com.taomee.seer2.app.pet {
import com.taomee.seer2.core.ui.UIManager;

public class StarSpawnedPet extends SpawnedPet {


    public function StarSpawnedPet(param1:int, param2:int, param3:int) {
        super(param1, param2, param3);
    }

    override protected function showLabel():void {
        setLabelStyle(13395456, 16777215);
        this.label = "Lv【★】" + " " + _petInfo.name;
    }

    override protected function addShadow():void {
        _shadow = UIManager.getMovieClip("UI_MiniBossShadow");
        addChild(_shadow);
    }
}
}
