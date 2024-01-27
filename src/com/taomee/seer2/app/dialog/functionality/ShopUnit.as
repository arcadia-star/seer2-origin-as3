package com.taomee.seer2.app.dialog.functionality {
import com.taomee.seer2.core.ui.UIManager;

public class ShopUnit extends ModuleUnit {


    public function ShopUnit() {
        super();
    }

    override protected function addIcon():void {
        _icon = UIManager.getSprite("UI_DialogShop");
        addChild(_icon);
    }
}
}
