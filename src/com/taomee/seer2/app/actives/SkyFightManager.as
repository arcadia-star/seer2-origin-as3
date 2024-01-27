package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.RemoteActor;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.utils.ByteArray;

public class SkyFightManager {

    private static var instance:SkyFightManager;

    private static const ICON_NAME:Array = ["waterIcon", "fireIcon", "grassIcon"];


    protected var addListenerFlag:Boolean = false;

    public function SkyFightManager() {
        super();
        if (instance != null) {
            throw new Error("只能有一个实例");
        }
    }

    public static function getInstance():SkyFightManager {
        if (instance == null) {
            instance = new SkyFightManager();
        }
        return instance;
    }

    public function addListener():void {
        if (this.addListenerFlag == false) {
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onChangeScene);
            this.addListenerFlag = true;
        }
    }

    private function onChangeScene(param1:SceneEvent):void {
        if (SceneManager.active.mapID == 1111) {
            Connection.addCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
            Connection.addCommandListener(CommandSet.USER_ENTER_MAP_1002, this.addUser);
            this.showOrHide(ActorManager.getActor(), false);
        } else if (SceneManager.currentSceneType == SceneType.LOBBY) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onChangeScene);
            this.addListenerFlag = false;
            this.showOrHide(ActorManager.getActor(), true);
            Connection.removeCommandListener(CommandSet.LIST_USER_1004, this.listUsers);
            Connection.removeCommandListener(CommandSet.USER_ENTER_MAP_1002, this.addUser);
        }
    }

    private function listUsers(param1:MessageEvent):void {
        var _loc3_:RemoteActor = null;
        if (SceneManager.active.mapID != 1111) {
            return;
        }
        var _loc2_:Vector.<RemoteActor> = ActorManager.getAllRemoteActors();
        for each(_loc3_ in _loc2_) {
            this.addTeamIcon(_loc3_, _loc3_.getInfo().activityData[4]);
            this.showOrHide(_loc3_, false);
        }
    }

    private function addUser(param1:MessageEvent):void {
        var _loc4_:RemoteActor = null;
        if (SceneManager.active.mapID != 1111) {
            return;
        }
        var _loc2_:ByteArray = param1.message.getRawDataCopy();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        if (_loc3_ != ActorManager.actorInfo.id) {
            if (_loc4_ = ActorManager.getRemoteActor(_loc3_)) {
                this.addTeamIcon(_loc4_, _loc4_.getInfo().activityData[4]);
                this.showOrHide(_loc4_, false);
            }
        }
    }

    public function addTeamIcon(param1:Actor, param2:int):void {
        var icon:IconDisplayer = null;
        var actor:Actor = param1;
        var teamId:int = param2;
    }

    private function showOrHide(param1:Actor, param2:Boolean):void {
        if (param1.getNono()) {
            param1.getNono().nonoInfo.isFollowing = param2;
        }
        if (param1.getFollowingPet()) {
            if (Boolean(param1.getInfo()) && Boolean(param1.getInfo().followingPetInfo)) {
                param1.getInfo().followingPetInfo.isFollowing = param2;
            }
            param1.blockFollowingPet = !param2;
        }
    }
}
}
