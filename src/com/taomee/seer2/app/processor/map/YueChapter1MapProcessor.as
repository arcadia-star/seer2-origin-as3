package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
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

public class YueChapter1MapProcessor extends CopyMapProcessor {


    private const mapIDs:Array = [4804, 4904, 3904, 5104, 5204];

    private const monsterIDs:Array = [110, 112, 185, 64, 87];

    private const limitID:int = 202254;

    private const fightID:Array = [427, 428, 429, 430, 431];

    private var currentIndex:int;

    private var _countArray:Array;

    public function YueChapter1MapProcessor(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.currentIndex = this.mapIDs.indexOf(_map.id);
        ActiveCountManager.requestActiveCount(this.limitID, this.getCount);
    }

    private function getCount(param1:int, param2:int):void {
        var i:int = 0;
        var type:int = param1;
        var count:int = param2;
        if (type == this.limitID) {
            if (count == 31) {
                AlertManager.showAlert("你已经找齐了所有的地图碎片，赶快去找吉吉导游吧，还等什么。", function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                    QuestManager.completeStep(10186, 2);
                });
                return;
            }
            this.readBit(count);
            i = 0;
            while (i < 5) {
                if (this._countArray[i] != 1) {
                    this.currentIndex = i;
                    this.createMonster();
                    break;
                }
                if (_map.id == this.mapIDs[i]) {
                    if (i < 4) {
                        AlertManager.showAlert("你已经获取了该层的地图碎片，快去看看下一层吧，GoGoGo！", function ():void {
                            ModuleManager.showModule(URLUtil.getAppModule("YueBeastPanel"), "", "1");
                        });
                    }
                    break;
                }
                i++;
            }
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == 10186 && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
            SceneManager.changeScene(SceneType.LOBBY, 4704);
        }
    }

    private function readBit(param1:int):void {
        this._countArray = [];
        var _loc2_:int = 0;
        while (_loc2_ < 5) {
            this._countArray.push(param1 >>> _loc2_ & 1);
            _loc2_++;
        }
    }

    private function createMonster():void {
        var _loc1_:SpawnedPet = new SpawnedPet(this.monsterIDs[this.currentIndex], this.fightID[this.currentIndex], 0);
        MobileManager.addMobile(_loc1_, MobileType.SPAWNED_PET);
    }

    override public function dispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        super.dispose();
    }
}
}
