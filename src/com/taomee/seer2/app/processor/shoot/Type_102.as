package com.taomee.seer2.app.processor.shoot {
import com.taomee.seer2.app.shoot.BaseShoot;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.core.cache.ShootCache;
import com.taomee.seer2.core.scene.SceneManager;

import flash.display.MovieClip;
import flash.events.Event;

import org.taomee.utils.DisplayUtil;

public class Type_102 extends BaseShoot {


    private var _ui:MovieClip;

    private var _ui2:MovieClip;

    public function Type_102() {
        super();
    }

    override public function execute(param1:ShootInfo):void {
        super.execute(param1);
        this._ui = ShootCache.getEffectMovieClip(_info.id, 1);
        this._ui.x = _info.startPos.x;
        this._ui.y = _info.startPos.y;
        this._ui.mouseEnabled = false;
        this._ui.mouseChildren = false;
        this._ui.scaleX = _info.endPos.x > _info.startPos.x ? 1 : -1;
        SceneManager.active.mapModel.front.addChild(this._ui);
        this._ui.addEventListener(Event.ENTER_FRAME, this.onEnter);
    }

    override public function dispose():void {
        super.dispose();
        this.disposeUI();
        if (this._ui2) {
            this._ui2.removeEventListener(Event.ENTER_FRAME, this.onEnter2);
            DisplayUtil.removeForParent(this._ui2);
            this._ui2 = null;
        }
    }

    private function disposeUI():void {
        if (this._ui) {
            this._ui.removeEventListener(Event.ENTER_FRAME, this.onEnter);
            DisplayUtil.removeForParent(this._ui);
            this._ui = null;
        }
    }

    private function onEnter(param1:Event):void {
        if (this._ui.currentFrame == this._ui.totalFrames) {
            this.disposeUI();
            ShootController.dispatchEvent(ShootEvent.PLAY_END, _info);
            this._ui2 = ShootCache.getEffectMovieClip(_info.id, 2);
            this._ui2.x = _info.endPos.x;
            this._ui2.y = _info.endPos.y;
            this._ui2.mouseEnabled = false;
            this._ui2.mouseChildren = false;
            SceneManager.active.mapModel.front.addChild(this._ui2);
            this._ui2.addEventListener(Event.ENTER_FRAME, this.onEnter2);
        }
    }

    private function onEnter2(param1:Event):void {
        if (this._ui2.currentFrame == this._ui2.totalFrames) {
            this.dispose();
        }
    }
}
}
