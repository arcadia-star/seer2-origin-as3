package com.taomee.seer2.app.animationInteractive {
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.ui.Mouse;

import org.taomee.utils.Tick;

public class DigStoneAnimation extends BaseAniamationInteractive {


    private var _scoreMC:MovieClip;

    private var _aniVec:Vector.<MovieClip>;

    private var _stoneContener:MovieClip;

    private var _stoneVec:Vector.<Stone>;

    private var _hammer:MovieClip;

    private var _score:int;

    private var _timerCnt:int;

    private var _timerTenMC:MovieClip;

    private var _timerDigitMC:MovieClip;

    private var _count:int;

    public function DigStoneAnimation() {
        super();
    }

    override protected function paramAnimation():void {
        var _loc3_:MovieClip = null;
        var _loc4_:Stone = null;
        this._scoreMC = _animation["scoreMC"];
        this._stoneContener = _animation["stoneContener"];
        this._hammer = getMovieClip("hammer");
        this._hammer.gotoAndStop(1);
        this._hammer.mouseEnabled = false;
        this._hammer.mouseChildren = false;
        _animation.addChild(this._hammer);
        this._aniVec = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            _loc3_ = _animation["ani_" + _loc1_];
            _loc3_.gotoAndStop(1);
            this._aniVec.push(_loc3_);
            _loc1_++;
        }
        this._stoneVec = new Vector.<Stone>();
        var _loc2_:int = 0;
        while (_loc2_ < 6) {
            _loc4_ = new Stone(_animation["stone_" + _loc2_], this.onClick, _loc2_);
            this._stoneVec.push(_loc4_);
            _loc2_++;
        }
        this._timerTenMC = _animation["timeTenMC"];
        this._timerDigitMC = _animation["timeDigitMC"];
        _animation.addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        this.reset();
    }

    private function reset():void {
        this._score = 0;
        this._count = 0;
        this._timerCnt = 60;
        this._stoneContener.gotoAndStop(1);
        this._scoreMC.gotoAndStop(1);
        Tick.instance.addRender(this.onTimer, 1000);
        this.changeTime();
        var _loc1_:int = 0;
        while (_loc1_ < this._stoneVec.length) {
            this._stoneVec[_loc1_].reset();
            _loc1_++;
        }
    }

    private function changeTime():void {
        var _loc1_:String = "0" + this._timerCnt.toString();
        this._timerTenMC.gotoAndStop(int(_loc1_.substr(_loc1_.length - 2, 1)) + 1);
        this._timerDigitMC.gotoAndStop(int(_loc1_.substr(_loc1_.length - 1, 1)) + 1);
    }

    private function onEnterFrame(param1:Event):void {
        this._hammer.x = LayerManager.topLayer.mouseX - 150;
        this._hammer.y = LayerManager.topLayer.mouseY;
    }

    private function onTimer(param1:int):void {
        --this._timerCnt;
        this.changeTime();
        if (this._timerCnt <= 0) {
            this.dispose();
        }
    }

    private function onClick(param1:int, param2:int, param3:int):void {
        var clickNum:int = param1;
        var type:int = param2;
        var index:int = param3;
        this._hammer.gotoAndStop(2);
        _animation.mouseEnabled = false;
        _animation.mouseChildren = false;
        this._hammer.addFrameScript(1, function ():void {
            _hammer.addFrameScript(1, null);
            MovieClipUtil.playMc(_hammer["mc"], 1, _hammer["mc"].totalFrames, function ():void {
                var stone:MovieClip = null;
                _animation.mouseEnabled = true;
                _animation.mouseChildren = true;
                _stoneVec[index].gotoAndStop(clickNum + 1);
                if (clickNum == 4) {
                    stone = getMovieClip("stone");
                    _stoneVec[index].addStone(stone);
                } else if (clickNum == 5) {
                    if (type == 2) {
                        _score += 5;
                    } else {
                        _score += type + 1;
                    }
                    _scoreMC.gotoAndStop(_score + 1);
                    _stoneVec[index].hide();
                    ++_count;
                    MovieClipUtil.playMc(_aniVec[type], 1, _aniVec[type].totalFrames, function ():void {
                        if (_score >= 10) {
                            _stoneContener.gotoAndStop(4);
                            _isSuccess = true;
                            dispose();
                        } else if (_score >= 6) {
                            _stoneContener.gotoAndStop(3);
                        } else {
                            _stoneContener.gotoAndStop(2);
                        }
                        if (_count >= 6 && _score < 10) {
                            Tick.instance.removeRender(onTimer);
                            AlertManager.showConfirm("没有挖到足够的宝石，继续加油！", function ():void {
                                reset();
                            }, function ():void {
                                dispose();
                            });
                        }
                    });
                }
            });
        });
    }

    override public function dispose():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._stoneVec.length) {
            this._stoneVec[_loc1_].dispose();
            _loc1_++;
        }
        Tick.instance.removeRender(this.onTimer);
        _animation.removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
        Mouse.show();
        super.dispose();
    }
}
}

import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.NumberUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

class Stone {


    private var _mc:MovieClip;

    private var _clickNum:int;

    private var _clickHandler:Function;

    private var _type:int;

    private var _stone:MovieClip;

    private var _index:int;

    public function Stone(param1:MovieClip, param2:Function, param3:int) {
        super();
        this._mc = param1;
        this._clickHandler = param2;
        this._index = param3;
        this._mc.addEventListener(MouseEvent.CLICK, this.onClick);
        this.reset();
    }

    public function addStone(param1:MovieClip):void {
        this._stone = param1;
        this._stone.gotoAndStop(this._type + 1);
        this._mc.addChild(this._stone);
    }

    public function gotoAndStop(param1:int):void {
        this._mc.gotoAndStop(param1);
    }

    public function reset():void {
        this._clickNum = 0;
        this._mc.visible = true;
        this._mc.gotoAndStop(1);
        DisplayObjectUtil.removeFromParent(this._stone);
    }

    private function onClick(param1:MouseEvent):void {
        var _loc2_:Number = NaN;
        ++this._clickNum;
        if (this._clickNum == 4) {
            _loc2_ = Number(NumberUtil.random(0, 1000));
            if (_loc2_ <= 500) {
                this._type = 0;
            } else if (_loc2_ <= 800) {
                this._type = 1;
            } else {
                this._type = 2;
            }
        }
        this._clickHandler(this._clickNum, this._type, this._index);
    }

    public function hide():void {
        this._mc.visible = false;
    }

    public function dispose():void {
        if (this._mc) {
            this._mc.removeEventListener(MouseEvent.CLICK, this.onClick);
            DisplayObjectUtil.removeFromParent(this._mc);
            this._clickHandler = null;
            this._mc = null;
        }
    }
}
