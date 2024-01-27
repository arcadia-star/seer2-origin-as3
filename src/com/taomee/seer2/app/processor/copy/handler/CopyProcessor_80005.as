package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.copySystem.CopyEvent;
import com.taomee.seer2.app.copySystem.CopyManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80005 extends CopyProcessor {


    private const POS_LIST:Array = [[-12, 315], [140, 155], [360, 125], [600, 119], [738, 228], [366, 275]];

    private const BOSS_INDEX:int = 298;

    private const SKILL_TIP:Vector.<String> = Vector.<String>(["技能效果:物防提升6级", "技能效果:致命一击率提升10%", "技能效果:特防提升6级", "技能效果:免疫不良状态", "技能效果:速度等级提升6级"]);

    private var _randomList:Vector.<int>;

    private var _typeList:Vector.<int>;

    private var _monstorList:Vector.<MovieClip>;

    private var _boss:MovieClip;

    public function CopyProcessor_80005(param1:CopyItemInfo) {
        super(param1);
    }

    override public function returnSceneHandle():void {
        this.monsterShowUpdate();
        if (this._boss) {
            this._boss.play();
            _mapModel.content.addChild(this._boss);
        }
    }

    override public function onAnimationLoaded():void {
        this.init();
    }

    private function init():void {
        var _loc1_:int = 0;
        this._randomList = new Vector.<int>();
        this._typeList = Vector.<int>([293, 294, 295, 296, 297]);
        this._monstorList = new Vector.<MovieClip>();
        _loc1_ = 0;
        while (_loc1_ < 5) {
            this._monstorList.push(getResFromDomain("monster_" + _loc1_));
            if (_loc1_ > 2) {
                (this._monstorList[_loc1_] as MovieClip).scaleX = -1;
            }
            (this._monstorList[_loc1_] as MovieClip).x = this.POS_LIST[_loc1_][0];
            (this._monstorList[_loc1_] as MovieClip).y = this.POS_LIST[_loc1_][1];
            (this._monstorList[_loc1_] as MovieClip).index = this._typeList[_loc1_];
            _loc1_++;
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        this._boss = getResFromDomain("boss");
        this._boss.x = this.POS_LIST[5][0];
        this._boss.y = this.POS_LIST[5][1];
        _mapModel.content.addChild(this._boss);
        this._boss.buttonMode = true;
        this._boss.addEventListener(MouseEvent.CLICK, this.onBossClick);
        this.rushMonsterHandle();
    }

    private function onBossClick(param1:MouseEvent):void {
        FightManager.startFightWithWild(this.BOSS_INDEX);
    }

    private function onComplete(param1:SceneEvent):void {
        var _loc2_:int = 0;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            _loc2_ = int(FightManager.currentFightRecord.initData.positionIndex);
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                if (this._randomList.indexOf(_loc2_) != -1) {
                    this.clearMonstor();
                    FightManager.startFightWithWild(this.BOSS_INDEX);
                }
                if (_loc2_ == this.BOSS_INDEX) {
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
                    this.clearMonstor();
                    this.clearBoss();
                    completeTipShow();
                }
            } else if (_loc2_ == this.BOSS_INDEX) {
                this.rushMonsterHandle();
            }
        }
    }

    private function clearMonstor():void {
        if (this._monstorList == null) {
            return;
        }
        var _loc1_:int = 0;
        while (_loc1_ < this._monstorList.length) {
            if (this._monstorList[_loc1_]) {
                this._monstorList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onMonstorClick);
                DisplayUtil.removeForParent(this._monstorList[_loc1_]);
                TooltipManager.remove(this._monstorList[_loc1_] as MovieClip);
            }
            _loc1_++;
        }
        this._randomList = new Vector.<int>();
    }

    private function clearBoss():void {
        if (this._boss) {
            this._boss.removeEventListener(MouseEvent.CLICK, this.onBossClick);
            DisplayUtil.removeForParent(this._boss);
            this._boss = null;
        }
    }

    private function onCopyComplete(param1:CopyEvent):void {
        ServerMessager.addMessage("完成副本，获得50个炼狱粉末!");
        CopyManager.instance().removeEventListener(CopyEvent.COMPLETE, this.onCopyComplete);
        this.dispose();
    }

    private function rushMonsterHandle():void {
        this.getRandomList();
        this.sendRushListToServer();
        this.monsterShowUpdate();
    }

    private function monsterShowUpdate():void {
        var _loc1_:int = 0;
        while (_loc1_ < this._monstorList.length) {
            if (this._randomList.indexOf(this._monstorList[_loc1_].index) != -1) {
                _mapModel.content.addChild(this._monstorList[_loc1_]);
                this._monstorList[_loc1_].buttonMode = true;
                (this._monstorList[_loc1_] as MovieClip).play();
                if (!this._monstorList[_loc1_].hasEventListener(MouseEvent.CLICK)) {
                    this._monstorList[_loc1_].addEventListener(MouseEvent.CLICK, this.onMonstorClick);
                    TooltipManager.addCommonTip(this._monstorList[_loc1_] as MovieClip, this.SKILL_TIP[_loc1_]);
                }
            } else {
                this._monstorList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onMonstorClick);
                TooltipManager.remove(this._monstorList[_loc1_] as MovieClip);
                DisplayUtil.removeForParent(this._monstorList[_loc1_]);
            }
            _loc1_++;
        }
    }

    private function getRandomList():void {
        var _loc1_:int = 0;
        this._randomList = new Vector.<int>();
        this._typeList = Vector.<int>([293, 294, 295, 296, 297]);
        var _loc2_:int = 0;
        while (_loc2_ < 4) {
            _loc1_ = int(Math.random() * (5 - _loc2_));
            if (_loc1_ == 5 - _loc2_) {
                _loc1_--;
            }
            this._randomList.push(this._typeList[_loc1_]);
            this._typeList.splice(_loc1_, 1);
            _loc2_++;
        }
    }

    private function onMonstorClick(param1:MouseEvent):void {
        FightManager.startFightWithWild((param1.currentTarget as MovieClip).index);
    }

    private function sendRushListToServer():void {
        Connection.send(CommandSet.CLI_RAND_MONSTER_INDEX_1242, 2, 4, this._randomList[0], this._randomList[1], this._randomList[2], this._randomList[3]);
    }

    override public function dispose():void {
        super.dispose();
        this.clearMonstor();
        this.clearBoss();
        SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
        this._monstorList = null;
    }
}
}
