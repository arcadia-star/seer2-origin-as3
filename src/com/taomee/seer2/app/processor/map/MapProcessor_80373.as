package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.Tick;

public class MapProcessor_80373 extends MapProcessor {

    public static var gameStop:int;


    private var _npc:MovieClip;

    private var fightId:int;

    private var _leaveTime:int = 0;

    private var timet:int;

    public function MapProcessor_80373(param1:MapModel) {
        super(param1);
    }

    override public function dispose():void {
        super.dispose();
        if (_map.hasEventListener(Event.ENTER_FRAME)) {
            _map.removeEventListener(Event.ENTER_FRAME, this.onFrame2);
        }
    }

    override public function init():void {
        _map.content["movieClip1"].visible = false;
        _map.content["movieClip2"].visible = false;
        _map.content["npc1025"].visible = false;
        _map.content["lj1"].visible = false;
        _map.content["lj2"].visible = false;
        _map.content["lj3"].visible = false;
        _map.content["mouse"].mouseEnabled = false;
        _map.content["mouse"].mouseChildren = false;
        _map.content["mouse"].visible = false;
        _map.content["movieClip1"].gotoAndStop(1);
        _map.content["movieClip2"].gotoAndStop(1);
        _map.content["npc1025"].gotoAndStop(1);
        _map.content["lj1"].gotoAndStop(1);
        _map.content["lj2"].gotoAndStop(1);
        _map.content["lj3"].gotoAndStop(1);
        _map.content["mouse"].gotoAndStop(1);
        this.update();
    }

    private function update():void {
        ActiveCountManager.requestActiveCountList([205348, 205349, 205350], function (param1:Parser_1142):void {
            var _loc3_:int = 0;
            var _loc2_:int = int(param1.infoVec[0]);
            timet = param1.infoVec[1];
            var _loc4_:int = int(param1.infoVec[2]);
            var _loc5_:Array = [];
            _loc3_ = 0;
            while (_loc3_ < 4) {
                _loc5_.push(_loc2_ & Math.pow(2, _loc3_));
                _loc3_++;
            }
            gameStop = 0;
            _loc3_ = 0;
            while (_loc3_ < 4) {
                if (_loc5_[_loc3_] != 0) {
                    ++gameStop;
                }
                _loc3_++;
            }
            _leaveTime = timet - TimeManager.getPrecisionServerTime();
            if (_leaveTime > 0) {
                if (!Tick.instance.hasRender(updateTime)) {
                    Tick.instance.addRender(updateTime, 1000);
                }
            } else {
                _leaveTime = 0;
                if (gameStop == 1 && timet != 0) {
                }
                if (Tick.instance.hasRender(updateTime)) {
                    Tick.instance.removeRender(updateTime);
                }
            }
            if (gameStop == 0) {
                createNpc();
            } else if (gameStop == 1) {
                if (SceneManager.prevSceneType != SceneType.ARENA) {
                    showMovieClip();
                }
            } else if (gameStop == 2) {
                showlj();
            } else if (gameStop == 3) {
            }
        });
    }

    private function showlj():void {
        _map.content["mouse"].visible = true;
        _map.content["lj1"].visible = true;
        _map.content["lj2"].visible = true;
        _map.content["lj3"].visible = true;
        _map.content["lj1"].gotoAndStop(1);
        _map.content["lj2"].gotoAndStop(1);
        _map.content["lj3"].gotoAndStop(1);
        _map.content["lj1"].mouseChildren = false;
        _map.content["lj2"].mouseChildren = false;
        _map.content["lj3"].mouseChildren = false;
        _map.content["lj1"].buttonMode = true;
        _map.content["lj2"].buttonMode = true;
        _map.content["lj3"].buttonMode = true;
        _map.content["lj1"].addEventListener(MouseEvent.CLICK, this.onClick);
        _map.content["lj2"].addEventListener(MouseEvent.CLICK, this.onClick);
        _map.content["lj3"].addEventListener(MouseEvent.CLICK, this.onClick);
        if (!_map.hasEventListener(Event.ENTER_FRAME)) {
            _map.addEventListener(Event.ENTER_FRAME, this.onFrame2);
        }
    }

