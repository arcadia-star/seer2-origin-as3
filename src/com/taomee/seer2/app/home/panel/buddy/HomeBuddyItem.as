package com.taomee.seer2.app.home.panel.buddy {
import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;

public class HomeBuddyItem extends Sprite {


    private var _fullItem:HomeBuddyFullItem;

    private var _emptyItem:HomeBuddyEmptyItem;

    private var _dataUnit:HomeBuddyDataUnit;

    public function HomeBuddyItem(param1:uint = 3) {
        super();
        this._fullItem = new HomeBuddyFullItem(param1);
        this._emptyItem = new HomeBuddyEmptyItem(param1);
    }

    public function setData(param1:HomeBuddyDataUnit):void {
        DisplayObjectUtil.removeAllChildren(this);
        this._dataUnit = param1;
        switch (param1.status) {
            case HomeBuddyDataUnit.EMPEY:
                this.showEmpty();
                break;
            case HomeBuddyDataUnit.BUSY:
                this.showBusy();
                this.setFullItemSelect();
                break;
            case HomeBuddyDataUnit.READY:
                this.showReady();
                this.setFullItemSelect();
        }
        this._fullItem.setLevel();
    }

    private function setFullItemSelect():void {
        if (this._dataUnit.id == SceneManager.active.mapID) {
            this._fullItem.select = true;
        } else {
            this._fullItem.select = false;
        }
    }

    private function showEmpty():void {
        addChild(this._emptyItem);
    }

    private function showBusy():void {
        addChild(this._fullItem);
    }

    private function showReady():void {
        addChild(this._fullItem);
        this._fullItem.setData(this._dataUnit);
    }

    public function dispose():void {
        this._fullItem.dispose();
        this._emptyItem.dispose();
    }
}
}
