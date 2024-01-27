package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class MapProcessor_3814 extends MapProcessor {

    private static const npc_id:int = 698;


    private var npc:Mobile;

    public function MapProcessor_3814(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.npc = MobileManager.getMobile(npc_id, MobileType.NPC);
        if (this.npc) {
            this.npc.addEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(npc_id, "虚影库贝萨", [[0, "来这里你只有死路一条！给你1秒钟从我魔尊眼前消失！"]], ["踏雪寻魔！", "你这么坏你家人知道吗？"], [function ():void {
            ModuleManager.showModule(URLUtil.getAppModule("FindMoInSnowPanel"), "");
        }]);
    }

    override public function dispose():void {
        if (this.npc) {
            this.npc.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        super.dispose();
    }
}
}
