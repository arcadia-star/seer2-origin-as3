package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_310 extends TitleMapProcessor {


    private var _pig:MovieClip;

    private var _light1:MovieClip;

    public function MapProcessor_310(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initPig();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_155);
    }

    private function initPig():void {
        this._light1 = _map.content["light1"];
        this._light1.gotoAndStop(1);
        this._light1.addEventListener(MouseEvent.CLICK, this.onLight1Click);
        this._pig = _map.content["pig"];
        this._pig.gotoAndStop(1);
    }

    private function onLight1Click(param1:MouseEvent):void {
        this._light1.removeEventListener(MouseEvent.CLICK, this.onLight1Click);
        if (SwapManager.isSwapNumberMax(84)) {
            SwapManager.entrySwap(84);
        }
        this._pig.play();
    }

    override public function dispose():void {
        this._light1.removeEventListener(MouseEvent.CLICK, this.onLight1Click);
        this._pig = null;
        this._light1 = null;
        super.dispose();
    }
}
}
