package com.taomee.seer2.app.arena.ui.status.panel {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.decoration.DecorationControl;
import com.taomee.seer2.app.arena.newUI.status.NewCapsuleBar;
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.status.BuffIconBar;
import com.taomee.seer2.app.arena.ui.status.CapsuleBar;
import com.taomee.seer2.app.arena.ui.status.SkillBubble;
import com.taomee.seer2.app.arena.ui.status.statusBar.FighterStatusBar;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.utils.Timer;

import org.taomee.manager.EventManager;

public class FightStatusPanel extends Sprite {


    protected var _arenaData:ArenaDataInfo;

    protected var _leftMainFighterBar:FighterStatusBar;

    protected var _leftBuffIconBar:BuffIconBar;

    protected var _leftCapsuleBar:*;

    protected var _leftSkillBubble:SkillBubble;

    protected var _leftAngerStatus:AngerStatusPanel;

    protected var _rightMainFighterBar:FighterStatusBar;

    protected var _rightBuffIconBar:BuffIconBar;

    protected var _rightCapsuleBar:*;

    protected var _rightSkillBubble:SkillBubble;

    protected var _rightAngerStatus:AngerStatusPanel;

    private var _title:MovieClip;

    private var _depositTxtMc:MovieClip;

    private var _deposite:MovieClip;

    private var _isVip:Boolean;

    private var _tm:Timer;

    public function FightStatusPanel() {
        this._tm = new Timer(2000, 1);
        super();
        this.createBar(FightSide.LEFT);
        this.createBar(FightSide.RIGHT);
        this.createBuffIconBar(FightSide.LEFT);
        this.createBuffIconBar(FightSide.RIGHT);
        this.createSkillBubble(FightSide.LEFT);
        this.createSkillBubble(FightSide.RIGHT);
        this.createCapsuleBar(FightSide.LEFT);
        this.createCapsuleBar(FightSide.RIGHT);
        this.createAngerBar(FightSide.LEFT);
        this.createAngerBar(FightSide.RIGHT);
        this.createTitleBar();
        this.createDepositBtn();
        this.layout();
    }

    private function createDepositBtn():void {
        this._tm.addEventListener(TimerEvent.TIMER, this.onTimer);
        this._deposite = FightUIManager.getMovieClip("New_UI_DepositBtn");
        this._deposite.y = 435;
        this._deposite.x = 1140;
        this._deposite.buttonMode = true;
        ArenaUIIsNew.isDeposit = false;
        this._deposite.addEventListener(MouseEvent.CLICK, this.onDeposite);
        addChild(this._deposite);
        if (VipManager.vipInfo.isVip()) {
            this._isVip = true;
            this._deposite.gotoAndStop(1);
        } else {
            this._isVip = true;
            this._deposite.gotoAndStop(1);
        }
        this._depositTxtMc = FightUIManager.getMovieClip("New_UI_DepositTxt");
        this._depositTxtMc.x = 490;
        this._depositTxtMc.y = 125;
        this._depositTxtMc.visible = false;
        addChild(this._depositTxtMc);
    }

    private function onTimer(param1:TimerEvent):void {
        this._deposite.addEventListener(MouseEvent.CLICK, this.onDeposite);
    }

    private function onDeposite(param1:MouseEvent):void {
        if (this._isVip == true) {
            if ((param1.currentTarget as MovieClip).currentFrame <= 2) {
                if (ArenaUIIsNew.enableClick == false) {
                    return;
                }
                this._deposite.removeEventListener(MouseEvent.CLICK, this.onDeposite);
                StatisticsManager.newSendNovice("2014系统", "自动对战", "使用自动对战");
                ArenaUIIsNew.isDeposit = true;
                (param1.currentTarget as MovieClip).gotoAndStop(3);
                EventManager.dispatchEvent(new Event("DEPOSIT_EVENT"));
                this._depositTxtMc.visible = true;
            } else if ((param1.currentTarget as MovieClip).currentFrame == 3) {
                ArenaUIIsNew.isDeposit = false;
                (param1.currentTarget as MovieClip).gotoAndStop(1);
                this._depositTxtMc.visible = false;
            }
        }
        SoundEffects.playSoundMouseClick(0.35);
        this._tm.reset();
        this._tm.start();
    }

    public function initStatusPanelInfo(param1:ArenaDataInfo):void {
        this._arenaData = param1;
    }

    public function updateFighters():void {
        this.setFighter(this._arenaData.leftTeam, FightSide.LEFT);
        this._leftCapsuleBar.setFighterTeam(this._arenaData.leftTeam);
        this.setFighter(this._arenaData.rightTeam, FightSide.RIGHT);
        if (this._rightCapsuleBar != null) {
            this._rightCapsuleBar.setFighterTeam(this._arenaData.rightTeam);
        }
    }

    public function showSkillBubble(param1:Fighter, param2:String):void {
        if (param1.fighterSide == FightSide.LEFT) {
            this._leftSkillBubble.setSkillName(param2);
        } else {
            this._rightSkillBubble.setSkillName(param2);
        }
    }

    public function update():void {
        this._leftMainFighterBar.update();
        this._leftBuffIconBar.update();
        this._rightMainFighterBar.update();
        this._rightBuffIconBar.update();
        if (ArenaUIIsNew.isNewUI) {
            this._leftCapsuleBar.update(this._arenaData.leftTeam.fighterVec);
            this._rightCapsuleBar.update(this._arenaData.rightTeam.fighterVec);
        } else {
            if (!this._leftCapsuleBar) {
                return;
            }
            this._leftCapsuleBar.update(this._arenaData.leftTeam.fighterVec);
            this._rightCapsuleBar.update(this._arenaData.rightTeam.fighterVec);
        }
        this.updateTitle();
    }

    private function updateTitle():void {
        var _loc1_:int = DecorationControl._trunCount + 1;
        if (_loc1_ / 100 >= 1) {
            this._title.gotoAndStop(3);
            this._title["count0"].gotoAndStop(int(_loc1_ / 100) + 1);
            this._title["count1"].gotoAndStop(int(_loc1_ % 100 / 10) + 1);
            this._title["count2"].gotoAndStop(_loc1_ % 100 % 10 + 1);
        } else if (_loc1_ / 10 >= 1) {
            this._title.gotoAndStop(2);
            this._title["count0"].gotoAndStop(int(_loc1_ / 10) + 1);
            this._title["count1"].gotoAndStop(_loc1_ % 10 + 1);
        } else {
            this._title.gotoAndStop(1);
            this._title["count0"].gotoAndStop(_loc1_ + 1);
        }
    }

    public function updateAngerBar():void {
        this._leftMainFighterBar.update();
        this._rightMainFighterBar.update();
        if (ArenaUIIsNew.isNewUI) {
            if (Boolean(this._leftAngerStatus) && Boolean(this._rightAngerStatus)) {
                this._leftAngerStatus.update();
                this._rightAngerStatus.update();
            }
        }
    }

    public function updatePetPress():void {
    }

    public function dispose():void {
        DisplayObjectUtil.removeAllChildren(this);
        if (this._rightCapsuleBar != null) {
            this._rightCapsuleBar.dispose();
            this._rightCapsuleBar = null;
        }
        this._leftMainFighterBar.dispose();
        this._leftBuffIconBar.dispose();
        this._leftSkillBubble.dispose();
        this._leftCapsuleBar.dispose();
        this._rightMainFighterBar.dispose();
        this._rightBuffIconBar.dispose();
        this._rightSkillBubble.dispose();
        this._leftMainFighterBar = null;
        this._leftSkillBubble = null;
        this._leftCapsuleBar = null;
        this._rightMainFighterBar = null;
        this._rightSkillBubble = null;
        this._arenaData = null;
    }

    protected function layout():void {
    }

    protected function createBar(param1:uint):void {
    }

    protected function setChildPosition(param1:DisplayObject, param2:int, param3:int):void {
        param1.x = param2;
        param1.y = param3;
    }

    protected function setFighter(param1:FighterTeam, param2:uint):void {
        if (param2 == FightSide.LEFT) {
            this._leftMainFighterBar.setFighter(param1.mainFighter);
            this._leftBuffIconBar.setFighter(param1.mainFighter);
            if (ArenaUIIsNew.isNewUI && Boolean(this._leftAngerStatus)) {
                this._leftAngerStatus.setFight(param1.mainFighter);
            }
        } else if (param2 == FightSide.RIGHT) {
            this._rightMainFighterBar.setFighter(param1.mainFighter);
            this._rightBuffIconBar.setFighter(param1.mainFighter);
            if (ArenaUIIsNew.isNewUI && Boolean(this._rightAngerStatus)) {
                this._rightAngerStatus.setFight(param1.mainFighter);
            }
        }
    }

    private function createSkillBubble(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            this._leftSkillBubble = new SkillBubble(FightSide.LEFT);
            addChild(this._leftSkillBubble);
        } else if (param1 == FightSide.RIGHT) {
            this._rightSkillBubble = new SkillBubble(FightSide.RIGHT);
            addChild(this._rightSkillBubble);
        }
    }

    protected function createBuffIconBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            this._leftBuffIconBar = new BuffIconBar(FightSide.LEFT);
            addChild(this._leftBuffIconBar);
        } else if (param1 == FightSide.RIGHT) {
            this._rightBuffIconBar = new BuffIconBar(FightSide.RIGHT);
            addChild(this._rightBuffIconBar);
        }
    }

    private function createCapsuleBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            if (ArenaUIIsNew.isNewUI) {
                this._leftCapsuleBar = new NewCapsuleBar();
            } else {
                this._leftCapsuleBar = new CapsuleBar();
            }
            addChild(this._leftCapsuleBar);
        } else if (param1 == FightSide.RIGHT) {
            if (ArenaUIIsNew.isNewUI) {
                this._rightCapsuleBar = new NewCapsuleBar();
            } else {
                this._rightCapsuleBar = new CapsuleBar();
            }
            addChild(this._rightCapsuleBar);
        }
    }

    private function createAngerBar(param1:uint):void {
        if (ArenaUIIsNew.isNewUI == false) {
            return;
        }
        if (param1 == FightSide.LEFT) {
            if (ArenaUIIsNew.isNewUI) {
                this._leftAngerStatus = new AngerStatusPanel(param1);
                addChild(this._leftAngerStatus);
            }
        } else if (param1 == FightSide.RIGHT) {
            if (ArenaUIIsNew.isNewUI) {
                this._rightAngerStatus = new AngerStatusPanel(param1);
                addChild(this._rightAngerStatus);
            }
        }
    }

    private function createTitleBar():void {
        this._title = FightUIManager.getMovieClip("New_UI_FighterTitle");
        this._title.x = 535;
        //if(ArenaUIIsNew.isNewUI)
        {
            addChild(this._title);
        }
    }
}
}
