package com.taomee.seer2.app.processor.copy.handler {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.info.CopyItemInfo;
import com.taomee.seer2.app.copySystem.CopyEvent;
import com.taomee.seer2.app.copySystem.CopyManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.copy.CopyProcessor;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class CopyProcessor_80004 extends CopyProcessor {


    private const POS_LIST:Array = [[-12, 315], [140, 155], [360, 125], [600, 119], [738, 228], [366, 275]];

    private const BOSS_INDEX:int = 298;

    private const SKILL_TIP:Vector.<String> = Vector.<String>(["技能效果:物防提升6级", "技能效果:致命一击率提升10%", "技能效果:特防提升6级", "技能效果:免疫不良状态", "技能效果:速度等级提升6级"]);

    private var _randomList:Vector.<int>;

    private var _typeList:Vector.<int>;

    private var _monstorList:Vector.<MovieClip>;

    private var _boss:MovieClip;

    private var _canMonstor:Boolean;

    private var _canBoss:Boolean;

    private var _isGuide:Boolean;

    public function CopyProcessor_80004(param1:CopyItemInfo) {
        super(param1);
    }

    override public function returnSceneHandle():void {
        this.monsterShowUpdate();
        if (this._boss) {
            this._boss.play();
            _mapModel.content.addChild(this._boss);
        }
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
        this._isGuide = true;
    }

    override public function onAnimationLoaded():void {
        this.init();
        MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen("80004_1"), function ():void {
            var _scenMc:MovieClip = null;
            _boss = getResFromDomain("boss");
            _boss.x = POS_LIST[5][0];
            _boss.y = POS_LIST[5][1];
            _mapModel.content.addChild(_boss);
            _boss.buttonMode = true;
            _boss.addEventListener(MouseEvent.CLICK, onBossClick);
            _scenMc = getResFromDomain("sceneTalk_1");
            _mapModel.front.addChild(_scenMc);
            MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                DisplayUtil.removeForParent(_scenMc);
                _scenMc = null;
                _scenMc = getResFromDomain("sceneAnimation_1");
                _scenMc.x = 44;
                _scenMc.y = -10;
                _mapModel.front.addChild(_scenMc);
                MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                    _randomList.push(294, 295, 296);
                    sendRushListToServer();
                    monsterShowUpdate();
                    DisplayUtil.removeForParent(_scenMc);
                    _scenMc = null;
                    _scenMc = getResFromDomain("sceneTalk_2");
                    _mapModel.front.addChild(_scenMc);
                    MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                        DisplayUtil.removeForParent(_scenMc);
                        _scenMc = null;
                        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, onComplete);
                        _canMonstor = true;
                    }, true);
                }, true);
            }, true);
        }, true, true, 2);
    }

    private function onBossClick(param1:MouseEvent):void {
        if (this._canBoss) {
            FightManager.startFightWithWild(this.BOSS_INDEX);
        } else {
            AlertManager.showAlert("先杀死其中一只小怪才可以挑战布里米亚哦");
        }
    }

    private function onComplete(param1:SceneEvent):void {
        var index:int = 0;
        var _scenMc:MovieClip = null;
        var _scenMc1:MovieClip = null;
        var evt:SceneEvent = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            index = int(FightManager.currentFightRecord.initData.positionIndex);
            if (this._randomList.indexOf(index) != -1) {
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this._canMonstor = false;
                    this.clearMonstorByIndex(index);
                    if (this._isGuide) {
                        _scenMc = getResFromDomain("sceneTalk_4");
                        _mapModel.front.addChild(_scenMc);
                        MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                            DisplayUtil.removeForParent(_scenMc);
                            _scenMc = null;
                            _canBoss = true;
                        }, true);
                    } else {
                        this._canBoss = true;
                    }
                } else {
                    this._canMonstor = true;
                    this._canBoss = false;
                    _scenMc1 = getResFromDomain("sceneTalk_3");
                    _mapModel.front.addChild(_scenMc1);
                    MovieClipUtil.playMc(_scenMc1, 2, _scenMc1.totalFrames, function ():void {
                        DisplayUtil.removeForParent(_scenMc1);
                        _scenMc1 = null;
                    }, true);
                }
            }
            if (index == this.BOSS_INDEX) {
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    this.clearMonstor();
                    this.clearBoss();
                    this._canMonstor = false;
                    this._canBoss = false;
                    SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE, this.onComplete);
                    MovieClipUtil.playFullScreen(URLUtil.getCopyFullScreen("80004_2"), function ():void {
                        var _scenMc:MovieClip = getResFromDomain("sceneTalk_5");
                        _mapModel.front.addChild(_scenMc);
                        MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
                            completeTipShow();
                        }, true);
                    }, true, true, 2);
                } else {
                    this._isGuide = false;
                    this.rushMonsterHandle();
                    this._canMonstor = true;
                    this._canBoss = false;
                }
            }
        }
    }

    private function clearMonstorByIndex(param1:int):void {
        var _loc2_:MovieClip = null;
        var _loc3_:int = 0;
        for each(_loc2_ in this._monstorList) {
            if (_loc2_.index == param1) {
                _loc2_.removeEventListener(MouseEvent.CLICK, this.onMonstorClick);
                DisplayUtil.removeForParent(_loc2_);
                TooltipManager.remove(_loc2_);
                _loc3_ = this._randomList.indexOf(param1);
                this._randomList.splice(_loc3_, 1);
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
        ServerMessager.addMessage("完成副本，获得30个炼狱粉末!");
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
        while (_loc2_ < 3) {
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
        if (this._canMonstor) {
            FightManager.startFightWithWild((param1.currentTarget as MovieClip).index);
        } else {
            AlertManager.showAlert("只能击杀一只精灵哦，请挑战布里米亚吧!");
        }
    }

    private function sendRushListToServer():void {
        Connection.send(CommandSet.CLI_RAND_MONSTER_INDEX_1242, 1, 3, this._randomList[0], this._randomList[1], this._randomList[2]);
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
