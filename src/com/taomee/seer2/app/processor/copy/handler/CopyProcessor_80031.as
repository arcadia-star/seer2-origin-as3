package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80031 extends CopyProcessor {


    private var _npc1:MovieClip;

    private var _boss1:SimpleButton;

    private var _boss2:MovieClip;

    private var _boss3:MovieClip;

    private var _boss4:MovieClip;

    private var _boss5:MovieClip;

    private var _boss6:MovieClip;

    private var _boss7:MovieClip;

    private var _boss8:MovieClip;

    private var _mouseHint:Sprite;

    private const POS_LIST:Array = [[630, 400], [0, 0], [280, 435], [260, 355], [375, 295], [835, 430], [860, 361], [702, 315], [512, 262]];

    private const FIGHT_INDEX:Vector.<int> = Vector.<int>([489, 490, 491]);

    private var _boss1Click1:Boolean;

    public function CopyProcessor_80031(param1:CopyItemInfo) {
        super(param1);
    }

    override protected function tatisticsHandle():void {
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_508);
    }

    override public function returnSceneHandle():void {
        if (this._boss1) {
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1Click);
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1Click1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
        }
        if (!isComplete) {
            this._boss1 = _mapModel.content["boss1"];
            if (this._boss1Click1) {
                this._boss1.addEventListener(MouseEvent.CLICK, this.onBoss1Click1);
            }
        }
        if (this._npc1) {
            this._npc1.play();
            _mapModel.content.addChild(this._npc1);
        }
        if (this._boss2) {
            this._boss2.play();
            _mapModel.content.addChild(this._boss2);
        }
        if (this._boss3) {
            this._boss3.play();
            _mapModel.content.addChild(this._boss3);
        }
        if (this._boss4) {
            this._boss4.play();
            _mapModel.content.addChild(this._boss4);
        }
        if (this._boss5) {
            this._boss5.play();
            _mapModel.content.addChild(this._boss5);
        }
        if (this._boss6) {
            this._boss6.play();
            _mapModel.content.addChild(this._boss6);
        }
        if (this._boss7) {
            this._boss7.play();
            _mapModel.content.addChild(this._boss7);
        }
        if (this._boss8) {
            this._boss8.play();
            _mapModel.content.addChild(this._boss8);
        }
    }

    override public function onAnimationLoaded():void {
        this._boss1 = _mapModel.content["boss1"];
        (_mapModel.content["mark"] as MovieClip).visible = false;
        this._npc1 = getResFromDomain("npc_1");
        this._npc1.x = this.POS_LIST[0][0];
        this._npc1.y = this.POS_LIST[0][1];
        this._npc1.buttonMode = true;
        this.showMouseHintAtMonster(this._npc1);
        _mapModel.content.addChild(this._npc1);
        this._npc1.addEventListener(MouseEvent.CLICK, this.onNpc1Click);
    }

    private function onNpc1Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(192, "s", [[0, "这里就是爸爸曾经关押的地方，上面的精灵一定就是冥王——撒旦！"]], ["冥王……撒旦！"], [function ():void {
            NpcDialog.show(192, "s", [[0, "让我们继续往前走吧"]], ["好！"], [function ():void {
                hideMouseHint();
                _npc1.removeEventListener(MouseEvent.CLICK, onNpc1Click);
                (_mapModel.content["mark"] as MovieClip).visible = true;
                _boss1.addEventListener(MouseEvent.CLICK, onBoss1Click);
            }]);
        }]);
    }

    private function onBoss1Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(590, "撒旦", [[0, "你们是谁？！这里不是你们该来的地方！"]], ["是S的爸爸指引我们来的"], [function ():void {
            NpcDialog.show(590, "撒旦", [[0, "S将军…啊啊啊啊……又回忆起了那些恐怖的回忆"]], ["我有一种不祥的预感"], [function ():void {
                (_mapModel.content["mark"] as MovieClip).visible = false;
                _boss1.removeEventListener(MouseEvent.CLICK, onBoss1Click);
                sceneAnimationHandle("80031_1", "", function ():void {
                    NpcDialog.show(590, "撒旦", [[0, "既然你们来了！就让你们替这个世界的罪恶付出代价吧！哈哈哈！出来吧！我的仆从们！"]], [], [function ():void {
                        var anima:* = undefined;
                        anima = getResFromDomain("sceneAnima_1");
                        _mapModel.front.addChild(anima);
                        anima.x = 120;
                        anima.y = 50;
                        MovieClipUtil.playMc(anima, 2, anima.totalFrames, function ():void {
                            DisplayUtil.removeForParent(anima);
                            anima = null;
                            _boss2 = getResFromDomain("boss_2");
                            _boss2.x = POS_LIST[2][0];
                            _boss2.y = POS_LIST[2][1];
                            _mapModel.content.addChild(_boss2);
                            _boss3 = getResFromDomain("boss_3");
                            _boss3.x = POS_LIST[3][0];
                            _boss3.y = POS_LIST[3][1];
                            _mapModel.content.addChild(_boss3);
                            _boss4 = getResFromDomain("boss_4");
                            _boss4.x = POS_LIST[4][0];
                            _boss4.y = POS_LIST[4][1];
                            _mapModel.content.addChild(_boss4);
                            _boss5 = getResFromDomain("boss_5");
                            _boss5.x = POS_LIST[5][0];
                            _boss5.y = POS_LIST[5][1];
                            _mapModel.content.addChild(_boss5);
                            _boss6 = getResFromDomain("boss_6");
                            _boss6.x = POS_LIST[6][0];
                            _boss6.y = POS_LIST[6][1];
                            _mapModel.content.addChild(_boss6);
                            _boss7 = getResFromDomain("boss_7");
                            _boss7.x = POS_LIST[7][0];
                            _boss7.y = POS_LIST[7][1];
                            _mapModel.content.addChild(_boss7);
                            _boss8 = getResFromDomain("boss_8");
                            _boss8.x = POS_LIST[8][0];
                            _boss8.y = POS_LIST[8][1];
                            _mapModel.content.addChild(_boss8);
                            showMouseHintAtMonster(_boss4);
                            _boss4.buttonMode = true;
                            _boss4.addEventListener(MouseEvent.CLICK, onBoss4Click);
                        }, true);
                    }]);
                });
            }]);
        }]);
    }

    private function onBoss4Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        NpcDialog.show(192, "s", [[0, "看样子要先打败这些BOSS了！这一次的对手是莫利亚、布里米亚、伊利塔！"]], ["现在就开始吧！", "我先准备一下！"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX[0]);
        }]);
    }

    private function onBoss8Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(192, "s", [[0, "下面我们要挑战泰瑞纳斯、埃尔萨斯、汉尼拔、伊利丹！准备好了吗？"]], ["现在就开始吧！", "我先准备一下！"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX[1]);
        }]);
    }

    private function showMouseHintAtMonster(param1:MovieClip):void {
        this.hideMouseHint();
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -this._mouseHint.height + 65;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2 + 27;
        param1.addChild(this._mouseHint);
    }

    private function hideMouseHint():void {
        if (Boolean(this._mouseHint) && Boolean(this._mouseHint.parent)) {
            DisplayUtil.removeForParent(this._mouseHint);
            this._mouseHint = null;
        }
    }

    private function onComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            (_mapModel.content["mark"] as MovieClip).visible = false;
            _loc2_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.winHandle(_loc2_);
            } else {
                this.failHandle(_loc2_);
            }
        }
    }

    private function winHandle(param1:int):void {
        var fightIndex:int = param1;
        if (fightIndex == this.FIGHT_INDEX[0]) {
            this.hideMouseHint();
            this._boss4.removeEventListener(MouseEvent.CLICK, this.onBoss4Click);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
            this.showMouseHintAtMonster(this._boss8);
            this._boss8.buttonMode = true;
            this._boss8.addEventListener(MouseEvent.CLICK, this.onBoss8Click);
            NpcDialog.show(192, "s", [[0, "下面我们要挑战泰瑞纳斯、埃尔萨斯、汉尼拔、伊利丹！准备好了吗？"]], ["现在就开始吧！", "我先准备一下！"], [function ():void {
                FightManager.startFightWithWild(FIGHT_INDEX[1]);
            }]);
        }
        if (fightIndex == this.FIGHT_INDEX[1]) {
            this.hideMouseHint();
            this._boss8.removeEventListener(MouseEvent.CLICK, this.onBoss8Click);
            DisplayUtil.removeForParent(this._boss8);
            this._boss8 = null;
            DisplayUtil.removeForParent(this._boss7);
            this._boss7 = null;
            DisplayUtil.removeForParent(this._boss6);
            this._boss6 = null;
            DisplayUtil.removeForParent(this._boss5);
            this._boss5 = null;
            (_mapModel.content["mark"] as MovieClip).visible = true;
            this._boss1.addEventListener(MouseEvent.CLICK, this.onBoss1Click1);
            this._boss1Click1 = true;
            NpcDialog.show(590, "撒旦", [[0, "执迷不悟的莽夫！你们让我回忆起了最痛苦的事情，现在你们要付出性命的代价！"]], ["撒旦！跟我们走吧！"], [function ():void {
                NpcDialog.show(590, "撒旦", [[0, "不可能！我要让人们内心承受像我一样的痛苦！ "]], ["挑战撒旦！", "准备一下！"], [function ():void {
                    FightManager.startFightWithWild(FIGHT_INDEX[2]);
                }]);
            }]);
        }
        if (fightIndex == this.FIGHT_INDEX[2]) {
            this.hideMouseHint();
            (_mapModel.content["mark"] as MovieClip).visible = false;
            if (this._boss1) {
                this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1Click1);
                this._boss1 = null;
            }
            this._boss1Click1 = false;
            DisplayUtil.removeForParent(_mapModel.content["boss1"]);
            sceneAnimationHandle("80031_2", "", function ():void {
                completeTipShow(1, 8, "忏悔之心");
            });
        }
    }

    private function onBoss1Click1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(590, "撒旦", [[0, "执迷不悟的莽夫！你们让我你们让我回忆起了最痛苦的事情，现在你们要付出性命的代价！"]], ["撒旦！跟我们走吧！"], [function ():void {
            NpcDialog.show(590, "撒旦", [[0, "不可能！我要让人们内心承受像我一样的痛苦！ "]], ["挑战撒旦！", "准备一下！"], [function ():void {
                FightManager.startFightWithWild(FIGHT_INDEX[2]);
            }]);
        }]);
    }

    private function failHandle(param1:int):void {
    }

    override public function dispose():void {
        super.dispose();
        this.hideMouseHint();
        if (this._npc1) {
            this._npc1.removeEventListener(MouseEvent.CLICK, this.onNpc1Click);
            DisplayUtil.removeForParent(this._npc1);
            this._npc1 = null;
        }
        if (this._boss1) {
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1Click);
            this._boss1.removeEventListener(MouseEvent.CLICK, this.onBoss1Click1);
            DisplayUtil.removeForParent(this._boss1);
            this._boss1 = null;
        }
        if (this._boss2) {
            DisplayUtil.removeForParent(this._boss2);
            this._boss2 = null;
        }
        if (this._boss3) {
            DisplayUtil.removeForParent(this._boss3);
            this._boss3 = null;
        }
        if (this._boss4) {
            this._boss4.removeEventListener(MouseEvent.CLICK, this.onBoss4Click);
            DisplayUtil.removeForParent(this._boss4);
            this._boss4 = null;
        }
        if (this._boss5) {
            DisplayUtil.removeForParent(this._boss5);
            this._boss5 = null;
        }
        if (this._boss6) {
            DisplayUtil.removeForParent(this._boss6);
            this._boss6 = null;
        }
        if (this._boss7) {
            DisplayUtil.removeForParent(this._boss7);
            this._boss7 = null;
        }
        if (this._boss8) {
            this._boss8.removeEventListener(MouseEvent.CLICK, this.onBoss8Click);
            DisplayUtil.removeForParent(this._boss8);
            this._boss8 = null;
        }
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }
}
}
