package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.core.ui.UIManager;

public class FishBookUnit extends ModuleUnit {


    public function FishBookUnit() {
        super();
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogReward");
        addChild(_icon);
    }
}
}
