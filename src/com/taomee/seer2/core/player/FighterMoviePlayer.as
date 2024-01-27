package com.taomee.seer2.core.player {
import flash.display.MovieClip;
import flash.events.Event;

import org.taomee.manager.EventManager;
import org.taomee.player.MoviePlayer;
import org.taomee.utils.Tick;

public class FighterMoviePlayer {


    private var _onComplete:Function;

    private var _moviePlayer:MoviePlayer;

    private var _onUpdate:Function;

    public function FighterMoviePlayer(param1:MovieClip, param2:Function = null, param3:uint = 40, param4:uint = 1, param5:Function = null) {
        super();
        if (param1 != null) {
            this._onComplete = param2;
            this._onUpdate = param5;
            this._moviePlayer = new MoviePlayer(null, param3);
            this._moviePlayer.movie = param1;
            this._moviePlayer.repeatCount = param4;
            Tick.instance.addRender(this.onTick);
        }
    }

    private function onTick(param1:int):void {
        EventManager.addEventListener("DEPOSIT_EVENT", this.onDeposit);
        if (this._onUpdate != null) {
            this._onUpdate();
        }
        if (this._moviePlayer.setInterval(param1)) {
            if (this._onComplete != null) {
                this._onComplete();
            }
        }
    }

    private function onDeposit(param1:Event):void {
        EventManager.removeEventListener("DEPOSIT_EVENT", this.onDeposit);
        this._moviePlayer = null;
        if (this._onComplete != null) {
            this._onComplete();
        }
    }

    public function destroy():void {
        Tick.instance.removeRender(this.onTick);
        this._moviePlayer = null;
        this._onComplete = null;
        this._onUpdate = null;
    }
}
}
