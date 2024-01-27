package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.data.RevenueInfo;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Processor_5 extends ArenaProcessor {


    public function Processor_5(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_GET_REVENUE_5, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        fightController.revenueInfo = new RevenueInfo(param1.message.getRawData());
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_GET_REVENUE_5, this.processor);
    }
}
}
