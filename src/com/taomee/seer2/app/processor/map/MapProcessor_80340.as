package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.SeatTipsManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
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

public class MapProcessor_80340 extends MapProcessor {

    private static const DAY_LIST:Array = [1446];

    private static const FOR_LIST:Array = [205063, 204428, 205085];

    private static const FIGHT_INDEX:Vector.<int> = Vector.<int>([1330, 1332, 1333]);

    private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605129]);

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1, 2]);

    private static const TIP_POS:Point = new Point(460, 110);

    private static var _par:Parser_1142;

    private static var _info:DayLimitListInfo;

    private static const RES_ID:Vector.<int> = Vector.<int>([626, 728, 731]);

    private static const DIALOG_ID:Vector.<int> = Vector.<int>([626, 728, 731]);

    private static const NPC_NAME:Vector.<String> = Vector.<String>(["晨璨★", "极冰凤皇", "奥黛丽赫本"]);

    private static const SAY_LIST:Vector.<String> = Vector.<String>(["醉舞晨曦 最是绚烂！我是晨璨，愿意和你战一次", "冰舞如雪 凤之吟唱！极冰凤凰在此！", "神灵舞动 冥灵沐身！我是撒旦神宠奥黛丽赫本！"]);


    private var _fightNum:TextField;

    private var _miPass:SimpleButton;

    private var _npc:Mobile;

    private var _canFightNum:int;

    private var _curBossIndex:int;

    public function MapProcessor_80340(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.onActInit();
    }

    private function onActInit():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FIGHT_INDEX.indexOf(FightManager.currentFightRecord.initData.positionIndex) != -1) {
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
                            ModuleManager.showAppModule("JiuWeiIceProcessActPanel");
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
            if (BitUtil.getBit(_par.infoVec[1], 2)) {
                this._miPass.visible = false;
            } else {
                this._miPass.visible = true;
            }
        }
        this._miPass.addEventListener(MouseEvent.CLICK, this.onMiPass);
        this._curBossIndex = -1;
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            if (!BitUtil.getBit(_par.infoVec[2], _loc1_)) {
                this._curBossIndex = _loc1_;
                break;
            }
            _loc1_++;
        }
        if (this._curBossIndex != -1) {
            this.createNpc(RES_ID[this._curBossIndex], NPC_NAME[this._curBossIndex]);
        }
    }

    private function createNpc(param1:int, param2:String):void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 160;
            this._npc.setPostion(new Point(450, 280));
            this._npc.resourceUrl = URLUtil.getNpcSwf(param1);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = param2;
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
            SeatTipsManager.registerSeat(TIP_POS, _map.id);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(DIALOG_ID[this._curBossIndex], NPC_NAME[this._curBossIndex], [[0, SAY_LIST[this._curBossIndex]]], ["开始挑战", "你好美啊"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX[_curBossIndex]);
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
        AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[0]) + "星钻一键通关吗?", function ():void {
            PayManager.buyItem(MI_ID_LIST[0], function ():void {
                _miPass.visible = false;
                ServerMessager.addMessage("恭喜通关喽!");
                SceneManager.changeScene(SceneType.LOBBY, 70);
                TweenNano.delayedCall(3, function ():void {
                    ModuleManager.showAppModule("GaiYaSuperProcessPanel");
                });
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
