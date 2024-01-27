package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.NpcChallenge;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class MapProcessor_110 extends TitleMapProcessor {


    private const ACTION_STAND:String = "站立";

    private var _gunShotCartoon:MovieClip;

    private var _gunTrigger:MovieClip;

    private var _caoNiMa:MovieClip;

    private var _npc17:Mobile;

    public function MapProcessor_110(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initGunShotCartoon();
        this.initGunTrigger();
        this.processNpc();
        this.initCaoNiMa();
        super.init();
    }

    private function initCaoNiMa():void {
        this._caoNiMa = _map.content["caonima"];
        this._caoNiMa.buttonMode = true;
        this._caoNiMa.addEventListener(MouseEvent.MOUSE_OVER, this.onCaoNiMaOver);
        this._caoNiMa.addEventListener(MouseEvent.MOUSE_OUT, this.onCaoNiMaOut);
    }

    private function onCaoNiMaOver(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        this._caoNiMa.gotoAndStop(2);
    }

    private function onCaoNiMaOut(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        this._caoNiMa.gotoAndStop(1);
    }

    private function initGunShotCartoon():void {
        this._gunShotCartoon = _map.content["gunShotCartoon"];
        this._gunShotCartoon.mouseEnabled = false;
        this._gunShotCartoon.mouseChildren = false;
        this._gunShotCartoon.gotoAndStop(1);
    }

    private function initGunTrigger():void {
        this._gunTrigger = _map.content["gunTrigger"];
        initInteractor(this._gunTrigger);
        this._gunTrigger.addEventListener(MouseEvent.CLICK, this.onGunTriggerClick);
    }

    private function onGunShotEnterFrame(param1:Event):void {
        if (this._gunShotCartoon.currentFrame == this._gunShotCartoon.totalFrames) {
            this._gunShotCartoon.gotoAndStop(1);
            this._gunShotCartoon.removeEventListener(Event.ENTER_FRAME, this.onGunShotEnterFrame);
            initInteractor(this._gunTrigger);
            this.reward();
        }
    }

    private function reward():void {
        if (SwapManager.isSwapNumberMax(12)) {
            SwapManager.entrySwap(12);
        }
    }

    private function onGunTriggerClick(param1:MouseEvent):void {
        closeInteractor(this._gunTrigger);
        this._gunShotCartoon.addEventListener(Event.ENTER_FRAME, this.onGunShotEnterFrame);
        this._gunShotCartoon.gotoAndPlay(1);
    }

    private function clearEventListener():void {
        this._caoNiMa.removeEventListener(MouseEvent.MOUSE_OVER, this.onCaoNiMaOver);
        this._caoNiMa.removeEventListener(MouseEvent.MOUSE_OUT, this.onCaoNiMaOut);
        this._gunShotCartoon.removeEventListener(Event.ENTER_FRAME, this.onGunShotEnterFrame);
        this._gunTrigger.removeEventListener(MouseEvent.CLICK, this.onGunTriggerClick);
    }

    private function processNpc():void {
        NpcChallenge.getInstance().init(17, [213, 214, 215]);
        this._npc17 = MobileManager.getMobile(17, MobileType.NPC);
        if (this._npc17 != null) {
            this._npc17.action = this.ACTION_STAND;
        }
    }

    override public function dispose():void {
        this.clearEventListener();
        this._gunShotCartoon = null;
        this._gunTrigger = null;
        this._npc17 = null;
        this._caoNiMa = null;
        NpcChallenge.getInstance().dispose();
        super.dispose();
    }
}
}
