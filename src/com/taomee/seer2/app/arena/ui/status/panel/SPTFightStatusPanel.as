package com.taomee.seer2.app.arena.ui.status.panel {
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;
import com.taomee.seer2.app.arena.ui.status.statusBar.PVEFighterStatusBar;
import com.taomee.seer2.app.arena.ui.status.statusBar.SPTBossStatusBar;
import com.taomee.seer2.app.arena.ui.status.statusBar.SPTFighterStatusBar;
import com.taomee.seer2.app.arena.util.FightSide;

public class SPTFightStatusPanel extends FightStatusPanel {


    public function SPTFightStatusPanel() {
        super();
    }

    override protected function createBar(param1:uint):void {
        if (param1 == FightSide.LEFT) {
            if (ArenaUIIsNew.isNewUI) {
                _leftMainFighterBar = new PVEFighterStatusBar();
            } else {
                _leftMainFighterBar = new SPTFighterStatusBar();
            }
            addChild(_leftMainFighterBar);
        } else if (param1 == FightSide.RIGHT) {
            if (ArenaUIIsNew.isNewUI) {
                _rightMainFighterBar = new PVEFighterStatusBar();
                _rightMainFighterBar.scaleX = -1;
            } else {
                _rightMainFighterBar = new SPTBossStatusBar();
            }
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
            setChildPosition(_rightMainFighterBar, 242, 0);
            setChildPosition(_leftCapsuleBar, 4, 118);
            setChildPosition(_leftBuffIconBar, 106, 89);
            setChildPosition(_leftSkillBubble, 0, 140);
            setChildPosition(_rightSkillBubble, 1200, 150);
            setChildPosition(_rightCapsuleBar, 1125, 130);
            setChildPosition(_rightBuffIconBar, 994, 62);
        }
    }
}
}
