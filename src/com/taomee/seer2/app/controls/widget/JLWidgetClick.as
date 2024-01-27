package com.taomee.seer2.app.controls.widget {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.widget.core.IWidgetable;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.manager.GlobalsManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.utils.URLUtil;
import com.taomee.seer2.core.utils.Util;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.net.URLRequest;
import flash.net.navigateToURL;

public class JLWidgetClick extends Sprite implements IWidgetable {

    public static const J_L:String = "J_L";


    private var _mainUI:MovieClip;

    private var _btn:MovieClip;

    private var _mc:MovieClip;

    private var _url:String;

    public function JLWidgetClick(param1:MovieClip) {
        super();
        this._mainUI = param1;
        addChild(this._mainUI);
        this.initMC();
        this.initEventListener();
    }

    private function jumpLink():void {
        this.exec("http://dc.61.com/Question/realQ?qn_id=84");
    }

    private function initMC():void {
        this._mainUI.buttonMode = true;
    }

    private function initEventListener():void {
        this._mainUI.addEventListener(MouseEvent.CLICK, this.onWidgetClick);
    }

    private function onWidgetClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("JLPanel"), "正在打开...");
    }

    public function exec(param1:String):void {
        var _loc2_:String = null;
        var _loc3_:uint = 0;
        var _loc4_:* = null;
        var _loc5_:String = null;
        this._url = param1;
        if (this._url == "http://bbs.61.com/") {
            _loc2_ = "http://bbs.61.com/checksession/";
            _loc3_ = ActorManager.actorInfo.id;
            param1 = _loc2_ + "?username=" + _loc3_ + "&gid=" + ClientConfig.productID + "&session=" + GlobalsManager.session + "&fid=37";
            navigateToURL(new URLRequest(param1), "_blank");
        } else if (this._url == "http://jl.61.com?tad=innermedia.seer2.free.mianban") {
            _loc4_ = "http://jl.61.com/" + "?sid=" + GlobalsManager.session2 + "&uid=" + ActorManager.actorInfo.id + "&fromGameId=10";
            navigateToURL(new URLRequest(_loc4_), "_blank");
        } else if (this._url == "http://dc.61.com/Question/realQ?qn_id=84") {
            _loc5_ = "http://dc.61.com/Question/realQ?qn_id=84" + "&session=" + GlobalsManager.session + "&gameid=" + ClientConfig.productID + "&userid=" + ActorManager.actorInfo.id;
            navigateToURL(new URLRequest(_loc5_), "_blank");
        } else {
            Connection.addCommandListener(CommandSet.SESSION_1156, this.onSession);
            Connection.send(CommandSet.SESSION_1156, this.getGid(this._url));
        }
    }

    private function onSession(param1:MessageEvent):void {
        var _loc2_:String = this.getFullHex(ActorManager.actorInfo.id.toString(16)) + Util.getSessionString(param1.message.getRawData());
        var _loc3_:String = this._url + "?sid=" + _loc2_ + "&fromGameId=" + ClientConfig.productID + "&serviceType=" + GlobalsManager.serverType;
        navigateToURL(new URLRequest(_loc3_));
    }

    private function getFullHex(param1:String):String {
        if (param1.length >= 8) {
            return param1;
        }
        while (param1.length < 8) {
            param1 = "0" + param1;
        }
        return param1;
    }

    private function getGid(param1:String):uint {
        if (param1.indexOf("gf.61.com") != -1) {
            return 6;
        }
        if (param1.indexOf("seer.61.com") != -1) {
            return 2;
        }
        return 0;
    }
}
}
