package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.activity.data.ActivityDefinition;

public class FlameBattle extends ActivityProcessor {


    private var _specialEvent:FlameBattleCSE;

    public function FlameBattle(param1:ActivityDefinition) {
        _relatedMapIDArr = [261, 263];
        super(param1);
    }

    override public function start():void {
        this._specialEvent = new FlameBattleCSE(17, this);
        super.start();
    }

    override public function refresh():void {
        super.refresh();
    }

    override public function dispose():void {
        this._specialEvent.dispose();
        this._specialEvent = null;
        super.dispose();
    }
}
}
