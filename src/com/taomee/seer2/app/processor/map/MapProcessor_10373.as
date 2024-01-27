package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.map.diceThing.DiceMapSanjiManager;
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

public class MapProcessor_10373 extends MapProcessor {

    private static var _preScene:int = -1;


    private var telpoint0:MovieClip;

    private var helpBtn:SimpleButton;

    public function MapProcessor_10373(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        if (SceneManager.prevSceneType == SceneType.LOBBY) {
            _preScene = SceneManager.prevMapID;
        }
        this.telpoint0 = _map.content["telpoint0"];
        this.helpBtn = _map.content["helpBtn"];
        this.telpoint0.addEventListener(MouseEvent.CLICK, this.to70);
        this.helpBtn.addEventListener(MouseEvent.CLICK, this.openHelp);
        this.telpoint0.buttonMode = true;
        if (_preScene == -1) {
            TooltipManager.addCommonTip(this.telpoint0, "传送室");
        } else {
            TooltipManager.addCommonTip(this.telpoint0, "返回");
        }
        DiceMapSanjiManager.getInstance().setup();
    }

    private function openHelp(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("SanjiHelpPanel"));
    }

    private function to70(param1:MouseEvent):void {
        if (_preScene == -1) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        } else {
            SceneManager.changeScene(SceneType.LOBBY, _preScene);
        }
    }

    override public function dispose():void {
        super.dispose();
        this.telpoint0.removeEventListener(MouseEvent.CLICK, this.to70);
        this.helpBtn.removeEventListener(MouseEvent.CLICK, this.openHelp);
        TooltipManager.remove(this.telpoint0);
    }
}
}
