package com.taomee.seer2.app.arena.cmd {
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;

public class UseEscapeCMD implements IArenaBaseCMD {


    public function UseEscapeCMD() {
        super();
    }

    public function init():void {
    }

    public function send():void {
        Connection.send(CommandSet.FIGHT_ESCAPE_1509);
    }

    public function dispose():void {
    }
}
}
