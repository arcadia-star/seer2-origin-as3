package com.taomee.seer2.app.actor {
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.actor.events.ActorEvent;
import com.taomee.seer2.app.cmdl.ActorMapServerBean;
import com.taomee.seer2.app.utils.BlockHelper;
import com.taomee.seer2.core.scene.BaseScene;
import com.taomee.seer2.core.utils.Direction;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.events.EventDispatcher;

import org.taomee.ds.HashMap;
import org.taomee.utils.DisplayUtil;

public class ActorManager {

    public static var actorInfo:UserInfo;

    private static var _actor:Actor;

    private static var _scene:BaseScene;

    private static var _forceHide:Boolean;

    private static var _remoteActorMap:HashMap = new HashMap();

    private static var _remoteUserBlocker:BlockHelper = new BlockHelper(showRemoteActor1, hideRemoteActor1);

    private static var _otherActorMap:HashMap = new HashMap();

    private static var _dispatcher:EventDispatcher = new EventDispatcher();


    public function ActorManager() {
        super();
    }

    public static function set forceHide(param1:Boolean):void {
        _forceHide = param1;
        showRemoteActor = param1;
    }

    public static function initialize(param1:BaseScene):void {
        _scene = param1;
    }

    public static function createRemoteActor(param1:UserInfo):RemoteActor {
        var _loc2_:RemoteActor = getRemoteActor(param1.id);
        if (_loc2_ == null) {
            _loc2_ = new RemoteActor(param1);
            _remoteActorMap.add(param1.id, _loc2_);
        }
        _loc2_.stand();
        if (_remoteUserBlocker.validate() && _scene && Boolean(_scene.mapModel)) {
            _scene.mapModel.content.addChild(_loc2_);
        }
        return _loc2_;
    }

    public static function removeRemoteActor(param1:int):void {
        var _loc2_:RemoteActor = getRemoteActor(param1);
        if (_loc2_ != null) {
            DisplayObjectUtil.removeFromParent(_loc2_);
            _loc2_.dispose();
            _remoteActorMap.remove(param1);
        }
    }

    public static function removeAllRemoteActor():void {
        _remoteActorMap.eachValue(function (param1:RemoteActor):void {
            param1.dispose();
            DisplayUtil.removeForParent(param1);
        });
        _remoteActorMap.clear();
    }

    public static function getRemoteActor(param1:int):RemoteActor {
        if (_remoteActorMap.containsKey(param1)) {
            return _remoteActorMap.getValue(param1) as RemoteActor;
        }
        return null;
    }

    public static function getAllRemoteActors():Vector.<RemoteActor> {
        return Vector.<RemoteActor>(_remoteActorMap.getValues());
    }

    public static function set showRemoteActor(param1:Boolean):void {
        if (_forceHide) {
            param1 = false;
        }
        _remoteUserBlocker.isEnable = param1;
    }

    public static function set isBlockRemoteUser(param1:Boolean):void {
        _remoteUserBlocker.isBlock = param1;
    }

    private static function showRemoteActor1():void {
        _remoteActorMap.eachValue(function (param1:RemoteActor):void {
            if (Boolean(_scene) && Boolean(_scene.mapModel)) {
                _scene.mapModel.content.addChild(param1);
                if (param1.getFollowingPet()) {
                    _scene.mapModel.content.addChild(param1.getFollowingPet());
                }
            }
        });
    }

    private static function hideRemoteActor1():void {
        _remoteActorMap.eachValue(function (param1:RemoteActor):void {
            DisplayUtil.removeForParent(param1);
            if (param1.getFollowingPet()) {
                DisplayUtil.removeForParent(param1.getFollowingPet());
            }
        });
    }

    public static function get showRemoteActor():Boolean {
        return _remoteUserBlocker.isEnable;
    }

    public static function getActor():Actor {
        if (_actor == null) {
            _actor = new Actor(actorInfo);
            _actor.stand();
        }
        return _actor;
    }

    public static function hideActor():void {
        DisplayObjectUtil.removeFromParent(_actor);
    }

    public static function update():void {
        _actor.update();
        _remoteActorMap.eachValue(function (param1:RemoteActor):void {
            param1.update();
        });
        _otherActorMap.eachValue(function (param1:RemoteActor):void {
            param1.update();
        });
    }

    public static function getActorById(param1:int):Actor {
        var _loc2_:Actor = null;
        if (param1 == ActorManager.actorInfo.id) {
            _loc2_ = ActorManager.getActor();
        } else {
            _loc2_ = ActorManager.getRemoteActor(param1);
        }
        return _loc2_;
    }

    public static function getActorByPos(param1:Number, param2:Number):Actor {
        var _loc4_:Actor = null;
        var _loc3_:Vector.<Actor> = Vector.<Actor>(_remoteActorMap.getValues());
        _loc3_.push(_actor);
        for each(_loc4_ in _loc3_) {
            if (_loc4_.hitTestPoint(param1, param2)) {
                return _loc4_;
            }
        }
        return null;
    }

    public static function addOtherActor(param1:UserInfo):RemoteActor {
        var _loc2_:RemoteActor = new RemoteActor(param1);
        _loc2_.stand();
        _loc2_.direction = Direction.LEFT_DOWN;
        _loc2_.update();
        _otherActorMap.add(param1.id, _loc2_);
        return _loc2_;
    }

    public static function removeOtherActor(param1:int):void {
        var _loc2_:RemoteActor = getOtherActor(param1);
        if (_loc2_ != null) {
            DisplayObjectUtil.removeFromParent(_loc2_);
            _loc2_.dispose();
            _otherActorMap.remove(param1);
        }
    }

    public static function getOtherActor(param1:int):RemoteActor {
        if (_otherActorMap.containsKey(param1)) {
            return _otherActorMap.getValue(param1) as RemoteActor;
        }
        return null;
    }

    public static function leaveMap():void {
        ActorManager.removeAllRemoteActor();
        ActorManager.hideActor();
    }

    public static function enterMap():void {
        ActorManager.getActor().stand();
        ActorManager.getActor().setPostion(_scene.mapModel.initialPoint);
        ActorManager.getActor().show();
        _scene.mapModel.content.addChild(ActorManager.getActor());
    }

    public static function syncToServer():void {
        ActorMapServerBean.syncToServer();
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String):void {
        if (_dispatcher.hasEventListener(param1)) {
            _dispatcher.dispatchEvent(new ActorEvent(param1));
        }
    }

    public static function hasEventListener(param1:String):Boolean {
        return _dispatcher.hasEventListener(param1);
    }
}
}
