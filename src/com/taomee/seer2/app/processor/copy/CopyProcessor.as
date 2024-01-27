package com.taomee.seer2.app.processor.copy {
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.copySystem.CopyManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;
import flash.utils.ByteArray;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class CopyProcessor {

    private static const PASS_TIP_LIST:Vector.<uint> = Vector.<uint>([80001, 80002, 80004, 80005, 80007, 80008, 80014, 80015, 80022, 80023, 80025, 80026, 80028, 80029]);

    private static const PASS_TIP_STR:Vector.<String> = Vector.<String>(["完成副本，获得10个炼狱粉末!", "完成副本，获得30个炼狱粉末!", "完成副本，获得30个炼狱粉末!", "完成副本，获得50个炼狱粉末!", "完成副本，获得50个炼狱星尘!", "完成副本，获得50个炼狱星尘!", "完成副本，获得10个虚弱之尘!", "完成副本，获得50个虚弱之尘!", "完成副本，获得10个狂暴之尘!", "完成副本，获得50个狂暴之尘!", "完成副本，获得10个妒忌之尘!", "完成副本，获得50个妒忌之尘!", "完成副本，获得1个傲慢之芯!", "完成副本，获得50个妒忌之尘!"]);

    private static var _curIndex:int;


    protected var _copyItem:CopyItemInfo;

    protected var _resLib:ApplicationDomain;

    protected var _mapModel:MapModel;

    private var _miPass:SimpleButton;

    private var _fightBuy:SimpleButton;

    public var isComplete:Boolean;

    public function CopyProcessor(param1:CopyItemInfo) {
        super();
        this._copyItem = param1;
        this._mapModel = SceneManager.active.mapModel;
        this.beforeAnimationHandle();
        this.onReturnCopySceneHandle();
        this.tatisticsHandle();
        this.addBuyMenu();
        this.loadAnimationRes();
        Connection.addCommandListener(CommandSet.CLI_NOTI_COPY_MAP_FIN_1243, this.onCompleteCopy);
    }

    private function addBuyMenu():void {
        this._fightBuy = UIManager.getButton("FightBuy") as SimpleButton;
        if (this._copyItem.passMiId > 0) {
            this._miPass = UIManager.getButton("MiCopyPass") as SimpleButton;
            this._miPass.x = 20;
            this._miPass.y = 120;
            this._mapModel.front.addChild(this._miPass);
            this._fightBuy.x = 20;
            this._fightBuy.y = 210;
            this._mapModel.front.addChild(this._fightBuy);
        } else {
            this._fightBuy.x = 20;
            this._fightBuy.y = 120;
            this._mapModel.front.addChild(this._fightBuy);
        }
        if (this._miPass) {
            this._miPass.addEventListener(MouseEvent.CLICK, this.onMiPass);
        }
        this._fightBuy.addEventListener(MouseEvent.CLICK, this.onFightBuy);
    }

    private function removeBuyMenu():void {
        if (this._miPass) {
            this._miPass.removeEventListener(MouseEvent.CLICK, this.onMiPass);
            DisplayUtil.removeForParent(this._miPass);
            this._miPass = null;
        }
        if (this._fightBuy) {
            this._fightBuy.removeEventListener(MouseEvent.CLICK, this.onFightBuy);
            DisplayUtil.removeForParent(this._fightBuy);
            this._fightBuy = null;
        }
    }

    private function onMiPass(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(this._copyItem.passMiId) + "星钻一键通关吗?", function ():void {
            _curIndex = PASS_TIP_LIST.indexOf(_copyItem.mapId);
            PayManager.buyItem(_copyItem.passMiId, function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen(_copyItem.miFull), function ():void {
                    ServerMessager.addMessage(PASS_TIP_STR[_curIndex]);
                    SceneManager.changeScene(SceneType.LOBBY, 1071);
                }, true, false, 2, true);
            });
        });
    }

    private function onFightBuy(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("MedicineShopPanel"));
    }

    protected function tatisticsHandle():void {
    }

    protected function onCompleteCopy(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.CLI_NOTI_COPY_MAP_FIN_1243, this.onCompleteCopy);
        var _loc2_:ByteArray = param1.message.getRawDataCopy();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        if (_loc3_ == this._copyItem.mapId) {
            CopyManager.instance().completeCopyItem(_loc3_);
            this.isComplete = true;
            this.removeBuyMenu();
        }
    }

    protected function sceneAnimationHandle(param1:String, param2:String = "", param3:Function = null, param4:Function = null):void {
        var fullScreenName:String = param1;
        var sceneTalkName:String = param2;
        var fun:Function = param3;
        var fun1:Function = param4;
        MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen(fullScreenName), function ():void {
            var _scenMc:MovieClip = null;
            if (null != fun) {
                fun.call();
            }
            if (sceneTalkName != "") {
                _scenMc = getResFromDomain(sceneTalkName);
                _mapModel.front.addChild(_scenMc);
                MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                    DisplayUtil.removeForParent(_scenMc);
                    _scenMc = null;
                    if (null != fun1) {
                        fun1.call();
                    }
                }, true);
            }
        }, true, true, 2, false);
    }

    protected function completeTipShow(param1:int = 30, param2:int = 50, param3:String = "炼狱粉末"):void {
        if (this.isComplete) {
            if (this._copyItem.mode == 1) {
                ServerMessager.addMessage("完成副本，获得" + param1 + "个" + param3 + "!");
            } else {
                ServerMessager.addMessage("完成副本，获得" + param2 + "个" + param3 + "!");
            }
        }
    }

    public function beforeAnimationHandle():void {
    }

    private function onReturnCopySceneHandle():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onReturnCopyScene);
    }

    private function onReturnCopyScene(param1:SceneEvent):void {
        if (this._copyItem == null) {
            return;
        }
        if (SceneManager.active.mapID == this._copyItem.mapId) {
            this._mapModel = SceneManager.active.mapModel;
            this.returnSceneHandle();
        }
    }

    public function returnSceneHandle():void {
    }

    protected function getResFromDomain(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function loadAnimationRes():void {
        QueueLoader.load(URLUtil.getCopyAnimation(this._copyItem.animationStr), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            onAnimationLoaded();
        });
    }

    public function onAnimationLoaded():void {
    }

    public function dispose():void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onReturnCopyScene);
        this._copyItem = null;
        this._resLib = null;
        this._mapModel = null;
        Connection.removeCommandListener(CommandSet.CLI_NOTI_COPY_MAP_FIN_1243, this.onCompleteCopy);
        this.isComplete = false;
    }
}
}
