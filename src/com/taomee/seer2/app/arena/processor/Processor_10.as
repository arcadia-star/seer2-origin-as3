package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.arena.animation.ArenaAnimationType;
import com.taomee.seer2.app.arena.data.ItemUseResultInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Processor_10 extends ArenaProcessor {


    public function Processor_10(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_USE_ITEM_NOTIFY_10, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        var _loc6_:Object = null;
        var _loc2_:ItemUseResultInfo = new ItemUseResultInfo(param1.message.getRawData());
        var _loc3_:uint = _loc2_.userId;
        var _loc4_:uint = _loc2_.fighterId;
        var _loc5_:Fighter;
        if ((_loc5_ = _secne.arenaData.getFighter(_loc3_, _loc4_)) != null) {
            _loc6_ = {
                "fighter": _loc5_,
                "side": _loc5_.fighterSide,
                "itemUseResultInfo": _loc2_
            };
            ArenaAnimationManager.createAnimation(ArenaAnimationType.ITEMUSE, _loc6_, this.endAnimation);
            arenaUIController.showSkillPanel();
            arenaUIController.updateStatusPanel();
        }
    }

    private function endAnimation():void {
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_USE_ITEM_NOTIFY_10, this.processor);
    }
}
}
