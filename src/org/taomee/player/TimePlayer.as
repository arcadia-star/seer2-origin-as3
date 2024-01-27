package org.taomee.player {
public class TimePlayer {


    protected var _repeatCount:uint;

    protected var _totalFrames:uint;

    protected var _currentFrame:uint;

    protected var _time:uint;

    protected var _position:Number = 0;

    protected var _timeRate:uint = 40;

    protected var _duration:uint;

    protected var _totalTime:uint;

    public function TimePlayer(param1:uint = 40) {
        super();
        this._timeRate = param1;
    }

    public function reset():void {
        this._currentFrame = 0;
        this._time = 0;
        this._position = 0;
    }

    public function get totalFrames():uint {
        return this._totalFrames;
    }

    public function get currentFrame():uint {
        return this._currentFrame;
    }

    public function get time():uint {
        return this._time;
    }

    public function get position():Number {
        return this._position;
    }

    public function get duration():uint {
        return this._duration;
    }

    public function get repeatCount():uint {
        return this._repeatCount;
    }

    public function get timeRate():uint {
        return this._timeRate;
    }

    public function set timeRate(param1:uint):void {
        this._timeRate = param1;
        this.setTotalTime();
    }

    public function set duration(param1:uint):void {
        this._duration = param1;
        this.setTotalTime();
    }

    public function set repeatCount(param1:uint):void {
        this._repeatCount = param1;
        this.setTotalTime();
    }

    public function set currentFrame(param1:uint):void {
        if (this._currentFrame == param1) {
            return;
        }
        this._currentFrame = param1;
        if (this._totalFrames > 0) {
            if (this._currentFrame >= this._totalFrames) {
                this._currentFrame = this._totalFrames - 1;
            }
            this.update();
        }
    }

    public function setInterval(param1:uint):Boolean {
        this._time += param1;
        return this.setTime(this._time);
    }

    public function setTime(param1:uint):Boolean {
        this._time = param1;
        if (this._duration > 0) {
            if (this._time >= this._duration) {
                this._position = 1;
                return true;
            }
            this._position = this._time / this._duration;
        } else if (this._totalTime > 0) {
            if (this._repeatCount > 0) {
                if (this._time >= this._totalTime) {
                    this._position = 1;
                    return true;
                }
            }
            this._position = this._time / this._totalTime;
        }
        this.updateForTime();
        return false;
    }

    public function set position(param1:Number):void {
        if (param1 > 1) {
            param1 = 1;
        } else if (param1 < 0) {
            param1 = 0;
        }
        this._position = param1;
        if (this._duration > 0) {
            this._time = this._position * this._duration;
            this.updateForTime();
        } else if (this._totalTime > 0) {
            this._time = this._position * this._totalTime;
            this.updateForTime();
        }
    }

    protected function setTotalTime():void {
        if (this._duration > 0) {
            if (this._repeatCount > 0) {
                this._totalTime = this._duration / this._repeatCount;
            } else {
                this._totalTime = this._totalFrames * this._timeRate;
            }
        } else if (this._totalFrames > 0) {
            this._totalTime = this._totalFrames * this._timeRate;
        }
    }

    protected function updateForTime():void {
        var _loc1_:uint = 0;
        if (this._totalFrames > 0) {
            _loc1_ = Math.round(this._time % this._totalTime / this._totalTime * this._totalFrames);
            if (_loc1_ >= this._totalFrames) {
                _loc1_ = this._totalFrames - 1;
            }
            if (this._currentFrame == _loc1_) {
                return;
            }
            this._currentFrame = _loc1_;
            this.update();
        }
    }

    public function nextFrame():void {
        if (this._totalFrames > 1) {
            ++this.currentFrame;
            if (this._currentFrame == this._totalFrames) {
                this.currentFrame = 0;
            }
        }
    }

    public function prevFrame():void {
        if (this._totalFrames > 1) {
            --this.currentFrame;
            if (this._currentFrame < 0) {
                this.currentFrame = this._totalFrames - 1;
            }
        }
    }

    protected function update():void {
    }
}
}
