package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.utils.ActsHelperUtil;
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

import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;

public class MapProcessor_80243 extends MapProcessor {

    private static const DAY_LIST:Array = [1279];

    private static const FOR_LIST:Array = [204558, 204561];

    private static const FIGHT_INDEX:int = 1159;

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([604074]);

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1, 2]);

    private static const TIP_POS:Point = new Point(460, 110);

    private static var _par:Parser_1142;

    private static var _info:DayLimitListInfo;


    private var _fightNum:TextField;

    private var _miPass:SimpleButton;

    private var _npc:Mobile;

    private var _canFightNum:int;

    public function MapProcessor_80243(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
            this.getDataHandleFromBattle();
        } else {
            this.getDataHandleNormal();
        }
    }

    private function getDataHandleNormal():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                _par = param1;
                _info = info;
                _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]), _par.infoVec[0], VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                initSet();
            });
        });
    }

    private function getDataHandleFromBattle():void {
        DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
            var info:DayLimitListInfo = param1;
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                if (_par == null) {
                    _par = par;
                } else if (par.infoVec[1] != _par.infoVec[1]) {
                    ServerMessager.addMessage("恭喜通关喽!");
                    _par = par;
                }
                _par = par;
                _info = info;
                _canFightNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]), _par.infoVec[0], VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                if (_canFightNum > 0) {
                    initSet();
                } else {
                    TweenNano.delayedCall(3, function ():void {
                        ServerMessager.addMessage("今日免费挑战次数已用完，可花费星钻继续战斗！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.showAppModule("LeiYiSuperProcessPanel");
                        });
                    });
                }
            });
        });
    }

    private function initSet():void {
        this.hideLobbyMenu();
        this._fightNum = _map.front["fightNum"];
        this._fightNum.text = this._canFightNum.toString();
        this._miPass = _map.front["miPass"];
        if (_par) {
            if (BitUtil.getBit(_par.infoVec[1], 1)) {
                this._miPass.visible = false;
            } else {
                this._miPass.visible = true;
            }
        }
        this._miPass.addEventListener(MouseEvent.CLICK, this.onMiPass);
        this.createNpc();
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(450, 280));
            this._npc.resourceUrl = URLUtil.getNpcSwf(477);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "雷伊";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS, _map.id);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(477, "雷伊", [[0, "  就是这里！能源之潮！是我雷神突破之口！"]], ["雷伊请赐教！", "我还没有准备好"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
            SeatTipsManager.removeSeat(TIP_POS, _map.id);
        }
    }

    private function onMiPass(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        ShopManager.buyItemForId(MI_ID_LIST[0], function ():void {
            _miPass.visible = false;
            ServerMessager.addMessage("恭喜通关喽!");
            SceneManager.changeScene(SceneType.LOBBY, 70);
            TweenNano.delayedCall(3, function ():void {
                ModuleManager.showAppModule("LeiYiSuperProcessPanel");
            });
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onActDispose():void {
        this.clearNpc();
        if (this._miPass) {
            this._miPass.removeEventListener(MouseEvent.CLICK, this.onMiPass);
            this._miPass = null;
        }
        this._fightNum = null;
        this._npc = null;
    }

    override public function dispose():void {
        this.onActDispose();
        super.dispose();
    }
}
}
