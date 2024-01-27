package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.teleport.DeferTeleport;
import com.taomee.seer2.app.gameRule.door.HeroDoor;
import com.taomee.seer2.app.gameRule.door.IDoor;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_85 extends MapProcessor {


    private var _doors:Vector.<IDoor>;

    private var _goFortDeferTeleport:DeferTeleport;

    private var _goFort:MovieClip;

    private var npc:Mobile;

    public function MapProcessor_85(param1:MapModel) {
        this._doors = new Vector.<IDoor>();
        super(param1);
    }

    override public function init():void {
        this.initDeferTeleport();
        var _loc1_:LobbyScene = SceneManager.active as LobbyScene;
        _loc1_.showToolbar();
        ActorManager.showRemoteActor = true;
        var _loc2_:Sprite = _map.content;
        this._doors.push(new HeroDoor(_loc2_["leftPassage"], DoorType.Door_NORMAL));
        this._doors.push(new HeroDoor(_loc2_["rightPassage"], DoorType.Door_50V50));
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_201);
    }

    private function initDeferTeleport():void {
        this._goFort = _map.content["goFort"];
        initInteractor(this._goFort);
        TooltipManager.addCommonTip(this._goFort, "英格瓦要塞");
        this._goFort.addEventListener(MouseEvent.CLICK, this.onFortClick);
        this._goFortDeferTeleport = new DeferTeleport(this._goFort);
        this._goFortDeferTeleport.setActorPostion(new Point(480, 350));
        this._goFortDeferTeleport.setActorTargetMapId(81);
        this._goFortDeferTeleport.addEventListener(DeferTeleport.ACTOR_ARRIVED, this.onActorArrivedFort);
    }

    private function onFortClick(param1:MouseEvent):void {
        this._goFortDeferTeleport.actorMoveClose();
    }

    private function onActorArrivedFort(param1:Event):void {
        this._goFort.play();
    }

    override public function dispose():void {
        var _loc2_:IDoor = null;
        this._goFortDeferTeleport.removeEventListener(DeferTeleport.ACTOR_ARRIVED, this.onActorArrivedFort);
        this._goFortDeferTeleport = null;
        TooltipManager.remove(this._goFort);
        this._goFort.removeEventListener(MouseEvent.CLICK, this.onFortClick);
        this._goFort = null;
        var _loc1_:uint = this._doors.length;
        while (this._doors.length > 0) {
            _loc2_ = this._doors.pop();
            _loc2_.dispose();
        }
        super.dispose();
    }
}
}
