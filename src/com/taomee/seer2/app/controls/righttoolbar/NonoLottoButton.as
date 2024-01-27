package com.taomee.seer2.app.controls.righttoolbar {
import com.taomee.seer2.app.gameRule.nono.NonoInfoEvent;
import com.taomee.seer2.app.gameRule.nono.NonoUtil;
import com.taomee.seer2.core.effects.SoundEffects;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class NonoLottoButton extends Sprite implements IShowable {

    public static const NONOLOTTO_BTN:uint = 0;


    private var _btn:SimpleButton;

    private var _timeBehavior:TimerMCBehavior;

    public function NonoLottoButton() {
        super();
        this._btn = UIManager.getButton("UI_ToolBar_VipBtn");
        this._btn.addEventListener(MouseEvent.CLICK, this.onClick);
        addChild(this._btn);
        SoundEffects.setButton(this._btn);
        this._timeBehavior = new TimerMCBehavior(UIManager.getMovieClip("UI_ToolBar_SugarTime"));
        this._timeBehavior.timeMC.y = this._btn.height - 3;
        this._timeBehavior.timeMC.x = -8;
        this._timeBehavior.update(0);
        addChild(this._timeBehavior.timeMC);
        NonoUtil.addEventListener(NonoInfoEvent.NONO_TIMER, this.onTimer);
        NonoUtil.addEventListener(NonoInfoEvent.NONO_TIMER_COMPLETE, this.onTimerComplete);
    }

    private function onClick(param1:MouseEvent):void {
        ModuleManager.toggleModule(URLUtil.getAppModule("NonoEdenLottoPanel"), "正在打Nono抽奖面板...");
    }

    private function onTimerComplete(param1:NonoInfoEvent):void {
        this._timeBehavior.update(0);
    }

    private function onTimer(param1:NonoInfoEvent):void {
        this._timeBehavior.update(param1.seconds);
    }

    public function show():void {
    }
}
}
