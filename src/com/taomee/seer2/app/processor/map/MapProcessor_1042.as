package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.map.diceThing.DiceMapMeeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class MapProcessor_1042 extends MapProcessor {


    private var telpoint0:MovieClip;

    private var helpBtn:SimpleButton;

    public function MapProcessor_1042(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        DiceMapMeeManager.getInstance().setup();
        this.telpoint0 = _map.content["telpoint0"];
        this.helpBtn = _map.content["helpBtn"];
        this.telpoint0.addEventListener(MouseEvent.CLICK, this.to70);
        this.helpBtn.addEventListener(MouseEvent.CLICK, this.openHelp);
        this.telpoint0.buttonMode = true;
        TooltipManager.addCommonTip(this.telpoint0, "传送室");
    }

    private function openHelp(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("DiceStarMeeHelpPanel"));
    }

    private function to70(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function dispose():void {
        super.dispose();
        this.telpoint0.removeEventListener(MouseEvent.CLICK, this.to70);
        this.helpBtn.removeEventListener(MouseEvent.CLICK, this.openHelp);
        TooltipManager.remove(this.telpoint0);
    }
}
}
