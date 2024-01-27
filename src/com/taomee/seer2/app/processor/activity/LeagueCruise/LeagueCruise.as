package com.taomee.seer2.app.processor.activity.LeagueCruise {
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class LeagueCruise {


    private var _mapModel:MapModel;

    private var _leagueMC:MovieClip;

    private var _leagueFlyMc:MovieClip;

    private const DAY_LIST:Array = [5178];

    private const SWAP_ID:int = 4164;

    public function LeagueCruise(param1:MapModel) {
        super();
        this._mapModel = param1;
        this._leagueMC = this._mapModel.content["leagueMc"];
        this._leagueMC.buttonMode = this._leagueMC.mouseEnabled = this._leagueMC.mouseChildren = true;
        this._leagueMC.addEventListener(MouseEvent.CLICK, this.onGoLeagueCruise);
    }

    public function onGoLeagueCruise(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
        ModuleManager.showAppModule("KingCarZhangPanel");
    }

    public function dispose():void {
        if (this._leagueMC.hasEventListener(MouseEvent.CLICK)) {
            this._leagueMC.removeEventListener(MouseEvent.CLICK, this.onGoLeagueCruise);
        }
    }
}
}
