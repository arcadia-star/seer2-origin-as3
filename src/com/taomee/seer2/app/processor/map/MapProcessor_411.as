package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.gameRule.door.support.PVPDoorSupport;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;

public class MapProcessor_411 extends MapProcessor {


    private var _hideRemoteActorFlag:Boolean;

    private var _scene:LobbyScene;

    private var _doorSupport:PVPDoorSupport;

    public function MapProcessor_411(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.hideToolBar();
        this.hideRemoteActor();
        this._doorSupport = PVPDoorSupport.getInstance();
        this._doorSupport.init(_map);
    }

    override public function dispose():void {
        this.resetHideRemoteActorFlag();
        if (this._doorSupport) {
            this._doorSupport.dispose();
        }
        this._scene = null;
    }

    private function hideRemoteActor():void {
        this._hideRemoteActorFlag = ActorManager.showRemoteActor;
        ActorManager.showRemoteActor = false;
    }

    private function hideToolBar():void {
        this._scene = SceneManager.active as LobbyScene;
        this._scene.hideTrailsToolBar();
    }

    private function resetHideRemoteActorFlag():void {
        ActorManager.showRemoteActor = this._hideRemoteActorFlag;
    }
}
}
