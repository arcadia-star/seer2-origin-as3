package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_80471 extends MapProcessor {

    private static const DAY_LIST:Array = [1720];

    private static const FIGHT_INDEX:int = 1614;

    private static const FIGHT_NUM_RULE:int = 3;

    private static const TIP_POS:Point = new Point(570, 300);


    private var _npc:Mobile;

    public function MapProcessor_80471(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                var canFightNum:int = FIGHT_NUM_RULE - info.getCount(DAY_LIST[0]) >= 0 ? FIGHT_NUM_RULE - info.getCount(DAY_LIST[0]) : 0;
                if (canFightNum > 0) {
                    if (VipManager.vipInfo.isVip()) {
                        initAct();
                    } else {
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.showAppModule("YearPetGetItemMainPanel");
                        });
                    }
                } else {
                    TweenNano.delayedCall(3, function ():void {
                        ServerMessager.addMessage("今日免费挑战次数已用完！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.showAppModule("YearPetGetItemMainPanel");
                        });
                    });
                }
            });
        } else {
            this.initAct();
        }
    }

    private function initAct():void {
        this.createNpc();
    }

    private function onActDispose():void {
        this.clearNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 200;
            this._npc.setPostion(new Point(580, 530));
            this._npc.resourceUrl = URLUtil.getNpcSwf(905);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "神迹盖亚";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS, _map.id);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        FightManager.startFightWithWild(FIGHT_INDEX);
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
            SeatTipsManager.removeSeat(TIP_POS, _map.id);
        }
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
