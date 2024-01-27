package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.PreFishActivity;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.activity.cookingActivity.CookingActivity;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;

public class MapProcessor_125 extends TitleMapProcessor {


    private var _pot:MovieClip;

    private var _activity:PreFishActivity;

    private var _cookingActivity:CookingActivity;

    public function MapProcessor_125(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._activity = new PreFishActivity();
        this._activity.init(_map);
        this._cookingActivity = new CookingActivity(_map);
        super.init();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnitClick);
    }

    private function onUnitClick(param1:DialogPanelEvent):void {
        if (param1.content.params == "FoodAct") {
            SceneManager.changeScene(SceneType.LOBBY, 1421);
        }
    }

    override public function dispose():void {
        TooltipManager.remove(this._pot);
        this._activity.dispose();
        if (this._cookingActivity) {
            this._cookingActivity.dispose();
        }
        this._cookingActivity = null;
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnitClick);
        super.dispose();
    }
}
}
