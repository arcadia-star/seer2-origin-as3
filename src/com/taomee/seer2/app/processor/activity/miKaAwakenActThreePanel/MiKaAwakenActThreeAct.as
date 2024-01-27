package com.taomee.seer2.app.processor.activity.miKaAwakenActThreePanel {
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.system.ApplicationDomain;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MiKaAwakenActThreeAct {

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([3887, 3888]);

    public static var gameHandleState:int;

    private static var _playState:Vector.<int> = Vector.<int>([0, 0, 0]);

    private static const GO_LIST:Array = ["MiKaAwakenThreeGameOneStartPanel", "MiKaAwakenThreeGameTwoStartPanel", "MiKaAwakenThreeGameThreeStartPanel"];

    private static const GAME_SET:Vector.<int> = Vector.<int>([5]);


    private var _resLib:ApplicationDomain;

    private var _sceneMc:MovieClip;

    private var _map:MapModel;

    private var _curGameIndex:int;

    public function MiKaAwakenActThreeAct(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        this.hideLobbyMenu();
        if (gameHandleState > 0) {
            if (_playState[gameHandleState - 1]) {
                this.startGame();
            } else {
                this.getURL(function ():void {
                    _sceneMc = getMovie("SceneMc" + gameHandleState);
                    if (gameHandleState == 3) {
                        _sceneMc.x = 600;
                        _sceneMc.y = 400;
                    }
                    if (gameHandleState == 2) {
                        LayerManager.topLayer.addChild(_sceneMc);
                        MovieClipUtil.playMc(_sceneMc, 2, 32, function ():void {
                            _sceneMc.gotoAndStop(32);
                            _playState[gameHandleState - 1] = 1;
                            (_sceneMc["mouse0"] as MovieClip).buttonMode = true;
                            (_sceneMc["mouse0"] as MovieClip).addEventListener(MouseEvent.CLICK, onMouseClick0);
                        }, true);
                    } else {
                        _map.front.addChild(_sceneMc);
                        MovieClipUtil.playMc(_sceneMc, 2, _sceneMc.totalFrames, function ():void {
                            _playState[gameHandleState - 1] = 1;
                            _sceneMc.gotoAndStop(1);
                            DisplayUtil.removeForParent(_sceneMc);
                            _sceneMc = null;
                            startGame();
                        }, true);
                    }
                });
            }
        }
    }

    private function onMouseClick0(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        (this._sceneMc["mouse0"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.onMouseClick0);
        MovieClipUtil.playMc(this._sceneMc, this._sceneMc.currentFrame, 699, function ():void {
            _sceneMc.gotoAndStop(699);
            (_sceneMc["mouse1"] as MovieClip).buttonMode = true;
            (_sceneMc["mouse1"] as MovieClip).addEventListener(MouseEvent.CLICK, onMouseClick1);
        }, true);
    }

    private function onMouseClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        (this._sceneMc["mouse1"] as MovieClip).removeEventListener(MouseEvent.CLICK, this.onMouseClick1);
        MovieClipUtil.playMc(this._sceneMc, this._sceneMc.currentFrame, this._sceneMc.totalFrames, function ():void {
            _sceneMc.gotoAndStop(1);
            DisplayUtil.removeForParent(_sceneMc);
            _sceneMc = null;
            startGame();
        }, true);
    }

    private function getURL(param1:Function = null):void {
        var callBack:Function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("miKaAwakenAct/MiKaAwakenAct3"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            if (callBack != null) {
                callBack();
            }
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function startGame():void {
        ActsHelperUtil.goHandle(GO_LIST[gameHandleState - 1]);
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    public function dispose():void {
        gameHandleState = 0;
        this._sceneMc = null;
    }
}
}
