package com.taomee.seer2.app.processor.map.diceThing {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.config.info.DiceMapTileInfo;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.PathMobile;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.Module;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.IDataInput;

public class DiceMapSanjiManager {

    private static var _instance:DiceMapSanjiManager;

    private static var _curCoin:int;


    protected var tileXml:XML;

    private var tileVec:Vector.<DiceMapTileInfo>;

    private var diceMc:MovieClip;

    private var _bar:MovieClip;

    private var _getBtn:SimpleButton;

    private var swapNpc:SimpleButton;

    private var scene:LobbyScene;

    private var _map:MapModel;

    private var roleMobile:PathMobile;

    private var roleMobileID:int;

    private var _currentTileSeat:int = 0;

    private var _maxSeat:int;

    private var _totalSeat:int;

    private var _leftCount:int = 0;

    private var freeCount:int;

    private var useCount:int;

    private var useCountId:uint;

    private var vipCount:int;

    private var normalCount:int;

    private var seatInfoId:uint;

    private var buyedCountId:uint;

    private var coinId:uint;

    private const BUY_DICE:uint = 604179;

    private var currentThing:BaseDiceThing;

    private var module:Module;

    private var _checkValue:int;

    public function DiceMapSanjiManager(param1:instancs) {
        super();
    }

    public static function getInstance():DiceMapSanjiManager {
        if (!_instance) {
            _instance = new DiceMapSanjiManager(new instancs());
        }
        return _instance;
    }

    public function dispose(param1:SceneEvent):void {
        this.tileXml = null;
        this.tileVec = null;
        if (this.diceMc) {
            this.diceMc.removeEventListener(MouseEvent.CLICK, this.clickDice);
            this.diceMc = null;
        }
        if (this.swapNpc) {
            this.swapNpc.removeEventListener(MouseEvent.CLICK, this.toSwap);
        }
        this.roleMobile = null;
        this.roleMobileID = 0;
        this._currentTileSeat = 0;
        this._maxSeat = 0;
        this._totalSeat = 0;
        this.freeCount = 0;
        this.useCount = 0;
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().show();
        if (this._map) {
            this._map.ground.mouseEnabled = true;
            this._map = null;
        }
        if (this.scene) {
            this.scene.showToolbar();
            this.scene = null;
        }
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.dispose);
    }

    public function setup():void {
        this._map = SceneManager.active.mapModel;
        this.setEnvironment();
        QueueLoader.load(URLUtil.getDiceMapData(this._map.id), LoadType.TEXT, this.onXmlLoaded);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.dispose);
    }

    private function setEnvironment():void {
        ActorManager.getActor().hide();
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().blockNoNo = true;
        this._map.ground.mouseEnabled = false;
        ActorManager.showRemoteActor = false;
        this.scene = SceneManager.active as LobbyScene;
        this.scene.hideToolbar();
        PetAvatarPanel.show();
    }

    private function onXmlLoaded(param1:ContentInfo):void {
        this.tileXml = XML(param1.content);
        this.parseXml();
    }

    private function parseXml():void {
        var _loc2_:XML = null;
        var _loc3_:DiceMapTileInfo = null;
        this.tileVec = new Vector.<DiceMapTileInfo>();
        this.roleMobileID = int(this.tileXml.@mobileId);
        this.seatInfoId = uint(this.tileXml.@seatInfoId);
        this.vipCount = uint(this.tileXml.@vipCount);
        this.normalCount = uint(this.tileXml.@normalCount);
        this.useCountId = uint(this.tileXml.@useCountId);
        this.buyedCountId = uint(this.tileXml.@buyedCountId);
        this.coinId = uint(this.tileXml.@coinId);
        var _loc1_:XMLList = this.tileXml.descendants("tile");
        for each(_loc2_ in _loc1_) {
            _loc3_ = new DiceMapTileInfo();
            _loc3_.seat = int(_loc2_.@seat);
            _loc3_.thingType = String(_loc2_.@tileType);
            _loc3_.x = int(_loc2_.@x);
            _loc3_.y = int(_loc2_.@y);
            this.tileVec.push(_loc3_);
        }
        this.tileVec.sort(this.sortVec);
        this._maxSeat = this.tileVec.length;
        if (ActorManager.actorInfo.vipInfo.isVip()) {
            this.freeCount = this.vipCount;
        } else {
            this.freeCount = this.normalCount;
        }
        this.initUI();
    }

    private function initUI():void {
        this.diceMc = this._map.content["dice"];
        this.diceMc.gotoAndStop(1);
        this.diceMc.buttonMode = true;
        this.diceMc.mouseChildren = false;
        this.diceMc.addEventListener(MouseEvent.CLICK, this.clickDice);
        this.swapNpc = this._map.content["swapNpc"];
        this.swapNpc.addEventListener(MouseEvent.CLICK, this.toSwap);
        this._bar = this._map.front["bar"];
        this._getBtn = this._map.content["getBtn"];
        this._getBtn.addEventListener(MouseEvent.CLICK, this.onGetBtn);
        if (!this.roleMobile) {
            this.initMobile();
        }
        this.getCoinNum();
        this.getLeftCount();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }

    private function onGetBtn(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        SwapManager.swapItem(3135, 1, function (param1:IDataInput):void {
            var _loc2_:SwapInfo = new SwapInfo(param1);
            getCoinNum();
        }, null, new SpecialInfo(1, 1));
    }

    private function toSwap(param1:MouseEvent):void {
        ModuleManager.showAppModule("SanjiSwapPanel");
        ModuleManager.addEventListener("SanjiSwapPanel", ModuleEvent.DISPOSE, this.onDispose);
    }

    private function onDispose(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("SanjiSwapPanel", ModuleEvent.DISPOSE, this.onDispose);
        this.getCoinNum();
    }

    private function getCoinNum(param1:Boolean = false, param2:String = ""):void {
        var needTip:Boolean = param1;
        var tipTxt:String = param2;
        ActiveCountManager.requestActiveCount(this.coinId, function (param1:uint, param2:uint):void {
            var _loc5_:int = 0;
            var _loc3_:TextField = _map.front["scoreFd"];
            _loc3_.text = param2 + "/100";
            var _loc4_:Number = param2 / 100 * 451.4;
            if (param2 < 100) {
                DisplayObjectUtil.disableButton(_getBtn);
            } else {
                DisplayObjectUtil.enableButton(_getBtn);
                _loc4_ = 451.4;
            }
            _bar.width = _loc4_;
            if (needTip) {
                if ((_loc5_ = param2 - _curCoin) > 0) {
                    ServerMessager.addMessage(tipTxt + "+" + _loc5_ + "亲密度");
                } else if (_loc5_ < 0) {
                    ServerMessager.addMessage(tipTxt + _loc5_ + "亲密度");
                }
            }
            _curCoin = param2;
        });
    }

    private function getLeftCount():void {
        DayLimitManager.getDoCount(this.useCountId, function (param1:uint):void {
            var c:uint = param1;
            useCount = c;
            ActiveCountManager.requestActiveCount(buyedCountId, function (param1:uint, param2:uint):void {
                var _loc3_:uint = param2;
                if (useCount >= freeCount) {
                    _leftCount = _loc3_;
                } else {
                    _leftCount = _loc3_ + freeCount - useCount;
                }
                var _loc4_:TextField;
                (_loc4_ = _map.content["countTxt"]["leftTxt"]).text = "还可以抛" + _leftCount + "次";
            });
        });
    }

    private function clickDice(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this._leftCount <= 0) {
            this.diceMc.mouseEnabled = false;
            AlertManager.showConfirm("你没有可以用的骰子了\n是否花费" + ShopPanelConfig.getItemPrice(this.BUY_DICE) + "星钻买一个?", function ():void {
                PayManager.buyItem(BUY_DICE, function ():void {
                    getLeftCount();
                    SwapManager.swapItem(3126, 1, dicePlay, null, new SpecialInfo(1, 1));
                }, function ():void {
                    diceMc.mouseEnabled = true;
                });
            }, function ():void {
                diceMc.mouseEnabled = true;
            });
        } else {
            SwapManager.swapItem(3126, 1, this.dicePlay, null, new SpecialInfo(1, 1));
        }
    }

    private function dicePlay(param1:IDataInput = null):void {
        var leftTxt:TextField;
        var diceResult:int = 0;
        var data:IDataInput = param1;
        StatisticsManager.newSendNovice("2014活动", "夏季寻宝大冒险", "投掷香吉士色字");
        --this._leftCount;
        leftTxt = this._map.content["countTxt"]["leftTxt"];
        if (this.useCount < this.freeCount) {
            ServerMessager.addMessage("消耗300赛尔豆,抛一次骰子！");
        }
        leftTxt.text = "还可以抛" + this._leftCount.toString() + "次";
        this.diceMc.mouseEnabled = false;
        this.diceMc.buttonMode = false;
        MovieClipUtil.playMc(this.diceMc, "旋转", "停止", function ():void {
            ActiveCountManager.requestActiveCount(seatInfoId, function (param1:uint, param2:uint):void {
                var stopMc:MovieClip;
                var mc:MovieClip;
                var type:uint = param1;
                var c:uint = param2;
                _totalSeat = c % 44;
                diceResult = _totalSeat - _currentTileSeat;
                if (_totalSeat < _currentTileSeat) {
                    diceResult += _maxSeat;
                }
                stopMc = diceMc.getChildAt(0) as MovieClip;
                stopMc.gotoAndStop(diceResult);
                mc = stopMc.getChildAt(0) as MovieClip;
                MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                    moveSeat();
                });
            });
        });
    }

    private function moveSeat():void {
        ++this._currentTileSeat;
        if (this._currentTileSeat >= this._maxSeat) {
            this._currentTileSeat -= this._maxSeat;
        }
        this.roleMobile.addEventListener(MoveEvent.FINISHED, this.moveFinished);
        if (this.roleMobileID != 0) {
            this.roleMobile.walkToLocation(this.tileVec[this._currentTileSeat].x, this.tileVec[this._currentTileSeat].y);
        } else {
            this.roleMobile.runToLocation(this.tileVec[this._currentTileSeat].x, this.tileVec[this._currentTileSeat].y);
        }
    }

    private function moveFinished(param1:MoveEvent):void {
        this.roleMobile.removeEventListener(MoveEvent.FINISHED, this.moveFinished);
        if (this._currentTileSeat != this._totalSeat) {
            this.moveSeat();
        } else {
            this.checkThing();
        }
    }

    private function checkThing():void {
        SwapManager.swapItem(3128, 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            var info:SwapInfo = new SwapInfo(data);
            DayLimitManager.getDoCount(1314, function (param1:uint):void {
                var _loc2_:int = 0;
                if (param1 >= 11000) {
                    _checkValue = param1;
                    ModuleManager.showAppModule("DiceBBQPanel");
                    ModuleManager.addEventListener("DiceBBQPanel", ModuleEvent.DISPOSE, onGameOver);
                } else if (param1 > 10000) {
                    _loc2_ = param1 - 10000 + 1000;
                    FightManager.startFightWithBoss(_loc2_);
                } else {
                    getCoinNum(true);
                }
            });
        });
        this.resetDice();
    }

    private function onGameOver(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("DiceBBQPanel", ModuleEvent.DISPOSE, this.onGameOver);
        this.getCoinNum(true, "小游戏结束，");
    }

    private function onComplete(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.getCoinNum(true, "战斗胜利");
            } else {
                this.getCoinNum(true, "战斗失败");
            }
        }
    }

    private function resetDice():void {
        if (this.diceMc) {
            this.diceMc.mouseEnabled = true;
            this.diceMc.buttonMode = true;
            LayerManager.resetOperation();
        }
    }

    private function sortVec(param1:DiceMapTileInfo, param2:DiceMapTileInfo):int {
        if (param1.seat > param2.seat) {
            return 1;
        }
        if (param1.seat < param2.seat) {
            return -1;
        }
        return 0;
    }

    private function initMobile():void {
        if (this.roleMobile) {
            MobileManager.removeMobile(this.roleMobile, MobileType.PET);
            this.roleMobile = null;
        }
        if (this.roleMobileID != 0) {
            this.roleMobile = new PathMobile();
            this.roleMobile.resourceUrl = URLUtil.getPetSwf(this.roleMobileID);
            MobileManager.addMobile(this.roleMobile, MobileType.PET);
        } else {
            this.roleMobile = ActorManager.getActor();
            ActorManager.getActor().show();
            ActorManager.getActor().blockNoNo = true;
            ActorManager.getActor().blockFollowingPet = true;
        }
        ActiveCountManager.requestActiveCount(this.seatInfoId, function (param1:uint, param2:uint):void {
            _currentTileSeat = param2 % 44;
            roleMobile.setPostion(new Point(tileVec[_currentTileSeat].x, tileVec[_currentTileSeat].y));
        });
    }
}
}

class instancs {


    public function instancs() {
        super();
    }
}
