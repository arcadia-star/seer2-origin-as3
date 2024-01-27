package com.taomee.seer2.app.processor.activity.fightVsBarry {
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class FightVsDick {


    private var _mapModel:MapModel;

    private var _npc:Mobile;

    public function FightVsDick(param1:MapModel) {
        super();
        this._mapModel = param1;
        this.init();
    }

    private function init():void {
        this.createNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(715, 325));
            this._npc.resourceUrl = URLUtil.getNpcSwf(675);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "迪克";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("FightVsDickPanel"), "正在打开迪克的挑战面板...");
    }

    public function dispose():void {
        this.clearNpc();
    }
}
}
