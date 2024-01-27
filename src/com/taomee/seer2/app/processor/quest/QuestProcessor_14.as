package com.taomee.seer2.app.processor.quest {
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.Quest;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestProcessor_14 extends QuestProcessor {


    private const mapArr:Array = [320, 330, 340, 370, 3700, 380];

    private var _mc:MovieClip;

    private var _mapID:uint;

    private var _close:SimpleButton;

    public function QuestProcessor_14(param1:Quest) {
        _isLoadResLib = true;
        super(param1);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
    }

    private function onMapComplete(param1:SceneEvent):void {
        if (QuestManager.isStepComplete(14, 3) && QuestManager.isStepComplete(14, 4) == false) {
            this._mapID = SceneManager.active.mapModel.id;
            if (SceneManager.active.mapModel.id == 3700) {
                this._mapID = 370;
            }
            if (this.mapArr.indexOf(this._mapID) != -1) {
                this.showPanel();
            }
        }
    }

    private function showPanel():void {
        if (resLib == null) {
            return;
        }
        if (this._mc == null) {
            this._mc = resLib.getMovieClip("mc_1");
        }
        this._close = this._mc["closeBtn"];
        this._close.addEventListener(MouseEvent.CLICK, this.onCloseClick);
        this._mc["map" + this._mapID].gotoAndStop(2);
        this._mc.x = LayerManager.root.width / 2 - this._mc.width / 2;
        this._mc.y = LayerManager.root.height / 2 - this._mc.height / 2;
        LayerManager.mapLayer.addChild(this._mc);
    }

    private function onCloseClick(param1:MouseEvent):void {
        this._close.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
        LayerManager.mapLayer.removeChild(this._mc);
        this._close = null;
    }

    override public function dispose():void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapComplete);
        if (this._close) {
            this._close.removeEventListener(MouseEvent.CLICK, this.onCloseClick);
            this._close = null;
        }
        DisplayUtil.removeForParent(this._mc);
        super.dispose();
    }
}
}
