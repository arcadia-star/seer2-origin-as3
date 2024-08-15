package com.taomee.seer2.app.arena.ui.status.panel {
import com.taomee.seer2.app.arena.Fighter;
import com.taomee.seer2.app.arena.data.FighterTeam;
import com.taomee.seer2.app.arena.ui.status.BuffIconBar;
import com.taomee.seer2.app.arena.ui.status.statusBar.DoubleFighterStatusBar;
import com.taomee.seer2.app.arena.ui.status.substatusbar.SubFighterStatusBar;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.PetPressConfig;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class DoubleFightStatusPanel extends FightStatusPanel {


    private var _leftSubFighterBar:SubFighterStatusBar;

    private var _rightSubFighterBar:SubFighterStatusBar;

    public function DoubleFightStatusPanel() {
        super();
    }

    override protected function createBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            _leftMainFighterBar = new DoubleFighterStatusBar();
            addChild(_leftMainFighterBar);
        } else if (param1 == FightSide.RIGHT) {
            _rightMainFighterBar = new DoubleFighterStatusBar();
            _rightMainFighterBar.scaleX = -1;
            addChild(_rightMainFighterBar);
        }
    }

    override protected function layout():void {
        setChildPosition(_rightMainFighterBar, 1200, 0);
        setChildPosition(_leftBuffIconBar, 85, 52);
        setChildPosition(_rightBuffIconBar, 845, 53);
        setChildPosition(_leftCapsuleBar, 6, 112);
        setChildPosition(_rightCapsuleBar, 1159, 112);
    }

    override public function update():void {
        super.update();
        if (this._leftSubFighterBar != null) {
            this._leftSubFighterBar.update();
        }
        if (this._rightSubFighterBar != null) {
            this._rightSubFighterBar.update();
        }
    }

    override public function updateAngerBar():void {
        super.updateAngerBar();
        if (this._leftSubFighterBar != null) {
            this._leftSubFighterBar.update();
        }
        if (this._rightSubFighterBar != null) {
            this._rightSubFighterBar.update();
        }
    }

    override protected function setFighter(param1:FighterTeam, param2:uint):void {
        super.setFighter(param1, param2);
        if (param1.subFighter != null) {
            this.updateSubFighterStatusBar(param1.subFighter, param2);
        }
    }

    override public function updatePetPress():void {
        var _loc1_:uint = 0;
        var _loc2_:uint = 0;
        if (_arenaData.leftTeam.mainFighter) {
            _loc1_ = uint(PetPressConfig.getPressColor(_arenaData.leftTeam.mainFighter.fighterInfo.typeId, _arenaData.rightTeam.mainFighter.fighterInfo.typeId));
            _leftMainFighterBar.updatePetPress(_loc1_);
        }
        if (_arenaData.leftTeam.subFighter) {
            _loc2_ = uint(PetPressConfig.getPressColor(_arenaData.leftTeam.subFighter.fighterInfo.typeId, _arenaData.rightTeam.subFighter.fighterInfo.typeId));
            this._leftSubFighterBar.updatePetPress(_loc2_);
        }
    }

    override protected function createBuffIconBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            this._leftBuffIconBar = new BuffIconBar(FightSide.LEFT,5);
            addChild(this._leftBuffIconBar);
        } else if (param1 == FightSide.RIGHT) {
            this._rightBuffIconBar = new BuffIconBar(FightSide.RIGHT,5);
            addChild(this._rightBuffIconBar);
        }
    }

    override public function dispose():void {
        super.dispose();
        this._leftSubFighterBar.dispose();
        this._leftSubFighterBar = null;
        this._rightSubFighterBar.dispose();
        this._rightSubFighterBar = null;
    }

    private function clearSubFighterStatusBar(param1:uint):void {
        var _loc2_:SubFighterStatusBar = null;
        if (param1 == FightSide.LEFT) {
            _loc2_ = this._leftSubFighterBar;
        } else if (param1 == FightSide.RIGHT) {
            _loc2_ = this._rightSubFighterBar;
        }
        if (_loc2_ != null) {
            DisplayObjectUtil.removeFromParent(_loc2_);
        }
    }

    private function updateSubFighterStatusBar(param1:Fighter, param2:uint):void {
        if (param2 == FightSide.LEFT) {
            if (this._leftSubFighterBar == null) {
                this._leftSubFighterBar = new SubFighterStatusBar();
                addChild(this._leftSubFighterBar);
                setChildPosition(this._leftSubFighterBar, 250, 2);
            }
            this._leftSubFighterBar.setFighter(param1);
        } else if (param2 == FightSide.RIGHT) {
            if (this._rightSubFighterBar == null) {
                this._rightSubFighterBar = new SubFighterStatusBar();
                this._rightSubFighterBar.scaleX = -1;
                addChild(this._rightSubFighterBar);
                setChildPosition(this._rightSubFighterBar, 950, 2);
            }
            this._rightSubFighterBar.setFighter(param1);
        }
    }
}
}
