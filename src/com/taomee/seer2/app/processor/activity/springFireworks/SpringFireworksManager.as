package com.taomee.seer2.app.processor.activity.springFireworks {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class SpringFireworksManager {

    private static var _count:uint;

    private static var _isPlay:Boolean;

    private static var _hongbaoVec:Vector.<MovieClip>;


    public function SpringFireworksManager() {
        super();
    }

    public static function setup(param1:Boolean, param2:int = 0):void {
        var isShowPlay:Boolean = param1;
        var index:int = param2;
        ActiveCountManager.requestActiveCount(250425, function (param1:uint, param2:uint):void {
            var type:uint = param1;
            var count:uint = param2;
            _count = count;
            if (isShowPlay) {
                if (_isPlay == false) {
                    _isPlay = true;
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("SpringFireworks" + index), function ():void {
                        _isPlay = false;
                        Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
                        showFireWorks();
                    });
                } else {
                    Connection.releaseCommand(CommandSet.ITEM_SERVER_GIVE_1051);
                    showFireWorks();
                }
            } else {
                showFireWorks();
            }
        });
    }

    private static function showFireWorks():void {
        removeAll();
        if (_count > 0) {
            updateFireworks();
        }
    }

    private static function updateFireworks():void {
        var _loc1_:MovieClip = null;
        _hongbaoVec = Vector.<MovieClip>([]);
        var _loc2_:int = 0;
        while (_loc2_ < _count) {
            _loc1_ = UIManager.getMovieClip("UI_Firework");
            _loc1_.buttonMode = true;
            _loc1_.x = Math.random() * 800 + 200;
            _loc1_.y = Math.random() * 440 + 100;
            SceneManager.active.mapModel.content.addChild(_loc1_);
            _loc1_.addEventListener(MouseEvent.CLICK, onHongbao);
            _hongbaoVec.push(_loc1_);
            _loc2_++;
        }
    }

    private static function onHongbao(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        mc = event.currentTarget as MovieClip;
        SwapManager.swapItem(3847, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            DisplayObjectUtil.removeFromParent(mc);
            ModuleManager.showModule(URLUtil.getAppModule("SpringLessMoneyPanel"), "正在打开...");
        });
    }

    private static function removeAll():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in _hongbaoVec) {
            DisplayObjectUtil.removeFromParent(_loc1_);
        }
    }

    public static function dispose():void {
        removeAll();
    }
}
}
