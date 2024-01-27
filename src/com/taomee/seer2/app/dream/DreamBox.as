package com.taomee.seer2.app.dream {
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class DreamBox {


    private var _boxIndex:int;

    private var _boxMC:Sprite;

    public function DreamBox(param1:int) {
        super();
        this._boxIndex = param1;
        this._boxMC = this._boxIndex == 0 ? UIManager.getSprite("dreamBoxMC0") : UIManager.getSprite("dreamBoxMC1");
        SceneManager.active.mapModel.front.addChild(this._boxMC);
        this._boxMC.x = 500;
        this._boxMC.y = 300;
        this._boxMC.buttonMode = true;
        this._boxMC.addEventListener(MouseEvent.CLICK, this.onBox);
    }

    private function onBox(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var swapId:uint = this._boxIndex == 0 ? 3867 : 3868;
        SwapManager.swapItem(swapId, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            DisplayUtil.removeForParent(_boxMC);
        });
    }
}
}
