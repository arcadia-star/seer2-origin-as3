package com.taomee.seer2.app.arena.data {
import com.taomee.seer2.app.arena.Fighter;

public class FighterChangeInfo {


    private var _newPosition:uint;

    private var _newFighter:Fighter;

    public function FighterChangeInfo(param1:uint, param2:Fighter) {
        this._newPosition = param1;
        this._newFighter = param2;
        super();
    }

    public function get newPosition():uint {
        return this._newPosition;
    }

    public function get newFighter():Fighter {
        return this._newFighter;
    }
}
}
