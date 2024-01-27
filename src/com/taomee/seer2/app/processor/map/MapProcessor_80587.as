package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;

import flash.events.MouseEvent;

public class MapProcessor_80587 extends MapProcessor {


    public function MapProcessor_80587(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        _map.content["luoke"].addEventListener(MouseEvent.CLICK, this.onLuokeClick);
        _map.content["luoke"].buttonMode = true;
    }

    private function onLuokeClick(param1:* = null):void {
        var e:* = param1;
        var dialog:Array = [[3131, "罗克", [[0, "(你们说这些话用意何在……)咯咯……XXXXXXXXXXXXXXXXXXXXXX"]], [" 捕捉罗克！  ", "2017年VIP系列活动"]]];
        NpcDialog.showDialogs(dialog, this.catchLuoMa, function ():void {
            ModuleManager.showAppModule("YearPet2017PreheatPanel");
        });
    }

    private function catchLuoMa():void {
        var haveItem:Boolean = ItemManager.getItemQuantityByReferenceId(401307) > 0;
        var dialog0:Array = [[3131, "罗克", [[0, "唔。这根鸡毛……有妈妈的味道,把它送给我，我就跟你走好不好OvO？"]], [" （尝试捕捉！）  ", " 我再想想……"]]];
        var dialog1:Array = [[3131, "罗克", [[0, "唔。你身上……没有妈妈的味道。"]], [" 需要有黄金鸡毛才能捕捉罗克哦！（前往获得）  "]]];
        if (haveItem) {
            NpcDialog.showDialogs(dialog0, function ():void {
                FightManager.startFightWithWild(1880);
            }, function ():void {
            });
        } else {
            NpcDialog.showDialogs(dialog1, function ():void {
                ModuleManager.showAppModule("YearPet2017PreheatPanel");
            });
        }
    }

    override public function dispose():void {
        _map.content["luoke"].removeEventListener(MouseEvent.CLICK, this.onLuokeClick);
        super.dispose();
    }
}
}
