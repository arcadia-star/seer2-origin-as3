package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.setTimeout;

public class HuanBeastChapter2Map extends MapProcessor {


    protected var needGoods:Array;

    protected var petIds:Array;

    private var items:Array;

    private var fights:Array;

    private var maps:Array;

    private var currentIndex:int;

    public function HuanBeastChapter2Map(param1:MapModel) {
        this.needGoods = [5, 5, 10, 1];
        this.petIds = [13, 72, 36, 82];
        this.items = [400285, 400286, 400287, 400288];
        this.fights = [318, 319, 320, 321];
        this.maps = [1312, 2112, 3012, 3701];
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        ItemManager.removeEventListener(ItemEvent.SERVER_ITEM_GIVEN, this.requestItemNum);
    }

    override public function init():void {
        this.currentIndex = this.maps.indexOf(_map.id);
        if (FightManager.currentFightRecord.initData.positionIndex == this.fights[this.currentIndex]) {
            setTimeout(this.requestItemNum, 500);
        } else {
            this.requestItemNum();
        }
    }

    private function requestItemNum():void {
        ItemManager.removeEventListener(ItemEvent.SERVER_ITEM_GIVEN, this.requestItemNum);
        ItemManager.requestItemList(function ():void {
            if (Boolean(ItemManager.getItemByReferenceId(items[currentIndex])) && ItemManager.getItemByReferenceId(items[currentIndex]).quantity >= needGoods[currentIndex]) {
                AlertManager.showAlert("你已经收集好了" + ItemManager.getItemByReferenceId(items[currentIndex]).name + ",打开约瑟传说看看吧!", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("HuanBeastPanel"), "", "2");
                });
            } else {
                createMonster();
            }
        });
    }

    private function createMonster():void {
        var _loc2_:SpawnedPet = null;
        var _loc1_:int = 0;
        while (_loc1_ < 5) {
            _loc2_ = new SpawnedPet(this.petIds[this.currentIndex], this.fights[this.currentIndex], 0);
            MobileManager.addMobile(_loc2_, MobileType.SPAWNED_PET);
            _loc1_++;
        }
    }
}
}
