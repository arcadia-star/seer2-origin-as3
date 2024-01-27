package com.taomee.seer2.app.gameRule.door.support {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.actor.events.ActorEvent;
import com.taomee.seer2.app.gameRule.core.ISupportable;
import com.taomee.seer2.app.gameRule.door.util.PVPDoorUtil;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.helper.UserInfoParseHelper;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.Direction;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.ByteArray;

public class PVPDoorSupport implements ISupportable, IDoorSupport {

    private static var _instance:PVPDoorSupport;


    protected var _supportInfo:DoorSupportInfo;

    private var _initData:Object;

    private var _map:MapModel;

    public function PVPDoorSupport() {
        super();
    }

    public static function getInstance():PVPDoorSupport {
        if (_instance == null) {
            _instance = new PVPDoorSupport();
        }
        return _instance;
    }

    public function init(param1:MapModel):void {
        this._map = param1;
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            ActorManager.addEventListener(ActorEvent.ACTOR_SYNC_SVR, this.onActorSyncSvr);
        }
    }

    private function onActorSyncSvr(param1:ActorEvent):void {
        ActorManager.removeEventListener(ActorEvent.ACTOR_SYNC_SVR, this.onActorSyncSvr);
        this.initUI();
    }

    private function initUI():void {
        var opponentId:uint = 0;
        var onGetUserSimpleInfo:Function = null;
        onGetUserSimpleInfo = function (param1:MessageEvent):void {
            var _loc4_:UserInfo = null;
            var _loc5_:Actor = null;
            var _loc2_:ByteArray = param1.message.getRawData();
            _loc2_.position = 0;
            var _loc3_:uint = _loc2_.readUnsignedInt();
            if (_loc3_ == opponentId) {
                Connection.removeCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028, onGetUserSimpleInfo);
                (_loc4_ = new UserInfo()).id = _loc3_;
                UserInfoParseHelper.readSimpleInfo(_loc4_, _loc2_);
                _initData["remoteUserInfo"] = _loc4_;
                (_loc5_ = ActorManager.getActor()).direction = Direction.RIGHT_DOWN;
                _loc5_.x = PVPDoorUtil.getSelfPosition(_supportInfo.doorRule).x;
                _loc5_.y = PVPDoorUtil.getSelfPosition(_supportInfo.doorRule).y;
                ModuleManager.toggleModule(URLUtil.getAppModule(_supportInfo.doorStartPanel), "正在打开选择出战精灵面板...", _initData);
            }
        };
        if (this._initData == null) {
            throw new Error("非正常进入地图");
        }
        opponentId = uint(this._initData["opponent"]["userId"]);
        Connection.addCommandListener(CommandSet.USER_GET_SIMPLE_INFO_1028, onGetUserSimpleInfo);
        Connection.send(CommandSet.USER_GET_SIMPLE_INFO_1028, opponentId);
    }

    public function initData(param1:Object):void {
        this._initData = param1;
        var _loc2_:String = "PVPDoorFightPanel";
        this._supportInfo = new DoorSupportInfo(this._initData["doorRule"], this._initData["doorType"], this._initData["targetMapId"], _loc2_);
    }

    public function get supportInfo():DoorSupportInfo {
        return this._supportInfo;
    }

    public function dispose():void {
        this._map = null;
    }
}
}
