package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_240 extends TitleMapProcessor {


    private var _stone:MovieClip;

    public function MapProcessor_240(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        var _loc1_:Mobile = null;
        this.initStone();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_167);
        if (QuestManager.isStepComplete(30051, 3)) {
            _loc1_ = MobileManager.getMobile(626, MobileType.NPC);
            if (_loc1_) {
                MobileManager.removeMobile(_loc1_, MobileType.NPC);
            }
        }
    }

    private function initStone():void {
        this._stone = _map.content["stone"];
        this._stone.gotoAndStop(1);
        initInteractor(this._stone);
        this._stone.addEventListener(MouseEvent.MOUSE_OVER, this.onStoneMouseOver);
        this._stone.addEventListener(MouseEvent.MOUSE_OUT, this.onStoneMouseOut);
        this._stone.addEventListener(MouseEvent.CLICK, this.onStoneClick);
    }

    private function onStoneMouseOver(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        if (_loc2_.currentFrame != 3) {
            _loc2_.gotoAndStop(2);
        }
    }

    private function onStoneMouseOut(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        if (_loc2_.currentFrame != 3) {
            _loc2_.gotoAndStop(1);
        }
    }

    private function onStoneClick(param1:MouseEvent):void {
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.gotoAndStop(3);
        this.reward();
        closeInteractor(_loc2_);
    }

    private function reward():void {
        if (SwapManager.isSwapNumberMax(31)) {
            SwapManager.entrySwap(31);
        }
    }

    override public function dispose():void {
        this._stone.removeEventListener(MouseEvent.MOUSE_OVER, this.onStoneMouseOver);
        this._stone.removeEventListener(MouseEvent.MOUSE_OUT, this.onStoneMouseOut);
        this._stone.removeEventListener(MouseEvent.CLICK, this.onStoneClick);
        this._stone = null;
        super.dispose();
    }
}
}
