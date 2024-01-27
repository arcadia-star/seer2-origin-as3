package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.utils.IDataInput;

public class MapProcessor_80483 extends MapProcessor {

    private static var _gameIndex:int;


    private var _index:int = -1;

    private const SWAP_LIST:Vector.<int> = Vector.<int>([4186, 4187, 4188, 4189, 4190, 4191]);

    public function MapProcessor_80483(param1:MapModel) {
        super(param1);
    }

    public static function setGameIndex(param1:int):void {
        _gameIndex = param1;
    }

    override public function init():void {
        if (-1 == _gameIndex) {
            return;
        }
        this._index = _gameIndex;
        ServerBufferManager.getServerBuffer(ServerBufferType.SALENSTHOSETHING_GAME, function (param1:ServerBuffer):void {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(_index + 1));
            if (!_isPlay) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.SALENSTHOSETHING_GAME, _index + 1, 1);
                QueueLoader.load(URLUtil.getActivityAnimation("SalensThoseThing/SalensThoseThingGame"), LoadType.SWF, function complete(param1:ContentInfo):void {
                    completeHandler(param1);
                });
            } else {
                TweenNano.delayedCall(1, function ():void {
                    startGame();
                });
            }
        });
    }

    private function completeHandler(param1:ContentInfo):void {
        var animation:MovieClip = null;
        var info:ContentInfo = param1;
        var mainMc:MovieClip = info.content as MovieClip;
        animation = mainMc["mc" + this._index];
        _map.front.addChildAt(animation, _map.front.numChildren);
        MovieClipUtil.playMc(animation, 2, animation.totalFrames, function endPlay():void {
            DisplayObjectUtil.removeFromParent(animation);
            animation = null;
            startGame();
        });
    }

    private function startGame():void {
        if (this._index == 0) {
            ModuleManager.showAppModule("SalensPinTuGamePanel");
        } else if (this._index == 1) {
            SwapManager.swapItem(this.SWAP_LIST[2 * this._index], 1, function success(param1:IDataInput):void {
                new SwapInfo(param1);
                ModuleManager.showAppModule("OutGameFromJLPanel", {
                    "gameName": "EraseGame",
                    "endFunc": gameEndCallback
                });
            }, function failed(param1:uint):void {
            });
        } else if (this._index == 2) {
            SwapManager.swapItem(this.SWAP_LIST[2 * this._index], 1, function success(param1:IDataInput):void {
                new SwapInfo(param1);
                ModuleManager.showAppModule("SalensBiBiKanGamePanel", {"func": bibikanGameOver});
            });
        }
    }

    private function gameEndCallback(param1:Object):void {
        var obj:Object = param1;
        var winFlag:int = 0;
        if (obj.moneyCnt >= 6) {
            winFlag = 1;
        }
        SwapManager.swapItem(4189, 1, function success(param1:IDataInput):void {
            new SwapInfo(param1);
            SceneManager.changeScene(SceneType.LOBBY, 70);
            ModuleManager.showAppModule("SalensThoseThingPanel");
        }, null, new SpecialInfo(1, winFlag));
    }

    private function bibikanGameOver(param1:int):void {
        var val:int = param1;
        var winFlag:int = 0;
        if (val >= 2) {
            winFlag = 1;
        }
        SwapManager.swapItem(4191, 1, function success(param1:IDataInput):void {
            new SwapInfo(param1);
            playFinishMc();
        }, null, new SpecialInfo(1, winFlag));
    }

    private function playFinishMc():void {
        ServerBufferManager.getServerBuffer(ServerBufferType.SALENSTHOSETHING_GAME, function (param1:ServerBuffer):void {
            var server:ServerBuffer = param1;
            var _isPlay:Boolean = Boolean(server.readDataAtPostion(4));
            if (!_isPlay) {
                ServerBufferManager.updateServerBuffer(ServerBufferType.SALENSTHOSETHING_GAME, 4, 1);
                QueueLoader.load(URLUtil.getActivityAnimation("SalensThoseThing/SalensThoseThingGame"), LoadType.SWF, function complete(param1:ContentInfo):void {
                    var animation:MovieClip = null;
                    var info:ContentInfo = param1;
                    var _mainMc:MovieClip = info.content as MovieClip;
                    animation = _mainMc.mc3;
                    _map.front.addChildAt(animation, _map.front.numChildren);
                    if (_mainMc) {
                        MovieClipUtil.playMc(animation, 2, animation.totalFrames, function callBanck():void {
                            DisplayObjectUtil.removeFromParent(animation);
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            ModuleManager.showAppModule("SalensThoseThingPanel");
                        });
                    }
                });
            } else {
                SceneManager.changeScene(SceneType.LOBBY, 70);
                ModuleManager.showAppModule("SalensThoseThingPanel");
            }
        });
    }

    override public function dispose():void {
        super.dispose();
    }
}
}
