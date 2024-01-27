package com.taomee.seer2.app.arena.processor {
import com.taomee.seer2.app.arena.ArenaScene;
import com.taomee.seer2.app.arena.animation.ArenaAnimationManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.net.MessageEvent;

public class Processor_1501 extends ArenaProcessor {


    public function Processor_1501(param1:ArenaScene) {
        super(param1);
    }

    override public function init():void {
        Connection.addCommandListener(CommandSet.FIGHT_RES_READY_1501, this.processor);
    }

    override public function processor(param1:MessageEvent):void {
        ArenaAnimationManager.hideWaiting();
    }

    override public function dispose():void {
        super.dispose();
        Connection.removeCommandListener(CommandSet.FIGHT_RES_READY_1501, this.processor);
    }
}
}
