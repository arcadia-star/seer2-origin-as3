package com.taomee.seer2.app.processor.map {
import com.greensock.TweenNano;
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightMode;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;

public class MapProcessor_80158 extends TitleMapProcessor {

    private static const FIGHT_INDEX:Vector.<int> = Vector.<int>([847, 848, 849, 850, 851]);

    private static const FOR_LIST:Array = [203838, 203839, 203840, 203841, 203843];

    private static const FIGHT_DAY:int = 1028;

    private static const FREE_HELP_SWAP:int = 2509;

    private static const VS_NAME:Vector.<String> = Vector.<String>(["壹擂", "贰擂", "叁擂", "肆擂", "伍擂"]);

    private static const MI_ID_LIST:Array = [[603537, 603538], [603541, 603542], [603543, 603544], [603545, 603546], [603547, 603548]];

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([1, 2]);

    private static const NPC_LIST:Vector.<int> = Vector.<int>([636, 721, 722, 601, 723]);

    private static const NPC_NAME:Vector.<String> = Vector.<String>(["莱曼萨尔", "霍利菲尔德", "因卡斯特", "盖亚", "战魔武煞"]);

    private static const NPC_DAILOGE_LIST:Vector.<int> = Vector.<int>([636, 721, 722, 601, 723]);

    private static const NPC_DIALOGE_ID_LIST:Vector.<int> = Vector.<int>([0, 0, 0, 0, 0]);

    private static const TIPS_LIST:Vector.<String> = Vector.<String>(["壹擂就是我莱曼萨尔！", "贰擂就是我霍利菲尔德!", "叁擂就是我因卡斯特!", "肆擂就是我盖亚!", "伍擂就是我武煞!"]);

    private static var _curIndex:int = 0;


    private var _miHelpList:Vector.<SimpleButton>;

    private var _freeHelp:SimpleButton;

    private var _winNum:TextField;

    private var _vsName:TextField;

    private var _npc:Mobile;

    private var _par:Parser_1142;

    private var _mouseHint:MouseClickHintSprite;

    public function MapProcessor_80158(param1:MapModel) {
        super(param1);
    }

    private function fightVsWuShaActInit():void {
        this.initUI();
        if (SceneManager.prevSceneType != SceneType.ARENA) {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("fightVsWuSha/FightVsWuSha1"), function ():void {
                ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                    var par:Parser_1142 = param1;
                    _par = par;
                    DayLimitManager.getDoCount(FIGHT_DAY, function (param1:int):void {
                        var val:int = param1;
                        _winNum.text = par.infoVec[4].toString() + "/3";
                        _curIndex = par.infoVec[1];
                        _vsName.text = VS_NAME[par.infoVec[1] > 4 ? 4 : par.infoVec[1]];
                        if (getCanFightNum(val, par.infoVec[0]) > 0) {
                            fightInit();
                        } else {
                            ServerMessager.addMessage("你今天的挑战次数已用完，购买挑战后再来吧!");
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(3, function ():void {
                                ModuleManager.showModule(URLUtil.getAppModule("FightVsWuShaPanel"), "正在打开面板...");
                            });
                        }
                    });
                });
            }, true, true, 2, true);
        } else {
            ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                var par:Parser_1142 = param1;
                _par = par;
                DayLimitManager.getDoCount(FIGHT_DAY, function (param1:int):void {
                    var val:int = param1;
                    _winNum.text = par.infoVec[4].toString() + "/3";
                    _vsName.text = VS_NAME[par.infoVec[1] > 4 ? 4 : par.infoVec[1]];
                    if (par.infoVec[1] == 5) {
                        _curIndex = par.infoVec[1];
                        ServerMessager.addMessage("你厉害啊！已打过所有擂台，快去领取精灵武煞吧！");
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                        TweenNano.delayedCall(3, function ():void {
                            ModuleManager.showModule(URLUtil.getAppModule("FightVsWuShaPanel"), "正在打开面板...");
                        });
                        return;
                    }
                    if (_curIndex != par.infoVec[1]) {
                        _curIndex = par.infoVec[1];
                        ServerMessager.addMessage("恭喜挑战成功，你可以进入下一个擂台接受挑战喽!");
                        ModuleManager.showModule(URLUtil.getAppModule("FightVsWuShaPanel"), "正在打开面板...", {"isPass": true});
                        if (getCanFightNum(val, par.infoVec[0]) > 0) {
                            fightInit();
                        } else {
                            TweenNano.delayedCall(3, function ():void {
                                ServerMessager.addMessage("你今天的挑战次数已用完，购买挑战后再来吧!");
                                SceneManager.changeScene(SceneType.LOBBY, 70);
                                TweenNano.delayedCall(3, function ():void {
                                    ModuleManager.showModule(URLUtil.getAppModule("FightVsWuShaPanel"), "正在打开面板...");
                                });
                            });
                        }
                    } else if (getCanFightNum(val, par.infoVec[0]) > 0) {
                        fightInit();
                    } else {
                        TweenNano.delayedCall(3, function ():void {
                            ServerMessager.addMessage("你今天的挑战次数已用完，购买挑战后再来吧!");
                            SceneManager.changeScene(SceneType.LOBBY, 70);
                            TweenNano.delayedCall(3, function ():void {
                                ModuleManager.showModule(URLUtil.getAppModule("FightVsWuShaPanel"), "正在打开面板...");
                            });
                        });
                    }
                });
            });
        }
    }

    private function getCanFightNum(param1:int, param2:int):int {
        var _loc3_:int = 0;
        if (VipManager.vipInfo.isVip()) {
            if (param1 > FIGHT_NUM_RULE[1]) {
                _loc3_ = param2;
            } else {
                _loc3_ = FIGHT_NUM_RULE[1] - param1 + param2;
            }
        } else if (param1 > FIGHT_NUM_RULE[0]) {
            _loc3_ = param2;
        } else {
            _loc3_ = FIGHT_NUM_RULE[0] - param1 + param2;
        }
        return _loc3_;
    }

    private function initUI():void {
        this.hideLobbyMenu();
        this._miHelpList = new Vector.<SimpleButton>();
        var _loc1_:int = 0;
        while (_loc1_ < 2) {
            this._miHelpList.push(_map.front["miHelp" + _loc1_]);
            _loc1_++;
        }
        this._freeHelp = _map.front["freeHelp"];
        this._winNum = _map.front["winNum"];
        this._vsName = _map.front["vsName"];
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function fightInit():void {
        var _loc1_:SimpleButton = null;
        if (Boolean(BitUtil.getBit(this._par.infoVec[3], _curIndex))) {
            this._freeHelp.visible = false;
            this._miHelpList[0].visible = true;
        } else {
            this._freeHelp.visible = true;
            this._miHelpList[0].visible = false;
        }
        this.addNpc(NPC_LIST[_curIndex], NPC_NAME[_curIndex]);
        this._freeHelp.addEventListener(MouseEvent.CLICK, this.onFreeHelp);
        for each(_loc1_ in this._miHelpList) {
            _loc1_.addEventListener(MouseEvent.CLICK, this.onMiHelp);
        }
    }

    private function onFreeHelp(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._par.infoVec[2] == 0) {
            SwapManager.swapItem(FREE_HELP_SWAP, 1, function (param1:IDataInput):void {
                var data:IDataInput = param1;
                new SwapInfo(data);
                ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                    ServerMessager.addMessage("雇佣成功,请在背包中挑选剩下的精灵出战！");
                    _freeHelp.visible = false;
                    _miHelpList[0].visible = true;
                    _par = param1;
                });
            }, null, new SpecialInfo(1, _curIndex));
        } else {
            AlertManager.showAlert("你当前已有雇佣兵相助了,用它打完下场挑战才能再次雇佣哦。");
        }
    }

    private function onMiHelp(param1:MouseEvent):void {
        var index:int = 0;
        var evt:MouseEvent = param1;
        index = this._miHelpList.indexOf(evt.currentTarget as SimpleButton);
        if (this._par.infoVec[2] == 0) {
            AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_ID_LIST[_curIndex][index]) + "星钻雇佣精灵吗?", function ():void {
                PayManager.buyItem(MI_ID_LIST[_curIndex][index], function ():void {
                    ActiveCountManager.requestActiveCountList(FOR_LIST, function (param1:Parser_1142):void {
                        ServerMessager.addMessage("雇佣成功,请在背包中挑选剩下的精灵出战！");
                        _par = param1;
                    });
                });
            });
        } else {
            AlertManager.showAlert("你当前已经有雇佣兵相助了，使用完了再雇佣吧。");
        }
    }

    private function fightVsWuShaActDispose():void {
        var _loc1_:SimpleButton = null;
        this.removeNpc();
        this.removeMouseHint();
        if (this._freeHelp) {
            this._freeHelp.removeEventListener(MouseEvent.CLICK, this.onFreeHelp);
            this._freeHelp = null;
        }
        if (this._miHelpList) {
            for each(_loc1_ in this._miHelpList) {
                _loc1_.removeEventListener(MouseEvent.CLICK, this.onMiHelp);
            }
            this._miHelpList = null;
        }
        this._miHelpList = null;
        this._freeHelp = null;
        this._winNum = null;
        this._npc = null;
    }

    private function addNpc(param1:int, param2:String):void {
        this.removeNpc();
        this._npc = new Mobile();
        this._npc.width = 82;
        this._npc.height = 115;
        this._npc.setPostion(new Point(190, 455));
        this._npc.resourceUrl = URLUtil.getNpcSwf(param1);
        this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
        this._npc.label = param2;
        this._npc.labelImage.y = -this._npc.height - 10;
        this._npc.buttonMode = true;
        this.showMouseHintAtMonster(this._npc);
        MobileManager.addMobile(this._npc, MobileType.NPC);
        this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
    }

    private function onNpc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(NPC_DAILOGE_LIST[_curIndex], NPC_NAME[_curIndex], [[NPC_DIALOGE_ID_LIST[_curIndex], TIPS_LIST[_curIndex]]], ["点击挑战", "准备一下"], [function ():void {
            if (_par.infoVec[2] == 0) {
                FightManager.startFightWithWild(FIGHT_INDEX[_curIndex]);
            } else {
                ModuleManager.showModule(URLUtil.getAppModule("PetSelectFightPanel"), "正在打开面板...", {
                    "mode": FightMode.FIGHT_ACT_VS_WuSha,
                    "posIndex": FIGHT_INDEX[_curIndex],
                    "min": 1,
                    "max": 5
                });
            }
        }]);
    }

    private function removeNpc():void {
        if (this._npc) {
            this.removeMouseHint();
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpc);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function showMouseHintAtMonster(param1:Sprite):void {
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.y = -param1.height - 10;
        this._mouseHint.x = (param1.width - this._mouseHint.width) / 2;
        param1.addChild(this._mouseHint);
    }

    private function removeMouseHint():void {
        DisplayUtil.removeForParent(this._mouseHint);
        this._mouseHint = null;
    }

    override public function init():void {
        this.fightVsWuShaActInit();
    }

    override public function dispose():void {
        this.fightVsWuShaActDispose();
        super.dispose();
    }
}
}
