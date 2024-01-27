package com.taomee.seer2.app.arena.ui.status.statusBar {
import com.taomee.seer2.app.arena.resource.FightUIManager;
import com.taomee.seer2.app.arena.ui.status.AngerBar;
import com.taomee.seer2.app.arena.ui.status.ShrinkBar;

public class SPTFighterStatusBar extends FighterStatusBar {


    public function SPTFighterStatusBar() {
        super();
    }

    override protected function createBack():void {
        _back = FightUIManager.getSprite("UI_FightSPTFighterStatusBack");
        addChild(_back);
    }

    override protected function createHealthShadowBar():void {
        _healthShadowBar = new ShrinkBar("UI_FightSPTFighterHealthShadowBar");
        addChild(_healthShadowBar);
    }

    override protected function createHealthBar():void {
        _healthBar = new ShrinkBar("UI_FightSPTFighterHealthBar");
        addChild(_healthBar);
    }

    override protected function createAngerBar():void {
        _angerBar = new AngerBar("UI_FightSPTFighterAngerBar");
        addChild(_angerBar);
    }

    override protected function createSign():void {
        _sign = FightUIManager.getSprite("UI_FightStatusBarSign");
        addChild(_sign);
    }

    override protected function createFighterIcon():void {
        super.createFighterIcon();
        _iconDisplayer.scaleX = _iconDisplayer.scaleY = 1.1;
    }

    override protected function layout():void {
        setChildPosition(_back, 0, 15);
        setChildPosition(_sign, 80, 50);
        setChildPosition(_levelSprite, 78, 31);
        setChildPosition(_nameSprite, 3, 93);
        setChildPosition(_iconDisplayer, 12, 22);
        setChildPosition(_sign, 82, 52);
        setChildPosition(_hpSign, 170, 52);
        setChildPosition(_healthShadowBar, 109, 54);
        setChildPosition(_healthBar, 109, 54);
        setChildPosition(_angerSign, 200, 70);
        setChildPosition(_angerBar, 109, 70);
        setChildPosition(_typeIcon, 140, 28);
    }
}
}
