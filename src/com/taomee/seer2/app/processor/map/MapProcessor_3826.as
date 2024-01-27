package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.item.EquipItem;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;

public class MapProcessor_3826 extends MapProcessor {

    private static const EQUIP_ID:uint = 101696;


    public function MapProcessor_3826(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUint);
    }

    private function onUint(param1:DialogPanelEvent):void {
        var equipList:Vector.<EquipItem> = null;
        var has:Boolean = false;
        var item:EquipItem = null;
        var evt:DialogPanelEvent = param1;
        var params:String = String(evt.content.params);
        if (params == "GoldProcessAct") {
            equipList = ActorManager.actorInfo.equipVec.slice();
            has = false;
            for each(item in equipList) {
                if (item.referenceId == EQUIP_ID) {
                    has = true;
                    break;
                }
            }
            if (has) {
                NpcDialog.show(816, "创世大帝", [[0, ActorManager.actorInfo.nick + ",  你确定不装备【创世神头盔】直接应战吗？拥有【创世神头盔】可以更容易的战胜我"]], ["我已装备,开始对战!", "我再想想"], [function ():void {
                    ModuleManager.showAppModule("GoldProcessFightPanel");
                }]);
            } else {
                NpcDialog.show(816, "创世大帝", [[0, ActorManager.actorInfo.nick + ",  你确定不装备【创世神头盔】直接应战吗？拥有【创世神头盔】可以更容易的战胜我"]], ["我要装备", "直接开战吧！"], [function ():void {
                    NpcDialog.show(816, "创世大帝", [[0, "你还没有这套装备呢"]], ["立即拥有", "打开背包穿上", "稍后再说"], [function ():void {
                        ModuleManager.showAppModule("GoldProcessBuyEquipPanel");
                    }, function ():void {
                        ModuleManager.showAppModule("ItemBagPanel");
                    }]);
                }, function ():void {
                    ModuleManager.showAppModule("GoldProcessFightPanel");
                }]);
            }
        }
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
