package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_1182 extends MapProcessor {


    public function MapProcessor_1182(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        _map.content["shifeng"].addEventListener(MouseEvent.CLICK, this.onShifengClick);
    }

    override public function dispose():void {
        _map.content["shifeng"].removeEventListener(MouseEvent.CLICK, this.onShifengClick);
        super.dispose();
    }

    private function onShifengClick(param1:* = null):void {
        var _loc2_:int = ItemManager.getItemQuantityByReferenceId(401303);
        var _loc3_:* = "（我有" + _loc2_ + "个[诗韵之羽]。消耗诗韵之羽可以和诗风进行更长时间的对战，还可以兑换纹章哦！）";
        NpcDialog.show(3124, "诗风", [[0, "久在樊笼里，复得返自然。不禁逸兴遄飞啊。" + _loc3_]], ["【诗韵之战】", "【兑换纹章】", "【购买“诗韵之羽】"], [this.fightShifeng, this.exchangeWenzhang, this.buyItem]);
    }

    private function fightShifeng():void {
        var fun:Function = function (param1:int):void {
            FightManager.startFightWithWild(param1);
        };
        NpcDialog.show(3124, "诗风", [[0, "[使用20枚“诗韵之羽”可以直接挑战诗风，但诗风2回合就会逃跑。],[使用100枚“诗韵之羽”可以获得额外时长，诗风不会逃跑。]"]], ["直接挑战（消耗20枚）", "永久挑战（消耗100枚）"], [function ():void {
            fun(1863);
        }, function ():void {
            fun(1864);
        }]);
    }

    private function exchangeWenzhang():void {
        AlertManager.showConfirm("你确定要消耗150枚诗韵之羽兑换诗风纹章吗？", function ():void {
            SwapManager.swapItem(4625, 1, function success(param1:IDataInput):void {
                new SwapInfo(param1);
            }, null);
        });
    }

    private function buyItem():void {
        var buyInfo:BuyPropInfo = new BuyPropInfo();
        buyInfo.itemId = 607084;
        buyInfo.iconId = 401303;
        buyInfo.buyComplete = function buyComplete(param1:*):void {
        };
        ShopManager.buyBagItem(buyInfo);
    }
}
}
