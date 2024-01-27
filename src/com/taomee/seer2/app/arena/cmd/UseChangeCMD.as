package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;

public class UseChangeCMD implements IArenaBaseCMD {


    private var _operateId:uint;

    public function UseChangeCMD(param1:uint) {
        super();
        this._operateId = param1;
    }

    public function init():void {
    }

    public function send():void {
        Connection.addErrorHandler(CommandSet.FIGHT_CHANGE_FIGHTER_1032, this.onError);
        Connection.send(CommandSet.FIGHT_CHANGE_FIGHTER_1032, this._operateId);
    }

    private function onError(param1:MessageEvent):void {
        var _loc2_:ArenaScene = null;
        if (param1.message.statusCode == 200009) {
            ServerMessager.addMessage("暂时无法替换精灵");
            _loc2_ = SceneManager.active as ArenaScene;
            _loc2_.fightController.arenaUIController.startSelectOperate();
        }
    }

    public function dispose():void {
    }
}
}
