package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.preview.ActorPreview;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80026 extends CopyProcessor {


    private const BOSS_INDEX:Vector.<int> = Vector.<int>([452, 448, 449, 453]);

    private const POS_LIST:Array = [[587, 230], [607, 290], [[369, 290], [607, 290], [833, 290]], [352, 220]];

    private const ACTOR_SCALE:Vector.<Number> = Vector.<Number>([0.4, 0.5, 0.4]);

    private var _stateOneNpc:MovieClip;

    private var _stateTwoNpc:ActorPreview;

    private var _stateThreeNpc:Vector.<ActorPreview>;

    private var _stateFourNpc:MovieClip;

    public function CopyProcessor_80026(param1:CopyItemInfo) {
        super(param1);
    }

    override protected function tatisticsHandle():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_477);
    }

    override public function returnSceneHandle():void {
        var _loc1_:int = 0;
        if (this._stateOneNpc) {
            this._stateOneNpc.play();
            _mapModel.content.addChildAt(this._stateOneNpc, 0);
        }
        if (this._stateTwoNpc) {
            _mapModel.content.addChildAt(this._stateTwoNpc, 0);
        }
        if (this._stateThreeNpc) {
            _loc1_ = 0;
            while (_loc1_ < 3) {
                this._stateThreeNpc[_loc1_].x = this.POS_LIST[2][_loc1_][0];
                this._stateThreeNpc[_loc1_].y = this.POS_LIST[2][_loc1_][1];
                _mapModel.content.addChildAt(this._stateThreeNpc[_loc1_], 0);
                _loc1_++;
            }
        }
        if (this._stateFourNpc) {
            this._stateFourNpc.play();
            _mapModel.content.addChildAt(this._stateFourNpc, 0);
        }
    }

    override public function onAnimationLoaded():void {
        var i:int;
        (_mapModel.content["mirror"] as MovieClip).mouseEnabled = (_mapModel.content["mirror"] as MovieClip).mouseChildren = false;
        i = 0;
        while (i < 3) {
            (_mapModel.content["mark" + i] as MovieClip).mouseEnabled = (_mapModel.content["mark" + i] as MovieClip).mouseChildren = false;
            i++;
        }
        this.cartoonHandle("80025_1", "", function ():void {
            _stateOneNpc = getResFromDomain("npc_1");
            _stateOneNpc.x = POS_LIST[0][0];
            _stateOneNpc.y = POS_LIST[0][1];
            _stateOneNpc.buttonMode = true;
            _mapModel.content.addChildAt(_stateOneNpc, 0);
            _mapModel.content.addChildAt(_stateOneNpc, 0);
            _stateOneNpc.addEventListener(MouseEvent.CLICK, onNpcClick);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
        });
    }

    private function onComplete(param1:SceneEvent):void {
        var index:int = 0;
        var posIndex:int = 0;
        var evt:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                index = int(FightManager.currentFightRecord.initData.positionIndex);
                if (this.BOSS_INDEX.indexOf(index) != -1) {
                    posIndex = this.BOSS_INDEX.indexOf(index);
                    if (posIndex == 0) {
                        this.cartoonHandle("80025_2", "", function ():void {
                            _stateOneNpc.removeEventListener(MouseEvent.CLICK, onNpcClick);
                            DisplayUtil.removeForParent(_stateOneNpc);
                            _stateOneNpc = null;
                            _stateTwoNpc = new ActorPreview();
                            _stateTwoNpc.scaleX = ACTOR_SCALE[1];
                            _stateTwoNpc.scaleY = ACTOR_SCALE[1];
                            _stateTwoNpc.setData(ActorManager.actorInfo);
                            _stateTwoNpc.buttonMode = true;
                            _stateTwoNpc.x = POS_LIST[1][0];
                            _stateTwoNpc.y = POS_LIST[1][1];
                            _mapModel.content.addChildAt(_stateTwoNpc, 0);
                            _stateTwoNpc.mask = _mapModel.content["mark1"];
                            _stateTwoNpc.addEventListener(MouseEvent.CLICK, onNpcClick);
                        });
                    } else if (posIndex == 1) {
                        this.cartoonHandle("80025_3", "", function ():void {
                            var _loc1_:ActorPreview = null;
                            DisplayUtil.removeForParent(_stateTwoNpc);
                            _stateTwoNpc.removeEventListener(MouseEvent.CLICK, onNpcClick);
                            _stateTwoNpc = null;
                            _stateThreeNpc = new Vector.<ActorPreview>();
                            var _loc2_:int = 0;
                            while (_loc2_ < 3) {
                                _loc1_ = new ActorPreview();
                                _loc1_.setData(ActorManager.actorInfo);
                                if (_loc2_ == 0) {
                                    _loc1_.scaleX = -ACTOR_SCALE[_loc2_];
                                    _loc1_.scaleY = ACTOR_SCALE[_loc2_];
                                } else {
                                    _loc1_.scaleX = ACTOR_SCALE[_loc2_];
                                    _loc1_.scaleY = ACTOR_SCALE[_loc2_];
                                }
                                _loc1_.x = POS_LIST[2][_loc2_][0];
                                _loc1_.y = POS_LIST[2][_loc2_][1];
                                _loc1_.buttonMode = true;
                                _stateThreeNpc.push(_loc1_);
                                _mapModel.content.addChildAt(_loc1_, 0);
                                _loc1_.mask = _mapModel.content["mark" + _loc2_];
                                _loc1_.addEventListener(MouseEvent.CLICK, onNpcClick);
                                _loc2_++;
                            }
                        });
                    } else if (posIndex == 2) {
                        this.cartoonHandle("80025_4", "", function ():void {
                            var _loc1_:ActorPreview = null;
                            for each(_loc1_ in _stateThreeNpc) {
                                _loc1_.removeEventListener(MouseEvent.CLICK, onNpcClick);
                                DisplayUtil.removeForParent(_loc1_);
                                _loc1_ = null;
                            }
                            _stateThreeNpc = null;
                            _stateFourNpc = getResFromDomain("npc_2");
                            _stateFourNpc.x = POS_LIST[3][0];
                            _stateFourNpc.y = POS_LIST[3][1];
                            _stateFourNpc.buttonMode = true;
                            _mapModel.content.addChildAt(_stateFourNpc, 0);
                            _stateFourNpc.addEventListener(MouseEvent.CLICK, onNpcClick);
                        });
                    } else if (posIndex == 3) {
                        DisplayUtil.removeForParent(this._stateFourNpc);
                        this._stateFourNpc = null;
                        completeTipShow(10, 50, "妒忌之尘");
                    }
                }
            }
        }
    }

    private function cartoonHandle(param1:String, param2:String = "", param3:Function = null, param4:Function = null):void {
        var fullScreenName:String = param1;
        var sceneTalkName:String = param2;
        var fun:Function = param3;
        var fun1:Function = param4;
        MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen(fullScreenName), function ():void {
            var _scenMc:MovieClip = null;
            if (null != fun) {
                fun.call();
            }
            if (sceneTalkName != "") {
                _scenMc = getResFromDomain(sceneTalkName);
                _mapModel.front.addChild(_scenMc);
                MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                    DisplayUtil.removeForParent(_scenMc);
                    _scenMc = null;
                    if (null != fun1) {
                        fun1.call();
                    }
                }, true);
            }
        }, true, true, 2, false);
    }

    private function clearEvent():void {
        var _loc1_:ActorPreview = null;
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        if (this._stateOneNpc) {
            this._stateOneNpc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
        if (this._stateTwoNpc) {
            this._stateTwoNpc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
        if (this._stateFourNpc) {
            this._stateFourNpc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
        if (this._stateThreeNpc) {
            for each(_loc1_ in this._stateThreeNpc) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            }
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        if (this._stateThreeNpc) {
            if (this._stateThreeNpc.indexOf(param1.currentTarget as ActorPreview) != -1) {
                ModuleManager.showModule(URLUtil.getAppModule("PetSelectFightPanel"), "正在打开pve精灵战斗选择面板...", {
                    "mode": 15,
                    "posIndex": this.BOSS_INDEX[2],
                    "min": 3,
                    "max": 3
                });
                return;
            }
        }
        switch (param1.currentTarget) {
            case this._stateOneNpc:
                FightManager.startFightWithWild(this.BOSS_INDEX[0]);
                break;
            case this._stateTwoNpc:
                FightManager.startFightWithWild(this.BOSS_INDEX[1]);
                break;
            case this._stateFourNpc:
                FightManager.startFightWithWild(this.BOSS_INDEX[3]);
        }
    }

    override public function dispose():void {
        var _loc1_:ActorPreview = null;
        super.dispose();
        this.clearEvent();
        DisplayUtil.removeForParent(this._stateOneNpc);
        this._stateOneNpc = null;
        DisplayUtil.removeForParent(this._stateTwoNpc);
        this._stateTwoNpc = null;
        if (this._stateThreeNpc) {
            for each(_loc1_ in this._stateThreeNpc) {
                DisplayUtil.removeForParent(_loc1_);
            }
            this._stateThreeNpc = null;
        }
        DisplayUtil.removeForParent(this._stateFourNpc);
        this._stateFourNpc = null;
    }
}
}
