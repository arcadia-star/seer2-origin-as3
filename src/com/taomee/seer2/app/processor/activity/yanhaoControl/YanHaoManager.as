package com.taomee.seer2.app.processor.activity.yanhaoControl {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.rightToolbar.RightToolbarTimeCheck;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;

public class YanHaoManager {

    private static var _yanhaoNpc:Mobile;

    private static var _activityList:Array = [204766, 204735, 204875];

    public static var _isNoShowPanel:Boolean;


    public function YanHaoManager() {
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
                        RightToolbarTimeCheck.clearUIBuf(3, false);
                        RightToolbarTimeCheck.openUIBuf(2, false);
                    } else {
                        RightToolbarTimeCheck.clearUIBuf(2, false);
                        RightToolbarTimeCheck.openUIBuf(3, false);
                    }
                    RightToolbarTimeCheck.updateRightToolbar();
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
        _yanhaoNpc = new Mobile();
        _yanhaoNpc.resourceUrl = URLUtil.getPetSwf(812);
        ActorManager.getActor().addCarriedMobile(_yanhaoNpc, 50);
        _yanhaoNpc.buttonMode = true;
        _yanhaoNpc.addEventListener(MouseEvent.CLICK, function (param1:MouseEvent):void {
            ModuleManager.showModule(URLUtil.getAppModule("YanHaoTaskPanel"), "正在打开面板...");
        });
    }

    public static function removeNpc():void {
        if (_yanhaoNpc) {
            ActorManager.getActor().removeCarriedMobile(_yanhaoNpc);
        }
    }
}
}
