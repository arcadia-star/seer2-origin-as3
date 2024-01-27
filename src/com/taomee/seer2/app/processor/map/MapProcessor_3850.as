package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.component.teleport.DeferTeleport;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.questTiny.QuestTinyPanel;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

public class MapProcessor_3850 extends MapProcessor {


    private var _goFort:MovieClip;

    private var _goFortDeferTeleport:DeferTeleport;

    public function MapProcessor_3850(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        QuestTinyPanel.instance.hide();
        RightToolbarConter.instance.hideRightAndLeft();
        TooltipManager.addCommonTip(_map.content["leftDoor"], "王者试炼");
        TooltipManager.addCommonTip(_map.content["rightDoor"], "万王之战");
        (_map.content["leftDoor"] as SimpleButton).addEventListener(MouseEvent.CLICK, this.onOpenLeftDoor);
        (_map.content["rightDoor"] as SimpleButton).addEventListener(MouseEvent.CLICK, this.onOpenRightDoor);
        this.initDeferTeleport();
        SeatTipsManager.registerSeat(new Point(603, 191), 3850);
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

    private function onOpenLeftDoor(param1:MouseEvent):void {
        ModuleManager.showAppModule("KingFightTrialPanel");
    }

    private function onOpenRightDoor(param1:MouseEvent):void {
        ModuleManager.showAppModule("WanWangBattleMainPanel");
    }

    override public function dispose():void {
        this._goFortDeferTeleport.removeEventListener(DeferTeleport.ACTOR_ARRIVED, this.onActorArrivedFort);
        this._goFortDeferTeleport = null;
        TooltipManager.remove(this._goFort);
        this._goFort.removeEventListener(MouseEvent.CLICK, this.onFortClick);
        this._goFort = null;
        QuestTinyPanel.instance.show();
        (_map.content["leftDoor"] as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onOpenLeftDoor);
        (_map.content["rightDoor"] as SimpleButton).removeEventListener(MouseEvent.CLICK, this.onOpenRightDoor);
        SeatTipsManager.removeSeat(new Point(603, 191), 3850);
        super.dispose();
    }
}
}
