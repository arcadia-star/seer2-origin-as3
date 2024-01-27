package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actives.MakeSnowmanAct;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.activity.fightCounter.FightBearProcess;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.filters.GlowFilter;

public class MapProcessor_10109 extends MapProcessor {


    private var _fightCounter:FightBearProcess;

    private var _houseMC:MovieClip;

    public function MapProcessor_10109(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._houseMC = _map.content["house"];
        var _loc1_:Teleport = AnimateElementManager.getElement(1) as Teleport;
        var _loc2_:GlowFilter = new GlowFilter();
        _loc2_.blurX = 25;
        _loc2_.blurY = 25;
        _loc2_.color = 16711680;
        _loc2_.inner = true;
        _loc1_.filters = [_loc2_];
        this._fightCounter = new FightBearProcess(this._houseMC);
        MakeSnowmanAct.getInstance().setup();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_291);
    }

    override public function dispose():void {
        super.dispose();
        this._fightCounter.dispose();
        MakeSnowmanAct.getInstance().dispose();
    }
}
}
