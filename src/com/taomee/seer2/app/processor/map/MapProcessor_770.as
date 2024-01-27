package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.map.MapModel;

public class MapProcessor_770 extends TitleMapProcessor {


    private var _teleport:Teleport;

    public function MapProcessor_770(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_181);
        this._teleport = AnimateElementManager.getElement(2) as Teleport;
        this._teleport.visible = false;
    }
}
}
