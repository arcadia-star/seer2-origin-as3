package com.taomee.seer2.app.arena.ui.status.statusBar {
import com.taomee.seer2.app.arena.controller.ArenaUIIsNew;

public class PVEFighterStatusBar extends FighterStatusBar {


    public function PVEFighterStatusBar() {
        super();
    }

    override protected function createFighterIcon():void {
        super.createFighterIcon();
        _iconDisplayer.scaleX = _iconDisplayer.scaleY = 1.3;
    }

    override public function set scaleX(param1:Number):void {
        super.scaleX = param1;
        if (param1 == -1) {
            if (ArenaUIIsNew.isNewUI) {
                _sign.scaleX = -1;
                _sign.x = 107;
                _hpSign.scaleX = -1;
                _hpSign.x = 260;
                _angerSign.scaleX = -1;
                _angerSign.x = 240;
                _levelSprite.scaleX = -1;
                _levelSprite.x = 227;
                _nameSprite.scaleX = -1;
                _nameSprite.x = 170;
            } else {
                _sign.scaleX = -1;
                _sign.x = 107;
                _hpSign.scaleX = -1;
                _hpSign.x = 240;
                _angerSign.scaleX = -1;
                _angerSign.x = 240;
                _levelSprite.scaleX = -1;
                _levelSprite.x = 145;
                _nameSprite.scaleX = -1;
                _nameSprite.x = 78;
            }
        }
    }

    override public function updatePetPress(param1:int):void {
        if (ArenaUIIsNew.isNewUI == false && Boolean(_preeeMC)) {
            _preeeMC.gotoAndStop(param1);
        }
    }
}
}
