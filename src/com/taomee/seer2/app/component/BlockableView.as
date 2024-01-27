package com.taomee.seer2.app.component {
import com.taomee.seer2.app.utils.BlockHelper;

import flash.display.Sprite;

public class BlockableView extends Sprite {


    private var _blockHelper:BlockHelper;

    public function BlockableView() {
        super();
        this._blockHelper = new BlockHelper(this.show, this.hide);
    }

    public function update(param1:*):void {
    }

    public function dispose():void {
        this._blockHelper.dispose();
    }

    public function set isShow(param1:Boolean):void {
        this._blockHelper.isEnable = param1;
    }

    public function set isBlock(param1:Boolean):void {
        this._blockHelper.isBlock = param1;
    }

    public function show():void {
    }

    public function hide():void {
    }
}
}
