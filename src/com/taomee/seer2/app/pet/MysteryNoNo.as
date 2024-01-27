package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.core.map.ResourceLibrary;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;

public class MysteryNoNo extends Sprite {

    public static const CLICKED_TEN_TIME:String = "clicked_ten_times";


    private var nonoMC:MovieClip;

    private var nonoLibs:ResourceLibrary;

    private var hasClickedTime:int;

    private var light:MovieClip;

    private var nonoMove:MovieClip;

    public function MysteryNoNo(param1:ResourceLibrary) {
        super();
        this.nonoLibs = param1;
        this.createNONO();
    }

    private function createNONO():void {
        this.nonoMC = this.nonoLibs.getMovieClip("NonoLight");
        this.light = this.nonoMC["light"];
        this.nonoMove = this.nonoMC["nono"];
        this.addChild(this.nonoMC);
        ShootController.addEventListener(ShootEvent.PLAY_END, this.onShot);
    }

    private function onShot(param1:ShootEvent):void {
        var _loc2_:ShootInfo = param1.info;
        if (_loc2_.userID == ActorManager.actorInfo.id) {
            if (this.nonoMove.hitTestPoint(_loc2_.endPos.x, _loc2_.endPos.y)) {
                this.hasClickedTime += 1;
                this.light.scaleX -= 0.05;
                this.light.scaleY = this.light.scaleX;
                if (this.hasClickedTime >= 10) {
                    this.light.scaleX = this.light.scaleY = 0.5;
                    this.dispatchEvent(new Event(MysteryNoNo.CLICKED_TEN_TIME));
                    StatisticsManager.sendNovice(StatisticsManager.ui_interact_399);
                }
            } else {
                --this.hasClickedTime;
                this.light.scaleX += 0.05;
                this.light.scaleY = this.light.scaleX;
                if (this.hasClickedTime < 0) {
                    this.hasClickedTime = 0;
                    this.light.scaleY = this.light.scaleX = 1;
                }
            }
        }
    }

    public function dispose():void {
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.onShot);
    }
}
}
