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
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.MessageGateWay;

public class LobbyMessageGateWay extends MessageGateWay {


    public function LobbyMessageGateWay(param1:BaseScene) {
        super(param1);
    }

    override protected function initMessageHandler():void {
        addMessageHandler(new MessageHandlerUserBroadcast());
        addMessageHandler(new MessageHandlerSyncServerTime());
        addMessageHandler(new MessageHandlerChat());
        addMessageHandler(new MessageHandlerPetSpawn());
        addMessageHandler(new MessageHandlerSetPetFollow());
        addMessageHandler(new MessageHandlerBuddy());
        addMessageHandler(new MessageHandlerEquipChange());
        addMessageHandler(new MessageHandlerServerMessage());
        addMessageHandler(new MessageHandlerStartLoadArenaMap());
        addMessageHandler(new MessageHanderServerClose());
        PetExperenceHelper.startListen();
    }

    override protected function realseCommands():void {
        Connection.releaseCommand(CommandSet.RANDOM_EVENT_1140);
        Connection.releaseCommand(CommandSet.QUEST_SUBMIT_STEP_BUFFER_1015);
        Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
        Connection.releaseCommand(CommandSet.GET_CONIS_1547);
        NoticeManager.relase();
    }
}
}
