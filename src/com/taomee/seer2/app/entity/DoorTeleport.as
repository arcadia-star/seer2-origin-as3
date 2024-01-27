package com.taomee.seer2.app.entity {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.entity.pool.TeleportResourcePool;
import com.taomee.seer2.app.gameRule.door.alone.Alone50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.alone.AloneDoorSupport;
import com.taomee.seer2.app.gameRule.door.atletico.Atletico50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.atletico.AtleticoDoorSupport;
import com.taomee.seer2.app.gameRule.door.constant.DoorRule;
import com.taomee.seer2.app.gameRule.door.constant.DoorType;
import com.taomee.seer2.app.gameRule.door.trails.Trail50V50DoorSupport;
import com.taomee.seer2.app.gameRule.door.trails.TrailDoorSupport;
import com.taomee.seer2.app.gameRule.door.warrior.Warrior50V50DoorSuport;
import com.taomee.seer2.app.gameRule.door.warrior.WarriorDoorSuport;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.events.MoveEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class DoorTeleport extends Teleport {


    private var _tip:String = "您确定要离开吗?";

    private var _doorRule:uint = 0;

    private var _doorType:uint = 0;

    private var _spot:MovieClip;

    public function DoorTeleport() {
        super();
    }

    override public function setData(param1:XML):void {
        super.setData(param1);
        this._tip = param1.attribute("tip").toString();
        this._doorRule = uint(param1.attribute("doorRule").toString());
        this._doorType = uint(param1.attribute("doorType").toString());
    }

    override public function onMouseClick(param1:MouseEvent):void {
        var _loc2_:Boolean = true;
        if (this._doorRule == DoorRule.TRAIL_DOOR) {
            if (this._doorType == DoorType.Door_NORMAL) {
                _loc2_ = TrailDoorSupport.getInstance().canLevelNow;
            } else if (this._doorType == DoorType.Door_50V50) {
                _loc2_ = Trail50V50DoorSupport.getInstance().canLevelNow;
            }
        } else if (this._doorRule == DoorRule.WARRIOR_DOOR) {
            if (this._doorType == DoorType.Door_NORMAL) {
                _loc2_ = WarriorDoorSuport.getInstance().canLevelNow;
            } else if (this._doorType == DoorType.Door_50V50) {
                _loc2_ = Warrior50V50DoorSuport.getInstance().canLevelNow;
            }
        } else if (this._doorRule == DoorRule.ATLETICO_DOOR) {
            if (this._doorType == DoorType.Door_NORMAL) {
                _loc2_ = AtleticoDoorSupport.getInstance().canLevelNow;
            } else if (this._doorType == DoorType.Door_50V50) {
                _loc2_ = Atletico50V50DoorSupport.getInstance().canLevelNow;
            }
        } else if (this._doorRule == DoorRule.ALONE_DOOR) {
            if (this._doorType == DoorType.Door_NORMAL) {
                _loc2_ = AloneDoorSupport.getInstance().canLevelNow;
            } else if (this._doorType == DoorType.Door_50V50) {
                _loc2_ = Alone50V50DoorSupport.getInstance().canLevelNow;
            }
        }
        if (_loc2_) {
            AlertManager.showConfirm(this._tip, this.confirmHandler, this.cancelHandler);
        }
        param1.stopImmediatePropagation();
    }

    override protected function addSpot():void {
        this._spot = TeleportResourcePool.checkDreamTeleportOut();
        addChild(this._spot);
    }

    override protected function checkPortInPool():void {
        TeleportResourcePool.checkDreamTeleportIn(this._spot);
    }

    override public function dispose():void {
        super.dispose();
        this._spot = null;
    }

    protected function confirmHandler():void {
        Connection.send(CommandSet.DOOR_OUT_1049);
        var _loc1_:Actor = ActorManager.getActor();
        var _loc2_:Boolean = isTargetArrived();
        if (_loc2_) {
            changeMap();
        } else {
            _loc1_.addEventListener(MoveEvent.FINISHED, onActorMoveFinished);
            _loc1_.runToLocation(this.x, this.y);
        }
    }

    protected function cancelHandler():void {
    }
}
}
