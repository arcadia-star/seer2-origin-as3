package com.taomee.seer2.app.animationInteractive {
import com.greensock.TweenLite;
import com.greensock.easing.Linear;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.ByteArray;

public class VipTurnTable extends BaseAniamationInteractive {


    private var _level:int;

    private var _rewardIdVec:Vector.<int>;

    private var _rewardCntVec:Vector.<int>;

    private var _rewardIconVec:Vector.<MovieClip>;

    private var _reduceGameCoinBtn:SimpleButton;

    private var _ball:MovieClip;

    private var _BaffleVec:Vector.<MovieClip>;

    private var _mouseHint:MovieClip;

    private var _result:int;

    private var pointVec:Vector.<Point>;

    private var _moveIndex:int;

    private var _durVec:Vector.<Number>;

    public function VipTurnTable(param1:int, param2:Vector.<int>, param3:Vector.<int>) {
        this.pointVec = Vector.<Point>([new Point(645, 94), new Point(645, 147), new Point(486, 165), new Point(645, 230), new Point(486, 246), new Point(645, 304), new Point(460, 322), new Point(645, 377), new Point(486, 394), new Point(645, 494), new Point(311, 363)]);
        this._durVec = Vector.<Number>([167, 53, 160, 83, 160, 74, 186, 73, 160, 117, 154]);
        this._level = param1;
        this._rewardIdVec = param2;
        this._rewardCntVec = param3;
        super();
    }

    override protected function paramAnimation():void {
        LayerManager.moduleLayer.addChild(_animation);
        this._reduceGameCoinBtn = _animation["reduceGameCoinBtn"];
        this._ball = _animation["ball"];
        this._BaffleVec = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 4) {
            this._BaffleVec.push(_animation["Baffle_" + _loc1_]);
            _loc1_++;
        }
        this._mouseHint = _animation["mouseHint"];
        this.hideMouseHint();
        _animation["levelMC"].gotoAndStop(this._level);
        this.loadRewardIcon();
        this.judgeGameRequest();
    }

    private function hideMouseHint():void {
        this._mouseHint.gotoAndStop(1);
        this._mouseHint.visible = false;
    }

    private function showMouseHint():void {
        this._mouseHint.gotoAndPlay(2);
        this._mouseHint.visible = true;
    }

    private function loadRewardIcon():void {
        var _loc2_:IconDisplayer = null;
        this._rewardIconVec = new Vector.<MovieClip>();
        var _loc1_:int = 0;
        while (_loc1_ < 10) {
            this._rewardIconVec.push(_animation["icon_" + _loc1_]);
            _loc2_ = new IconDisplayer();
            _loc2_.setIconUrl(ItemConfig.getItemIconUrl(this._rewardIdVec[_loc1_]));
            this._rewardIconVec[_loc1_]["numTxt"].text = this._rewardCntVec[_loc1_].toString();
            this._rewardIconVec[_loc1_]["icon"].addChild(_loc2_);
            TooltipManager.addCommonTip(this._rewardIconVec[_loc1_], ItemConfig.getItemName(this._rewardIdVec[_loc1_]));
            _loc1_++;
        }
    }

    private function judgeGameRequest():void {
        _animation["tipMC"].gotoAndStop(this._level);
        if (VipManager.vipInfo.level < this._level) {
            _animation["tipMC"].visible = true;
            this._reduceGameCoinBtn.visible = false;
        } else {
            _animation["tipMC"].visible = false;
            this._reduceGameCoinBtn.visible = true;
            this._reduceGameCoinBtn.addEventListener(MouseEvent.CLICK, this.reduceGameCoin);
        }
    }

    private function reduceGameCoin(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ItemManager.requestItemList(function ():void {
            var data:ByteArray = null;
            var gameCoin:int = ItemManager.getItemQuantityByReferenceId(400102);
            if (gameCoin >= 1) {
                data = new ByteArray();
                data.writeByte(_level);
                Connection.addCommandListener(CommandSet.LUCKY_TURN_TABLE_1170, onreduceGameCoin);
                Connection.send(CommandSet.LUCKY_TURN_TABLE_1170, data);
            } else {
                AlertManager.showConfirm("要投1枚游戏牌才能开始游戏哦！看看游戏牌怎么兑换吧？", function ():void {
                    ModuleManager.toggleModule(URLUtil.getAppModule("NewVipPanel"), "正在vip面板...", {"currentTab": 2});
                });
            }
        });
    }

    private function onreduceGameCoin(param1:MessageEvent):void {
        var ani:MovieClip = null;
        var evt:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.LUCKY_TURN_TABLE_1170, this.onreduceGameCoin);
        this._reduceGameCoinBtn.visible = false;
        ItemManager.reduceItemQuantity(400102, 1);
        this._result = evt.message.getRawDataCopy().readUnsignedByte() - 1;
        ani = getMovieClip("timeMC");
        LayerManager.topLayer.addChild(ani);
        MovieClipUtil.playMc(ani, 1, ani.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(ani);
            startGame();
        }, true);
    }

    private function startGame():void {
        _animation["Baffle"].visible = false;
        this.showMouseHint();
        this.rotationReward();
        this.moveBall(0);
        _animation.addEventListener(MouseEvent.CLICK, this.onStageClick);
    }

    private function onStageClick(param1:MouseEvent):void {
        var _loc5_:int = 0;
        this.hideMouseHint();
        _animation.removeEventListener(MouseEvent.CLICK, this.onStageClick);
        var _loc2_:int = 560;
        var _loc3_:int = -1;
        var _loc4_:int = 0;
        while (_loc4_ < 4) {
            _loc5_ = Math.abs(this._BaffleVec[_loc4_].y - this._ball.y);
            if (_loc2_ > _loc5_) {
                _loc2_ = _loc5_;
                _loc3_ = _loc4_;
            }
            _loc4_++;
        }
        MovieClipUtil.playMc(this._BaffleVec[_loc3_], 1, this._BaffleVec[_loc3_].totalFrames);
    }

    private function rotationReward():void {
        var _loc1_:Number = (this._result + 1) * 40 / 717;
        var _loc2_:int = 4;
        while (_loc2_ < 10) {
            if (_loc2_ == 4) {
                TweenLite.to(this._rewardIconVec[_loc2_], _loc1_, {
                    "ease": Linear.easeNone,
                    "x": this._rewardIconVec[9].x,
                    "y": this._rewardIconVec[9].y,
                    "onComplete": this.rotationReward
                });
            } else {
                TweenLite.to(this._rewardIconVec[_loc2_], _loc1_, {
                    "ease": Linear.easeNone,
                    "x": this._rewardIconVec[_loc2_ - 1].x,
                    "y": this._rewardIconVec[_loc2_ - 1].y,
                    "onComplete": this.rotationReward
                });
            }
            _loc2_++;
        }
    }

    private function stopRotationReward():void {
        var _loc1_:int = 4;
        while (_loc1_ < 10) {
            TweenLite.killTweensOf(this._rewardIconVec[_loc1_]);
            _loc1_++;
        }
    }

    private function moveBall(param1:int):void {
        this._moveIndex = param1;
        TweenLite.to(this._ball, this._durVec[this._moveIndex] / 400, {
            "ease": Linear.easeNone,
            "x": this.pointVec[this._moveIndex].x,
            "y": this.pointVec[this._moveIndex].y,
            "onComplete": this.onBallMoveComplete
        });
    }

    private function onBallMoveComplete():void {
        switch (this._moveIndex) {
            case 0:
                this.moveBall(1);
                break;
            case 1:
            case 3:
            case 5:
            case 7:
                this.judgeResult();
                break;
            case 2:
                this.gameOver(1);
                break;
            case 4:
                this.gameOver(2);
                break;
            case 8:
                this.gameOver(3);
                break;
            case 9:
                this.gameOver(4);
                break;
            case 10:
                this.gameOver(11);
                break;
            case 6:
                this.moveBall(10);
        }
    }

    private function judgeResult():void {
        var _loc1_:int = int(this._moveIndex / 2);
        if (this._BaffleVec[_loc1_].currentFrame > 1) {
            this.moveBall(this._moveIndex + 1);
        } else {
            this.moveBall(this._moveIndex + 2);
        }
    }

    private function gameOver(param1:int):void {
        this.dispose();
        var _loc2_:ByteArray = new ByteArray();
        _loc2_.writeByte(param1);
        _loc2_.writeByte(this._level);
        Connection.addCommandListener(CommandSet.LUCKY_TURN_TABLE_1171, this.onGetGameReward);
        Connection.send(CommandSet.LUCKY_TURN_TABLE_1171, _loc2_);
    }

    private function onGetGameReward(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.LUCKY_TURN_TABLE_1171, this.onGetGameReward);
        var _loc2_:ByteArray = param1.message.getRawDataCopy();
        var _loc3_:uint = _loc2_.readUnsignedInt();
        var _loc4_:uint = _loc2_.readUnsignedInt();
        if (_loc3_ == 1) {
            AlertManager.showCoinsGainedAlert(_loc4_);
            ActorManager.actorInfo.coins += _loc4_;
        } else {
            AlertManager.showItemGainedAlert(_loc3_, _loc4_);
            ItemManager.addItem(_loc3_, _loc4_, 0);
        }
    }

    override public function dispose():void {
        this._reduceGameCoinBtn.removeEventListener(MouseEvent.CLICK, this.reduceGameCoin);
        _animation.removeEventListener(MouseEvent.CLICK, this.onStageClick);
        Connection.removeCommandListener(CommandSet.LUCKY_TURN_TABLE_1171, this.onGetGameReward);
        Connection.removeCommandListener(CommandSet.LUCKY_TURN_TABLE_1170, this.onreduceGameCoin);
        TweenLite.killTweensOf(this._ball, true);
        this.stopRotationReward();
        super.dispose();
        var _loc1_:int = 0;
        while (_loc1_ < this._rewardIconVec.length) {
            TooltipManager.remove(this._rewardIconVec[_loc1_]);
            _loc1_++;
        }
    }
}
}
