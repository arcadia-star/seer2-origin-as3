package com.taomee.seer2.app.activity.processor.salungInvade {
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.SyncEvent;
import flash.ui.Mouse;

import org.taomee.utils.DisplayUtil;

public class SalungHostageTarget extends SalungSoldierBase {

    private static const STEP:uint = 15;

    private static const XPOS_VEC:Vector.<Number> = Vector.<Number>([38.9, 243.3, 349.2, 582.1, 812.95]);


    private var _lanzi:MovieClip;

    private var _bg:MovieClip;

    private var _progressbar:MovieClip;

    private var _isTouched:Boolean = false;

    private var _isGameOver:Boolean = false;

    protected var _targetMc:MovieClip;

    protected var _angle:Number;

    protected var _type:uint;

    public var hasWard:Boolean = true;

    public function SalungHostageTarget(param1:uint = 0) {
        super(param1);
        loadRes("SalungHostage");
    }

    override protected function onResLoaded(param1:ContentInfo = null):void {
        if (_mapId != 0 && SceneManager.active.mapID != _mapId) {
            return;
        }
        if (_info == null) {
            _info = param1;
        }
        initNpc();
    }

    override protected function initGame(param1:MouseEvent):void {
        super.initGame(null);
        this._bg = new (_info.domain.getDefinition("SalungHostageUI"))();
        addChild(this._bg);
        this.createTarget();
        addEventListener(Event.ENTER_FRAME, this.move);
        this._progressbar = new (_info.domain.getDefinition("progressBar"))();
        addChild(this._progressbar);
        this._progressbar.gotoAndStop(this._progressbar.totalFrames);
        this._progressbar.x = 648.5;
        this._progressbar.y = 10;
        this._lanzi = new (_info.domain.getDefinition("Lanzi"))();
        this._lanzi.x = 480;
        this._lanzi.y = 380;
        addChild(this._lanzi);
        Mouse.hide();
    }

    private function createTarget():void {
        if (this._isGameOver) {
            return;
        }
        if (this._targetMc) {
            this.removeChild(this._targetMc);
            this._targetMc["mc1"].stop();
            this._targetMc["mc2"].stop();
        }
        this._isTouched = false;
        this._type = int(Math.random() * 100000 % 5);
        this.initUI();
        this.initPisition();
        if (this._type == 0) {
            this._targetMc["mc1"].addFrameScript(this._targetMc["mc1"].totalFrame - 1, function ():void {
                _targetMc["mc1"].stop();
                _targetMc["mc2"].stop();
                createTarget();
            });
        }
    }

    private function clickHandler(param1:Event = null):void {
        if (this._isTouched) {
            return;
        }
        if (this._type != 0) {
            if (this._targetMc.hitTestObject(this._lanzi["touchArea"])) {
                this._isTouched = true;
                this.playMc(2);
                this._progressbar.gotoAndStop(this._progressbar.currentFrame - 2);
            }
        } else if (this._targetMc["mc1"]["target"].hitTestObject(this._lanzi["touchArea"])) {
            this._isTouched = true;
            this.playMc(2);
            this._progressbar.gotoAndStop(this._progressbar.currentFrame + 4);
        }
    }

    override protected function initUI():void {
        this._targetMc = this.getMovie();
        addChild(this._targetMc);
        this.playMc(1);
    }

    private function initPisition():void {
        var _loc1_:uint = Math.random() * 10000 % 5;
        this._targetMc.x = XPOS_VEC[_loc1_];
        this._targetMc.y = -this._targetMc.height;
    }

    private function getMovie():MovieClip {
        var _loc1_:MovieClip = null;
        if (this._type == 1) {
            _loc1_ = new (_info.domain.getDefinition("st1"))();
        } else if (this._type == 2) {
            _loc1_ = new (_info.domain.getDefinition("st2"))();
        } else if (this._type == 3) {
            _loc1_ = new (_info.domain.getDefinition("st3"))();
        } else if (this._type == 4) {
            _loc1_ = new (_info.domain.getDefinition("st4"))();
        } else if (this._type == 0) {
            _loc1_ = new (_info.domain.getDefinition("st0"))();
        }
        return _loc1_;
    }

    private function playMc(param1:uint):void {
        var index:uint = param1;
        var i:int = 1;
        while (i <= 2) {
            this._targetMc["mc" + i].visible = false;
            this._targetMc["mc" + i].stop();
            i++;
        }
        this._targetMc["mc" + index].visible = true;
        this._targetMc["mc" + index].gotoAndPlay(1);
        if (index == 2) {
            if (this._type == 0) {
                this._targetMc["mc2"].x = this._targetMc["mc1"]["target"].x;
                this._targetMc["mc2"].y = this._targetMc["mc1"]["target"].y - 160;
            }
            this._targetMc["mc" + index].gotoAndPlay(1);
            this._targetMc["mc" + index].addFrameScript(this._targetMc["mc" + index].totalFrames - 1, function ():void {
                _targetMc["mc1"].stop();
                _targetMc["mc2"].stop();
                createTarget();
            });
        }
    }

    public function move(param1:Event):void {
        if (stage == null) {
            return;
        }
        setChildIndex(this._progressbar, numChildren - 1);
        this.clickHandler();
        this._lanzi.x = stage.mouseX;
        this._lanzi.y = stage.mouseY;
        if (this._type != 0 && !this._isTouched) {
            this._targetMc.y += STEP;
            if (this._targetMc.y > 560 && Boolean(this.parent)) {
                this.createTarget();
            }
        }
        if (this._progressbar.currentFrame <= 1) {
            this.dispose();
        }
    }

    override public function dispose():void {
        Mouse.show();
        if (this.hasWard) {
            getAward();
        }
        removeEventListener(Event.ENTER_FRAME, this.move);
        if (this._targetMc) {
            DisplayUtil.removeForParent(this._targetMc);
            this._targetMc["mc1"].stop();
            this._targetMc["mc2"].stop();
        }
        DisplayUtil.removeForParent(this._lanzi);
        DisplayUtil.removeForParent(this._bg);
        DisplayUtil.removeForParent(this._progressbar);
        DisplayUtil.removeForParent(this);
        this._isGameOver = true;
        this._targetMc = null;
        super.dispose();
        this.dispatchEvent(new SyncEvent("closeGame", true, false, [this._progressbar.currentFrame]));
    }
}
}
