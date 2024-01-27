package com.taomee.seer2.app.processor.activity.jiuWeiIceProcessAct {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.MouseEvent;
import flash.geom.Point;
import flash.utils.IDataInput;

public class JiuWeiIceProcessAct {

    private static const DAY_LIST:Array = [1441];

    private static const FOR_LIST:Array = [205084];

    private static const FIGHT_INDEX:int = 1328;

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([3381]);

    private static const FIGHT_NUM:Vector.<int> = Vector.<int>([3, 5]);


    private var _npc:Mobile;

    private var _par:Parser_1142;

    private var _info:DayLimitListInfo;

    public function JiuWeiIceProcessAct() {
        super();
        this.init();
    }

    private function init():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.fightWinnerSide == FightSide.LEFT && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            ServerMessager.addMessage("挑战胜利！获得1次凿开的机会,快去凿冰融开第十条尾巴吧!");
        }
        SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
            var data:IDataInput = param1;
            new SwapInfo(data);
            DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                    _par = param1;
                    _info = info;
                    if (Boolean(param1.infoVec[0])) {
                        createNpc();
                    }
                });
            });
        });
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(450, 280));
            this._npc.resourceUrl = URLUtil.getNpcSwf(826);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "爆炎战狐";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._info.getCount(DAY_LIST[0]) < (VipManager.vipInfo.isVip() ? FIGHT_NUM[1] : FIGHT_NUM[0])) {
            NpcDialog.show(826, "爆炎战狐", [[0, "想用我的爆炎之念融化第十条冰尾？战胜我就可以！"]], ["开始挑战 ", "准备一下"], [function ():void {
                FightManager.startFightWithWild(FIGHT_INDEX);
            }]);
        } else {
            NpcDialog.show(826, "爆炎战狐", [[0, "不要太贪心啊，小赛尔，明天再来和战斗获得更多吧！"]], ["额……悄悄走开 "], []);
        }
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayObjectUtil.removeFromParent(this._npc);
            this._npc = null;
        }
    }

    public function dispose():void {
        this.clearNpc();
    }
}
}
