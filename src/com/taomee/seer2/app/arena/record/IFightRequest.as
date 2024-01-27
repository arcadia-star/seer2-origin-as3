package com.taomee.seer2.app.arena.record {
import com.taomee.seer2.app.arena.ui.ButtonPanelData;

public interface IFightRequest {


    function get uid():Number;

    function get fightRecordData():FightRecordData;

    function startFight(param1:Object, param2:ButtonPanelData, param3:Number = -1):void;
}
}
