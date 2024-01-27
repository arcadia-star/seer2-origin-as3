package com.taomee.seer2.app.processor.activity.stomach {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.pet.constant.PetType;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.utils.DateUtil;

import flash.events.Event;
import flash.events.MouseEvent;

public class StomachManager {

    private static var _questAbort:Boolean = false;

    private static var _endDate:uint = new Date(2012, 11, 11, 15, 2).getTime() / 1000;


    private var _map:MapModel;

    private var _grassNpc:Mobile;

    private var _fireNpc:Mobile;

    private var _waterNpc:Mobile;

    private var _fahaiNpc:Mobile;

    private var _teleport:Teleport;

    public function StomachManager(param1:MapModel) {
        super();
        this._map = param1;
        this._teleport = AnimateElementManager.getElement(1) as Teleport;
        this.initTeleport();
        this.initNpc();
        this.initDialogEvent();
    }

    public static function isTimerLater():Boolean {
        if (TimeManager.getServerTime() < _endDate) {
            if (Boolean(DateUtil.inInDateScope(5, 13, 0, 15, 1)) || Boolean(DateUtil.inInDateScope(6, 13, 0, 15, 1)) || Boolean(DateUtil.inInDateScope(0, 13, 0, 15, 1))) {
                return false;
            }
        }
        return false;
    }

    private function initTeleport():void {
        this._map.content.addEventListener(Event.ENTER_FRAME, this.onEnter);
    }

    private function onEnter(param1:Event):void {
        if (isTimerLater()) {
            this._teleport.visible = false;
        } else {
            this._teleport.visible = true;
        }
    }

    private function initNpc():void {
        this._grassNpc = MobileManager.getMobile(62, MobileType.NPC);
        this._fireNpc = MobileManager.getMobile(63, MobileType.NPC);
        this._waterNpc = MobileManager.getMobile(64, MobileType.NPC);
        this._fahaiNpc = MobileManager.getMobile(61, MobileType.NPC);
        this._grassNpc.buttonMode = true;
        this._fireNpc.buttonMode = true;
        this._waterNpc.buttonMode = true;
        this._grassNpc.addEventListener(MouseEvent.CLICK, this.onGrass, false, 1);
        this._fireNpc.addEventListener(MouseEvent.CLICK, this.onFire, false, 1);
        this._waterNpc.addEventListener(MouseEvent.CLICK, this.onWater, false, 1);
    }

    private function initDialogEvent():void {
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onDialogShow);
    }

    private function onDialogShow(param1:NpcEvent):void {
        if (param1.npcDefinition.id == 61) {
            if (isTimerLater()) {
                param1.npcDefinition.resetFunctionalityData();
                param1.npcDefinition.removeFunctionalityUnit("空腹节的灾难");
            } else {
                param1.npcDefinition.removeFunctionalityUnit("兑换道具");
                if (QuestManager.isComplete(10042)) {
                    param1.npcDefinition.removeFunctionalityUnit("空腹节的灾难");
                }
            }
        }
    }

    private function onGrass(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        event.stopImmediatePropagation();
        if (PetInfoManager.getFirstPetInfo().getPetDefinition().type == PetType.GRASS) {
            NpcDialog.show(18, "草系部落勇士", [[3, "我是草系部落的勇士，你可以用草系精灵和我对战，为了部落！"]], ["我要挑战你", "我先走了"], [function ():void {
                FightManager.startFightWithWild(45);
            }]);
        } else {
            NpcDialog.show(18, "草系部落勇士", [[3, "想要挑战我的话，你的首发精灵必须是草系的。"]], ["知道了！"]);
        }
    }

    private function onFire(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        event.stopImmediatePropagation();
        if (PetInfoManager.getFirstPetInfo().getPetDefinition().type == PetType.WATER) {
            NpcDialog.show(26, "水系部落勇士", [[2, "我是水系部落的勇士，你也想了解魔法的奥秘吗？"]], ["我要挑战你", "我先走了"], [function ():void {
                FightManager.startFightWithWild(46);
            }]);
        } else {
            NpcDialog.show(26, "水系部落勇士", [[2, "想要挑战我的话，你的首发精灵必须是水系的。"]], ["知道了！"]);
        }
    }

    private function onWater(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        event.stopImmediatePropagation();
        if (PetInfoManager.getFirstPetInfo().getPetDefinition().type == PetType.FIRE) {
            NpcDialog.show(34, "火系部落勇士", [[0, "我是火系部落的勇士，荣耀即吾命！"]], ["我要挑战你", "我先走了"], [function ():void {
                FightManager.startFightWithWild(47);
            }]);
        } else {
            NpcDialog.show(34, "火系部落勇士", [[0, "想要挑战我的话，你的首发精灵必须是火系的。"]], ["知道了！"]);
        }
    }

    public function dispose():void {
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onDialogShow);
        this._map.content.removeEventListener(Event.ENTER_FRAME, this.onEnter);
        this._grassNpc.removeEventListener(MouseEvent.CLICK, this.onGrass);
        this._fireNpc.removeEventListener(MouseEvent.CLICK, this.onFire);
        this._waterNpc.removeEventListener(MouseEvent.CLICK, this.onWater);
    }
}
}
