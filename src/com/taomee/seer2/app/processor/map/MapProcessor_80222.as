package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
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

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;

public class MapProcessor_80222 extends MapProcessor {

    private static const FOR_LIST:Array = [204383, 204385];

    private static const DAY_LIST:Array = [1225];

    private static const FIGHT_LIST:Vector.<int> = Vector.<int>([1066, 1067, 1068, 1069, 1070, 1071]);

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([603970]);

    private static const FIGHT_NUM_RULE:int = 1;

    private static const NPC_ID:int = 764;


    private var _npc:Mobile;

    private var _buyItem:SimpleButton;

    public function MapProcessor_80222(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FIGHT_LIST.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                ActiveCountManager.requestActiveCount(FOR_LIST[0], function (param1:uint, param2:uint):void {
                    if (FOR_LIST[0] == param1) {
                        if (param2 == 63) {
                            ServerMessager.addMessage("恭喜全部挑战成功，赶快去领取进化芯片吧!");
                        } else {
                            ServerMessager.addMessage("恭喜挑战成功，迎接更强的挑战吧!");
                            initAct();
                        }
                    }
                });
            } else {
                ModuleManager.showAppModule("MoZunFailPanel");
                this.initAct();
            }
        } else {
            this.initAct();
        }
    }

    private function initAct():void {
        this._buyItem = _map.content["buyItem"] as SimpleButton;
        this._buyItem.addEventListener(MouseEvent.CLICK, this.onBuyItem);
        this.createNpc();
    }

    private function onBuyItem(param1:MouseEvent):void {
        ModuleManager.showAppModule("MedicineShopPanel");
    }

    private function onActDispose():void {
        this.clearNpc();
        if (this._buyItem) {
            this._buyItem.removeEventListener(MouseEvent.CLICK, this.onBuyItem);
            this._buyItem = null;
        }
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(460, 275));
            this._npc.resourceUrl = URLUtil.getNpcSwf(NPC_ID);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "万劫魔尊";
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
                var _curIndex:int = 0;
                var par:Parser_1142 = param1;
                var _fightNum:int = ActsHelperUtil.getCanNum(info.getCount(DAY_LIST[0]), par.infoVec[1], FIGHT_NUM_RULE);
                _curIndex = 0;
                var i:int = 0;
                while (i < 6) {
                    if (!BitUtil.getBit(par.infoVec[0], i)) {
                        _curIndex = i;
                        break;
                    }
                    i++;
                }
                if (_fightNum > 0) {
                    NpcDialog.show(NPC_ID, "万劫魔尊", [[0, "         哪里来的小毛贼！不想活了吗？今天你有<font color=\'#FF0000\'>" + _fightNum + "</font>次挑战我的机会！"]], ["挑战吧！", "准备一下"], [function ():void {
                        FightManager.startFightWithWild(FIGHT_LIST[_curIndex]);
                    }]);
                } else {
                    NpcDialog.show(NPC_ID, "万劫魔尊", [[0, "         你已经没有机会了！明天再来找我挑战吧！"]], ["通过星钻继续挑战", " 明天再说吧"], [function ():void {
                        AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻购买本次挑战吗?", function ():void {
                            PayManager.buyItem(MI_ID_LIST[0], function ():void {
                                FightManager.startFightWithWild(FIGHT_LIST[_curIndex]);
                            });
                        });
                    }]);
                }
            });
        });
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
