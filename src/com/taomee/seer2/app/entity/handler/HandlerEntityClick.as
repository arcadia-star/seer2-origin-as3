package com.taomee.seer2.app.entity.handler {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.processor.activity.npcPosHandle.NpcPosHandle;
import com.taomee.seer2.core.entity.definition.EntityDefinition;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.entity.handler.IEntityEventHandler;

import flash.events.Event;
import flash.geom.Point;

public class HandlerEntityClick implements IEntityEventHandler {


    protected var _entityDefinition:EntityDefinition;

    private var _type:String;

    private var _actorTargetPosition:Point;

    public function HandlerEntityClick() {
        super();
    }

    public function set type(param1:String):void {
        this._type = param1;
    }

    public function get type():String {
        return this._type;
    }

    public function setEntityDefinition(param1:EntityDefinition):void {
        this._entityDefinition = param1;
        this._actorTargetPosition = new Point(this._entityDefinition.actorPos.x, this._entityDefinition.actorPos.y);
    }

    public function initData(param1:XML):void {
        throw new Error("Should be override in subclasses");
    }

    public function onEvent(param1:Event):void {
        var _loc2_:Actor = ActorManager.getActor();
        var _loc3_:Boolean = this.isTargetArrived(this._actorTargetPosition);
        if (NpcPosHandle.isMove) {
            NpcPosHandle.isMove = false;
            return;
        }
        if (_loc3_) {
            this.action();
        } else {
            _loc2_.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
            _loc2_.runToLocation(this._entityDefinition.actorPos.x, this._entityDefinition.actorPos.y);
        }
        param1.stopImmediatePropagation();
    }

    private function isTargetArrived(param1:Point):Boolean {
        var _loc2_:Actor = ActorManager.getActor();
        return _loc2_.isArrivedPosition(param1);
    }

    private function onActorMoveFinished(param1:MoveEvent):void {
        ActorManager.getActor().removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        var _loc2_:Boolean = this.isTargetArrived(this._actorTargetPosition);
        if (_loc2_) {
            this.action();
        }
    }

    protected function action():void {
        throw new Error("Should be override in subclasses");
    }
}
}
