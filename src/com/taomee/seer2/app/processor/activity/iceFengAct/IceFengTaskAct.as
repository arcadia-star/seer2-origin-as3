package com.taomee.seer2.app.processor.activity.iceFengAct {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;
import org.taomee.utils.Tick;

public class IceFengTaskAct {

    private static var _instance:IceFengTaskAct;


    private var _eggFollow:Mobile;

    private var _taskTip:MovieClip;

    private var _resLib:ApplicationDomain;

    private const FOR_LIST:Array = [203889, 203890, 203900];

    private const SWAP_LIST:Vector.<int> = Vector.<int>([2561]);

    private const EGG_ID:int = 3030;

    private const MAP_ID:Vector.<int> = Vector.<int>([80162, 80163, 80164, 80165, 80166]);

    private const CD_TIME:int = 180;

    private const TASK_FINISH:Vector.<int> = Vector.<int>([1, 3, 1, 3, 1]);

    private var _leaveTime:uint;

    private var _par:Parser_1142;

    private var _tipMc:MovieClip;

    private const MINE_ID_LIST:Vector.<int> = Vector.<int>([308, 309, 307]);

    private const POS:Array = [[0, 0], [0, 0], [0, 0]];

    private const MONSTER_NAME:Vector.<String> = Vector.<String>(["法拉", "奇鲁"]);

    private var _mineCurIndex:int;

    private var _curFightIndex:int;

    public function IceFengTaskAct() {
        super();
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onStateHandle);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onStateDispose);
    }

    public static function getInstance():IceFengTaskAct {
        if (_instance == null) {
            _instance = new IceFengTaskAct();
        }
        return _instance;
    }

    public function addFollow():void {
        this._eggFollow = new Mobile();
        this._eggFollow.resourceUrl = URLUtil.getPetSwf(this.EGG_ID);
        ActorManager.getActor().addCarriedMobile(this._eggFollow, 50);
        this._eggFollow.setPostion(new Point(ActorManager.getActor().x + 100, ActorManager.getActor().y));
        this._taskTip = UIManager.getMovieClip("UI_Nono_Msg");
        this._taskTip.x = -this._eggFollow.width / 2;
        this._taskTip.y = -this._taskTip.height - 20;
        this._eggFollow.addChild(this._taskTip);
        this._eggFollow.buttonMode = true;
        this._eggFollow.addEventListener(MouseEvent.CLICK, this.onEggFollowClick);
    }

    private function onEggFollowClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("IcePetComePanel"), "正在打开面板...");
    }

    private function onStateHandle(param1:SceneEvent):void {
        var index:int = 0;
        var evt:SceneEvent = param1;
        if (SceneManager.currentSceneType != SceneType.ARENA) {
            index = this.MAP_ID.indexOf(SceneManager.active.mapID);
            if (index != -1) {
                ActiveCountManager.requestActiveCountList(this.FOR_LIST, function (param1:Parser_1142):void {
                    var par:Parser_1142 = param1;
                    _par = par;
                    if (isNeedSetState()) {
                        SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                            new SwapInfo(param1);
                            if ([0, 2, 4].indexOf(index) != -1) {
                                mineHandleInit([0, 2, 4].indexOf(index));
                            } else {
                                fightHandleInit([1, 3].indexOf(index));
                            }
                            updateFollowState();
                        });
                    } else {
                        if ([0, 2, 4].indexOf(index) != -1) {
                            mineHandleInit([0, 2, 4].indexOf(index));
                        } else {
                            fightHandleInit([1, 3].indexOf(index));
                        }
                        updateFollowState();
                    }
                });
            }
        }
    }

    private function isNeedSetState():Boolean {
        var _loc1_:Boolean = false;
        if (this._par.infoVec[0] == 0) {
            _loc1_ = false;
        }
        if (this._par.infoVec[0] >= 1 && this._par.infoVec[0] <= 4) {
            if (SceneManager.prevSceneType == SceneType.ARENA && (this._par.infoVec[0] == 2 || this._par.infoVec[0] == 4)) {
                if (this._par.infoVec[1] == this.TASK_FINISH[this._par.infoVec[0] - 1]) {
                    ServerMessager.addMessage("任务完成，获得20成熟度!");
                }
            }
            if (this._par.infoVec[1] >= this.TASK_FINISH[this._par.infoVec[0] - 1] && TimeManager.getPrecisionServerTime() >= this._par.infoVec[2] + this.CD_TIME) {
                _loc1_ = true;
            }
        }
        if (this._par.infoVec[0] == 5) {
            if (this._par.infoVec[1] >= this.TASK_FINISH[this._par.infoVec[0] - 1]) {
                _loc1_ = true;
            }
        }
        return _loc1_;
    }

    private function FollowAfterCD():void {
        ActiveCountManager.requestActiveCountList(this.FOR_LIST, function (param1:Parser_1142):void {
            var par:Parser_1142 = param1;
            _par = par;
            if (isNeedSetState()) {
                SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    updateFollowState();
                });
            } else {
                updateFollowState();
            }
        });
    }

    private function updateFollowState():void {
        Tick.instance.removeRender(this.onTimeCount);
        if (TimeManager.getPrecisionServerTime() >= this._par.infoVec[2] + this.CD_TIME) {
            this._taskTip.visible = true;
        } else {
            this._taskTip.visible = false;
            this._leaveTime = this._par.infoVec[2] + this.CD_TIME - TimeManager.getPrecisionServerTime();
            Tick.instance.addRender(this.onTimeCount, 1000);
        }
    }

    private function onTimeCount(param1:int):void {
        --this._leaveTime;
        if (this._leaveTime <= 0) {
            Tick.instance.removeRender(this.onTimeCount);
            this._taskTip.visible = true;
        }
    }

    private function mineHandleInit(param1:int):void {
        var curIndex:int = param1;
        this._mineCurIndex = curIndex;
        if (this._par.infoVec[0] == this.MAP_ID.indexOf(SceneManager.active.mapID) + 1) {
            this.getURL(function ():void {
                if (_par.infoVec[1] == 0) {
                    if (SceneManager.active.mapModel) {
                        _tipMc = getMovie("MineTip" + _mineCurIndex.toString());
                        _tipMc.x = POS[_mineCurIndex][0];
                        _tipMc.y = POS[_mineCurIndex][1];
                        _tipMc.mouseEnabled = _tipMc.mouseChildren = false;
                        SceneManager.active.mapModel.front.addChild(_tipMc);
                        ItemManager.addEventListener1(ItemEvent.MINE_SUCCESS, onMine);
                    }
                }
            });
        }
    }

    private function onMine(param1:ItemEvent):void {
        var evt:ItemEvent = param1;
        if (int(evt.content) == this.MINE_ID_LIST[this._mineCurIndex]) {
            DisplayUtil.removeForParent(this._tipMc);
            this._tipMc = null;
            ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, this.onMine);
            ServerMessager.addMessage("任务完成，获得20成熟度!");
            ActiveCountManager.requestActiveCountList(this.FOR_LIST, function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                _par = par;
                if (isNeedSetState()) {
                    SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                        var data:IDataInput = param1;
                        new SwapInfo(data);
                        updateFollowState();
                        if (_mineCurIndex == 2) {
                            ServerMessager.addMessage("你已经获得冰凤皇咯，赶快去进行极冰进化吧，让你的冰凤皇进化成为极冰凤皇！");
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(3, function ():void {
                                ModuleManager.showModule(URLUtil.getAppModule("IcePetComePanel"), "正在打开面板...");
                            });
                        } else {
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(3, function ():void {
                                ModuleManager.toggleModule(URLUtil.getAppModule("IcePetComePanel"));
                            });
                        }
                    });
                } else {
                    updateFollowState();
                    if (_mineCurIndex == 2) {
                        ServerMessager.addMessage("你已经获得冰凤皇咯，赶快去进行极冰进化吧，让你的冰凤皇进化成为极冰凤皇！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.showModule(URLUtil.getAppModule("IcePetComePanel"), "正在打开面板...");
                        });
                    } else {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.toggleModule(URLUtil.getAppModule("IcePetComePanel"));
                        });
                    }
                }
            });
        }
    }

    private function getURL(param1:Function = null):void {
        var callBack:Function = param1;
        QueueLoader.load(URLUtil.getActivityAnimation("iceFengTaskAct/IceFengTaskAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            if (callBack != null) {
                callBack();
            }
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function mineHandleDispose():void {
        ItemManager.removeEventListener1(ItemEvent.MINE_SUCCESS, this.onMine);
    }

    private function fightHandleInit(param1:int):void {
        var curIndex:int = param1;
        this._curFightIndex = curIndex;
        if (this._par.infoVec[0] == this.MAP_ID.indexOf(SceneManager.active.mapID) + 1) {
            if (SceneManager.prevSceneType != SceneType.ARENA) {
                ServerMessager.addMessage("击败场景中3只" + this.MONSTER_NAME[this._curFightIndex] + "就可以获得20点成熟度咯。");
            } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex <= 9) {
                ActiveCountManager.requestActiveCountList(this.FOR_LIST, function (param1:Parser_1142):void {
                    var par:Parser_1142 = param1;
                    _par = par;
                    if (_par.infoVec[1] == 3) {
                        ServerMessager.addMessage("任务完成，获得20成熟度!");
                        ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                            var par:Parser_1142 = param1;
                            _par = par;
                            if (isNeedSetState()) {
                                SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                                    new SwapInfo(param1);
                                    updateFollowState();
                                    ModuleManager.toggleModule(URLUtil.getAppModule("IcePetComePanel"));
                                });
                            } else {
                                updateFollowState();
                                ModuleManager.toggleModule(URLUtil.getAppModule("IcePetComePanel"));
                            }
                        });
                    }
                });
            }
        }
    }

    private function fightHandleDispose():void {
    }

    private function onStateDispose(param1:SceneEvent):void {
        if (this.MAP_ID.indexOf(SceneManager.prevMapID) != -1) {
            this.mineHandleDispose();
            this.fightHandleDispose();
        }
        if (SceneManager.currentSceneType == SceneType.ARENA) {
            Tick.instance.removeRender(this.onTimeCount);
        }
    }
}
}
