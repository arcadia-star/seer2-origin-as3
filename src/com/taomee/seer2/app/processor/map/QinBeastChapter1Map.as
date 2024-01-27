package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.setTimeout;

public class QinBeastChapter1Map extends CopyMapProcessor {


    private const mapsID:Array = [1423, 1933, 2703, 1523, 5303, 3702, 6103, 7101, 7901];

    private const monsterID:Array = [17, 31, 38, 57, 80, 82, 127, 157, 215];

    private const itemsID:Array = [603043, 603044, 603045, 603046, 603047, 603048, 603049, 603050, 603051];

    private const fightID:Array = [366, 367, 368, 369, 370, 371, 372, 373, 374];

    private var currentIndex:int;

    public function QinBeastChapter1Map(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.currentIndex = this.mapsID.indexOf(_map.id);
        setTimeout(this.requestItem, 1000);
    }

    private function requestItem():void {
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.onSuccess);
        ItemManager.requestSpecialItemList();
    }

    private function onSuccess(param1:ItemEvent):void {
        var event:ItemEvent = param1;
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.onSuccess);
        if (ItemManager.getSpecialItem(this.itemsID[this.currentIndex])) {
            if (this.itemsID[this.currentIndex] != 603051) {
                AlertManager.showAlert("你已经收集到了" + ItemConfig.getItemName(this.itemsID[this.currentIndex]) + ",赶紧去收集其它的吧!", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("QinBeastPanel"), "", "1");
                });
            } else {
                AlertManager.showAlert("你现在已经收集齐了所有的尾巴，赶快去解封吧！", function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                    QuestManager.completeStep(10178, 3);
                });
            }
        } else {
            this.createMonster();
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 640);
    }

    override public function dispose():void {
        super.dispose();
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.onSuccess);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
    }

    private function createMonster():void {
        var _loc2_:SpawnedPet = null;
        var _loc1_:int = 0;
        while (_loc1_ < 5) {
            _loc2_ = new SpawnedPet(this.monsterID[this.currentIndex], this.fightID[this.currentIndex], 0);
            MobileManager.addMobile(_loc2_, MobileType.SPAWNED_PET);
            _loc1_++;
        }
    }
}
}
