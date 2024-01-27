package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;
import org.taomee.utils.MathUtil;

public class LihuaAct {

    private static const MAPIDS:Array = [81, 350];

    private static var _fireCls:Class;

    private static var _hongBaoCls:Class;


    public function LihuaAct() {
        super();
    }

    public static function init():void {
        loadFireMc(null);
        Connection.addCommandListener(CommandSet.FROZEN_ACTIVITY_TYPE_1151, onBroadcast);
    }

    private static function onBroadcast(param1:MessageEvent):void {
        if (MAPIDS.indexOf(SceneManager.active.mapID) == -1) {
            return;
        }
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:uint = uint(_loc2_.readUnsignedInt());
        var _loc4_:uint = uint(_loc2_.readUnsignedInt());
        var _loc5_:uint = uint(_loc2_.readUnsignedInt());
        var _loc6_:uint = uint(_loc2_.readUnsignedInt());
        if (_loc5_ == ActorManager.actorInfo.id) {
            return;
        }
        fire(_loc3_, _loc5_);
    }

    public static function fire(param1:int, param2:int):void {
        var x:Number;
        var y:Number;
        var hongBaoY:Number;
        var fireMc:MovieClip = null;
        var mv:MovieClip = null;
        var hongBao:DisplayObject = null;
        var type:int = param1;
        var uid:int = param2;
        if (_fireCls == null) {
            loadFireMc(function ():void {
                fire(type, uid);
            });
            return;
        }
        fireMc = new _fireCls();
        fireMc.gotoAndStop(type + 1);
        mv = fireMc["mv"];
        hongBao = new _hongBaoCls();
        x = Number(MathUtil.randomRegion(300, 900));
        y = Number(MathUtil.randomRegion(48, 200));
        hongBaoY = Number(MathUtil.randomRegion(450, 550));
        SceneManager.active.mapModel.front.addChild(hongBao);
        hongBao.x = x;
        fireMc.x = x;
        fireMc.y = y;
        hongBao.y = hongBaoY;
        hongBao.visible = false;
        SceneManager.active.mapModel.front.addChild(fireMc);
        MovieClipUtil.playMc(mv, 1, mv.totalFrames, function ():void {
            DisplayUtil.removeForParent(fireMc);
            if (ActorManager.actorInfo.id != uid) {
                hongBao.visible = true;
            }
        });
        addHongaoClick(hongBao, uid);
    }

    private static function addHongaoClick(param1:DisplayObject, param2:int):void {
        var onRemove:Function = null;
        var onClick:Function = null;
        var hongbao:DisplayObject = param1;
        var uid:int = param2;
        onRemove = function (param1:Event):void {
            hongbao.removeEventListener(Event.REMOVED_FROM_STAGE, onRemove);
            hongbao.removeEventListener(MouseEvent.CLICK, onClick);
        };
        onClick = function (param1:Event):void {
            var e:Event = param1;
            DisplayUtil.removeForParent(hongbao);
            SwapManager.swapItem(4658, 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                ServerMessager.addMessage("你获得了米米号:" + uid + "燃放的礼花掉落的共享大礼哦！~祝鸡年大吉！");
            }, function (param1:uint):void {
                AlertManager.showAlert("你今天已经捡了很多红包了，明天再来吧！");
            });
        };
        hongbao.addEventListener(MouseEvent.CLICK, onClick);
    }

    private static function loadFireMc(param1:Function):void {
        var fun:Function = param1;
        if (_fireCls != null) {
            if (fun != null) {
                fun();
            }
            return;
        }
        QueueLoader.load(URLUtil.getRes("activity/animation/lihua.swf"), LoadType.SWF, function (param1:ContentInfo):void {
            _fireCls = DomainUtil.getClass("fireMc", param1.domain);
            _hongBaoCls = DomainUtil.getClass("hongBao", param1.domain);
            if (fun != null) {
                fun();
            }
        });
    }
}
}
