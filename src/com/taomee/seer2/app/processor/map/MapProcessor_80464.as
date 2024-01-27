package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.Tick;

public class MapProcessor_80464 extends MapProcessor {


    private const SWAP_RANDOM_ID:int = 3977;

    private const DAY_ID:int = 1700;

    private const FOR_ID:int = 205794;

    private var pointNum:uint = 2;

    private var camera:MovieClip;

    private var ghost:MovieClip;

    private var maskMc:MovieClip;

    private var bgMc:MovieClip;

    private var closeBtn:SimpleButton;

    private var pointList:Vector.<Point>;

    public function MapProcessor_80464(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.pointList = new Vector.<Point>();
        this.getPoint();
        this.initMouse();
        this.initUI();
    }

    override public function dispose():void {
        super.dispose();
        Tick.instance.removeTimeout(this.clear);
        this.stopMove();
    }

    private function initMouse():void {
        _map.content.stage.addEventListener(MouseEvent.MOUSE_MOVE, this.moveCamera);
    }

    private function getPoint():void {
        var _loc1_:int = 0;
        var _loc2_:Point = null;
        if (this.pointList.length != this.pointNum) {
            _loc1_ = 0;
            while (_loc1_ < 8) {
                _loc2_ = new Point();
                _loc2_.x = Math.floor(760 * Math.random()) + 100;
                _loc2_.y = Math.floor(360 * Math.random()) + 100;
                this.pointList.push(_loc2_);
                _loc1_++;
            }
        } else {
            _loc1_ = 0;
            while (_loc1_ < this.pointNum) {
                _loc2_ = this.pointList[_loc1_];
                _loc2_.x = Math.floor(760 * Math.random()) + 100;
                _loc2_.y = Math.floor(360 * Math.random()) + 100;
                _loc1_++;
            }
        }
    }

    private function stopMove():void {
        if (_map.content.stage) {
            _map.content.stage.removeEventListener(MouseEvent.MOUSE_MOVE, this.moveCamera);
        }
    }

    private function initUI():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        ActorManager.hideActor();
        this.camera = _map.front["cameraMc"];
        this.closeBtn = _map.front["closeBtn"];
        this.closeBtn.addEventListener(MouseEvent.CLICK, this.onClose);
        this.maskMc = _map.front["maskMc"];
        this.bgMc = _map.front["bgMc"];
        this.ghost = this.camera["ghostMc"];
        this.ghost.gotoAndStop(1);
        this.ghost.visible = false;
        this.camera.addEventListener(MouseEvent.CLICK, this.reqResult);
    }

    private function onClose(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        AlertManager.showConfirm("确认结束游戏吗？结束会扣除本次使用的相机哦.", function ():void {
            SwapManager.swapItem(3976, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                SceneManager.changeScene(SceneType.LOBBY, 70);
                ModuleManager.showAppModule("BlackShootingPanel");
            });
        });
    }

    protected function reqResult(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (!this.ghost.visible) {
            return;
        }
        this.ghost.stop();
        SwapManager.swapItem(this.SWAP_RANDOM_ID, 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            new SwapInfo(data);
            ActiveCountManager.requestActiveCount(FOR_ID, function (param1:int, param2:int):void {
                var type:int = param1;
                var count:int = param2;
                if (count != 0) {
                    stopMove();
                    ModuleManager.addEventListener("BlackShootingResultPanel", ModuleEvent.HIDE, startMove);
                    ModuleManager.toggleModule(URLUtil.getAppModule("BlackShootingResultPanel"), "", count);
                } else {
                    DayLimitManager.getDoCount(DAY_ID, function (param1:int):void {
                        if (param1 >= 10) {
                            ModuleManager.showAppModule("BlackShootingOverPanel");
                        } else {
                            ServerMessager.addMessage("获得1个【黑影】");
                        }
                    });
                }
                ghost.gotoAndStop(1);
                ghost.visible = false;
                getPoint();
            });
        });
    }

    private function startMove(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("BlackShootingResultPanel", ModuleEvent.HIDE, this.startMove);
        this.initMouse();
    }

    private function moveCamera(param1:MouseEvent):void {
        this.camera.x = this.maskMc.x = param1.stageX;
        this.camera.y = this.maskMc.y = param1.stageY;
        if (this.ghost.visible) {
            return;
        }
        if (Math.random() > 0.5) {
            return;
        }
        var _loc2_:int = 0;
        while (_loc2_ < this.pointNum) {
            if (this.camera.hitTestPoint(this.pointList[_loc2_].x, this.pointList[_loc2_].y)) {
                this.showGhost();
                break;
            }
            _loc2_++;
        }
    }

    private function showGhost():void {
        this.ghost.visible = true;
        MovieClipUtil.playMc(this.ghost, 1, this.ghost.totalFrames, this.clear);
    }

    private function clear():void {
        Tick.instance.removeTimeout(this.clear);
        this.ghost.visible = false;
        this.ghost.gotoAndStop(1);
        this.getPoint();
    }
}
}
