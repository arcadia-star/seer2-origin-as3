package com.taomee.seer2.app.processor.activity.devilActivity {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.rightToolbar.RightToolbarTimeCheck;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class DevilActivity {

    public static var isFight:Boolean = false;

    private static const mapIdList:Vector.<uint> = Vector.<uint>([151, 123, 100]);

    private static const pointList:Vector.<Point> = Vector.<Point>([new Point(235, 256), new Point(334, 237), new Point(192, 332)]);

    private static var _devilLoad:DevilLoad;

    private static var _npc:MovieClip;

    private static var _index:int;

    private static var _fightIndex:uint;


    public function DevilActivity() {
        super();
    }

    public static function setup():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_START, onSwitchStart);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onSwitchComplete);
    }

    private static function onSwitchComplete(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA && _fightIndex == 1 && FightManager.fightWinnerSide == FightSide.LEFT) {
            _fightIndex = 0;
            DevilActivity.isFight = true;
            ModuleManager.toggleModule(URLUtil.getAppModule("DevilPanel"), "正在打开面板...");
        }
        _index = mapIdList.indexOf(SceneManager.active.mapID);
        var _loc2_:Date = new Date(TimeManager.getServerTime() * 1000);
        if (_index != -1 && RightToolbarTimeCheck.isTimeContent("2012_8_*_13_0", "2012_8_*_14_0") && _loc2_.date != 10) {
            _devilLoad = new DevilLoad();
            _devilLoad.playLoad("devilLoad/devilLoad", onLoadComplete);
        } else if (RightToolbarTimeCheck.isTimeContent("2012_8_*_13_0", "2012_8_*_14_0") == false && _index != -1 && _loc2_.date != 10) {
            TimeManager.addEventListener(TimeManager.TIME_UPDATE, onTimeUpdate);
        }
    }

    private static function onTimeUpdate(param1:Event):void {
        if (RightToolbarTimeCheck.isTimeContent("2012_8_*_13_0", "2012_8_*_14_0")) {
            if (_devilLoad == null) {
                _devilLoad = new DevilLoad();
            }
            _devilLoad.playLoad("devilLoad/devilLoad", onLoadComplete);
        }
    }

    private static function onLoadComplete():void {
        _npc = _devilLoad.getMC("npc" + _index);
        _npc.x = pointList[_index].x;
        _npc.y = pointList[_index].y;
        SceneManager.active.mapModel.content.addChild(_npc);
        _npc.buttonMode = true;
        _npc.addEventListener(MouseEvent.CLICK, onNpc);
    }

    private static function onNpc(param1:MouseEvent):void {
        if (FightVerifyManager.validateFightStart()) {
            _fightIndex = 1;
            FightManager.startFightWithWild(131);
        }
    }

    private static function onSwitchStart(param1:SceneEvent):void {
        dispose();
    }

    public static function dispose():void {
        if (_devilLoad) {
            _devilLoad.dispose();
        }
        TimeManager.removeEventListener(TimeManager.TIME_UPDATE, onTimeUpdate);
        DisplayUtil.removeForParent(_npc);
        _devilLoad = null;
        _npc = null;
    }
}
}
