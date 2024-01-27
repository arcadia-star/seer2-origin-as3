package com.taomee.seer2.app.manager {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.record.FightRecordData;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

public class PVPWOHOOManager {

    private static var _instance:PVPWOHOOManager;


    public function PVPWOHOOManager(param1:PrivateClass) {
        super();
    }

    public static function getInstance():PVPWOHOOManager {
        if (_instance == null) {
            _instance = new PVPWOHOOManager(new PrivateClass());
        }
        return _instance;
    }

    public function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onSwitchComplete);
    }

    private function onSwitchComplete(param1:SceneEvent):void {
        this.showMatchPanel(FightRecordData.FIGHT_PVP_WOHOO, "WoHooStartFightPanel", DateUtil.isInHourScope(13, 14), {
            "id": 462,
            "func": this.getDayLimit
        });
        this.showMatchPanel(FightRecordData.FIGHT_PVP_TRAINER, "TrainerMatchPanel");
    }

    private function showMatchPanel(param1:String, param2:String, param3:Boolean = true, param4:Object = null):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.type) && FightManager.currentFightRecord.initData.type == param1) {
                if (param3) {
                    ModuleManager.toggleModule(URLUtil.getAppModule(param2), "正在加载资源...");
                    if (param4 != null) {
                        DayLimitManager.getDoCount(param4.id, param4.func);
                    }
                }
            }
        }
    }

    private function getDayLimit(param1:int):void {
        ServerMessager.addMessage("当前连胜" + param1 + "场！");
    }
}
}

class PrivateClass {


    public function PrivateClass() {
        super();
    }
}
