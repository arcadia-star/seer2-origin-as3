package com.taomee.seer2.app.entity.handler {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class HandlerChangePlant extends HandlerEntityClick {


    private var _targetMapId:uint;

    public function HandlerChangePlant() {
        super();
    }

    override public function initData(param1:XML):void {
        this._targetMapId = uint(param1.toString());
    }

    override protected function action():void {
        SceneManager.changeScene(SceneType.PLANT, ActorManager.actorInfo.id);
    }
}
}
