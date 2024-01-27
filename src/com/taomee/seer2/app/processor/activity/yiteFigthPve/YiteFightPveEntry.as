package com.taomee.seer2.app.processor.activity.yiteFigthPve {
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class YiteFightPveEntry {

    public static var mapIndex:uint = 1;


    private const npcIdList:Vector.<uint> = Vector.<uint>([75, 76, 77, 78]);

    private var _mapModel:MapModel;

    private var _yiteList:Vector.<Mobile>;

    public function YiteFightPveEntry() {
        super();
        this._mapModel = SceneManager.active.mapModel;
        this.initYite();
    }

    private function initYite():void {
        this._yiteList = Vector.<Mobile>([]);
        var _loc1_:int = 0;
        while (_loc1_ < 4) {
            this._yiteList.push(MobileManager.getMobile(this.npcIdList[_loc1_], MobileType.NPC));
            this._yiteList[_loc1_].buttonMode = true;
            this._yiteList[_loc1_].addEventListener(MouseEvent.CLICK, this.onYite, false, 1);
            _loc1_++;
        }
    }

    private function onYite(param1:MouseEvent):void {
        param1.stopImmediatePropagation();
        var _loc2_:int = this._yiteList.indexOf(param1.currentTarget as Mobile);
        var _loc3_:Object = new Object();
        _loc3_.index = _loc2_;
        ModuleManager.toggleModule(URLUtil.getAppModule("StartYiteFightPvePanel"), "正在打开...", _loc3_);
    }

    public function dispose():void {
        var _loc1_:Mobile = null;
        for each(_loc1_ in this._yiteList) {
            _loc1_.removeEventListener(MouseEvent.CLICK, this.onYite);
        }
    }
}
}
