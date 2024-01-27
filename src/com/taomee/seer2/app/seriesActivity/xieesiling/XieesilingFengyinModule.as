package com.taomee.seer2.app.seriesActivity.xieesiling {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.events.MouseEvent;
import flash.text.TextField;

import org.taomee.utils.BitUtil;

public class XieesilingFengyinModule extends XieesilingModule {


    protected var _fengyinIndex:int;

    protected var _leftFightNum:int;

    public function XieesilingFengyinModule() {
        super();
    }

    public function refreshPanel():void {
        DayLimitListManager.getDaylimitList([xieesilignConfig.fengyinFightNumId, xieesilignConfig.fightDamageId], function callback(param1:DayLimitListInfo):void {
            _leftFightNum = 8 - param1.getCount(xieesilignConfig.fengyinFightNumId);
            if (_leftFightNum <= 0) {
                DisplayObjectUtil.disableButton(_mainUI["fightBtn"]);
                DisplayObjectUtil.enableButton(_mainUI["addBtn"]);
            } else {
                DisplayObjectUtil.enableButton(_mainUI["fightBtn"]);
                DisplayObjectUtil.disableButton(_mainUI["addBtn"]);
            }
            (_mainUI["leftFightNum"] as TextField).text = _leftFightNum + "";
            if (_fengyinIndex == 1) {
            }
        });
    }

    public function onPanelClick(param1:MouseEvent):void {
        var fightId:int = 0;
        var e:MouseEvent = param1;
        switch (e.target.name) {
            case "fightBtn":
                fightId = int(xieesilignConfig.fightIds[this._fengyinIndex]);
                ModuleManager.closeForInstance(this);
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, function complete(param1:SceneEvent):void {
                    if (SceneManager.prevSceneType == SceneType.ARENA) {
                        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, complete);
                        if (fightId == FightManager.currentFightRecord.initData.positionIndex) {
                            onFightOver();
                        }
                    }
                });
                FightManager.startFightWithWild(fightId);
                break;
            case "addBtn":
                ShopManager.buyItemForId(xieesilignConfig.addFengyinFightNumBuyId, function buyComplete(param1:*):void {
                    refreshPanel();
                });
                break;
            case "buyBtn":
                this.passByMoney();
        }
    }

    protected function passByMoney():void {
        var module:* = undefined;
        module = this;
        ShopManager.buyItemForId(xieesilignConfig.xingzuanFengyinByStartId + this._fengyinIndex, function buyComplete(param1:*):void {
            ModuleManager.closeForInstance(module);
            ModuleManager.showAppModule(xieesilignConfig.panelPrefix + "GetPanel");
        });
    }

    private function onFightOver():void {
        DayLimitListManager.getDaylimitList([xieesilignConfig.fightFlagId], function callback(param1:DayLimitListInfo):void {
            var _loc2_:int = int(param1.getCount(xieesilignConfig.fightFlagId));
            var _loc3_:* = BitUtil.getBit(_loc2_, _fengyinIndex) != 0;
            if (_loc3_) {
                ModuleManager.showAppModule(xieesilignConfig.panelPrefix + "GetPanel");
            } else {
                ModuleManager.showAppModule(xieesilignConfig.panelPrefix + "Fengyin" + (_fengyinIndex + 1) + "Panel");
            }
        });
    }

    override protected function onClose(param1:MouseEvent):void {
        super.onClose(param1);
        ModuleManager.showAppModule(xieesilignConfig.panelPrefix + "GetPanel");
    }
}
}
