package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.utils.IDataInput;
import flash.utils.clearInterval;
import flash.utils.setInterval;

public class MapProcessor_80249 extends MapProcessor {

    public static var FOREVER_LIMIT:Array = [204607, 204608, 204611, 204616, 204678, 204679, 204680];

    public static var SWAP_ID:Array = [3090, 3099, 3100];

    public static var FIGHT_ID:Array = [1165, 1166, 1167, 1168, 1169];

    public static var _fightIndex:int;

    public static var _copyOverBoo:Boolean = false;

    private static var _readyFightBoo:Boolean;


    private var _barCount:int;

    private var _fightBtn:SimpleButton;

    private var _readyBtn:SimpleButton;

    private var _bossItem:MovieClip;

    private var _exitBtn:SimpleButton;

    private var _mask:MovieClip;

    private var _maxNum:int = 375;

    private var _seaWaveBg:MovieClip;

    private var _threeEnterBg:MovieClip;

    private var _hurtBar:MovieClip;

    private var _fightBoo:Boolean;

    public function MapProcessor_80249(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        _map.front.visible = true;
        this._hurtBar = _map.front["enter"];
        _map.front["ready"].visible = false;
        _map.front["enter"].visible = false;
        _map.front["seaWave"].visible = false;
        _map.front["threeEnter"].visible = false;
        _map.ground["monster0"].visible = true;
        _map.ground["monster1"].visible = false;
        MovieClip(_map.front["mcPlayer0"]).stop();
        MovieClip(_map.front["mcPlayer0"]).visible = false;
        MovieClip(_map.front["mcPlayer1"]).stop();
        MovieClip(_map.front["mcPlayer1"]).visible = false;
        this._mask = _map.front["enter"]["hurtBar"]["mask"];
        this.updata();
        ServerBufferManager.getServerBuffer(ServerBufferType.MAILINGSHEN_FIRST, function (param1:ServerBuffer):void {
            var _loc2_:Boolean = Boolean(param1.readDataAtPostion(1));
            ServerBufferManager.updateServerBuffer(ServerBufferType.MAILINGSHEN_FIRST, 1, 1);
            if (_loc2_ == false) {
                MovieClip(_map.front["mcPlayer0"]).gotoAndPlay(2);
                play0();
            } else {
                _map.front["threeEnter"].visible = true;
                setup();
            }
        });
        this._hurtBar["getPet0"].addEventListener(MouseEvent.CLICK, this.onGetRwd);
        this._hurtBar["getPet1"].addEventListener(MouseEvent.CLICK, this.onGetRwd);
        this._hurtBar["getPet2"].addEventListener(MouseEvent.CLICK, this.onGetRwd);
    }

