package com.taomee.seer2.app.processor.activity.diluControl {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.newPlayerGuideVerOne.NewPlayerGuideTimeManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class DiluManager {

    private static var _diluNpc:Mobile;

    private static var _activityList:Array = [204766, 204735, 204875, 206080];

    public static var _isNoShowPanel:Boolean;


    public function DiluManager() {
        super();
    }

    public static function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
    }

    private static function onComplete(param1:SceneEvent):void {
        var e:SceneEvent = param1;
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
        ServerBufferManager.getServerBuffer(ServerBufferType.LOGIN_SHOW_PANEL, onShowPanel);
        ActiveCountManager.requestActiveCountList(_activityList, function (param1:Parser_1142):void {
            var data:Object = null;
            var par:Parser_1142 = param1;
            if (par.infoVec[0] == 1) {
                addNpc();
            }
            if (par.infoVec[1] == 1) {
                ModuleManager.showModule(URLUtil.getAppModule("PasswordBoundPanel"), "正在打开面板...");
            }
            if (par.infoVec[2] == 1) {
                DayLimitManager.getDoCount(1381, function (param1:int):void {
                    if (param1 != 1) {
                    }
                });
            }
            if (par.infoVec[3] == 0) {
                if (NewPlayerGuideTimeManager.timeCheckNewGuide() && !QuestManager.isComplete(99)) {
                    return;
                }
                data = new Object();
                data.objInt = 1;
                ModuleManager.showModule(URLUtil.getAppModule("PasswordDefendPanel"), "正在打开面板...", data);
                SwapManager.swapItem(3550, 1, function (param1:IDataInput):void {
                });
            }
        });
    }

    private static function onShowPanel(param1:ServerBuffer):void {
        if (param1.readDataAtPostion(0) != 1 && _isNoShowPanel == false) {
            ServerBufferManager.updateServerBuffer(ServerBufferType.LOGIN_SHOW_PANEL, 0, 1);
        }
    }

    public static function addNpc():void {
        _diluNpc = new Mobile();
        _diluNpc.resourceUrl = URLUtil.getPetSwf(789);
        ActorManager.getActor().addCarriedMobile(_diluNpc, 50);
        _diluNpc.buttonMode = true;
        _diluNpc.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            ModuleManager.showModule(URLUtil.getAppModule("DiLuTaskPanel"), "正在打开面板...");
        });
    }

    public static function removeNpc():void {
        if (_diluNpc) {
            ActorManager.getActor().removeCarriedMobile(_diluNpc);
        }
    }
}
}
