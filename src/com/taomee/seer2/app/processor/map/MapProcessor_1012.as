package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.controls.MinorToolBar;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.controls.ToolBar;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_1012 extends DreamMapProcessor {


    public function MapProcessor_1012(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        PetAvatarPanel.show();
    }

    override public function dispose():void {
        super.dispose();
        PetAvatarPanel.hide();
        ToolBar.hide();
        MinorToolBar.hide();
    }
}
}
