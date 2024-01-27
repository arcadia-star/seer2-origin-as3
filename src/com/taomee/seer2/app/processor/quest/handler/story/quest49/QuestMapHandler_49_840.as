package com.taomee.seer2.app.processor.quest.handler.story.quest49 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.HitTest;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

import org.taomee.utils.DisplayUtil;
import org.taomee.utils.Tick;

public class QuestMapHandler_49_840 extends QuestMapHandler {


    private var _myself:Actor;

    private var _fightStatus:Boolean;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _preArr:Array;

    private var _afterArr:Array;

    private var _preBallNum:int;

    private var _afterBallNum:int;

    private var _npcBlood:int = 1;

    private var _timeNum:int;

    private var _slodier1:MovieClip;

    private var _slodier2:MovieClip;

    private var _blood:MovieClip;

    private var _fire:MovieClip;

    private var _tips:MovieClip;

    private var _fireBallPrev:MovieClip;

    private var _fireBallAfter:MovieClip;

    public function QuestMapHandler_49_840(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (this._fightStatus) {
                this._fightStatus = false;
                this.npcTalk();
            } else {
                this.playFlayNiya();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkHandler);
        }
    }

    private function playFlayNiya():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            _fightStatus = true;
            FightManager.startFightWithWild(108);
        }, true);
    }

    private function npcTalk():void {
        NpcDialog.show(489, "卡特琳娜", [[0, "吾……不想出手……汝等还是回去吧…"]], ["我不是来和你打架的！"], [function ():void {
            NpcDialog.show(489, "卡特琳娜", [[0, "请回吧……这里没有任何汝等需要的东西……"]], ["（等等，我怎么越看她越眼熟……）"], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("49_0"), function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneHandler);
                    QuestManager.completeStep(_quest.id, 1);
                }, false, false, 2);
            }]);
        }]);
    }

    private function onStepOneHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneHandler);
        this.queenTalk();
    }

    private function queenTalk():void {
        NpcDialog.show(489, "卡特琳娜", [[0, "汝曾去过冰沁氏族……？他们……他们还好吗……不，吾问这些，有何意义……"]], ["那位冰后是你姐姐？妹妹？不对，你是精灵呀……"], [function ():void {
            NpcDialog.show(489, "卡特琳娜", [[0, "冰沁氏族怎么样了……"]], ["（将自己在冰沁氏族的经历告诉她。）"], [function ():void {
                NpcDialog.show(489, "卡特琳娜", [[0, "原来……即便冰冻一切也无法阻止萨伦帝国……"]], ["冰冻，真的是卡尼娅暴走的原因吗？那歌声又是什么？"], [function ():void {
                    playLittleSoldiers();
                }]);
            }]);
        }]);
    }

    private function onNpcTalkHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "49_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkHandler);
            this.playLittleSoldiers();
        }
    }

    private function playLittleSoldiers():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_2");
        _map.content.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            _mc_1 = _processor.resLib.getMovieClip("mc_1");
            _map.front.addChild(_mc_1);
            MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                NpcTalkAgain();
            }, true);
        }, true);
    }

    private function NpcTalkAgain():void {
        NpcDialog.show(489, "卡特琳娜", [[0, "无论如何……吾都会死守那份秘宝……！"]], ["我来帮你！！"], [function ():void {
            NpcDialog.show(489, "卡特琳娜", [[0, "汝等若要援助，吾不会言谢……但谨记，万物相生相克，水可克火，亦能助冰……"]], ["明白！赶快开始吧！"], [function ():void {
                if (_mc_0) {
                    DisplayUtil.removeForParent(_mc_0);
                }
                if (_mc_1) {
                    DisplayUtil.removeForParent(_mc_1);
                }
                initFight();
            }]);
        }]);
    }

    private function initFight():void {
        this._myself = ActorManager.getActor();
        this._myself.hide();
        ActorManager.showRemoteActor = false;
        this._slodier1 = _processor.resLib.getMovieClip("slodier_1");
        this._slodier2 = _processor.resLib.getMovieClip("slodier_2");
        this._blood = _processor.resLib.getMovieClip("blood");
        this._fire = _processor.resLib.getMovieClip("fire");
        this._tips = _processor.resLib.getMovieClip("tips");
        _map.content.addChild(this._slodier1);
        _map.content.addChild(this._slodier2);
        _map.front.addChild(this._blood);
        _map.front.addChild(this._tips);
        MovieClipUtil.playMc(this._tips, 1, this._tips.totalFrames, function ():void {
            intFireBall();
        }, true);
    }

    private function intFireBall():void {
        ShootController.start(2, true);
        ShootController.addEventListener(ShootEvent.PLAY_END, this.shootWaterHandler);
        this._preArr = new Array();
        this._afterArr = new Array();
        this.createPreBall();
        this._timeNum = setTimeout(this.createAfterBall, 1000);
        Tick.instance.addRender(this.checkHitBall, 100);
    }

    private function createPreBall():void {
        var _loc1_:MovieClip = null;
        if (this._preBallNum < 10) {
            ++this._preBallNum;
            _loc1_ = _processor.resLib.getMovieClip("fireball_1");
            _loc1_.mouseEnabled = false;
            _map.front.addChild(_loc1_);
            this._preArr.push(_loc1_);
            _loc1_.play();
        }
        if (this._preBallNum + this._afterBallNum >= 20) {
            this.gameOver();
        }
    }

    private function createAfterBall():void {
        var _loc1_:MovieClip = null;
        if (this._afterBallNum < 10) {
            ++this._afterBallNum;
            _loc1_ = _processor.resLib.getMovieClip("fireball_2");
            _loc1_.mouseEnabled = false;
            _map.front.addChild(_loc1_);
            this._afterArr.push(_loc1_);
            _loc1_.play();
        }
        if (this._preBallNum + this._afterBallNum >= 20) {
            this.gameOver();
        }
    }

    private function checkHitBall(param1:int):void {
        var _loc2_:Mobile = null;
        _loc2_ = MobileManager.getMobile(489, MobileType.NPC);
        this.checkHitPreListBall(_loc2_);
        this.checkHitAfterListBall(_loc2_);
    }

    private function checkHitPreListBall(param1:Mobile):void {
        var _loc2_:uint = 0;
        while (_loc2_ < this._preArr.length) {
            if (HitTest.complexHitTestObject(this._preArr[_loc2_], param1)) {
                DisplayObjectUtil.removeFromParent(this._preArr[_loc2_]);
                this._preArr.splice(_loc2_, 1);
                ++this._npcBlood;
                this._blood.gotoAndStop(this._npcBlood);
                _map.front.addChild(this._fire);
                this._fire.gotoAndPlay(1);
                if (this._npcBlood >= 10) {
                    this.gameOver();
                } else {
                    this.createPreBall();
                }
                break;
            }
            _loc2_++;
        }
    }

    private function checkHitAfterListBall(param1:Mobile):void {
        var _loc2_:uint = 0;
        while (_loc2_ < this._afterArr.length) {
            if (HitTest.complexHitTestObject(this._afterArr[_loc2_], param1)) {
                DisplayObjectUtil.removeFromParent(this._afterArr[_loc2_]);
                this._afterArr.splice(_loc2_, 1);
                ++this._npcBlood;
                this._blood.gotoAndStop(this._npcBlood);
                _map.front.addChild(this._fire);
                this._fire.gotoAndPlay(1);
                if (this._npcBlood >= 10) {
                    this.gameOver();
                } else {
                    this.createAfterBall();
                }
                break;
            }
            _loc2_++;
        }
    }

    private function shootWaterHandler(param1:ShootEvent):void {
        var _loc2_:ShootInfo = param1.info;
        if (_loc2_.userID == ActorManager.actorInfo.id) {
            this.checkShootPreListBall(_loc2_);
            this.checkShootAfterListBall(_loc2_);
        }
    }

    private function checkShootPreListBall(param1:ShootInfo):void {
        var _loc2_:uint = 0;
        while (_loc2_ < this._preArr.length) {
            if ((this._preArr[_loc2_] as MovieClip).hitTestPoint(param1.endPos.x, param1.endPos.y)) {
                DisplayObjectUtil.removeFromParent(this._preArr[_loc2_]);
                this._preArr.splice(_loc2_, 1);
                this.createPreBall();
                break;
            }
            _loc2_++;
        }
    }

    private function checkShootAfterListBall(param1:ShootInfo):void {
        var _loc2_:uint = 0;
        while (_loc2_ < this._afterArr.length) {
            if ((this._afterArr[_loc2_] as MovieClip).hitTestPoint(param1.endPos.x, param1.endPos.y)) {
                DisplayObjectUtil.removeFromParent(this._afterArr[_loc2_]);
                this._afterArr.splice(_loc2_, 1);
                this.createAfterBall();
                break;
            }
            _loc2_++;
        }
    }

    private function gameOver():void {
        DisplayUtil.removeForParent(this._blood);
        DisplayUtil.removeForParent(this._fire);
        DisplayUtil.removeForParent(this._tips);
        DisplayUtil.removeForParent(this._slodier1);
        DisplayUtil.removeForParent(this._slodier2);
        Tick.instance.removeRender(this.checkHitBall);
        ShootController.close();
        var _loc1_:uint = 0;
        while (_loc1_ < this._preArr.length) {
            if ((this._preArr[_loc1_] as MovieClip).parent) {
                DisplayObjectUtil.removeFromParent(this._preArr[_loc1_]);
            }
            _loc1_++;
        }
        var _loc2_:uint = 0;
        while (_loc2_ < this._afterArr.length) {
            if ((this._afterArr[_loc2_] as MovieClip).parent) {
                DisplayObjectUtil.removeFromParent(this._afterArr[_loc2_]);
            }
            _loc2_++;
        }
        clearTimeout(this._timeNum);
        this.playFull();
    }

    private function playFull():void {
        this._myself.show();
        ActorManager.showRemoteActor = true;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("49_1"), function ():void {
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "你，你难道就是……冰沁氏族的曾经的守护人：冰后？？"]], ["你刚才变身了吧？还唱歌了吧？！"], [function ():void {
                NpcDialog.show(489, "卡特琳娜", [[0, "不错……吾的确曾化身冰沁族人，只为化解他们的危难……但无尽的纷争令吾感到绝望。倘若毁去战争的源头，是否就没有战争了？"]], ["不……这只是一厢情愿。"], [function ():void {
                    NpcDialog.show(489, "卡特琳娜", [[0, "是么……那汝等就用行动来告诉吾，何为正解……"]], ["我一定会做到的！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onCompleteHandler);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            }]);
        }, false, false, 2);
    }

    private function onCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }
}
}
