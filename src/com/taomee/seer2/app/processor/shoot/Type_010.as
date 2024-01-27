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

public class Type_010 extends BaseShoot {


    private var _speedPos:Point;

    private var _ui:MovieClip;

    public function Type_010() {
        super();
    }

    override public function execute(param1:ShootInfo):void {
        super.execute(param1);
        this._ui = ShootCache.getEffectMovieClip(_info.id, 1);
        this._ui.x = _info.startPos.x;
        this._ui.y = _info.startPos.y;
        this._ui.mouseEnabled = false;
        this._ui.mouseChildren = false;
        this._ui.rotation = GeomUtil.pointAngle(_info.endPos, _info.startPos);
        SceneManager.active.mapModel.front.addChild(this._ui);
        this._speedPos = GeomUtil.angleSpeed(_info.endPos, _info.startPos);
        this._speedPos.x *= param1.speed;
        this._speedPos.y *= param1.speed;
        this._ui.addEventListener(Event.ENTER_FRAME, this.onEnter);
    }

    override public function dispose():void {
        super.dispose();
        if (this._ui) {
            this._ui.removeEventListener(Event.ENTER_FRAME, this.onEnter);
            DisplayUtil.removeForParent(this._ui);
            this._ui = null;
        }
        this._speedPos = null;
    }

    private function onEnter(param1:Event):void {
        if (Math.abs(this._ui.x - _info.endPos.x) < _info.speed / 2 && Math.abs(this._ui.y - _info.endPos.y) < _info.speed / 2) {
            ShootController.dispatchEvent(ShootEvent.PLAY_END, _info);
            this.dispose();
            return;
        }
        this._ui.x += this._speedPos.x;
        this._ui.y += this._speedPos.y;
    }
}
}
