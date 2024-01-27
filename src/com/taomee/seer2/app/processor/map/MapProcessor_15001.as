package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class MapProcessor_15001 extends MapProcessor {


    public function MapProcessor_15001(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.updateListUser();
        this.initEvent();
        this.checkTime();
    }

    private function initEvent():void {
        Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002, this.listUsers);
        Connection.addCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
    }

    private function checkTime():void {
        var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_loc1_.hours < 13 || _loc1_.hours > 15 && _loc1_.hours < 18 || _loc1_.hours > 20) {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        }
    }

    private function listUsers(param1:MessageEvent):void {
        this.updateListUser();
    }

    private function updateListUser():void {
        var _loc2_:RemoteActor = null;
        var _loc1_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
        for each(_loc2_ in _loc1_) {
            _loc2_.addEggIcon();
        }
        ActorManager.getActor().addEggIcon();
    }

    override public function dispose():void {
        ActorManager.getActor().removeEggIcon();
        Connection.removeCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
        Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002, this.listUsers);
    }
}
}
