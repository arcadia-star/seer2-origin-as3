package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.copySystem.CopyEvent;
import com.taomee.seer2.app.copySystem.CopyManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80002 extends CopyProcessor {


    private const SINGLE_INDEX:int = 260;

    private const DOUBLE_ONE_INDEX:int = 258;

    private const DOUBLE_TWO_INDEX:int = 259;

    private const GOLE_KILL_NUM:int = 10;

    private const POS_LIST:Array = [[208, 254], [310, 280], [270, 280], [490, 280]];

    private var _singleBoss:MovieClip;

    private var _doubleOneBoss:MovieClip;

    private var _doubleTwoBoss:MovieClip;

    private var _singleBossStart:Boolean;

    private var _killNum:int;

    public function CopyProcessor_80002(param1:CopyItemInfo) {
        super(param1);
    }

    override public function beforeAnimationHandle():void {
    }

    override public function returnSceneHandle():void {
        if (this._singleBoss) {
            this._singleBoss.play();
            _mapModel.content.addChild(this._singleBoss);
        }
        if (this._doubleOneBoss) {
            this._doubleOneBoss.play();
            _mapModel.content.addChild(this._doubleOneBoss);
        }
        if (this._doubleTwoBoss) {
            this._doubleTwoBoss.play();
            _mapModel.content.addChild(this._doubleTwoBoss);
        }
    }

    override public function onAnimationLoaded():void {
        this._singleBoss = getResFromDomain("npc");
        this._singleBoss.x = this.POS_LIST[1][0];
        this._singleBoss.y = this.POS_LIST[1][1];
        this._singleBoss.buttonMode = true;
        _mapModel.content.addChild(this._singleBoss);
        this._singleBoss.addEventListener(MouseEvent.CLICK, this.onSingleBossClick);
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
    }

    private function onSingleBossClick(param1:MouseEvent):void {
        if (this._singleBossStart) {
            FightManager.startFightWithWild(this.SINGLE_INDEX);
        } else {
            AlertManager.showAlert("需要击败10个场地内的精灵才能够和莫利亚对战！");
        }
    }

    private function onComplete(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex <= 9) {
            ++this._killNum;
            if (this._killNum < this.GOLE_KILL_NUM) {
                ServerMessager.addMessage("你还需要击败" + (this.GOLE_KILL_NUM - this._killNum) + "只精灵就可以和莫利亚对战！");
            } else {
                this._singleBossStart = true;
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
                SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete1);
            }
        }
    }

    private function onComplete1(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == this.SINGLE_INDEX) {
            DisplayUtil.removeForParent(this._singleBoss);
            this._singleBoss = null;
            this._doubleOneBoss = getResFromDomain("npc");
            this._doubleOneBoss.x = this.POS_LIST[2][0];
            this._doubleOneBoss.y = this.POS_LIST[2][1];
            this._doubleOneBoss.buttonMode = true;
            _mapModel.content.addChild(this._doubleOneBoss);
            this._doubleTwoBoss = getResFromDomain("npc");
            this._doubleTwoBoss.scaleX = -1;
            this._doubleTwoBoss.x = this.POS_LIST[3][0];
            this._doubleTwoBoss.y = this.POS_LIST[3][1];
            this._doubleTwoBoss.buttonMode = true;
            _mapModel.content.addChild(this._doubleTwoBoss);
            this._doubleOneBoss.addEventListener(MouseEvent.CLICK, this.onDoubleBossClick);
            this._doubleTwoBoss.addEventListener(MouseEvent.CLICK, this.onDoubleBossClick);
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete1);
            SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete2);
        }
    }

    private function onDoubleBossClick(param1:MouseEvent):void {
        var _loc2_:int = param1.currentTarget == this._doubleOneBoss ? this.DOUBLE_ONE_INDEX : this.DOUBLE_TWO_INDEX;
        FightManager.startFightWithWild(_loc2_);
    }

    private function onComplete2(param1:SceneEvent):void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && (FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_ONE_INDEX || FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_TWO_INDEX)) {
            if (FightManager.currentFightRecord.initData.positionIndex == this.DOUBLE_ONE_INDEX) {
                DisplayUtil.removeForParent(this._doubleOneBoss);
                this._doubleOneBoss = null;
            } else {
                DisplayUtil.removeForParent(this._doubleTwoBoss);
                this._doubleTwoBoss = null;
            }
            if (!this._doubleOneBoss && !this._doubleTwoBoss) {
                SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete2);
                CopyManager.instance().addEventListener(CopyEvent.COMPLETE, this.onCopyComplete);
                CopyManager.instance().completeCopyItem(_copyItem.mapId);
            }
        }
    }

    private function onCopyComplete(param1:CopyEvent):void {
        ServerMessager.addMessage("完成副本，获得30个炼狱粉末!");
        CopyManager.instance().removeEventListener(CopyEvent.COMPLETE, this.onCopyComplete);
        this.dispose();
    }

    override public function dispose():void {
        super.dispose();
        if (this._singleBoss) {
            this._singleBoss.removeEventListener(MouseEvent.CLICK, this.onSingleBossClick);
        }
        if (this._doubleOneBoss) {
            this._doubleOneBoss.removeEventListener(MouseEvent.CLICK, this.onDoubleBossClick);
        }
        if (this._doubleTwoBoss) {
            this._doubleTwoBoss.removeEventListener(MouseEvent.CLICK, this.onDoubleBossClick);
        }
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete1);
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete2);
        DisplayUtil.removeForParent(this._singleBoss);
        DisplayUtil.removeForParent(this._doubleOneBoss);
        DisplayUtil.removeForParent(this._doubleTwoBoss);
        CopyManager.instance().removeEventListener(CopyEvent.COMPLETE, this.onCopyComplete);
    }
}
}
