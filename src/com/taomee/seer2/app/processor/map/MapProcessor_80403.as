package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.utils.ActsHelperUtil;
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

public class MapProcessor_80403 extends MapProcessor {

    private static const FOR_LIST:Array = [205631, 205630];

    private static const DAY_LIST:Array = [1632];

    private static const FIGHT_INDEX:int = 1510;

    private static const FIGHT_NUM_RULE:int = 1;

    private static const NPC_ID:int = 868;


    private var _npc:Mobile;

    public function MapProcessor_80403(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX == FightManager.currentFightRecord.initData.positionIndex) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                ActiveCountManager.requestActiveCount(FOR_LIST[0], function (param1:uint, param2:uint):void {
                    if (FOR_LIST[0] == param1) {
                        if (param2 == 6) {
                            ModuleManager.showAppModule("DragonFourActFinishPanel");
                        } else {
                            ModuleManager.showAppModule("DragonFourActWinPanel");
                            initAct();
                        }
                    }
                });
            } else {
                ModuleManager.showAppModule("DragonFourActFailPanel");
                this.initAct();
            }
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
            this._npc.height = 160;
            this._npc.setPostion(new Point(637, 327));
            this._npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "末日咆哮";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        this.startFight();
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function startFight():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var _fightNum:int = 0;
                var par:Parser_1142 = param1;
                _fightNum = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[0]), par.infoVec[1], FIGHT_NUM_RULE);
                NpcDialog.show(NPC_ID, "末日咆哮", [[0, "你的末日到了！ 今天你有<font color=\'#FF0000\'>" + _fightNum + "</font>次挑战我的机会！"]], ["你咆哮一声给我听听"], [function ():void {
                    if (_fightNum > 0) {
                        FightManager.startFightWithWild(FIGHT_INDEX);
                    } else {
                        ModuleManager.showAppModule("DragonFourActBuyCountPanel");
                    }
                }]);
            });
        });
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
