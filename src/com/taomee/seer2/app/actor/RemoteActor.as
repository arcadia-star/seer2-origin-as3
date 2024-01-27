package com.taomee.seer2.app.actor {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.gameRule.data.MapUser;
import com.taomee.seer2.app.gameRule.data.MapUserStatusEvent;
import com.taomee.seer2.app.gameRule.util.MapUserStatusType;
import com.taomee.seer2.app.manager.MapUserStatusManager;
import com.taomee.seer2.core.entity.AnimateElement;
import com.taomee.seer2.core.utils.URLUtil;

public class RemoteActor extends Actor {


    private var _bufferMark:AnimateElement;

    private var _isFighting:Boolean;

    public function RemoteActor(param1:UserInfo) {
        super(param1);
        this.initEventListener();
    }

    private function initEventListener():void {
        MapUserStatusManager.addEventListener(MapUserStatusEvent.UPDATE, this.onUserStatusUpdate);
    }

    private function onUserStatusUpdate(param1:MapUserStatusEvent):void {
        var _loc2_:MapUser = param1.statusUser;
        if (_loc2_.userInfo.id == getInfo().id) {
            this.removeActorBuffer();
            this.addActorBuffer(_loc2_.status);
            this.updateFighting(_loc2_.status);
        }
    }

    private function addActorBuffer(param1:int):void {
        var _loc2_:String = "";
        if (param1 == MapUserStatusType.FIGHT) {
            _loc2_ = "fighting";
        } else if (param1 == MapUserStatusType.GAME) {
            _loc2_ = "game";
        }
        if (_loc2_ != "") {
            this._bufferMark = new AnimateElement();
            this._bufferMark.resourceUrl = URLUtil.getMapDecorationSwf(_loc2_);
            this._bufferMark.y = -(this.height > 100 ? this.height : 100) + 10;
            addChild(this._bufferMark);
        }
    }

    private function removeActorBuffer():void {
        if (this._bufferMark) {
            removeChild(this._bufferMark);
            this._bufferMark.dispose();
            this._bufferMark = null;
        }
    }

    private function disposeEventListener():void {
        MapUserStatusManager.removeEventListener(MapUserStatusEvent.UPDATE, this.onUserStatusUpdate);
    }

    private function updateFighting(param1:int):void {
        if (param1 == MapUserStatusType.FIGHT) {
            this._isFighting = true;
        } else {
            this._isFighting = false;
        }
    }

    public function get isFighting():Boolean {
        return this._isFighting;
    }

    override public function update():void {
        if (this._bufferMark != null) {
            this._bufferMark.update();
        }
        super.update();
    }

    override public function dispose():void {
        this.removeActorBuffer();
        this.disposeEventListener();
        super.dispose();
    }
}
}
