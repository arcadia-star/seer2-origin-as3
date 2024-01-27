package com.taomee.seer2.app.activity.processor.salungInvade {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.ui.Mouse;

import org.taomee.utils.DisplayUtil;

public class SalungShootEngine extends SalungSoldierBase {


    private var _total:uint = 0;

    private var _container:Sprite;

    private var _mouseCursor:MovieClip;

    private var _bg:MovieClip;

    private var _progressBar:MovieClip;

    public function SalungShootEngine(param1:uint) {
        super(param1);
        loadRes("SalungShoot");
    }

    override protected function onResLoaded(param1:ContentInfo = null):void {
        if (SceneManager.active.mapID != _mapId) {
            return;
        }
        if (_info == null) {
            _info = param1;
        }
        initNpc();
    }

    override protected function initGame(param1:MouseEvent):void {
        super.initGame(null);
        _npc.removeEventListener(MouseEvent.CLICK, this.initGame);
        this._bg = new (_info.domain.getDefinition("SalungShootUI"))();
        addChild(this._bg);
        this._progressBar = new (_info.domain.getDefinition("progressBar"))();
        addChild(this._progressBar);
        this._progressBar.x = 652.5;
        this._progressBar.y = 10;
        this._container = new Sprite();
        addChild(this._container);
        this.createTarget();
        this.initEventListener();
        Mouse.hide();
    }

    private function createTarget():void {
        var _loc2_:uint = 0;
        var _loc3_:ShootTarget = null;
        this._mouseCursor = new (_info.domain.getDefinition("mouseIcon"))();
        this._mouseCursor.mouseChildren = false;
        this._mouseCursor.mouseEnabled = false;
        addChild(this._mouseCursor);
        var _loc1_:int = 0;
        while (_loc1_ < 10) {
            if (_loc1_ < 2) {
                _loc2_ = 0;
            } else if (_loc1_ < 5) {
                _loc2_ = 1;
            } else if (_loc1_ < 7) {
                _loc2_ = 2;
            } else if (_loc1_ < 10) {
                _loc2_ = 3;
            }
            _loc3_ = new ShootTarget(_loc2_, this);
            this._container.addChild(_loc3_);
            _loc1_++;
        }
    }

    private function initEventListener():void {
        this.addEventListener(Event.ENTER_FRAME, this.moveHandler);
    }

    public function get contentInfo():ContentInfo {
        return _info;
    }

    public function updateProgressBar(param1:Boolean):void {
        if (param1) {
            this._progressBar.gotoAndStop(this._progressBar.currentFrame + 2);
        } else {
            this._progressBar.gotoAndStop(this._progressBar.currentFrame - 4);
        }
    }

    override public function dispose():void {
        getAward();
        Mouse.show();
        while (this._container.numChildren) {
            this._container.removeChildAt(0);
        }
        removeEventListener(Event.ENTER_FRAME, this.moveHandler);
        DisplayUtil.removeAllChild(this._container);
        DisplayUtil.removeAllChild(this);
        this._container = null;
        this._mouseCursor = null;
        this._bg = null;
        this._progressBar = null;
        super.dispose();
    }

    private function moveHandler(param1:Event):void {
        var _loc3_:ShootTarget = null;
        if (stage == null) {
            return;
        }
        setChildIndex(this._progressBar, numChildren - 1);
        this._mouseCursor.x = stage.mouseX;
        this._mouseCursor.y = stage.mouseY;
        var _loc2_:int = 0;
        while (_loc2_ < this._container.numChildren) {
            _loc3_ = this._container.getChildAt(_loc2_) as ShootTarget;
            if (_loc3_.x > 960 || _loc3_.x < -_loc3_.width || _loc3_.y < -_loc3_.height) {
                _loc3_.resetUI();
            }
            _loc3_.move();
            _loc2_++;
        }
        if (this._progressBar.currentFrame >= this._progressBar.totalFrames) {
            this.dispose();
        }
    }
}
}
