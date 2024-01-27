package com.taomee.seer2.app.processor.activity.nextyearActivity {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.scene.SceneManager;

public class NextyearActivity {


    private var _map:MapModel;

    private var _activityThis:ActivityThis;

    private var _activityFriend:ActivityFriend;

    public function NextyearActivity(param1:MapModel) {
        super();
        this._map = param1;
        this.init();
    }

    private function init():void {
        if (SceneManager.active.mapID == ActorManager.actorInfo.id) {
            this.initThis();
        } else {
            this.initFriend();
        }
    }

    private function initThis():void {
        this._activityThis = new ActivityThis(this._map);
    }

    private function initFriend():void {
        this._activityFriend = new ActivityFriend(this._map);
    }

    public function dispose():void {
        if (this._activityThis) {
            this._activityThis.dispose();
        }
        this._activityThis = null;
        if (this._activityFriend) {
            this._activityFriend.dispose();
        }
        this._activityFriend = null;
        this._map = null;
    }
}
}
