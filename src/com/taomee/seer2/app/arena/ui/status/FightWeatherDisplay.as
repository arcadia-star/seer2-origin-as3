package com.taomee.seer2.app.arena.ui.status {
import com.taomee.seer2.app.arena.util.FightWeatherNameMap;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.Sprite;

public class FightWeatherDisplay extends Sprite {


    private var _back:Sprite;

    private var _icon:Sprite;

    private var _weatherCode:uint;

    public function FightWeatherDisplay() {
        super();
        this._back = UIManager.getSprite("UI_WeatherIconBack");
        DisplayObjectUtil.disableSprite(this._back);
        addChild(this._back);
    }

    public function update(param1:uint):void {
        if (this._weatherCode != param1) {
            this._weatherCode = param1;
            this.removeIcon();
            this._icon = UIManager.getSprite("UI_WeatherIcon" + param1);
            if (this._icon) {
                this._icon.x = 42;
                this._icon.y = 4;
                TooltipManager.addCommonTip(this._icon, FightWeatherNameMap.getWeatherNameByCode(param1));
                addChild(this._icon);
            }
            if (param1 == 16) {
                this._icon.visible = false;
                this._back.visible = false;
            }
        }
    }

    private function removeIcon():void {
        if (this._icon != null) {
            TooltipManager.remove(this._icon);
            removeChild(this._icon);
        }
    }

    public function dispose():void {
        this.removeIcon();
    }
}
}
