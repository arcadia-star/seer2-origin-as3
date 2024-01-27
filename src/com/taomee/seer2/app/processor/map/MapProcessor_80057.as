package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

import org.taomee.utils.Tick;

public class MapProcessor_80057 extends MapProcessor {


    private const RANDOM_INDEX:uint = 61;

    private var pointNum:uint = 2;

    private var camera:MovieClip;

    private var ghost:MovieClip;

    private var maskMc:MovieClip;

    private var bgMc:MovieClip;

    private var pointList:Vector.<Point>;

    public function MapProcessor_80057(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.pointList = new Vector.<Point>();
        this.getPoint();
        this.initMouse();
        this.initUI();
        StatisticsManager.sendNovice("0x1003412F");
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
        this.maskMc = _map.front["maskMc"];
        this.bgMc = _map.front["bgMc"];
        this.ghost = this.camera["ghostMc"];
        this.ghost.gotoAndStop(1);
        this.ghost.visible = false;
        this.camera.addEventListener(MouseEvent.CLICK, this.reqResult);
    }

    protected function reqResult(param1:MouseEvent):void {
        if (!this.ghost.visible) {
            return;
        }
        this.ghost.stop();
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.getResult);
        Connection.send(CommandSet.RANDOM_EVENT_1140, this.RANDOM_INDEX, 0);
    }

    private function getResult(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.getResult);
        var _loc2_:IDataInput = param1.message.getRawDataCopy();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint;
        if ((_loc4_ = uint(_loc2_.readUnsignedInt())) != 0) {
            this.stopMove();
            ModuleManager.addEventListener("LunaDevilResultPanel", ModuleEvent.HIDE, this.startMove);
            ModuleManager.toggleModule(URLUtil.getAppModule("LunaDevilResultPanel"), "", _loc4_);
        } else {
            ServerMessager.addMessage("很可惜亡灵已经走了，你动作慢了哦");
        }
        this.ghost.gotoAndStop(1);
        this.ghost.visible = false;
        this.getPoint();
    }

    private function startMove(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("LunaDevilResultPanel", ModuleEvent.HIDE, this.startMove);
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
