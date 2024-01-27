package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.scene.SceneManager;

public class MapProcessor_412 extends MapProcessor {


    private var _hideRemoteActorFlag:Boolean;

    private var _scene:LobbyScene;

    public function MapProcessor_412(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        this.resetHideRemoteActorFlag();
        this._scene = null;
    }

    override public function init():void {
        this.hideToolBar();
        this.hideRemoteActor();
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
