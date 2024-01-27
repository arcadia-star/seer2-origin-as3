package com.taomee.seer2.app.processor.activity.fightHolySkyAct {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.pet.data.PetInfo;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.filter.ColorFilter;

public class FightHolySkyAct {

    private static var _self:FightHolySkyAct;

    private static const FOR_LIST:Array = [250296, 250297, 250298, 250299];

    private static const DAY_LIST:Array = [5103];

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([4019, 4021, 4022, 4023, 4024]);

    private static const FIGHT_INDEX:int = 1605;

    private static const GAME_SET:Vector.<int> = Vector.<int>([10, 80, 42]);

    private static const ITEM_ID_LIST:Vector.<uint> = Vector.<uint>([400801]);

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605786]);

    private static var _isInit:Boolean = false;


    private var _tipMC:MovieClip;

    private var _doorList:Vector.<MovieClip>;

    private var _eventTipList:Vector.<MovieClip>;

    private var _eventPetList:Vector.<MovieClip>;

    private var _awardBag:MovieClip;

    private var _gateNum:TextField;

    private var _leftNum:TextField;

    private var _map:MapModel;

    private var _par:Parser_1142;

    private var _info:DayLimitListInfo;

    private var _index:int;

    public function FightHolySkyAct() {
        super();
    }

    public static function getInstance():FightHolySkyAct {
        if (_self == null) {
            _self = new FightHolySkyAct();
        }
        return _self;
    }

    public function setup(param1:MapModel):void {
        this._map = param1;
        this.hideLobbyMenu();
        this.init();
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function showLobbyMenu():void {
        (SceneManager.active as LobbyScene).showToolbar();
    }

    private function init():void {
        this.initSet();
        this.initEvent();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            this.goalItemNumHandle();
        }
        this.update();
        if (!_isInit) {
            _isInit = true;
            this._tipMC.visible = true;
            MovieClipUtil.playMc(this._tipMC, 2, this._tipMC.totalFrames, function ():void {
                _tipMC.gotoAndStop(1);
                _tipMC.visible = false;
            });
        }
    }

    private function initSet():void {
        var _loc1_:int = 0;
        this._tipMC = this._map.front["tipMC"];
        this._tipMC.visible = false;
        this._doorList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 3) {
            this._doorList.push(this._map.content["door" + _loc1_]);
            this._doorList[_loc1_].buttonMode = true;
            _loc1_++;
        }
        this._eventTipList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 3) {
            this._eventTipList.push(this._map.front["eventTip" + _loc1_]);
            this._eventTipList[_loc1_].visible = false;
            _loc1_++;
        }
        this._eventPetList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 3) {
            this._eventPetList.push(this._map.content["eventPet" + _loc1_]);
            this._eventPetList[_loc1_].buttonMode = true;
            this._eventPetList[_loc1_].visible = false;
            _loc1_++;
        }
        this._awardBag = this._map.content["awardBag"];
        this._awardBag.buttonMode = true;
        this._awardBag.scaleX = this._awardBag.scaleY = 0.5;
        this._awardBag.visible = false;
        this._gateNum = this._map.front["gateNum"];
        this._leftNum = this._map.front["leftNum"];
    }

    private function initEvent():void {
        var _loc1_:MovieClip = null;
        for each(_loc1_ in this._doorList) {
            _loc1_.addEventListener(MouseEvent.CLICK, this.onDoor);
        }
        this._awardBag.addEventListener(MouseEvent.CLICK, this.onAwardBag);
    }

    private function selectFilter():Boolean {
        var _loc1_:PetInfo = PetInfoManager.getFirstPetInfo();
        if (_loc1_ != null) {
            if (_loc1_.hp == 0) {
                AlertManager.showAlert("首发精灵体力耗尽,暂时不可前进,以防遇到对战不可进入战斗哦!");
                return false;
            }
            return true;
        }
        AlertManager.showAlert("没有设置首发精灵,暂时不可前进,以防遇到对战不可进入战斗哦!");
        return false;
    }

    private function onAwardBag(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        SwapManager.swapItem(SWAP_LIST[4], 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            goalItemNumHandle();
            update();
        });
    }

    private function onDoor(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (!this.selectFilter()) {
            return;
        }
        StatisticsManager.newSendNovice("2015活动", "战神的天阶", "选择三个入口");
        this.setDoorEnable(false);
        if (this._par.infoVec[3] != 0) {
            this.stateHandle();
        } else {
            SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                var oldLayer:int = 0;
                var data:IDataInput = param1;
                new SwapInfo(data);
                oldLayer = int(_par.infoVec[2]);
                update(function ():void {
                    if (_par.infoVec[3] == 0) {
                        if (_par.infoVec[2] > oldLayer) {
                            _eventTipList[1].visible = true;
                            MovieClipUtil.playMc(_eventTipList[1], 2, _eventTipList[1].totalFrames, function ():void {
                                _eventTipList[1].gotoAndStop(1);
                                _eventTipList[1].visible = false;
                            });
                        } else if (_par.infoVec[2] == oldLayer) {
                            _eventTipList[2].visible = true;
                            MovieClipUtil.playMc(_eventTipList[2], 2, _eventTipList[2].totalFrames, function ():void {
                                _eventTipList[2].gotoAndStop(2);
                                _eventTipList[2].visible = false;
                            });
                        } else {
                            _eventTipList[0].visible = true;
                            MovieClipUtil.playMc(_eventTipList[0], 2, _eventTipList[0].totalFrames, function ():void {
                                _eventTipList[0].gotoAndStop(2);
                                _eventTipList[0].visible = false;
                            });
                        }
                    } else {
                        stateHandle();
                    }
                });
            });
        }
    }

    private function stateHandle():void {
        if (this._par.infoVec[3] <= 3) {
            this._eventPetList[this._par.infoVec[3] - 1].visible = true;
            MovieClipUtil.playMc(this._eventPetList[this._par.infoVec[3] - 1], 2, this._eventPetList[this._par.infoVec[3] - 1].totalFrames, function ():void {
                _eventPetList[_par.infoVec[3] - 1].gotoAndStop(_eventPetList[_par.infoVec[3] - 1].totalFrames);
                _eventPetList[_par.infoVec[3] - 1].addEventListener(MouseEvent.CLICK, onEventPetClick);
            });
        } else {
            this.setDoorEnable(true);
            FightManager.startFightWithWild(FIGHT_INDEX);
        }
    }

    private function onEventPetClick(param1:MouseEvent):void {
        this._index = this._eventPetList.indexOf(param1.currentTarget as MovieClip);
        if (this._index == 0) {
            this.handle0();
        } else if (this._index == 1) {
            this.handle1();
        } else if (this._index == 2) {
            this.handle2();
        }
    }

    private function handle0():void {
        NpcDialog.show(902, "汤姆", [[1, "吖，给我条小黄鱼，我也会送你个礼物"]], ["给你！", "我要想想"], [function ():void {
            ItemManager.requestItemList(function ():void {
                if (ItemManager.getItemQuantityByReferenceId(ITEM_ID_LIST[0]) > 0) {
                    SwapManager.swapItem(SWAP_LIST[3], 1, function (param1:IDataInput):void {
                        new SwapInfo(param1);
                        _eventPetList[_index].visible = false;
                        goalItemNumHandle();
                        update();
                    });
                } else {
                    NpcDialog.show(902, "汤姆", [[1, "喵——你的包包里好像没有鱼啊"]], ["去钓鱼", "给你点钱算了"], [function ():void {
                        SceneManager.changeScene(SceneType.LOBBY, 152);
                    }, function ():void {
                        ShopManager.buyItemForId(MI_ID_LIST[0], function ():void {
                            _eventPetList[_index].removeEventListener(MouseEvent.CLICK, onEventPetClick);
                            _eventPetList[_index].visible = false;
                            goalItemNumHandle();
                            update();
                        });
                    }]);
                }
            });
        }]);
    }

    private function handle1():void {
        NpcDialog.show(901, "杰瑞", [[1, "在神域守门人小游戏中获得950分，我会给你想要的东西"]], ["神域守门人", "我要想想"], [function ():void {
            var oldNum:* = undefined;
            oldNum = _par.infoVec[0];
            ModuleManager.showModule(URLUtil.getAppModule("MiniGameConsolePanel"), "正在打开小游戏...", {
                "gameId": GAME_SET[2],
                "gameOverFunc": function (param1:int):void {
                    var score:int = param1;
                    _eventPetList[_index].removeEventListener(MouseEvent.CLICK, onEventPetClick);
                    _eventPetList[_index].visible = false;
                    ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                        if (param1.infoVec[0] > oldNum) {
                            ServerMessager.addMessage("恭喜获得" + (param1.infoVec[0] - oldNum) + "天阶碎片!");
                        }
                    });
                    update();
                }
            });
        }]);
    }

    private function handle2():void {
        NpcDialog.show(900, "派克", [[1, "终于有人可以和我玩石头剪刀布了"]], ["狗也会玩石头剪刀布？！", "我不要和狗玩游戏"], [function ():void {
            SwapManager.swapItem(SWAP_LIST[1], 1, function (param1:IDataInput):void {
                new SwapInfo(param1);
                ModuleManager.showModule(URLUtil.getAppModule("FightHolySkyGuessGamePanel"), "正在打开猜拳面板...", {"func": gameHandle});
            });
        }]);
    }

    private function gameHandle(param1:int):void {
        var val:int = param1;
        SwapManager.swapItem(SWAP_LIST[2], 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            _eventPetList[_index].visible = false;
            goalItemNumHandle();
            update();
            if (val == 1) {
                ServerMessager.addMessage("挑战胜利!");
            } else {
                ServerMessager.addMessage("挑战失败...");
            }
        }, null, new SpecialInfo(1, val));
    }

    private function setFuncDisable():void {
        this.setDoorEnable(false);
    }

    private function setDoorEnable(param1:Boolean):void {
        var _loc2_:MovieClip = null;
        for each(_loc2_ in this._doorList) {
            _loc2_.mouseEnabled = _loc2_.mouseChildren = param1;
        }
    }

    private function goalItemNumHandle():void {
        var oldNum:int = 0;
        oldNum = int(this._par.infoVec[0]);
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            if (param1.infoVec[0] > oldNum) {
                ServerMessager.addMessage("恭喜获得" + (param1.infoVec[0] - oldNum) + "天阶碎片!");
            }
        });
    }

    private function update(param1:Function = null):void {
        var callBack:Function = param1;
        this.setFuncDisable();
        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                _par = par;
                _info = info;
                _gateNum.text = (par.infoVec[2] + 1).toString();
                _leftNum.text = (GAME_SET[0] - info.getCount(DAY_LIST[0])).toString();
                if (par.infoVec[2] == 9) {
                    _awardBag.visible = true;
                    _awardBag.scaleX = _awardBag.scaleY = 0.5;
                    MovieClipUtil.playMc(_awardBag, 2, _awardBag.totalFrames, function ():void {
                        _awardBag.gotoAndStop(_awardBag.totalFrames);
                    });
                    return;
                }
                _awardBag.visible = false;
                _awardBag.gotoAndStop(1);
                if (par.infoVec[1] >= GAME_SET[1]) {
                    if (par.infoVec[3] == 0) {
                        ServerMessager.addMessage("已用完所有游戏次数了!");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(2, function ():void {
                            ModuleManager.showAppModule("FightHolySkyPanel");
                        });
                        return;
                    }
                }
                if (int(_leftNum.text) == 0) {
                    if (par.infoVec[3] == 0) {
                        ServerMessager.addMessage("今天游戏次数已用完!");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(2, function ():void {
                            ModuleManager.showAppModule("FightHolySkyPanel");
                        });
                        return;
                    }
                }
                setDoorEnable(true);
                if (callBack != null) {
                    callBack();
                }
            });
        });
    }

    private function setBtnState(param1:SimpleButton, param2:Boolean):void {
        if (param2) {
            param1.filters = [];
            param1.mouseEnabled = true;
        } else {
            ColorFilter.setGrayscale(param1);
            param1.mouseEnabled = false;
        }
    }

    public function dispose():void {
        var _loc1_:MovieClip = null;
        var _loc2_:MovieClip = null;
        this._tipMC = null;
        this._eventTipList = null;
        this._gateNum = null;
        this._leftNum = null;
        if (this._doorList) {
            for each(_loc1_ in this._doorList) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onDoor);
            }
        }
        if (this._awardBag) {
            this._awardBag.removeEventListener(MouseEvent.CLICK, this.onAwardBag);
            this._awardBag = null;
        }
        if (this._eventPetList) {
            for each(_loc2_ in this._eventPetList) {
                _loc2_.removeEventListener(MouseEvent.CLICK, this.onEventPetClick);
            }
        }
    }
}
}
