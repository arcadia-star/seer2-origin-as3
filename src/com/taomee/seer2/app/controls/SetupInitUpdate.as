package com.taomee.seer2.app.controls {
import com.taomee.seer2.app.inventory.ItemManager;

public class SetupInitUpdate {


    public function SetupInitUpdate() {
        super();
    }

    public static function setup():void {
        ItemManager.requestItemList(function ():void {
        });
    }
}
}
