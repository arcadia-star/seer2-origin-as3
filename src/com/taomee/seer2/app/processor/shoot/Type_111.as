package com.taomee.seer2.app.processor.shoot {
import com.taomee.seer2.app.shoot.BaseShoot;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.core.cache.ShootCache;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.GeomUtil;

public class Type_111 extends BaseShoot {


    private var _speedPos:Point;

    private var _ui0:MovieClip;

    private var _ui1:MovieClip;

    private var _ui2:MovieClip;

    public function Type_111() {
        super();
    }

    override public function execute(param1:ShootInfo):void {
        super.execute(param1);
        this._ui0 = ShootCache.getEffectMovieClip(_info.id, 1);
        this._ui0.x = _info.startPos.x;
        this._ui0.y = _info.startPos.y;
        this._ui0.mouseEnabled = false;
        this._ui0.mouseChildren = false;
        this._ui0.scaleX = _info.endPos.x > _info.startPos.x ? 1 : -1;
        SceneManager.active.mapModel.front.addChild(this._ui0);
        this._ui0.addEventListener(Event.ENTER_FRAME, this.onEnter0);
    }

    override public function dispose():void {
        this.disposeUI0();
        this.disposeUI1();
        super.dispose();
        if (this._ui2) {
            this._ui2.removeEventListener(Event.ENTER_FRAME, this.onEnter2);
            DisplayUtil.removeForParent(this._ui2);
            this._ui2 = null;
        }
        this._speedPos = null;
    }

    private function disposeUI0():void {
        if (this._ui0) {
            this._ui0.removeEventListener(Event.ENTER_FRAME, this.onEnter0);
            DisplayUtil.removeForParent(this._ui0);
            this._ui0 = null;
        }
    }

    private function disposeUI1():void {
        if (this._ui1) {
            this._ui1.removeEventListener(Event.ENTER_FRAME, this.onEnter1);
            DisplayUtil.removeForParent(this._ui1);
            this._ui1 = null;
        }
    }

    private function onEnter0(param1:Event):void {
        if (this._ui0.currentFrame == this._ui0.totalFrames) {
            this.disposeUI0();
            this._ui1 = ShootCache.getEffectMovieClip(_info.id, 2);
            this._ui1.x = _info.startPos.x;
            this._ui1.y = _info.startPos.y;
            this._ui1.mouseEnabled = false;
            this._ui1.mouseChildren = false;
            this._ui1.rotation = GeomUtil.pointAngle(_info.endPos, _info.startPos);
            SceneManager.active.mapModel.front.addChild(this._ui1);
            this._speedPos = GeomUtil.angleSpeed(_info.endPos, _info.startPos);
            this._speedPos.x *= _info.speed;
            this._speedPos.y *= _info.speed;
            this._ui1.addEventListener(Event.ENTER_FRAME, this.onEnter1);
        }
    }

    private function onEnter1(param1:Event):void {
        if (Math.abs(this._ui1.x - _info.endPos.x) < _info.speed / 2 && Math.abs(this._ui1.y - _info.endPos.y) < _info.speed / 2) {
            this.disposeUI1();
            ShootController.dispatchEvent(ShootEvent.PLAY_END, _info);
            this._ui2 = ShootCache.getEffectMovieClip(_info.id, 3);
            this._ui2.x = _info.endPos.x;
            this._ui2.y = _info.endPos.y;
            this._ui2.mouseEnabled = false;
            this._ui2.mouseChildren = false;
            this._ui2.addEventListener(Event.ENTER_FRAME, this.onEnter2);
            SceneManager.active.mapModel.front.addChild(this._ui2);
            return;
        }
        this._ui1.x += this._speedPos.x;
        this._ui1.y += this._speedPos.y;
    }

    private function onEnter2(param1:Event):void {
        if (this._ui2.currentFrame == this._ui2.totalFrames) {
            this.dispose();
        }
    }
}
}
