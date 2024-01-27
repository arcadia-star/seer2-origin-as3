package com.taomee.seer2.app.home.garbage {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.common.MovieClipPlayer;
import com.taomee.seer2.app.config.TimeLimitConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1051;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.ResourceLibrary;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class HomeGarbage extends Sprite {


    private var _resLib:ResourceLibrary;

    private var _data:HomeGarbageData;

    private var _garbageMc:MovieClip;

    private var _recycleMc:MovieClip;

    private var _coinsMc:MovieClip;

    private var _movieClipPlayer:MovieClipPlayer;

    public function HomeGarbage(param1:HomeGarbageData, param2:ResourceLibrary) {
        super();
        this._data = param1;
        this._resLib = param2;
        this._garbageMc = param2.getMovieClip(this._data.type);
        if (this._garbageMc) {
            this._movieClipPlayer = new MovieClipPlayer();
            this.x = this._data.pos.x;
            this.y = this._data.pos.y;
            this.mouseChildren = false;
            this.enable = true;
            this.addEventListener(MouseEvent.CLICK, this.onClick);
            this.addChild(this._garbageMc);
        }
    }

    public function set enable(param1:Boolean):void {
        this.mouseEnabled = param1;
        this.buttonMode = param1;
    }

    private function onClick(param1:MouseEvent):void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_245);
        this._recycleMc = this._resLib.getMovieClip("recyle");
        this.addChild(this._recycleMc);
        this._movieClipPlayer.playMc(this._recycleMc, 1, null, false, this.onRecyclePlayEnd);
        dispatchEvent(new Event(Event.OPEN));
    }

    private function onRecyclePlayEnd():void {
        if (TimeLimitConfig.InLimitTime(261)) {
            ActiveCountManager.requestActiveCountList([205827, 206014], function (param1:Parser_1142):void {
                if (param1.infoVec[1] == 1) {
                    if (param1.infoVec[0] - TimeManager.getPrecisionServerTime() > 0) {
                        ServerMessager.addMessage("辛苦啦，休息一会再继续打扫吧~");
                        ModuleManager.showAppModule("AllSkillStudyBoyGetScorePanel", {"idx": 1});
                    }
                }
            });
        }
        DisplayObjectUtil.removeFromParent(this._garbageMc);
        DisplayObjectUtil.removeFromParent(this._recycleMc);
        ItemManager.addEventListener1(ItemEvent.SERVER_ITEM_GIVEN, this.onServerItemGiven);
        Connection.send(CommandSet.HOME_GARBAGE_CLEAN_1123);
    }

    private function onServerItemGiven(param1:ItemEvent):void {
        ItemManager.removeEventListener1(ItemEvent.SERVER_ITEM_GIVEN, this.onServerItemGiven);
        var _loc2_:Parser_1051 = param1.content as Parser_1051;
        if (_loc2_.cmdId == 1123 && _loc2_.itemDes[0].referenceId == 1) {
            this._coinsMc = this._resLib.getMovieClip("Animation_" + _loc2_.itemDes[0].quantity);
            this.addChild(this._coinsMc);
            this._movieClipPlayer.playMc(this._coinsMc, 1, null, false, this.onCoinsPlayEnd);
        } else {
            dispatchEvent(new Event(Event.COMPLETE));
        }
    }

    private function onCoinsPlayEnd():void {
        DisplayObjectUtil.removeFromParent(this._coinsMc);
        dispatchEvent(new Event(Event.COMPLETE));
    }

    public function dispose():void {
        this.removeEventListener(MouseEvent.CLICK, this.onClick);
        ItemManager.removeEventListener1(ItemEvent.SERVER_ITEM_GIVEN, this.onServerItemGiven);
        this._movieClipPlayer.cancel();
        this._resLib = null;
    }
}
}
