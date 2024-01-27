package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class MapProcessor_3833 extends MapProcessor {


    private var _npc:MovieClip;

    public function MapProcessor_3833(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
    }

    override public function init():void {
        this.createNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = _map.content["npc1025"];
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep2Continue);
        }
    }

    private function initStep2Continue(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1025, "废品分装队长", [[0, "我是废品分装队长——在地球清理行动中负责分装回收机器人收集来的垃圾。"]], ["净化家园", "你加油"], [function ():void {
            ModuleManager.showModule(URLUtil.getAppModule("ResetBuliderHomePanel"), "正在打开面板...", {"type": 0});
        }, function ():void {
        }]);
    }
}
}
