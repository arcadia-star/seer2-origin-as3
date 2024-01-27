package com.taomee.seer2.app.processor.shoot {
import com.taomee.seer2.app.shoot.BaseShoot;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootHitEffect;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.core.cache.ShootCache;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.GeomUtil;

public class Type_011 extends BaseShoot {


    private var _speedPos:Point;

    private var _moveEffect:MovieClip;

    private var _hitEffect:ShootHitEffect;

    public function Type_011() {
        super();
    }

    override public function execute(param1:ShootInfo):void {
        super.execute(param1);
        this._moveEffect = ShootCache.getEffectMovieClip(_info.id, 1);
        this._moveEffect.x = _info.startPos.x;
        this._moveEffect.y = _info.startPos.y;
        this._moveEffect.mouseEnabled = false;
        this._moveEffect.mouseChildren = false;
        this._moveEffect.rotation = GeomUtil.pointAngle(_info.endPos, _info.startPos);
        SceneManager.active.mapModel.front.addChild(this._moveEffect);
        this._speedPos = GeomUtil.angleSpeed(_info.endPos, _info.startPos);
        this._speedPos.x *= param1.speed;
        this._speedPos.y *= param1.speed;
        this._moveEffect.addEventListener(Event.ENTER_FRAME, this.onMoveEffect);
    }

    private function onMoveEffect(param1:Event):void {
        var _loc2_:MovieClip = null;
        var _loc3_:MovieClip = null;
        if (Math.abs(this._moveEffect.x - _info.endPos.x) < _info.speed / 2 && Math.abs(this._moveEffect.y - _info.endPos.y) < _info.speed / 2) {
            this.disposeMoveEffect();
            ShootController.dispatchEvent(ShootEvent.PLAY_END, _info);
            _loc2_ = ShootCache.getEffectMovieClip(_info.id, 2);
            _loc3_ = ShootCache.getStateMovieClip(_info.id, 1);
            if (_loc3_ == null) {
                _loc3_ = _loc2_;
            }
            this._hitEffect = new ShootHitEffect(_loc2_, _loc3_, _info);
            if (_isHide) {
                this._hitEffect.hide();
            }
        } else {
            this._moveEffect.x += this._speedPos.x;
            this._moveEffect.y += this._speedPos.y;
        }
    }

    override public function hideEffect():void {
        super.hideEffect();
        if (this._hitEffect) {
            this._hitEffect.hide();
        }
    }

    private function disposeMoveEffect():void {
        if (this._moveEffect) {
            this._moveEffect.removeEventListener(Event.ENTER_FRAME, this.onMoveEffect);
            DisplayUtil.removeForParent(this._moveEffect);
            this._moveEffect = null;
        }
    }

    private function disposeHitEffect():void {
        if (this._hitEffect) {
            this._hitEffect.dispose();
            this._hitEffect = null;
        }
    }

    override public function dispose():void {
        super.dispose();
        this.disposeMoveEffect();
        this.disposeHitEffect();
        this._speedPos = null;
    }
}
}
