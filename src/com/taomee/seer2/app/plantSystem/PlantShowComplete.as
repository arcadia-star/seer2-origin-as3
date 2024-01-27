package com.taomee.seer2.app.plantSystem {
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class PlantShowComplete {


    private var _idList:Vector.<uint>;

    private var _countList:Vector.<uint>;

    private var _completeList:Vector.<PlantCompleteItem>;

    private var _setTimeout:uint;

    private var _index:int;

    private var _mc:MovieClip;

    public function PlantShowComplete(param1:Vector.<uint>, param2:Vector.<uint>, param3:MovieClip) {
        super();
        this._mc = param3;
        this._idList = param1;
        this._countList = param2;
        this.init();
    }

    private function init():void {
        this._completeList = Vector.<PlantCompleteItem>([]);
        this._index = 0;
        this.playMove();
    }

    private function playMove():void {
        var plantComplete:PlantCompleteItem = null;
        if (this._index < this._idList.length) {
            plantComplete = new PlantCompleteItem(this._idList[this._index], this._countList[this._index]);
            plantComplete.scaleX = 0.7;
            plantComplete.scaleY = 0.7;
            plantComplete.x = this._mc.x + 10;
            plantComplete.y = this._mc.y - 20;
            LayerManager.topLayer.addChild(plantComplete);
            this._completeList.push(plantComplete);
            ++this._index;
            this._setTimeout = setTimeout(function ():void {
                playMove();
            }, 1500);
        }
    }

    public function dispose():void {
        var _loc1_:PlantCompleteItem = null;
        for each(_loc1_ in this._completeList) {
            _loc1_.dispose();
        }
        clearTimeout(this._setTimeout);
    }
}
}
