package com.taomee.seer2.app.processor.activity.worldWar {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.net.MessageEvent;

public class WorldWarProcessor {


    public function WorldWarProcessor() {
        super();
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.month == 10 && _loc1_.date <= 7 && (_loc1_.hours == 13 || _loc1_.hours == 19)) {
            this.entryWorld();
        }
    }

    private function entryWorld():void {
        ActorManager.getActor().addEggIcon("UI_WorldWar");
        this.remoteAddIcon();
        Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002, this.listUsers);
        Connection.addCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
    }

    private function listUsers(param1:MessageEvent):void {
        this.remoteAddIcon();
    }

    private function remoteAddIcon():void {
        var _loc2_:Vector.<RemoteActor> = null;
        var _loc3_:RemoteActor = null;
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.month == 10 && _loc1_.date <= 7 && (_loc1_.hours == 13 || _loc1_.hours == 19)) {
            _loc2_ = ActorManager.getAllRemoteActors();
            for each(_loc3_ in _loc2_) {
                _loc3_.addEggIcon("UI_WorldWar");
            }
        } else {
            Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002, this.listUsers);
            Connection.removeCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
        }
    }

    public function dispose():void {
        ActorManager.getActor().removeEggIcon();
        Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002, this.listUsers);
        Connection.removeCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
    }
}
}
