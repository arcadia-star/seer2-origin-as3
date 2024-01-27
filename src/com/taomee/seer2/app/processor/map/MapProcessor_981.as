package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.processor.activity.candyTree.CandyTreeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_981 extends MapProcessor {


    private var _candyTree:CandyTreeManager;

    private var _ghost_mc:MovieClip;

    private var _bigGhost_mc:MovieClip;

    public function MapProcessor_981(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
    }

    private function onOpenPanel1Handler(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("HalloweenShalunInfoPanel"), "正在打开面板...");
    }

    private function onOpenPanel2Handler(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("CandyTreePanel"), "正在打开面板...");
    }

    override public function dispose():void {
    }
}
}
