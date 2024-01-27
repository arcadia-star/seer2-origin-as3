package com.taomee.seer2.app.processor.activity.dragonchroniclesManager {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.SpawnedPet;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.BitUtil;

public class DragonChroniclesFirstSeasonManager {

    private static var _resMc:MovieClip;

    private static var _operaterIdx:int;

    private static var MAXNUM:int = 3;

    private static var WINCOUNT:int = 205531;

    private static var winCount:int = 0;

    private static var numTxt:TextField;

    private static var fightOneID:Array = [1487, 1488, 1489, 1476];

    private static var levelList:Array = [100, 100, 100, 100];

    private static var petVector:Array = new Array();

    private static var petTwoIDArr:Array = [862, 778, 782, 777, 781, 783, 776, 780, 758];

    private static var fightTwoIDArr:Array = [1477, 1478, 1479, 1480, 1481, 1482, 1483, 1484, 1485];

    private static var petPos:Array = [[357, 335], [395, 404], [460, 479], [590, 524], [720, 520], [844, 484], [814, 394], [753, 320], [664, 302]];

    private static var petName:Array = ["英菲尼迪", "玛莎拉蒂", "法拉利", "保时捷", "帕加尼", "阿斯顿马丁", "迈巴赫", "布加迪威龙", "不死龙王"];

    private static var WINTWOCOUNT:int = 205534;

    private static var winTwoBit:int;

    private static var num2Txt:TextField;

    private static var petTwoVector:Array = new Array();

    private static var fightThreeID:int = 1486;

    private static var _longMc:SimpleButton;

    private static var _itemShop:SimpleButton;

    private static var _harmMc:MovieClip;

    private static var foreverLimit:Array = [205536, 205537, 205538];

    private static var _curHarm:int;

    private static var _totalHarm:int;

    private static var _hasLong:Boolean;

    private static var _npcBlackDragon:Mobile;


    public function DragonChroniclesFirstSeasonManager() {
        super();
    }

    public static function init(param1:int = -1):void {
        var operaterIdx:int = param1;
        _operaterIdx = operaterIdx;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (fightOneID.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                ActiveCountManager.requestActiveCountList([205532], function (param1:Parser_1142):void {
                    if (param1.infoVec[0] >= 3) {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        ModuleManager.showAppModule("DragonChroniclesFirstSeasonPanel");
                    }
                });
            }
            if (fightTwoIDArr.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
                ActiveCountManager.requestActiveCountList([205539], function (param1:Parser_1142):void {
                    if (param1.infoVec[0] >= 3) {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        ModuleManager.showAppModule("DragonChroniclesFirstSeasonPanel");
                    }
                });
            }
            if (fightThreeID == FightManager.currentFightRecord.initData.positionIndex) {
                ActiveCountManager.requestActiveCountList([205540], function (param1:Parser_1142):void {
                    if (param1.infoVec[0] >= 3) {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        ModuleManager.showAppModule("DragonChroniclesFirstSeasonPanel");
                    }
                });
            }
        }
        QueueLoader.load(URLUtil.getActivityAnimation("dragonchronicles/dragonchroniclesfirst"), LoadType.SWF, onResLoaded);
    }

    private static function onResLoaded(param1:ContentInfo):void {
        var _loc2_:MovieClip = param1.content as MovieClip;
        _resMc = _loc2_["resMc" + _operaterIdx];
        LayerManager.mapLayer.addChild(_resMc);
        switch (_operaterIdx) {
            case 1:
                onOperationOne();
                break;
            case 2:
                onOperationTwo();
                break;
            case 3:
                onOperationThree();
        }
    }

    private static function onOperationOne():void {
        numTxt = _resMc["numTxt"];
        ActiveCountManager.requestActiveCountList([WINCOUNT], function (param1:Parser_1142):void {
            winCount = param1.infoVec[0];
            numTxt.text = winCount.toString();
            createFightPet();
        });
    }

    private static function createFightPet():void {
        var _loc1_:int = 0;
        var _loc2_:int = 0;
        var _loc3_:SpawnedPet = null;
        petVector = [];
        if (winCount < 9) {
            _loc1_ = 0;
            while (_loc1_ < MAXNUM) {
                _loc2_ = generateRandom();
                if (_loc2_ != -1) {
                    _loc3_ = new SpawnedPet(531, fightOneID[_loc2_], levelList[_loc2_]);
                    MobileManager.addMobile(_loc3_, MobileType.SPAWNED_PET);
                    petVector.push(_loc3_);
                }
                _loc1_++;
            }
        }
    }

    private static function generateRandom():int {
        var _loc1_:int = Math.random() * 100 + 1;
        if (_loc1_ < 20) {
            return 0;
        }
        if (_loc1_ < 40) {
            return 1;
        }
        if (_loc1_ < 60) {
            return 2;
        }
        if (_loc1_ < 101) {
            return 3;
        }
        return -1;
    }

    private static function onOperationTwo():void {
        num2Txt = _resMc.numTxt;
        ActiveCountManager.requestActiveCountList([WINTWOCOUNT], function (param1:Parser_1142):void {
            winTwoBit = param1.infoVec[0];
            var _loc2_:int = 0;
            var _loc3_:int = 0;
            while (_loc3_ < 9) {
                if (BitUtil.getBit(winTwoBit, _loc3_) == true) {
                    _loc2_++;
                }
                _loc3_++;
            }
            num2Txt.text = _loc2_.toString();
            createFightTwoPet();
        });
    }

    private static function createFightTwoPet():void {
        var _loc2_:Mobile = null;
        petTwoVector = [];
        var _loc1_:int = 0;
        while (_loc1_ < 9) {
            if (BitUtil.getBit(winTwoBit, _loc1_) == false) {
                _loc2_ = new Mobile();
                _loc2_.setPostion(new Point(petPos[_loc1_][0], petPos[_loc1_][1]));
                _loc2_.label = petName[_loc1_];
                _loc2_.resourceUrl = URLUtil.getNpcSwf(petTwoIDArr[_loc1_]);
                _loc2_.buttonMode = true;
                _loc2_.addEventListener(MouseEvent.CLICK, onFight);
                MobileManager.addMobile(_loc2_, MobileType.NPC);
                petTwoVector.push({
                    "obj": _loc2_,
                    "idx": _loc1_
                });
            }
            _loc1_++;
        }
    }

    private static function onFight(param1:MouseEvent):void {
        var _loc2_:int = 0;
        while (_loc2_ < petTwoVector.length) {
            if (petTwoVector[_loc2_].obj == param1.currentTarget) {
                FightManager.startFightWithWild(fightTwoIDArr[petTwoVector[_loc2_].idx]);
            }
            _loc2_++;
        }
    }

    private static function onOperationThree():void {
        _longMc = _resMc["longMc"];
        _longMc.addEventListener(MouseEvent.CLICK, onBuyLong);
        _harmMc = _resMc["harmMc"];
        _itemShop = _resMc["itemShop"];
        _itemShop.addEventListener(MouseEvent.CLICK, onItemShop);
        createBlackDragon();
        updateShow();
    }

    private static function onItemShop(param1:MouseEvent):void {
        ModuleManager.showAppModule("MedicineShopPanel");
    }

    private static function createBlackDragon():void {
        _npcBlackDragon = new Mobile();
        _npcBlackDragon.setPostion(new Point(833, 534));
        _npcBlackDragon.resourceUrl = URLUtil.getNpcSwf(863);
        _npcBlackDragon.label = "魔纹黑龙";
        _npcBlackDragon.buttonMode = true;
        _npcBlackDragon.addEventListener(MouseEvent.CLICK, onFightBlackDragon);
        MobileManager.addMobile(_npcBlackDragon, MobileType.NPC);
    }

    private static function onFightBlackDragon(param1:MouseEvent):void {
        FightManager.startFightWithWild(fightThreeID);
    }

    private static function updateShow():void {
        ActiveCountManager.requestActiveCountList(foreverLimit, function (param1:Parser_1142):void {
            _curHarm = param1.infoVec[0];
            _totalHarm = param1.infoVec[1];
            _hasLong = Boolean(param1.infoVec[2]);
            if (_hasLong) {
                DisplayObjectUtil.disableButton(_longMc);
            }
            _harmMc.totalTxt.text = _totalHarm + "/999999";
            _harmMc.harmTxt.text = _curHarm.toString();
            _harmMc.barMc.gotoAndStop(_totalHarm / 999999 > 1 ? 100 : int(_totalHarm / 999999 * 100));
        });
    }

    private static function onBuyLong(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        ShopManager.buyItemForId(500623, function (param1:*):void {
            updateShow();
        });
    }

    public static function dispose():void {
        var _loc1_:int = 0;
        while (_loc1_ < petVector.length) {
            MobileManager.removeMobile(petVector[_loc1_], MobileType.SPAWNED_PET);
            _loc1_++;
        }
        _loc1_ = 0;
        while (_loc1_ < petTwoVector.length) {
            MobileManager.removeMobile(petTwoVector[_loc1_].obj, MobileType.NPC);
            _loc1_++;
        }
        if (_npcBlackDragon != null) {
            MobileManager.removeMobile(_npcBlackDragon, MobileType.NPC);
        }
        if (_resMc != null) {
            DisplayObjectUtil.removeFromParent(_resMc);
        }
    }
}
}
