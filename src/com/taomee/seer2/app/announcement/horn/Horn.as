package com.taomee.seer2.app.announcement.horn {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

public class Horn extends AbstractHorn {


    private var _hornMC:MovieClip;

    private var _groupMC:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _contentTxt:TextField;

    private var _contentMC:MovieClip;

    private var _setTimeout:uint;

    public function Horn(param1:HornInfo) {
        super(param1);
    }

    override public function onClick(param1:MouseEvent):void {
        var _loc2_:Array = null;
        var _loc3_:String = null;
        var _loc4_:Object = null;
        var _loc5_:Array = null;
        var _loc6_:String = null;
        var _loc7_:Array = null;
        var _loc8_:uint = 0;
        var _loc9_:uint = 0;
        if (_info.mouseClickType == "module") {
            _loc2_ = _info.transport.split("|");
            if (_loc2_.length > 1) {
                _loc3_ = String(_loc2_[1]);
                _loc4_ = new Object();
                _loc5_ = _loc3_.split(",");
                for each(_loc6_ in _loc5_) {
                    _loc7_ = _loc6_.split(":");
                    _loc4_[_loc7_[0]] = _loc7_[1];
                }
                ModuleManager.showModule(URLUtil.getAppModule(_loc2_[0]), "正在打开面板...", _loc4_);
            } else {
                ModuleManager.showModule(URLUtil.getAppModule(_loc2_[0]), "正在打开面板...");
            }
        } else if (_info.mouseClickType == "gotoMap") {
            _loc8_ = uint(SceneType.LOBBY);
            if ((_loc9_ = uint(_info.transport)) == 70000) {
                _loc8_ = uint(SceneType.PLANT);
                _loc9_ = ActorManager.actorInfo.id;
            }
            if (_loc9_ == 50000) {
                _loc8_ = uint(SceneType.HOME);
                _loc9_ = ActorManager.actorInfo.id;
            }
            SceneManager.changeScene(_loc8_, _loc9_);
        }
        super.onClick(param1);
    }

    override public function show():void {
        this.initTime();
        super.show();
    }

    private function initTime():void {
        var totalMinmute:uint = 0;
        var date:Date = new Date(TimeManager.getServerTime() * 1000);
        var minmute:int = date.minutes + 1;
        if (minmute > _info.minute) {
            totalMinmute = uint(minmute - _info.minute);
        } else {
            totalMinmute = 3;
        }
        this._setTimeout = setTimeout(function ():void {
            HornControl._isShowHorn = false;
            onClose(null);
        }, uint(totalMinmute * 60 * 1000));
    }

    private function removeTime():void {
        clearTimeout(this._setTimeout);
    }

    override public function onClose(param1:MouseEvent):void {
        this.removeTime();
        super.onClose(param1);
    }
}
}
