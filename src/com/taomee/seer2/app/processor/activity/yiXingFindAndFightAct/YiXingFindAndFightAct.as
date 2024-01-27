package com.taomee.seer2.app.processor.activity.yiXingFindAndFightAct {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DateUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;
import flash.ui.Mouse;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;
import org.taomee.utils.Tick;

public class YiXingFindAndFightAct {

    private static var _self:YiXingFindAndFightAct;


    private var _bossNpc:Mobile;

    private var _curMapId:int;

    private var _resLib:ApplicationDomain;

    private var _hurtedMC:MovieClip;

    private var _helpHandMC:MovieClip;

    private var _yiXingShowScene:MovieClip;

    private var _npc:Mobile;

    private const FIND_DAY:uint = 837;

    private const FIND_SWAP:int = 2023;

    private const FIND_MAP:Vector.<int> = Vector.<int>([480, 204, 133, 304, 550, 480]);

    private const HURT_POS:Array = [[200, 200], [550, 90], [270, 200], [600, 200], [420, 360]];

    private var _curFindState:int;

    private const FIGHT_INDEX:int = 632;

    private const FIGHT_MAP:Vector.<int> = Vector.<int>([90, 160, 230, 320, 470, 90, 160, 230, 320, 470, 90]);

    private const MAP_NAME:Vector.<String> = Vector.<String>(["草系主城", "水系主城", "火系主城", "沙系主城", "地系主城", "草系主城", "水系主城", "火系主城", "沙系主城", "地系主城", "草系主城"]);

    private const TIME_REGION:Array = [[13, 35, 13, 38], [13, 40, 13, 43], [13, 45, 13, 48], [13, 50, 13, 53], [13, 55, 13, 58], [14, 0, 14, 3], [14, 5, 14, 8], [14, 10, 14, 13], [14, 15, 14, 18], [14, 20, 14, 23], [14, 25, 14, 28]];

    private const BOSS_POS:Array = [[300, 400], [465, 400], [420, 500], [450, 400], [420, 490], [300, 400], [465, 400], [420, 500], [450, 400], [420, 490], [300, 400]];

    private var _isTickShow:Vector.<Boolean>;

    private var _curTimeIndex:int;

    private var _mouseHint:MouseClickHintSprite;

    public function YiXingFindAndFightAct() {
        this._isTickShow = Vector.<Boolean>([false, false, false, false, false, false, false, false, false, false, false]);
        super();
    }

    public static function getInstance():YiXingFindAndFightAct {
        if (_self == null) {
            _self = new YiXingFindAndFightAct();
        }
        return _self;
    }

    public function setup():void {
        if (this.isActTime()) {
            SceneManager.addEventListener(SceneEvent.SWITCH_START, this.onMapSwitchStart);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
            this.initBossFightShowTip();
        }
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("yiXingFindAndFightAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            initRes();
        });
    }

    private function initRes():void {
        this._hurtedMC = this.getMovie("HurtedPet");
        this._helpHandMC = this.getMovie("HelpHand");
        this._yiXingShowScene = this.getMovie("YiXingShowAnimation");
        this._hurtedMC.buttonMode = true;
        this._hurtedMC.addEventListener(MouseEvent.CLICK, this.onHurtedClick);
    }

    private function onHurtedClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._hurtedMC.mouseEnabled = this._hurtedMC.mouseChildren = false;
        SwapManager.swapItem(this.FIND_SWAP, 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            _hurtedMC.mouseEnabled = _hurtedMC.mouseChildren = true;
            new SwapInfo(data);
            MovieClipUtil.playMc(_hurtedMC, 2, _hurtedMC.totalFrames, function ():void {
                _hurtedMC.gotoAndStop(1);
                DisplayUtil.removeForParent(_hurtedMC, false);
                if (_curFindState < 5) {
                    Mouse.show();
                    MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("yiXingAct/YiXingFind_" + _curFindState), function ():void {
                        SceneManager.changeScene(SceneType.LOBBY, FIND_MAP[_curFindState + 1]);
                    }, true, false, 2, true);
                } else {
                    Mouse.show();
                    SceneManager.active.mapModel.front.addChild(_yiXingShowScene);
                    MovieClipUtil.playMc(_yiXingShowScene, 2, _yiXingShowScene.totalFrames, function ():void {
                        DisplayUtil.removeForParent(_yiXingShowScene);
                        _yiXingShowScene = null;
                        findHandleDispose();
                        createBossNpc([445, 420]);
                    }, true);
                }
            }, true);
        }, function (param1:uint):void {
            _hurtedMC.mouseEnabled = _hurtedMC.mouseChildren = true;
        });
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function isActTime():Boolean {
        if (Boolean(DateUtil.isDay(2013, 10, 19)) || Boolean(DateUtil.isDay(2013, 10, 20))) {
            if (this.isBeforeHourScope(14, 28)) {
                return true;
            }
            return false;
        }
        return false;
    }

    public function getCurMapId(param1:Function = null):void {
        var callBack:Function = param1;
        DayLimitManager.getDoCount(this.FIND_DAY, function (param1:int):void {
            _curFindState = param1;
            if (_curFindState >= 6) {
                _curTimeIndex = getTimeIndex();
                if (_curTimeIndex != -1) {
                    _curMapId = FIGHT_MAP[_curTimeIndex];
                    if (callBack != null) {
                        callBack(_curMapId);
                    }
                } else {
                    _curMapId = 0;
                }
            } else {
                _curMapId = FIND_MAP[_curFindState];
                if (callBack != null) {
                    callBack(_curMapId);
                }
            }
        });
    }

    private function initBossFightShowTip():void {
        DayLimitManager.getDoCount(this.FIND_DAY, function (param1:int):void {
            _curFindState = param1;
            if (param1 >= 6) {
                startBossFightShowTip();
            } else {
                getURL();
            }
        });
    }

    private function showMouseHintAtMonster(param1:Sprite):void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -param1.height - 10;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
        param1.addChild(this._mouseHint);
    }

    private function removeMouseHint():void {
        DisplayUtil.removeForParent(this._mouseHint);
        this._mouseHint = null;
    }

    private function startBossFightShowTip():void {
        Tick.instance.removeRender(this.onTimeCheck);
        Tick.instance.addRender(this.onTimeCheck, 2000);
    }

    private function onTimeCheck(param1:int):void {
        var _loc3_:int = 0;
        var _loc2_:int = 0;
        while (_loc2_ < this.TIME_REGION.length) {
            if (DateUtil.isInHourScope(this.TIME_REGION[_loc2_][0], this.TIME_REGION[_loc2_][2], this.TIME_REGION[_loc2_][1], this.TIME_REGION[_loc2_][3])) {
                if (!this._isTickShow[_loc2_]) {
                    this._isTickShow[_loc2_] = true;
                    ServerMessager.addMessage("始祖吸血病原体【异形】已进入" + this.MAP_NAME[_loc2_] + "!");
                    if (!SceneManager.isSwitching && SceneManager.active && SceneManager.active.type == SceneType.LOBBY) {
                        ModuleManager.showModule(URLUtil.getAppModule("YiXingMainPanel"), "正在打开僵尸活动面板...");
                    }
                    if (_loc2_ == this._isTickShow.length - 1 && this.isAfterHourScope(this.TIME_REGION[_loc2_][2], this.TIME_REGION[_loc2_][3])) {
                        this.fightHandleDispose();
                    }
                }
                break;
            }
            _loc2_++;
        }
        if (Boolean(SceneManager.active) && SceneManager.active.type == SceneType.LOBBY) {
            if (this.FIGHT_MAP.indexOf(SceneManager.active.mapID) != -1) {
                if (!SceneManager.isSwitching) {
                    _loc3_ = this.getCurInTimeIndex();
                    if (_loc3_ == -1) {
                        this.removeBossNpc(1);
                    } else if (SceneManager.active.mapID == this.FIGHT_MAP[_loc3_]) {
                        this.createBossNpc(this.BOSS_POS[_loc3_], 1);
                    }
                }
            }
        }
    }

    private function getTimeIndex():int {
        var _loc1_:int = -1;
        var _loc2_:int = 0;
        while (_loc2_ < this.TIME_REGION.length) {
            if (DateUtil.isInHourScope(this.TIME_REGION[_loc2_][0], this.TIME_REGION[_loc2_][2], this.TIME_REGION[_loc2_][1], this.TIME_REGION[_loc2_][3])) {
                _loc1_ = _loc2_;
                break;
            }
            if (Boolean(this.TIME_REGION[_loc2_ + 1]) && this.isBeforeHourScope(this.TIME_REGION[_loc2_ + 1][0], this.TIME_REGION[_loc2_ + 1][1])) {
                _loc1_ = _loc2_ + 1;
                break;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    private function getCurInTimeIndex():int {
        var _loc1_:int = -1;
        var _loc2_:int = 0;
        while (_loc2_ < this.TIME_REGION.length) {
            if (DateUtil.isInHourScope(this.TIME_REGION[_loc2_][0], this.TIME_REGION[_loc2_][2], this.TIME_REGION[_loc2_][1], this.TIME_REGION[_loc2_][3])) {
                _loc1_ = _loc2_;
                break;
            }
            _loc2_++;
        }
        return _loc1_;
    }

    private function isBeforeHourScope(param1:uint, param2:uint = 0):Boolean {
        var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc4_:Date = new Date(_loc3_.fullYear, _loc3_.month, _loc3_.date, param1, param2);
        if (_loc3_ < _loc4_) {
            return true;
        }
        return false;
    }

    private function isAfterHourScope(param1:uint, param2:uint = 0):Boolean {
        var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
        var _loc4_:Date = new Date(_loc3_.fullYear, _loc3_.month, _loc3_.date, param1, param2);
        if (_loc3_ >= _loc4_) {
            return true;
        }
        return false;
    }

    private function findHandleDispose():void {
        if (this._hurtedMC) {
            this._hurtedMC.removeEventListener(MouseEvent.CLICK, this.onHurtedClick);
            DisplayUtil.removeForParent(this._hurtedMC);
            this._hurtedMC = null;
        }
        if (this._helpHandMC) {
            this._helpHandMC.stopDrag();
            DisplayUtil.removeForParent(this._helpHandMC);
            this._helpHandMC = null;
        }
        if (this._yiXingShowScene) {
            DisplayUtil.removeForParent(this._yiXingShowScene);
            this._yiXingShowScene = null;
        }
        this.removeNpc();
        this.removeBossNpc();
    }

    private function fightHandleDispose():void {
        Tick.instance.removeRender(this.onTimeCheck);
        this.removeBossNpc(1);
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.onMapSwitchStart);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onMapSwitchComplete);
    }

    private function onMapSwitchStart(param1:SceneEvent):void {
        this.removeNpc();
        Mouse.show();
        if (this._curFindState >= 6) {
            this.removeBossNpc(1);
        } else {
            this.removeBossNpc();
        }
        if (this._helpHandMC) {
            this._helpHandMC.stopDrag();
            DisplayUtil.removeForParent(this._helpHandMC, false);
        }
    }

    private function processHandle(param1:int):void {
        if (this._curFindState >= 6) {
            if (this._curMapId == SceneManager.active.mapID) {
            }
        } else {
            if (this.FIND_MAP.indexOf(SceneManager.active.mapID) == -1) {
                return;
            }
            if (this._curFindState == 0 && this._curMapId == SceneManager.active.mapID) {
                this.addNpc();
            }
            if (this._curFindState > 0 && this._curFindState <= 5 && this._curMapId == SceneManager.active.mapID) {
                this._hurtedMC.x = this.HURT_POS[this._curFindState - 1][0];
                this._hurtedMC.y = this.HURT_POS[this._curFindState - 1][1];
                SceneManager.active.mapModel.content.addChild(this._hurtedMC);
                Mouse.hide();
                this._helpHandMC.startDrag(true);
                this._helpHandMC.mouseEnabled = this._helpHandMC.mouseChildren = false;
                SceneManager.active.mapModel.front.addChild(this._helpHandMC);
            }
        }
    }

    private function addNpc():void {
        this._npc = new Mobile();
        this._npc.width = 82;
        this._npc.height = 115;
        this._npc.setPostion(new Point(650, 340));
        this._npc.resourceUrl = URLUtil.getNpcSwf(2);
        this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
        this._npc.label = "伊娃博士";
        this._npc.labelImage.y = -this._npc.height - 10;
        this._npc.buttonMode = true;
        this.showMouseHintAtMonster(this._npc);
        MobileManager.addMobile(this._npc, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function removeNpc():void {
        if (this._npc) {
            this.removeMouseHint();
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function onNpc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(2, "伊娃博士", [[0, "小赛尔！我已经发现异形病原的踪迹，现在有一个紧急的任务交给你！"]], ["好的！是什么？"], [function ():void {
            NpcDialog.show(2, "伊娃博士", [[0, "小赛尔，氏族遭到异形感染，快来一起搜救精灵，我的雷达跟踪器会告诉你一些线索的！"]], ["嗯！我一定使命必达！"], [function ():void {
                NpcDialog.show(2, "伊娃博士", [[0, "对了，这些药剂可以救治小精灵（<font color=\'#FF0000\'>发现精灵后，用鼠标点击受伤精灵就可以了</font>）！我现在要去虫穴地牢看看！"]], ["好的博士！你快去吧，这里交给我！"], [function ():void {
                    StatisticsManager.sendNovice("0x1003417D");
                    SwapManager.swapItem(FIND_SWAP, 1, function (param1:IDataInput):void {
                        var data:IDataInput = param1;
                        new SwapInfo(data);
                        removeNpc();
                        Mouse.show();
                        MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("yiXingAct/YiXingFind_" + _curFindState), function ():void {
                            SceneManager.changeScene(SceneType.LOBBY, FIND_MAP[_curFindState + 1]);
                        }, true, false, 2, true);
                    });
                }]);
            }]);
        }]);
    }

    private function createBossNpc(param1:Array, param2:int = 0):void {
        if (!this._bossNpc) {
            this._bossNpc = new Mobile();
            this._bossNpc.width = 100;
            this._bossNpc.height = 110;
            this._bossNpc.setPostion(new Point(param1[0], param1[1]));
            this._bossNpc.resourceUrl = URLUtil.getNpcSwf(635);
            this._bossNpc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._bossNpc.label = "异形";
            this._bossNpc.labelImage.y = -this._bossNpc.height - 10;
            this._bossNpc.buttonMode = true;
            MobileManager.addMobile(this._bossNpc, MobileType.NPC);
            this.showMouseHintAtMonster(this._bossNpc);
            if (param2 == 0) {
                this._bossNpc.addEventListener(MouseEvent.CLICK, this.onBossNpcClick);
            } else {
                this._bossNpc.addEventListener(MouseEvent.CLICK, this.onBossNpcClick1);
            }
        }
    }

    private function removeBossNpc(param1:int = 0):void {
        if (this._bossNpc) {
            this.removeMouseHint();
            if (param1 == 0) {
                this._bossNpc.removeEventListener(MouseEvent.CLICK, this.onBossNpcClick);
            } else {
                this._bossNpc.removeEventListener(MouseEvent.CLICK, this.onBossNpcClick1);
            }
            DisplayUtil.removeForParent(this._bossNpc);
        }
        this._bossNpc = null;
    }

    private function onBossNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(635, "异形", [[0, "尽敢碰我们的战利品？莫非你也想被咬一口？"]], ["你可能要失望了……我们机器人可没有血……"], [function ():void {
            NpcDialog.show(635, "异形", [[0, "哼！那你就来领教一下始祖吸血家族的厉害！"]], ["来啊！谁怕谁啊！"], [function ():void {
                NpcDialog.show(635, "异形", [[0, "口气倒不小，这个星球已经被我们弟兄侵入！处处都有我们的身影，有种就来找我们吧。"]], ["你们跑不掉的！"], [function ():void {
                    removeBossNpc();
                    getCurMapId(function (param1:int):void {
                        startBossFightShowTip();
                        if (_curMapId != 0) {
                            SceneManager.changeScene(SceneType.LOBBY, _curMapId);
                        }
                    });
                }]);
            }]);
        }]);
    }

    private function onBossNpcClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(635, "异形", [[0, "没血的家伙靠边站！或者像样的来和我打一场！"]], ["来吧!"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function onMapSwitchComplete(param1:SceneEvent):void {
        if (this.FIND_MAP.indexOf(SceneManager.active.mapID) != -1 || this.FIGHT_MAP.indexOf(SceneManager.active.mapID) != -1) {
            this.getCurMapId(this.processHandle);
        }
    }
}
}
