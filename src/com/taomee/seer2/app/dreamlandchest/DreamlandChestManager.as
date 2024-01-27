package com.taomee.seer2.app.dreamlandchest {
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class DreamlandChestManager {

    private static var homeObj:Array = [{
        "mapID": 80421,
        "objs": ["coralCartoon", "crab"]
    }, {
        "mapID": 80422,
        "objs": ["funnyFace", "hor", "mainCartoon"]
    }, {
        "mapID": 80423,
        "objs": ["fruits", "bigMushroom", "mushroomObver", "mushroomUnder"]
    }, {
        "mapID": 80424,
        "objs": ["ligthFlowerLeft", "lutosFlower"]
    }, {
        "mapID": 80425,
        "objs": ["ugrySwarn", "funnyFace"]
    }, {
        "mapID": 80426,
        "objs": ["flower1", "flower2", "flower3", "flower4", "flower5"]
    }, {
        "mapID": 80427,
        "objs": ["blowBubble", "seaSnail"]
    }, {
        "mapID": 80428,
        "objs": ["adBoard", "trigger1", "light2"]
    }, {
        "mapID": 80429,
        "objs": ["cabinLight", "wcFacia"]
    }, {
        "mapID": 80430,
        "objs": ["funnyFlower", "teapot"]
    }, {
        "mapID": 80431,
        "objs": ["pipe1", "pipe2"]
    }, {
        "mapID": 80432,
        "objs": ["bing", "bing1"]
    }, {
        "mapID": 80433,
        "objs": ["icecream", "sceneMc", "duck", "ladder"]
    }, {
        "mapID": 80434,
        "objs": ["winnower", "flowerClick"]
    }, {
        "mapID": 80435,
        "objs": ["zhuaMC", "mechineMc"]
    }];

    private static const DAY_LIST:Array = [5010, 5011, 5012, 5013, 5014];

    private static var _map:MapModel;

    private static var mapID:int;

    private static var contentMc:MovieClip;

    private static var talkMc:MovieClip;

    private static var wordMc:MovieClip;

    private static var dateLimit:Array = [[2016, 2, 12, 13, 0], [2016, 2, 18, 13, 30]];


    public function DreamlandChestManager() {
        super();
    }

    private static function getHomeIdx(param1:int):int {
        var _loc2_:int = 0;
        while (_loc2_ < homeObj.length) {
            if (param1 == homeObj[_loc2_]["mapID"]) {
                return _loc2_;
            }
            _loc2_++;
        }
        return -1;
    }

    public static function getRandomObj():Array {
        var _loc2_:Object = null;
        var _loc3_:int = 0;
        var _loc4_:int = 0;
        var _loc5_:int = 0;
        var _loc1_:Array = new Array();
        while (_loc1_.length >= 5) {
            _loc2_ = new Object();
            _loc3_ = int(Math.random() * homeObj.length);
            _loc4_ = int(homeObj[_loc3_].objs.length);
            _loc2_["mapID"] = homeObj[_loc3_].mapID;
            _loc2_["obj"] = homeObj[_loc3_].objs[_loc4_];
            _loc5_ = 0;
            while (_loc5_ < _loc1_.length) {
                if (_loc2_["mapID"] != _loc1_[_loc5_]["mapID"]) {
                    _loc1_.push(_loc2_);
                }
                _loc5_++;
            }
            if (_loc1_.length <= 0) {
                _loc1_.push(_loc2_);
            }
        }
        return _loc1_;
    }

    public static function init(param1:MapModel):void {
        _map = param1;
        mapID = param1.id;
        contentMc = param1.content as MovieClip;
        if (getHomeIdx(mapID) == -1) {
            return;
        }
        QueueLoader.load(URLUtil.getActivityAnimation("dreamlandchest/DreamlandChestAnimation"), LoadType.SWF, onResLoaded);
    }

    private static function onResLoaded(param1:ContentInfo):void {
        var info:ContentInfo = param1;
        var talkMainMc:Sprite = info.content as Sprite;
        talkMc = talkMainMc["talkMc"];
        wordMc = talkMainMc["wordMc"];
        var date:Date = new Date(TimeManager.getPrecisionServerTime() * 1000);
        var serTime:Number = TimeManager.getServerTime() * 1000;
        var startDate:Date = new Date(date.fullYear, date.month, date.date, dateLimit[0][3], dateLimit[0][4]);
        var endDate:Date = new Date(date.fullYear, date.month, date.date, dateLimit[1][3], dateLimit[1][4]);
        if (DateUtil.isInMonthDayScope(dateLimit[0][1] - 1, dateLimit[0][2], dateLimit[1][1] - 1, dateLimit[1][2])) {
            if (serTime >= startDate.getTime() && serTime <= endDate.getTime()) {
                DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                    var info:DayLimitListInfo = param1;
                    if (info.getCount(DAY_LIST[0]) > 0) {
                        _map.front.addChildAt(wordMc, _map.front.numChildren);
                        MovieClipUtil.playMc(wordMc, 2, wordMc.totalFrames, function ():void {
                            DisplayObjectUtil.removeFromParent(wordMc);
                            var _loc1_:int = getHomeIdx(mapID);
                            var _loc2_:int = int(Math.random() * homeObj[_loc1_]["objs"].length);
                            var _loc3_:String = String(homeObj[_loc1_]["objs"][_loc2_]);
                            if (contentMc[_loc3_]) {
                                if (_loc3_ == "pipe1" || _loc3_ == "pipe2") {
                                    (contentMc[_loc3_] as MovieClip).gotoAndStop(1);
                                }
                                contentMc[_loc3_].addEventListener(MouseEvent.CLICK, onSwap);
                            }
                        });
                    }
                });
            }
        }
    }

    private static function onSwap(param1:MouseEvent):void {
        var childIdx:int;
        var e:MouseEvent = param1;
        e.currentTarget.removeEventListener(MouseEvent.CLICK, onSwap);
        childIdx = _map.front.numChildren - 1 < 0 ? 0 : int(_map.front.numChildren - 1);
        _map.front.addChildAt(talkMc, childIdx);
        RightToolbarConter.instance.hide();
        MovieClipUtil.playMc(talkMc, 2, talkMc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(talkMc);
            RightToolbarConter.instance.show();
            SceneManager.changeScene(SceneType.LOBBY, 70);
            ModuleManager.showAppModule("DreamlandChestGamePanel", {"map_ID": mapID});
        });
    }

    public static function dispose():void {
    }
}
}
