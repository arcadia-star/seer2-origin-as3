package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.gameRule.fish.FishRule_790;
import com.taomee.seer2.app.gameRule.spt.SptAilixisiSupport;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class MapProcessor_790 extends TitleMapProcessor {


    private var _fishRule:FishRule_790;

    public function MapProcessor_790(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        SptAilixisiSupport.getInstance().init(_map);
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_182);
        this._fishRule = new FishRule_790();
        this._fishRule.init(_map);
        this.checkAnimation();
        _map.content["luoke"].addEventListener(MouseEvent.CLICK, this.onLuokeClick);
    }

    private function checkAnimation():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.MAP_790_ONE_ANIMATION, this.onGetServerBuff);
    }

    private function onGetServerBuff(param1:ServerBuffer):void {
        var event:ServerBuffer = param1;
        if (event.readDataAtPostion(0) != 1) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("FullScreenAnimation"), function ():void {
                ServerBufferManager.updateServerBuffer(ServerBufferType.MAP_790_ONE_ANIMATION, 0, 1);
            }, true, false, 2);
        }
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
            });
        } else {
            NpcDialog.showDialogs(dialog1, function ():void {
                ModuleManager.showAppModule("YearPet2017PreheatPanel");
            });
        }
    }

    override public function dispose():void {
        _map.content["luoke"].removeEventListener(MouseEvent.CLICK, this.onLuokeClick);
        SptAilixisiSupport.getInstance().dispose();
        this._fishRule.dispose();
        this._fishRule = null;
        super.dispose();
    }
}
}
