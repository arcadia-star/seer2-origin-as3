package com.taomee.seer2.app.processor.quest.handler.branch.quest10092 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1060;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.HitTest;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.TimerEvent;
import flash.utils.IDataInput;
import flash.utils.Timer;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10092_840 extends QuestMapHandler {

    private static var startFight:uint = 0;


    private var npc:Mobile;

    private var tipsTxt:MovieClip;

    private var blood:MovieClip;

    private var slodier1:MovieClip;

    private var slodier2:MovieClip;

    private var slodier3:MovieClip;

    private var fire:MovieClip;

    private var bulletList:Array;

    private var bulletNum:int;

    private var interactiveNum:int;

    private var checkNum:int;

    private var timer:Timer;

    public function QuestMapHandler_10092_840(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.npc = MobileManager.getMobile(489, MobileType.NPC);
        this.npc.addOverHeadMark(new AcceptableMark());
        if (!QuestManager.isAccepted(_quest.id)) {
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        } else if (!QuestManager.isStepComplete(_quest.id, 1)) {
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onBattleDia);
        }
        if (QuestManager.isStepComplete(_quest.id, 1)) {
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onArriveNpc);
        }
        if (QuestManager.isAccepted(_quest.id) && SceneManager.prevSceneType == SceneType.ARENA && startFight == 1) {
            startFight = 0;
            if (FightManager.isWinWar()) {
                NpcDialog.show(489, "卡特琳娜", [[0, "吾吟唱数百年的魔音竟然为汝等所破……原来，吾所构建的障壁并不是真的坚不可摧……"]], ["逃避，什么都改变不了，更不会让自己变强！"], [function ():void {
                    NpcDialog.show(489, "卡特琳娜", [[0, "吾愿意与汝等同行……想试着去直面这世界，令心灵真正坚强起来。"]], ["我们一起努力吧！"], [function ():void {
                        npc.addOverHeadMark(new AcceptableMark());
                        checkComplete1();
                    }]);
                }]);
            } else {
                this.againBattle();
            }
        }
    }

    private function checkComplete1():void {
        if (!QuestManager.isStepComplete(_quest.id, 1)) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            QuestManager.completeStep(_quest.id, 1);
        }
    }

    private function againBattle():void {
        NpcDialog.show(489, "卡特琳娜", [[0, "若连这痛苦都无法战胜，汝等如何证明所谓的勇敢……？"]], ["我不会输，再来！", "还是算了。"], [function ():void {
            startFight = 1;
            FightManager.startFightWithWild(111);
        }, function ():void {
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, onBattleDia);
            NpcDialog.hide();
        }]);
    }

    private function onBattleDia(param1:NpcEvent):void {
        var _loc2_:XML = null;
        if (param1.npcDefinition.id == 489) {
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onBattleDia);
            _loc2_ = <node type="quest" name="魔音圆舞曲" params="battle"/>;
            param1.npcDefinition.resetFunctionalityData();
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 0);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.initStep2();
        }
    }

    private function initStep2():void {
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onArriveNpc);
    }

    private function onArriveNpc(param1:NpcEvent):void {
        var _loc2_:XML = null;
        var _loc3_:XML = null;
        var _loc4_:XML = null;
        if (param1.npcDefinition.id == 489) {
            _loc2_ = <node type="quest" name="魔音圆舞曲" params="30013_0"/>;
            _loc3_ = <node type="quest" name="奖品兑换" params="30013_1"/>;
            _loc4_ = <node type="quest" name="帮助抵抗袭击" params="30013_2"/>;
            param1.npcDefinition.resetFunctionalityData();
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 0);
            param1.npcDefinition.addFunctionalityUnitAt(_loc3_, 1);
            param1.npcDefinition.addFunctionalityUnitAt(_loc4_, 2);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function onActorArriveShow(param1:NpcEvent):void {
        var _loc2_:XML = null;
        if (param1.npcDefinition.id == 489) {
            param1.npcDefinition.resetFunctionalityData();
            NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
            _loc2_ = <node type="quest" name="魔音圆舞曲" params="30013_0"/>;
            param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 1);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == "30013_0") {
            if (QuestManager.isStepComplete(_quest.id, 1)) {
                FightManager.startFightWithWild(111);
            } else {
                NpcDialog.show(489, "卡特琳娜", [[0, "倘若毁去战争的源头，是否就没有战争了？汝辈，告诉吾，为何要有战争……？"]], ["嗯，这个嘛……"], [function ():void {
                    NpcDialog.show(400, "我", [[0, "这世上，总会有各种理念和利益的冲突，为了实现自己的理念，让一切按照“自己认为对”的方向发展，就难免发生战争……"]], ["例如为了所谓的正义，又或者单纯为了生存。"], [function ():void {
                        NpcDialog.show(489, "卡特琳娜", [[0, "欲望即为污垢……吾生于精灵王的心脏，为了让心灵归于纯净，吾只能选择将那污浊封印，即便……伴随着牺牲。"]], ["不，你的理解过于偏激。"], [function ():void {
                            NpcDialog.show(400, "我", [[0, "为了生存而不懈努力，为了梦想而拼尽全力。我们因为同伴的离开而悲伤，因为获得他人的认同而喜悦……这都让生命熠熠生辉！"]], ["毁灭一切并不勇敢，恰恰是懦弱的表现！"], [function ():void {
                                NpcDialog.show(489, "卡特琳娜", [[0, "汝，认为吾懦弱吗……！封印同伴的悲伤，汝等可曾感同身受？！来吧……听听这魔音……若你能从这苦痛中抬起头来……！"]], ["我接受你的挑战！", "还是算了。"], [function ():void {
                                    playFullMc();
                                }, function ():void {
                                    NpcDialog.hide();
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }
        }
        if (event.content.params == "battle") {
            this.againBattle();
        }
        if (event.content.params == "30013_1") {
            ModuleManager.toggleModule(URLUtil.getAppModule("KateRewardPanel"), "奖品兑换");
        }
        if (event.content.params == "30013_2") {
            ServerBufferManager.getServerBuffer(ServerBufferType.MAGIC_ACTIVITY, this.getBuffer);
        }
    }

    private function initInteractive():void {
        ActorManager.showRemoteActor = false;
        this.tipsTxt = _processor.resLib.getMovieClip("tips");
        _map.front.addChild(this.tipsTxt);
        MovieClipUtil.playMc(this.tipsTxt, 1, this.tipsTxt.totalFrames, function ():void {
            DisplayUtil.removeForParent(tipsTxt);
            blood = _processor.resLib.getMovieClip("blood");
            slodier1 = _processor.resLib.getMovieClip("slodier_1");
            slodier2 = _processor.resLib.getMovieClip("slodier_2");
            slodier3 = _processor.resLib.getMovieClip("slodier_3");
            fire = _processor.resLib.getMovieClip("fire");
            fire.gotoAndStop(fire.totalFrames);
            _map.front.addChild(fire);
            _map.front.addChild(blood);
            _map.content.addChild(slodier1);
            _map.content.addChild(slodier2);
            _map.content.addChild(slodier3);
            initShoot();
        }, true);
    }

    private function initShoot():void {
        this.bulletNum = 0;
        this.bulletList = [];
        this.checkNum = 0;
        ShootController.start(2, true);
        ShootController.addEventListener(ShootEvent.PLAY_END, this.chekTarget);
        (SceneManager.active as LobbyScene).hideToolbar();
        this.timer = new Timer(200);
        this.timer.addEventListener(TimerEvent.TIMER, this.checkHitNpc);
        this.timer.start();
        this.createFireBall();
    }

    private function checkHitNpc(param1:TimerEvent):void {
        if (this.blood.currentFrame == this.blood.totalFrames) {
            this.overInteractive();
            return;
        }
        ++this.checkNum;
        if (this.checkNum % 5 == 0 && this.bulletNum < 45) {
            this.createFireBall();
        }
        var _loc2_:int = 0;
        while (_loc2_ < this.bulletList.length) {
            if (HitTest.complexHitTestObject(this.bulletList[_loc2_], this.npc)) {
                this.fire.gotoAndPlay(1);
                this.blood.nextFrame();
                DisplayUtil.removeForParent(this.bulletList[_loc2_]);
                this.bulletList[_loc2_].gotoAndStop(1);
                this.bulletList.splice(_loc2_, 1);
            }
            _loc2_++;
        }
        if (this.bulletNum == 45 && this.bulletList.length == 0) {
            this.overInteractive();
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
            Connection.send(CommandSet.DIGGER_MINE_1060, 123);
        }
    }

    private function showResult(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060, this.showResult);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:Parser_1060 = new Parser_1060(_loc2_);
        _loc3_.showResult(true);
    }

    private function overInteractive():void {
        DisplayUtil.removeForParent(this.slodier1);
        DisplayUtil.removeForParent(this.slodier2);
        DisplayUtil.removeForParent(this.slodier3);
        DisplayUtil.removeForParent(this.fire);
        DisplayUtil.removeForParent(this.blood);
        this.blood.gotoAndStop(1);
        ++this.interactiveNum;
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        ServerBufferManager.updateServerBuffer(ServerBufferType.MAGIC_ACTIVITY, 0, this.interactiveNum);
        this.timer.stop();
        this.timer.reset();
        ShootController.close();
        (SceneManager.active as LobbyScene).showToolbar();
        var _loc1_:int = 0;
        while (_loc1_ < this.bulletList.length) {
            DisplayUtil.removeForParent(this.bulletList[_loc1_]);
            this.bulletList[_loc1_].gotoAndStop(1);
            this.bulletList.splice(_loc1_, 1);
            _loc1_++;
        }
    }

    private function getBuffer(param1:ServerBuffer):void {
        var serverBuffer:ServerBuffer = param1;
        this.interactiveNum = serverBuffer.readDataAtPostion(0);
        if (this.interactiveNum == 10) {
            NpcDialog.show(489, "卡特琳娜", [[0, "萨伦帝国的残党已经尝够了失败，今日不会再举进攻。"]], ["那我明天再来帮你！"], [function ():void {
                NpcDialog.hide();
            }]);
        } else {
            this.initInteractive();
        }
    }

    private function createFireBall():void {
        var _loc1_:MovieClip = null;
        var _loc2_:int = this.bulletNum % 3;
        if (_loc2_ == 0) {
            _loc1_ = _processor.resLib.getMovieClip("fireball_1");
        } else if (_loc2_ == 1) {
            _loc1_ = _processor.resLib.getMovieClip("fireball_2");
        } else {
            _loc1_ = _processor.resLib.getMovieClip("fireball_3");
        }
        ++this.bulletNum;
        this.bulletList.push(_loc1_);
        _map.front.addChild(_loc1_);
    }

    private function chekTarget(param1:ShootEvent):void {
        var _loc4_:MovieClip = null;
        var _loc2_:ShootInfo = param1.info;
        var _loc3_:int = int(this.bulletList.length - 1);
        if (_loc2_.userID == ActorManager.actorInfo.id) {
            while (_loc3_ > -1) {
                if ((_loc4_ = this.bulletList[_loc3_]).hitTestPoint(_loc2_.endPos.x, _loc2_.endPos.y)) {
                    _loc4_.stop();
                    DisplayUtil.removeForParent(_loc4_);
                    this.bulletList.splice(_loc3_, 1);
                }
                _loc3_--;
            }
        }
    }

    private function playFullMc():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10092_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(_quest.id);
        }, false);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            FightManager.startFightWithWild(111);
        }
    }

    override public function processMapDispose():void {
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onArriveNpc);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        if (this.timer) {
            this.timer.stop();
            this.timer.reset();
            this.timer.removeEventListener(TimerEvent.TIMER, this.checkHitNpc);
        }
        super.processMapDispose();
    }
}
}
