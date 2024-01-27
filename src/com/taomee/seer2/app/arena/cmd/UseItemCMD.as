package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.arena.controller.ArenaUIController;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.net.MessageEvent;

public class UseItemCMD implements IArenaBaseCMD {


    private var _uiContorller:ArenaUIController;

    private var _usedItemReferenceId:uint;

    private var _fighterId:uint;

    public function UseItemCMD(param1:ArenaUIController, param2:uint, param3:uint) {
        super();
        this._uiContorller = param1;
        this._fighterId = param2;
        this._usedItemReferenceId = param3;
    }

    public function init():void {
    }

    public function send():void {
        Connection.addCommandListener(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUseMedicine);
        Connection.addErrorHandler(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUsedPetError);
        Connection.send(CommandSet.FIGHT_USE_MEDICINE_1048, this._fighterId, this._usedItemReferenceId, 1);
    }

    private function onUsedPetError(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUseMedicine);
        Connection.removeErrorHandler(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUsedPetError);
        if (param1.message.statusCode == 205) {
            AlertManager.showAlert("精灵不喜欢吃这个");
        }
    }

    private function onUseMedicine(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUseMedicine);
        Connection.removeErrorHandler(CommandSet.FIGHT_USE_MEDICINE_1048, this.onUsedPetError);
        if (this._usedItemReferenceId > 0) {
            ItemManager.reduceItemQuantity(this._usedItemReferenceId, 1);
        }
        if (this._uiContorller) {
            this._uiContorller.itemPanelUpdate();
        }
        this.dispose();
    }

    public function dispose():void {
        this._uiContorller = null;
    }
}
}
