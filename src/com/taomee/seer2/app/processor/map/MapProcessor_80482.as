package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.events.MouseEvent;

public class MapProcessor_80482 extends MapProcessor {


    private var _npc:Mobile;

    private const FIGHT_ID:int = 1648;

    private const DAY_LIMIT:int = 5186;

    private var dayCount:int;

    public function MapProcessor_80482(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this._npc = MobileManager.getMobile(818, MobileType.NPC);
        this._npc.buttonMode = true;
        DayLimitManager.getDoCount(this.DAY_LIMIT, function (param1:int):void {
            dayCount = 5 - param1 < 0 ? 0 : 5 - param1;
            _npc.addEventListener(MouseEvent.CLICK, onClickNPC);
        });
    }

    private function onClickNPC(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(984, "神迹休罗斯", [[0, "烈焰的守护之神，我需要得到你的认可，完成我彻底的觉醒！"]], ["请给赐予我力量"], [function ():void {
            NpcDialog.show(818, "幻灵神", [[0, "我以永恒的烈焰之名赐予你每天5次试炼的机会，能否得到我的认可，就看你自身的能力了！"]], ["我不会让你失望的"], [function ():void {
                if (dayCount <= 0) {
                    NpcDialog.show(818, "幻灵神", [[0, "今日挑战次数已用完，明天再来进入试炼吧！"]], ["知道了！"], [function ():void {
                    }]);
                } else {
                    NpcDialog.show(818, "幻灵神", [[0, "今天你还剩" + dayCount + "次机会，如果你准备好了，就开始进入试炼吧！每次完成试炼，都将获得5个技能觉醒石！"]], ["我准备好了！", " 啊再等一下下"], [function ():void {
                        FightManager.startFightWithWild(FIGHT_ID);
                    }]);
                }
            }]);
        }]);
    }

    override public function dispose():void {
        this._npc.removeEventListener(MouseEvent.CLICK, this.onClickNPC);
        this._npc = null;
        super.dispose();
    }
}
}
