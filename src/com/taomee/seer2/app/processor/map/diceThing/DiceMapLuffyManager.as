package com.taomee.seer2.app.processor.map.diceThing {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.DiceMapThingConfig;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.config.info.DiceMapTileInfo;
import com.taomee.seer2.app.config.info.DiceThingInfo;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.map.diceThing.event.DiceThingEvent;
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
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.DomainUtil;

public class DiceMapLuffyManager {

    private static var _instance:DiceMapLuffyManager;


    protected var tileXml:XML;

    private var tileVec:Vector.<DiceMapTileInfo>;

    private var diceMc:MovieClip;

    private var diceResult:int;

    private var scene:LobbyScene;

    private var _map:MapModel;

    private var roleMobile:PathMobile;

    private var roleMobileID:int;

    private var currentTileSeat:int = 0;

    private var maxSeat:int;

    private var totalSeat:int;

    private var _leftCount:int = 0;

    private var freeCount:int;

    private var useCount:int;

    private var useCountId:uint;

    private var vipCount:int;

    private var normalCount:int;

    private var seatInfoId:uint;

    private var buyedCountId:uint;

    private var coinId:uint;

    private var fightId:uint;

    private var randomPoint:uint;

    private var swapNpc:SimpleButton;

    private var curCoinTextField:TextField;

    private var _curCoin:int;

    private var currentThing:BaseDiceThing;

    private const BUY_DICE:uint = 604103;

    public function DiceMapLuffyManager(param1:instancs) {
        super();
    }

    public static function getInstance():DiceMapLuffyManager {
        if (!_instance) {
            _instance = new DiceMapLuffyManager(new instancs());
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
        this.curCoinTextField = null;
        this._curCoin = 0;
        this.diceResult = 0;
        this.roleMobileID = 0;
        this.currentTileSeat = 0;
        this.maxSeat = 0;
        this.totalSeat = 0;
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
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
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
        this.fightId = uint(this.tileXml.@fightId);
        this.randomPoint = uint(this.tileXml.@randomPoint);
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
        this.maxSeat = this.tileVec.length;
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
        if (!this.roleMobile) {
            this.initMobile();
        }
        this.getCoinNum();
        this.getLeftCount();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }

    private function toSwap(param1:MouseEvent):void {
        ModuleManager.showAppModule("LuffySwapPanel");
        ModuleManager.addEventListener("LuffySwapPanel", ModuleEvent.DISPOSE, this.onDispose);
    }

    private function onDispose(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("LuffySwapPanel", ModuleEvent.DISPOSE, this.onDispose);
        this.getCoinNum();
    }

    private function getCoinNum():void {
        ActiveCountManager.requestActiveCount(this.coinId, function (param1:uint, param2:uint):void {
            var _loc3_:TextField = null;
            if (_map) {
                _loc3_ = _map.content["coinNumTxt"];
                _loc3_.text = param2.toString();
            }
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
            AlertManager.showConfirm("你没有可以用的骰子了\n花费" + ShopPanelConfig.getItemPrice(this.BUY_DICE) + "星钻买一个?", function ():void {
                PayManager.buyItem(BUY_DICE, function ():void {
                    getLeftCount();
                    SwapManager.swapItem(3054, 1, dicePlay);
                }, function ():void {
                    diceMc.mouseEnabled = true;
                });
            }, function ():void {
                diceMc.mouseEnabled = true;
            });
        } else {
            SwapManager.swapItem(3054, 1, this.dicePlay);
        }
    }

    private function dicePlay(param1:IDataInput = null):void {
        var leftTxt:TextField;
        var data:IDataInput = param1;
        --this._leftCount;
        leftTxt = this._map.content["countTxt"]["leftTxt"];
        ServerMessager.addMessage("消耗300赛尔豆,抛一次骰子！");
        leftTxt.text = "还可以抛" + this._leftCount.toString() + "次";
        this.diceMc.mouseEnabled = false;
        this.diceMc.buttonMode = false;
        MovieClipUtil.playMc(this.diceMc, "旋转", "停止", function ():void {
            ActiveCountManager.requestActiveCount(randomPoint, function (param1:uint, param2:uint):void {
                var stopMc:MovieClip;
                var mc:MovieClip;
                var type:uint = param1;
                var c:uint = param2;
                diceResult = c;
                stopMc = diceMc.getChildAt(0) as MovieClip;
                stopMc.gotoAndStop(diceResult);
                mc = stopMc.getChildAt(0) as MovieClip;
                MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                    totalSeat = currentTileSeat + diceResult;
                    if (totalSeat >= maxSeat) {
                        totalSeat -= maxSeat;
                    }
                    moveSeat();
                });
            });
        });
    }

    private function moveSeat():void {
        ++this.currentTileSeat;
        if (this.currentTileSeat >= this.maxSeat) {
            this.currentTileSeat -= this.maxSeat;
        }
        this.roleMobile.addEventListener(MoveEvent.FINISHED, this.moveFinished);
        if (this.roleMobileID != 0) {
            this.roleMobile.walkToLocation(this.tileVec[this.currentTileSeat].x, this.tileVec[this.currentTileSeat].y);
        } else {
            this.roleMobile.runToLocation(this.tileVec[this.currentTileSeat].x, this.tileVec[this.currentTileSeat].y);
        }
    }

    private function moveFinished(param1:MoveEvent):void {
        this.roleMobile.removeEventListener(MoveEvent.FINISHED, this.moveFinished);
        if (this.currentTileSeat != this.totalSeat) {
            this.moveSeat();
        } else {
            this.checkThing();
        }
    }

    private function checkThing():void {
        var tileInfo:DiceMapTileInfo = null;
        tileInfo = this.tileVec[this.currentTileSeat];
        switch (tileInfo.thingType) {
            case DiceThingType.BOX_THING:
                SwapManager.swapItem(3057, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                });
                break;
            case DiceThingType.CHANCE_THING:
                SwapManager.swapItem(3122, 1, function (param1:IDataInput):void {
                    var _loc2_:String = "com.taomee.seer2.app.processor.map.diceThing.";
                    var _loc3_:* = DiceThingType.CHANCE_THING + ".";
                    var _loc4_:String = tileInfo.thingType + int(Math.random() * 2);
                    var _loc5_:DiceThingInfo;
                    (_loc5_ = DiceMapThingConfig.thingMap.getValue(_loc4_) as DiceThingInfo).currentSeat = currentTileSeat;
                    var _loc6_:String = _loc5_.className;
                    var _loc7_:Class = DomainUtil.getCurrentDomainClass(_loc2_ + _loc3_ + _loc6_);
                    currentThing = new _loc7_(_loc5_);
                    currentThing.addEventListener(DiceThingEvent.DICE_THING_OVER, thingOver);
                    currentThing.setUpThing();
                }, function ():void {
                });
                break;
            case DiceThingType.ADD10_THING:
                SwapManager.swapItem(3061, 1, function (param1:IDataInput):void {
                    ServerMessager.addMessage("+10海盗币");
                    getCoinNum();
                });
                break;
            case DiceThingType.ADDMONEY_THING:
                SwapManager.swapItem(3060, 1, function (param1:IDataInput):void {
                    ServerMessager.addMessage("+1海盗币");
                    getCoinNum();
                });
                break;
            case DiceThingType.SUBMONEY_THING:
                SwapManager.swapItem(3059, 1, function (param1:IDataInput):void {
                    ServerMessager.addMessage("-1海盗币");
                    getCoinNum();
                });
                break;
            case DiceThingType.REVERSE_THING:
                SwapManager.swapItem(3058, 1, function (param1:IDataInput):void {
                    ServerMessager.addMessage("-3海盗币");
                    getCoinNum();
                });
                break;
            case DiceThingType.FIGHT_THING:
                SwapManager.swapItem(3056, 1, function (param1:IDataInput):void {
                    var data:IDataInput = param1;
                    ActiveCountManager.requestActiveCount(fightId, function (param1:uint, param2:uint):void {
                        FightManager.startFightWithBoss(param2);
                    });
                });
                break;
            case DiceThingType.EMPTY_THING:
                SwapManager.swapItem(3124);
        }
        this.resetDice();
    }

    private function thingOver(param1:DiceThingEvent):void {
        var event:DiceThingEvent = param1;
        this.currentThing.removeEventListener(DiceThingEvent.DICE_THING_OVER, this.thingOver);
        this.currentThing.dispose();
        this.currentThing = null;
        if (event.resultInfo) {
            SwapManager.swapItem(3123, 1, function ():void {
                SwapManager.swapItem(3089, 1, function ():void {
                    totalSeat = currentTileSeat + event.resultInfo.moveTile;
                    if (totalSeat >= maxSeat) {
                        totalSeat -= maxSeat;
                    }
                    if (event.resultInfo.moveTile != 0) {
                        moveSeat();
                    } else {
                        resetDice();
                    }
                }, function ():void {
                }, new SpecialInfo(1, event.resultInfo.moveTile));
            }, function ():void {
            });
        } else {
            SwapManager.swapItem(3123, 1, function ():void {
                SwapManager.swapItem(3089, 1, function ():void {
                    resetDice();
                }, function ():void {
                    resetDice();
                }, new SpecialInfo(1, 0));
            });
        }
    }

    private function onComplete(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                ServerMessager.addMessage("战斗胜利+2海盗币");
                this.getCoinNum();
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
            currentTileSeat = param2;
            roleMobile.setPostion(new Point(tileVec[currentTileSeat].x, tileVec[currentTileSeat].y));
        });
    }
}
}

class instancs {


    public function instancs() {
        super();
    }
}
