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

public class QinChapter2Map extends CopyMapProcessor {


    private var currentIndex:int;

    private const mapsID:Array = [5701, 5702, 5703, 5704, 5705, 5706, 5707];

    private const monsterID:Array = [1064, 1065, 1066, 1067, 1068, 1069, 1070];

    private const fightID:Array = [383, 384, 385, 386, 387, 388, 389];

    private const limitID:int = 202213;

    private var _countArray:Array;

    public function QinChapter2Map(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        super.init();
        this.currentIndex = this.mapsID.indexOf(_map.id);
        ActiveCountManager.requestActiveCount(this.limitID, this.getCount);
    }

    private function readBit(param1:uint):void {
        this._countArray = [];
        var _loc2_:int = 0;
        while (_loc2_ < 7) {
            this._countArray.push(param1 >>> _loc2_ & 1);
            _loc2_++;
        }
    }

    private function getCount(param1:uint, param2:uint):void {
        var i:int = 0;
        var type:uint = param1;
        var count:uint = param2;
        if (type == this.limitID) {
            if (count == 127) {
                AlertManager.showAlert("你已经完成了沁灵兽第二章，快去找神秘九尾吧！", function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                    QuestManager.completeStep(10180, 2);
                });
                return;
            }
            this.readBit(count);
            i = 0;
            while (i < 7) {
                if (this._countArray[i] != 1) {
                    this.currentIndex = i;
                    this.createMonster();
                    break;
                }
                if (_map.id == this.mapsID[i]) {
                    if (i < 6) {
                        AlertManager.showAlert("你已经通过这一层的考验，快去看看下一层吧！", function ():void {
                            ModuleManager.toggleModule(URLUtil.getAppModule("QinBeastPanel"), "", "2");
                        });
                    }
                    break;
                }
                i++;
            }
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        SceneManager.changeScene(SceneType.LOBBY, 640);
    }

    private function createMonster():void {
        var _loc1_:SpawnedPet = new SpawnedPet(this.monsterID[this.currentIndex], this.fightID[this.currentIndex], 0);
        MobileManager.addMobile(_loc1_, MobileType.SPAWNED_PET);
    }
}
}