    private function onGetRwd(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        switch (evt.currentTarget) {
            case this._hurtBar["getPet0"]:
                SwapManager.swapItem(SWAP_ID[1], 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    updata();
                });
                break;
            case this._hurtBar["getPet1"]:
                SwapManager.swapItem(SWAP_ID[2], 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    updata();
                });
                break;
            case this._hurtBar["getPet2"]:
                SwapManager.swapItem(SWAP_ID[0], 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    updata();
                });
        }
    }

    private function play0():void {
        var cc:uint = 0;
        cc = setInterval(function ():void {
            if (MovieClip(_map.front["mcPlayer0"]).currentFrame >= 46) {
                clearInterval(cc);
                MovieClip(_map.front["mcPlayer0"]).stop();
                MovieClip(_map.front["mcPlayer0"]).visible = false;
                NpcDialog.show(400, "小赛尔", [[0, "脉灵兽果然也睡着了"]], ["赛尔，你看这边黑黑的？"], [function ():void {
                    NpcDialog.show(113, "NONO", [[0, "很明显这是梦魇搞的鬼"]], ["怎么办？"], [function ():void {
                        NpcDialog.show(400, "小赛尔", [[0, "快把这些该死的黑雾清理掉"]], ["嗯！一起来吧！"], [function ():void {
                            play1();
                        }]);
                    }]);
                }]);
            }
        }, 30);
    }

    private function play1():void {
        var bb:uint = 0;
        MovieClip(_map.front["mcPlayer1"]).visible = true;
        MovieClip(_map.front["mcPlayer1"]).gotoAndPlay(2);
        bb = setInterval(function ():void {
            if (MovieClip(_map.front["mcPlayer1"]).currentFrame >= 46) {
                clearInterval(bb);
                MovieClip(_map.front["mcPlayer1"]).stop();
                MovieClip(_map.front["mcPlayer1"]).visible = false;
                setup();
            }
        }, 30);
    }

    private function openPlayer():void {
        if (_copyOverBoo) {
            _copyOverBoo = false;
            this.setup();
            return;
        }
    }

    private function setup():void {
        _map.front["ready"].visible = false;
        _map.front["enter"].visible = true;
        _map.front["seaWave"].visible = false;
        _map.front["threeEnter"].visible = true;
        MovieClip(_map.front["mcPlayer0"]).stop();
        MovieClip(_map.front["mcPlayer0"]).visible = false;
        MovieClip(_map.front["mcPlayer1"]).stop();
        MovieClip(_map.front["mcPlayer1"]).visible = false;
        this._fightBtn = _map.front["ready"]["fightBtn"];
        this._readyBtn = _map.front["ready"]["readyBtn"];
        this._bossItem = _map.front["ready"]["bossItem"];
        this._exitBtn = _map.front["enter"]["exitBtn"];
        this._mask.height = this._barCount / 200 * this._maxNum;
        this._mask.y = 0;
        this._fightBtn.addEventListener(MouseEvent.CLICK, this.onClick);
        this._readyBtn.addEventListener(MouseEvent.CLICK, this.onClick);
        this._exitBtn.addEventListener(MouseEvent.CLICK, this.onExitCopy);
        var _loc1_:SimpleButton = _map.front["enter"]["enterBtn"] as SimpleButton;
        _loc1_.addEventListener(MouseEvent.CLICK, this.onEnter);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }

    private function onExitCopy(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
        ModuleManager.showAppModule("MaiLingShenSuperProcessPanel");
        ModuleManager.closeForName("MaiLingShenFightSelectPanel");
    }

    private function onClick(param1:MouseEvent):void {
        switch (param1.currentTarget) {
            case this._fightBtn:
                FightManager.startFightWithWild(FIGHT_ID[_fightIndex]);
                break;
            case this._readyBtn:
                _map.front["ready"].visible = false;
                _map.front["enter"].visible = true;
                _readyFightBoo = true;
        }
    }

    private function onEnter(param1:MouseEvent):void {
        if (_readyFightBoo) {
            _readyFightBoo = false;
            _map.front["ready"].visible = true;
            _map.front["enter"].visible = false;
        } else {
            ModuleManager.showAppModule("MaiLingShenFightSelectPanel", {"fun": this.copyType});
        }
    }

    private function copyType(param1:int):void {
        var index:int = param1;
        _fightIndex = index;
        if (index == 0) {
            _map.front["seaWave"].visible = true;
            _map.ground["monster0"].visible = true;
            _map.ground["monster1"].visible = false;
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("maiLingShen/MaiLingShenProcessMc"), function ():void {
                NpcDialog.show(813, "脉灵兽", [[0, "小赛尔，谢谢你让我从海啸中复苏！"]], ["我会让你变得更强大"], [function ():void {
                    FightManager.startFightWithWild(FIGHT_ID[0]);
                }]);
            }, true, true, 2, true);
        } else {
            _map.front["seaWave"].visible = false;
            _map.front.visible = true;
            _map.front["ready"].visible = true;
            _map.front["enter"].visible = false;
            this._bossItem.gotoAndStop(index);
        }
    }

    private function quitCopy():void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
        ModuleManager.showAppModule("MaiLingShenSuperProcessPanel");
    }

    private function updata():void {
        ActiveCountManager.requestActiveCountList([FOREVER_LIMIT[2], FOREVER_LIMIT[3], FOREVER_LIMIT[4], FOREVER_LIMIT[5], FOREVER_LIMIT[6]], function (param1:Parser_1142):void {
            var _loc2_:uint = param1.infoVec[1];
            if (_loc2_ > 200) {
                _loc2_ = 200;
            }
            var _loc3_:int = _loc2_ - _barCount;
            _barCount = _loc2_;
            _mask.height = _barCount / 200 * _maxNum;
            _mask.y = 0;
            var _loc4_:int;
            if (_loc4_ = int(param1.infoVec[0])) {
                _map.front.visible = false;
                _map.ground["monster0"].visible = false;
                _map.ground["monster1"].visible = true;
                FightManager.startFightWithWild(FIGHT_ID[_loc4_ - 1]);
            } else {
                _map.ground["monster0"].visible = true;
                _map.ground["monster1"].visible = false;
                openPlayer();
            }
            if (_copyOverBoo) {
                ServerMessager.addMessage("获得海啸值 +" + _loc3_);
            }
            if (_barCount >= 50) {
                if (int(param1.infoVec[2]) == 0) {
                    DisplayObjectUtil.enableButton(_hurtBar["getPet0"]);
                    _hurtBar["rwdState0"].visible = false;
                } else {
                    DisplayObjectUtil.disableButton(_hurtBar["getPet0"]);
                    _hurtBar["rwdState0"].visible = true;
                }
            } else {
                _hurtBar["rwdState0"].visible = false;
                DisplayObjectUtil.disableButton(_hurtBar["getPet0"]);
            }
            if (_barCount >= 100) {
                if (int(param1.infoVec[3]) == 0) {
                    DisplayObjectUtil.enableButton(_hurtBar["getPet1"]);
                    _hurtBar["rwdState1"].visible = false;
                } else {
                    DisplayObjectUtil.disableButton(_hurtBar["getPet1"]);
                    _hurtBar["rwdState1"].visible = true;
                }
            } else {
                _hurtBar["rwdState1"].visible = false;
                DisplayObjectUtil.disableButton(_hurtBar["getPet1"]);
            }
            if (_barCount >= 200) {
                if (int(param1.infoVec[4]) == 0) {
                    DisplayObjectUtil.enableButton(_hurtBar["getPet2"]);
                    _hurtBar["rwdState2"].visible = false;
                } else {
                    DisplayObjectUtil.disableButton(_hurtBar["getPet2"]);
                    _hurtBar["rwdState2"].visible = true;
                }
            } else {
                _hurtBar["rwdState2"].visible = false;
                DisplayObjectUtil.disableButton(_hurtBar["getPet2"]);
            }
        });
    }

    private function onComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            _loc2_ = FIGHT_ID.indexOf(FightManager.currentFightRecord.initData.positionIndex);
            if (_loc2_ != -1) {
            }
            _copyOverBoo = true;
        }
    }

    override public function dispose():void {
        var _loc1_:SimpleButton = null;
        if (this._fightBtn != null) {
            this._fightBtn.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._readyBtn.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._exitBtn.removeEventListener(MouseEvent.CLICK, this.onExitCopy);
            _loc1_ = _map.front["enter"]["exitBtn"] as SimpleButton;
            _loc1_.removeEventListener(MouseEvent.CLICK, this.onEnter);
        }
        super.dispose();
    }
}
}
