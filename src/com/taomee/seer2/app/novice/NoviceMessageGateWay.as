package com.taomee.seer2.app.novice {
import com.taomee.seer2.app.lobby.messageHandler.MessageHanderServerClose;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerSetPetFollow;
import com.taomee.seer2.app.lobby.messageHandler.MessageHandlerStartLoadArenaMap;
import com.taomee.seer2.app.manager.PetExperenceHelper;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.scene.MessageGateWay;

public class NoviceMessageGateWay extends MessageGateWay {


    public function NoviceMessageGateWay(param1:BaseScene) {
        super(param1);
    }

    override protected function initMessageHandler():void {
        addMessageHandler(new MessageHandlerStartLoadArenaMap());
        addMessageHandler(new MessageHandlerSetPetFollow());
        addMessageHandler(new MessageHanderServerClose());
        PetExperenceHelper.startListen();
    }
}
}
