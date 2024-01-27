package com.taomee.seer2.app.arena.ui.status.panel {
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.ui.status.statusBar.PVEFighterStatusBar;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.PetPressConfig;

public class PVEFightStatusPanel extends FightStatusPanel {


    public function PVEFightStatusPanel() {
        super();
    }

    override protected function createBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            _leftMainFighterBar = new PVEFighterStatusBar();
            addChild(_leftMainFighterBar);
        } else if (param1 == FightSide.RIGHT) {
            _rightMainFighterBar = new PVEFighterStatusBar();
            _rightMainFighterBar.scaleX = -1;
            addChild(_rightMainFighterBar);
        }
    }

    override protected function layout():void {
        if (ArenaUIIsNew.isNewUI) {
            setChildPosition(_rightMainFighterBar, 1200, 0);
            setChildPosition(_leftBuffIconBar, 174, 86);
            setChildPosition(_rightBuffIconBar, 994, 86);
            setChildPosition(_leftCapsuleBar, 6, 112);
            setChildPosition(_rightCapsuleBar, 1159, 112);
        } else {
            setChildPosition(_rightMainFighterBar, 1200, 0);
            setChildPosition(_leftBuffIconBar, 174, 52);
            setChildPosition(_rightBuffIconBar, 994, 52);
            setChildPosition(_leftCapsuleBar, 6, 112);
            setChildPosition(_rightCapsuleBar, 1123, 112);
        }
    }

    override public function updatePetPress():void {
        var _loc1_:uint = uint(PetPressConfig.getFrame(_arenaData.leftTeam.mainFighter.fighterInfo.typeId, _arenaData.rightTeam.mainFighter.fighterInfo.typeId));
        _leftMainFighterBar.updatePetPress(_loc1_);
    }
}
}
