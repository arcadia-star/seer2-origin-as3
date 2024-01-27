package com.taomee.seer2.app.lobby {
import com.taomee.seer2.app.lobby.messageHandler.MessageHanderServerClose;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerBuddy;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerChat;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerEquipChange;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerPetSpawn;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerServerMessage;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSetPetFollow;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerStartLoadArenaMap;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSyncServerTime;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerUserBroadcast;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;

internal class LobbyMessageHandlerDelegate {


    private var _scene:LobbyScene;

    public function LobbyMessageHandlerDelegate(param1:LobbyScene) {
        super();
        this._scene = param1;
        this.initialize();
    }

    private function initialize():void {
        this.addMessageHandler();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
    }

    private function onSwitchComplete(param1:SceneEvent):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
        Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
        Connection.releaseCommand(CommandSet.GET_CONIS_1547);
        NoticeManager.relase();
    }

    private function addMessageHandler():void {
        this._scene.addMessageHandler(new MessageHandlerUserBroadcast());
        this._scene.addMessageHandler(new MessageHandlerSyncServerTime());
        this._scene.addMessageHandler(new MessageHandlerChat());
        this._scene.addMessageHandler(new MessageHandlerPetSpawn());
        this._scene.addMessageHandler(new MessageHandlerSetPetFollow());
        this._scene.addMessageHandler(new MessageHandlerBuddy());
        this._scene.addMessageHandler(new MessageHandlerEquipChange());
        this._scene.addMessageHandler(new MessageHandlerServerMessage());
        this._scene.addMessageHandler(new MessageHandlerStartLoadArenaMap());
        this._scene.addMessageHandler(new MessageHanderServerClose());
    }

    public function dispose():void {
        NoticeManager.block();
    }
}
}
