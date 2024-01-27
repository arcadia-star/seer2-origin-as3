package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class StarShadowShengtuManager {

    public static var ENTER_BY_PET:int = 0;

    public static var ENTER_BY_ITEM:int = 1;

    public static const CONFIG:* = {
        "3": {
            "firstMapID": 10,
            "secondMapId": 80556,
            "petId": 2565,
            "followPetId": 2562,
            "itemId": 401284,
            "buyId": 606985,
            "enterLimitID": 1964,
            "exploreFlagID": 1967,
            "enterSwapId": 4592,
            "swapItemId": 4593,
            "swapItemId1": 4594,
            "fightId": 1852,
            "preActivityIndex": 0,
            "mapName": "翘曲点"
        },
        "5": {
            "firstMapID": 50,
            "secondMapId": 80556,
            "petId": 2567,
            "followPetId": 2563,
            "itemId": 401285,
            "buyId": 606986,
            "enterLimitID": 1968,
            "exploreFlagID": 1969,
            "enterSwapId": 4603,
            "swapItemId": 4604,
            "swapItemId1": 4605,
            "fightId": 1856,
            "preActivityIndex": 3,
            "mapName": "翘曲点"
        },
        "8": {
            "firstMapID": 81,
            "secondMapId": 80579,
            "petId": 2570,
            "followPetId": 2564,
            "itemId": 401286,
            "buyId": 606987,
            "enterLimitID": 1990,
            "exploreFlagID": 1991,
            "enterSwapId": 4619,
            "swapItemId": 4620,
            "swapItemId1": 4621,
            "fightId": 1862,
            "preActivityIndex": 2,
            "mapName": "规律的翘曲"
        },
        "9": {
            "firstMapID": 81,
            "secondMapId": 80579,
            "petId": 2571,
            "followPetId": 2566,
            "itemId": 401290,
            "buyId": 607004,
            "enterLimitID": 1993,
            "exploreFlagID": 1994,
            "enterSwapId": 4627,
            "swapItemId": 4628,
            "swapItemId1": 4629,
            "fightId": 1866,
            "preActivityIndex": 4,
            "mapName": "规律的翘曲"
        },
        "10": {
            "firstMapID": 30,
            "secondMapId": 80579,
            "petId": 2572,
            "followPetId": 2568,
            "itemId": 401290,
            "buyId": 607004,
            "enterLimitID": 2008,
            "exploreFlagID": 2009,
            "enterSwapId": 4662,
            "swapItemId": 4663,
            "swapItemId1": 4664,
            "fightId": 1888,
            "preActivityIndex": 6,
            "mapName": "黏着的翘曲点"
        },
        "11": {
            "firstMapID": 40,
            "secondMapId": 80579,
            "petId": 2573,
            "followPetId": 2569,
            "itemId": 401294,
            "buyId": 607014,
            "enterLimitID": 2011,
            "exploreFlagID": 2012,
            "enterSwapId": 4670,
            "swapItemId": 4671,
            "swapItemId1": 4672,
            "fightId": 1891,
            "preActivityIndex": 7,
            "mapName": "时空翘曲点"
        }
    };

    private static var DIALOG_CONFIG:* = {
        "3": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之首影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧。"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之躯影】十分相似，或许星之躯影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之躯影！"]]]],
        "5": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之首影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧。"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之躯影】十分相似，或许星之躯影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之躯影！"]]]],
        "8": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之臂影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧。"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之臂影】十分相似，或许星之臂影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之臂影！"]]]],
        "9": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之足影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之足影】十分相似，或许星之足影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之足影！"]]]],
        "10": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之背影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧。"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之背影】十分相似，或许星之背影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之背影！"]]]],
        "11": [[[400, "小赛尔", [[0, "好强烈的时空涟漪……然而扭曲区域的影响竟然如此集中，对飞船的其他器械毫无干扰，真是神奇而诡异的现象！"]], ["进去看看！", "待会儿再说……"]]], [[400, "小赛尔", [[0, "唔……星之心影的体力好像支持不住了，翘曲点的入口似乎也变得混沌不堪……冒险进入虫洞是不明智的，选择其他的方法吧。"]], [" 投入星屑试试！", " 待会儿再说……"]]], [[400, "小赛尔", [[0, "虫洞入口似乎混沌不堪无法进入……这个翘曲点发出的电磁波及引力波特征都与【星之心影】十分相似，或许星之心影能成为打开入口的钥匙！"]], ["投入星屑试试！", "去捕捉星之心影!"]]]]
    };

    private static var _currentIndex:int = 4;

    private static var _icon:DisplayObject;

    private static var _freeEnterTimes:int = 0;


    public function StarShadowShengtuManager() {
        super();
    }

    public static function start(param1:int):void {
        _currentIndex = param1;
        if (SceneManager.active.mapID == currentConfig["firstMapID"]) {
            initFirstMap();
            return;
        }
        SceneManager.changeScene(SceneType.LOBBY, currentConfig["firstMapID"]);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
    }

    private static function onMapSwitch(param1:SceneEvent):void {
        if (SceneManager.active.type != SceneType.ARENA) {
            if (currentConfig["firstMapID"] == SceneManager.active.mapID) {
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, onMapSwitch);
                initFirstMap();
            }
        }
    }

    private static function initFirstMap():void {
        var itemIcon:IconDisplayer;
        var iconUrl:String;
        var limitId:int = 0;
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, destoryMap);
        if (_icon != null) {
            return;
        }
        itemIcon = new IconDisplayer();
        itemIcon.setBoundary(250, 250);
        iconUrl = String(URLUtil.getRes("activity/icon/starShadow/" + _currentIndex + ".swf"));
        itemIcon.setIconUrl(iconUrl);
        itemIcon["buttonMode"] = true;
        _icon = itemIcon;
        if (_currentIndex == 11) {
            _icon.x = 150;
            _icon.y = 250;
        } else {
            _icon.x = 150 + 634;
            _icon.y = 250 + 118;
        }
        _icon.addEventListener(MouseEvent.CLICK, onIconClick);
        _icon.visible = false;
        limitId = int(currentConfig["enterLimitID"]);
        DayLimitListManager.getDaylimitList([limitId], function callback(param1:DayLimitListInfo):void {
            _freeEnterTimes = param1.getCount(limitId);
            if (_icon != null) {
                _icon.visible = true;
            }
        });
        SceneManager.active.mapModel.front.addChild(_icon);
    }

    private static function onIconClick(param1:* = null):void {
        var dialogs:Array = null;
        var e:* = param1;
        if (isPetFollow && leftFreeEnterNum > 0) {
            dialogs = DIALOG_CONFIG[_currentIndex + ""][0];
        } else if (isPetFollow) {
            dialogs = DIALOG_CONFIG[_currentIndex + ""][1];
        } else {
            dialogs = DIALOG_CONFIG[_currentIndex + ""][2];
        }
        NpcDialog.showDialogs(dialogs, function ():void {
            enterSencondMap();
        }, function ():void {
            cancelEnterSencondMap();
        });
    }

    private static function enterSencondMap():void {
        var itemId:int = 0;
        var count:int = 0;
        var itemName:String = null;
        var mapName:String = null;
        var buyId:int = 0;
        if (isPetFollow && leftFreeEnterNum > 0) {
            startEnterMap(ENTER_BY_PET);
        } else {
            itemId = int(currentConfig["itemId"]);
            count = ItemManager.getItemQuantityByReferenceId(itemId);
            itemName = ItemConfig.getItemName(itemId);
            mapName = String(currentConfig["mapName"]);
            buyId = int(currentConfig["buyId"]);
            if (count >= 50) {
                AlertManager.showConfirm("您确定要投入50枚“" + itemName + "”强制打开" + mapName + "吗？", function ():void {
                    startEnterMap(ENTER_BY_ITEM);
                });
            } else {
                AlertManager.showConfirm("要投入50枚“" + itemName + "”才能强制打开" + mapName + "，目前只有" + count + "枚，确定购买吗？", function ():void {
                    var _loc1_:BuyPropInfo = new BuyPropInfo();
                    _loc1_.itemId = buyId;
                    _loc1_.iconId = itemId;
                    ShopManager.buyBagItem(_loc1_);
                });
            }
        }
    }

    private static function startEnterMap(param1:int):void {
        var type:int = param1;
        var swapId:int = int(currentConfig["enterSwapId"]);
        var catchTime:int = 0;
        if (type == ENTER_BY_PET) {
            catchTime = int(ActorManager.actorInfo.followingPetInfo.catchTime);
        }
        SwapManager.swapItem(swapId, 1, function success(param1:IDataInput):void {
            var data:IDataInput = param1;
            new SwapInfo(data);
            SceneManager.changeScene(SceneType.COPY, currentConfig["secondMapId"]);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, function (param1:SceneEvent):void {
                if (SceneManager.active.type != SceneType.ARENA) {
                    if (currentConfig["secondMapId"] == SceneManager.active.mapID) {
                        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, arguments.callee);
                        ModuleManager.showAppModule("StarShadowExplorePanel");
                    }
                }
            });
        }, null, new SpecialInfo(2, type, catchTime));
    }

    private static function cancelEnterSencondMap():void {
        var _loc1_:* = {};
        if (isPetFollow) {
            _loc1_.index = _currentIndex;
        } else {
            _loc1_.index = currentConfig["preActivityIndex"];
        }
        ModuleManager.showAppModule("StarShadowPanel", _loc1_);
    }

    private static function get isPetFollow():Boolean {
        var _loc1_:int = int(currentConfig["followPetId"]);
        var _loc2_:int = ActorManager.actorInfo.followingPetInfo == null ? 0 : int(ActorManager.actorInfo.followingPetInfo.resourceId);
        return _loc2_ == _loc1_;
    }

    private static function destoryMap(param1:*):void {
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, destoryMap);
        if (_icon != null) {
            _icon.removeEventListener(MouseEvent.CLICK, onIconClick);
            _icon = null;
        }
    }

    private static function get leftFreeEnterNum():int {
        var _loc1_:int = VipManager.vipInfo.isVip() ? 3 : 2;
        return _loc1_ - _freeEnterTimes;
    }

    public static function get currentConfig():* {
        var _loc1_:* = CONFIG[_currentIndex + ""];
        _loc1_["index"] = _currentIndex;
        return _loc1_;
    }
}
}