    private function showMovieClip():void {
        ActorManager.getActor().isShow = false;
        _map.content["movieClip1"].visible = true;
        _map.content["movieClip1"].gotoAndStop(1);
        MovieClipUtil.playToEnd(_map.content["movieClip1"], 1, function ():void {
            if (timet == 0) {
                SwapManager.swapItem(3552, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    SceneManager.changeScene(SceneType.LOBBY, 3833);
                    ModuleManager.showModule(URLUtil.getAppModule("ResetBuliderHomePanel"), "正在打开面板...", {"type": 0});
                    update();
                }, null, null);
            }
        });
    }

    private function showMovieClip2():void {
        _map.content["movieClip2"].visible = true;
        MovieClipUtil.playToEnd(_map.content["movieClip2"], _map.content["movieClip2"].totalFrames, function ():void {
            _map.content["movieClip2"].visible = false;
            SwapManager.swapItem(3555, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                update();
            }, null, null);
        });
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = _map.content["npc1025"];
            _map.content["npc1025"].play();
            this._npc.visible = true;
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep2Continue);
        }
    }

    private function onFrame2(param1:Event):void {
        var e:Event = param1;
        _map.content["mouse"].x = _map.content.mouseX;
        _map.content["mouse"].y = _map.content.mouseY;
        if (_map.content["lj1"].currentFrame == _map.content["lj1"].totalFrames && _map.content["lj2"].currentFrame == _map.content["lj2"].totalFrames && _map.content["lj3"].currentFrame == _map.content["lj3"].totalFrames) {
            SwapManager.swapItem(3554, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                update();
                SceneManager.changeScene(SceneType.LOBBY, 3833);
                ModuleManager.showModule(URLUtil.getAppModule("ResetBuliderHomePanel"), "正在打开面板...", {"type": 0});
            }, null, null);
            _map.content["mouse"].visible = false;
            _map.content["lj1"].visible = false;
            _map.content["lj2"].visible = false;
            _map.content["lj3"].visible = false;
            _map.content["lj1"].removeEventListener(MouseEvent.CLICK, this.onClick);
            _map.content["lj2"].removeEventListener(MouseEvent.CLICK, this.onClick);
            _map.content["lj3"].removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        if (e.target == _map.content["lj1"]) {
            _map.content["lj1"].gotoAndPlay(2);
        } else if (e.target == _map.content["lj2"]) {
            _map.content["lj2"].gotoAndPlay(2);
        } else if (e.target == _map.content["lj3"]) {
            _map.content["lj3"].gotoAndPlay(2);
        }
        if (_map.content["lj1"].currentFrame != 1 && _map.content["lj2"].currentFrame != 1 && _map.content["lj3"].currentFrame != 1) {
            SwapManager.swapItem(3554, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                SceneManager.changeScene(SceneType.LOBBY, 3833);
                ModuleManager.showModule(URLUtil.getAppModule("ResetBuliderHomePanel"), "正在打开面板...", {"type": 0});
            }, null, null);
            _map.content["mouse"].visible = false;
            _map.content["lj1"].visible = false;
            _map.content["lj2"].visible = false;
            _map.content["lj3"].visible = false;
            _map.content["lj1"].buttonMode = true;
            _map.content["lj2"].buttonMode = true;
            _map.content["lj3"].buttonMode = true;
            _map.content["lj1"].removeEventListener(MouseEvent.CLICK, this.onClick);
            _map.content["lj2"].removeEventListener(MouseEvent.CLICK, this.onClick);
            _map.content["lj3"].removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }

    private function initStep2Continue(param1:MouseEvent):void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.fightOver);
        FightManager.startFightWithWild(1427);
    }

    private function fightOver(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.fightOver);
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                ModuleManager.showModule(URLUtil.getAppModule("CuMeiMaoMainPanel"), "正在打开面板...");
            }
        }
    }

    private function updateTime(param1:int):void {
        --this._leaveTime;
        this.updateTimeShow();
        if (this._leaveTime <= 0) {
            Tick.instance.removeRender(this.updateTime);
        }
    }

    private function updateTimeShow():void {
    }

    public function styleChange(param1:int):String {
        var _loc3_:String = null;
        var _loc5_:String = null;
        var _loc2_:int = param1 / 60;
        var _loc4_:int = param1 % 60;
        if (_loc2_ <= 9) {
            _loc3_ = "0" + String(_loc2_);
        } else {
            _loc3_ = String(_loc2_);
        }
        if (_loc4_ <= 9) {
            _loc5_ = "0" + String(_loc4_);
        } else {
            _loc5_ = String(_loc4_);
        }
        return _loc3_ + ":" + _loc5_;
    }
}
}
