package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.config.ShopPanelConfig;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.QueueLoader;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.system.ApplicationDomain;
import flash.utils.IDataInput;

import org.taomee.utils.BitUtil;
import org.taomee.utils.DisplayUtil;
import org.taomee.utils.DomainUtil;

public class MapProcessor_80219 extends MapProcessor {

    private static const PET_KILL_DAY:int = 1207;

    private static const BOSS_FIGHT_DAY:int = 1206;

    private static const USE_FREE_HURT_ITEM_FOR:uint = 204366;

    private static const MI_BUY_FIGHT_NUM_FOR:uint = 204352;

    private static const USE_HURT_SWAP:int = 2936;

    private static const FIGHT_BOSS_LIST:Vector.<int> = Vector.<int>([1050, 1058, 1059, 1060, 1061, 1062, 1051]);

    private static const MI_BUY_LIST:Vector.<uint> = Vector.<uint>([603944, 500609]);

    private static const PET_POS:Array = [[200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400], [200, 400]];

    private static const BOSS_POS:Vector.<int> = Vector.<int>([200, 400]);

    private static const NPC_RES_LIST:Array = [[[100, 160], 723, [244, 347], "武煞 Lv20"], [[100, 160], 723, [376, 306], "武煞 Lv20"], [[100, 160], 723, [476, 315], "武煞 Lv100"], [[100, 160], 723, [475, 361], "武煞 Lv100"], [[100, 160], 723, [580, 304], "武煞 Lv100"], [[100, 160], 723, [686, 348], "武煞 Lv100"], [[100, 200], 762, [475, 467], "逆世盖亚"]];

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([2, 4]);

    private static var _isFightPet:Boolean;


    private var _resLib:ApplicationDomain;

    private var _npc:Mobile;

    private var _activityMonsterVec:Vector.<Mobile>;

    private var _openList:Vector.<SimpleButton>;

    private var _fightNum:int;

    public function MapProcessor_80219(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.superGaiYaActInit();
    }

    private function superGaiYaActInit():void {
        this.hideLobbyMenu();
        this.getURL();
    }

    private function getURL():void {
        QueueLoader.load(URLUtil.getActivityAnimation("superGaiYaAct/SuperGaiYaAct"), LoadType.SWF, function (param1:ContentInfo):void {
            _resLib = param1.domain;
            createOpenMenu();
            initSet();
        });
    }

    private function initSet():void {
        DayLimitManager.getDoCount(PET_KILL_DAY, function (param1:int):void {
            var val:int = param1;
            if (val != 63) {
                _openList[2].visible = false;
                if (!_isFightPet) {
                    playMc("SceneMC1", function ():void {
                        _isFightPet = true;
                        ModuleManager.showModule(URLUtil.getAppModule("KillSixBossPanel"), "正在打开面板...", {"func": useKillPet});
                        createPetList(val);
                    });
                } else {
                    createPetList(val);
                }
            } else {
                _openList[2].visible = true;
                DayLimitManager.getDoCount(BOSS_FIGHT_DAY, function (param1:int):void {
                    if (param1 == 0) {
                        playBossMc();
                    } else {
                        _npc = createNpc(NPC_RES_LIST[6]);
                        _npc.addEventListener(MouseEvent.CLICK, onNpcClick);
                    }
                });
            }
        });
    }

    private function playBossMc():void {
        var _scenMc:MovieClip = null;
        _scenMc = this.getMovie("SceneMC3");
        _map.front.addChild(_scenMc);
        MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            _openList[2].visible = true;
            _npc = createNpc(NPC_RES_LIST[6]);
            _npc.addEventListener(MouseEvent.CLICK, onNpcClick);
        }, true);
    }

    private function createPetList(param1:int):void {
        var _loc2_:int = 0;
        while (_loc2_ < 6) {
            if (!BitUtil.getBit(param1, _loc2_)) {
                this.addPetByIndex(_loc2_);
            }
            _loc2_++;
        }
    }

    private function playMc(param1:String, param2:Function = null, param3:Array = null):void {
        var _scenMc:MovieClip = null;
        var resName:String = param1;
        var callBack:Function = param2;
        var pos:Array = param3;
        _scenMc = this.getMovie(resName);
        _map.front.addChild(_scenMc);
        if (pos != null) {
            _scenMc.x = pos[0];
            _scenMc.y = pos[1];
        }
        MovieClipUtil.playMc(_scenMc, 2, _scenMc.totalFrames, function ():void {
            DisplayUtil.removeForParent(_scenMc);
            _scenMc = null;
            if (callBack != null) {
                callBack();
                callBack = null;
            }
        }, true);
    }

    private function createOpenMenu():void {
        this._openList = new Vector.<SimpleButton>();
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._openList.push(_map.content["open" + _loc1_]);
            this._openList[_loc1_].addEventListener(MouseEvent.CLICK, this.onOpen);
            _loc1_++;
        }
    }

    private function onOpen(param1:MouseEvent):void {
        var _loc2_:int = this._openList.indexOf(param1.currentTarget as SimpleButton);
        switch (_loc2_) {
            case 0:
                if (this._activityMonsterVec == null || this._activityMonsterVec && this._activityMonsterVec.length == 0) {
                    AlertManager.showAlert("所有武煞已清除，不需要使用一键除煞。");
                } else {
                    ModuleManager.showModule(URLUtil.getAppModule("KillSixBossPanel"), "正在打开面板...", {"func": this.useKillPet});
                }
                break;
            case 1:
                ModuleManager.showModule(URLUtil.getAppModule("MedicineShopPanel"), "正在打开面板...");
                break;
            case 2:
                this.hurtItemBuyHandle();
        }
    }

    private function hurtItemBuyHandle():void {
        ActiveCountManager.requestActiveCount(USE_FREE_HURT_ITEM_FOR, function (param1:uint, param2:uint):void {
            var type:uint = param1;
            var val:uint = param2;
            if (val == 0) {
                SwapManager.swapItem(USE_HURT_SWAP, 1, function (param1:IDataInput):void {
                    new SwapInfo(param1);
                    AlertManager.showAlert("免费使用成功，赶快去挑战逆世盖亚吧!");
                });
            } else if (val == 1) {
                AlertManager.showAlert("你已经是战斗加成效果了，使用完了再买吧!");
            } else {
                ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, function getItem(param1:ItemEvent):void {
                    var num:int;
                    var evt:ItemEvent = param1;
                    ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, getItem);
                    num = ItemManager.getSpecialItem(MI_BUY_LIST[1]) != null ? int(ItemManager.getSpecialItem(MI_BUY_LIST[1]).quantity) : 0;
                    if (num > 0) {
                        AlertManager.showAlert("你已经是战斗加成效果了，使用完了再买吧!");
                    } else {
                        AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_BUY_LIST[1]) + "星钻购买战神荣耀吗?", function ():void {
                            PayManager.buyItem(MI_BUY_LIST[1], function ():void {
                            });
                        });
                    }
                });
                ItemManager.requestSpecialItemList();
            }
        });
    }

    private function buyHandle(param1:uint, param2:Boolean = false, param3:Boolean = true):void {
        ModuleManager.addEventListener("BuyPropPanel", ModuleEvent.DISPOSE, this.onBuyPanelHide);
        ModuleManager.toggleModule(URLUtil.getAppModule("BuyPropPanel"), "正在打开米币小面板...", {
            "itemId": param1,
            "canBatch": param2,
            "islimitNum": param3,
            "buyType": "mi",
            "itemType": "hideShop"
        });
    }

    private function onBuyPanelHide(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("BuyPropPanel", ModuleEvent.DISPOSE, this.onBuyPanelHide);
    }

    private function clearOpenMenu():void {
        var _loc1_:int = 0;
        if (this._openList) {
            _loc1_ = 0;
            while (_loc1_ < this._openList.length) {
                this._openList[_loc1_].removeEventListener(MouseEvent.CLICK, this.onOpen);
                _loc1_++;
            }
            this._openList = null;
        }
    }

    private function addPetByIndex(param1:int):void {
        var _loc2_:int = 0;
        if (this._activityMonsterVec == null) {
            this._activityMonsterVec = new Vector.<Mobile>();
            _loc2_ = 0;
            while (_loc2_ < 6) {
                this._activityMonsterVec.push(new Mobile());
                _loc2_++;
            }
        }
        this._activityMonsterVec[param1] = this.createNpc(NPC_RES_LIST[param1]);
        this._activityMonsterVec[param1].addEventListener(MouseEvent.CLICK, this.onSmallBossClick);
    }

    private function onSmallBossClick(param1:MouseEvent):void {
        var _loc2_:int = this._activityMonsterVec.indexOf(param1.currentTarget as Mobile);
        FightManager.startFightWithWild(FIGHT_BOSS_LIST[_loc2_]);
    }

    private function clearPetList():void {
        var _loc1_:int = 0;
        if (this._activityMonsterVec) {
            _loc1_ = 0;
            while (_loc1_ < this._activityMonsterVec.length) {
                if (this._activityMonsterVec[_loc1_]) {
                    this._activityMonsterVec[_loc1_].removeEventListener(MouseEvent.CLICK, this.onSmallBossClick);
                    MobileManager.removeMobile(this._activityMonsterVec[_loc1_], MobileType.NPC);
                }
                _loc1_++;
            }
        }
        this._activityMonsterVec = null;
    }

    private function getMovie(param1:String):MovieClip {
        if (this._resLib) {
            return DomainUtil.getMovieClip(param1, this._resLib);
        }
        return null;
    }

    private function useKillPet():void {
        this.clearPetList();
        this.playMc("SceneMC2", function ():void {
            playBossMc();
        });
    }

    private function createNpc(param1:Array):Mobile {
        var _loc2_:Array = param1[0] as Array;
        var _loc3_:int = param1[1] as int;
        var _loc4_:Array = param1[2] as Array;
        var _loc5_:String = param1[3] as String;
        var _loc6_:Mobile;
        (_loc6_ = new Mobile()).width = _loc2_[0];
        _loc6_.height = _loc2_[1];
        _loc6_.setPostion(new Point(_loc4_[0], _loc4_[1]));
        _loc6_.resourceUrl = URLUtil.getNpcSwf(_loc3_);
        _loc6_.labelPosition = MobileLabelPosition.OVER_HEAD;
        _loc6_.label = _loc5_;
        _loc6_.labelImage.y = -_loc6_.height - 10;
        _loc6_.buttonMode = true;
        MobileManager.addMobile(_loc6_, MobileType.NPC);
        return _loc6_;
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        ModuleManager.showModule(URLUtil.getAppModule("SuperGaiYaFightPanel"), "正在打开面板...", {"func": this.startFight});
    }

    private function startFight():void {
        DayLimitManager.getDoCount(BOSS_FIGHT_DAY, function (param1:int):void {
            var val:int = param1;
            ActiveCountManager.requestActiveCount(MI_BUY_FIGHT_NUM_FOR, function (param1:uint, param2:uint):void {
                var type:uint = param1;
                var count:uint = param2;
                _fightNum = ActsHelperUtil.getCanNum(val, count, VipManager.vipInfo.isVip() ? FIGHT_NUM_RULE[1] : FIGHT_NUM_RULE[0]);
                if (_fightNum > 0) {
                    NpcDialog.show(762, "逆世盖亚", [[0, "                         你很有胆量！准备好了吗？今天只有<font color=\'#FF0000\'>" + _fightNum + "</font>次挑战的机会！"]], ["挑战吧！", "准备一下"], [function ():void {
                        FightManager.startFightWithWild(FIGHT_BOSS_LIST[6]);
                    }]);
                } else {
                    NpcDialog.show(762, "逆世盖亚", [[0, "                         你已经没有机会了！明天再次突破武煞六将来找我吧！"]], ["通过星钻继续挑战", " 明天再说吧"], [function ():void {
                        AlertManager.showConfirm("你确定花费" + ShopPanelConfig.getItemPrice(MI_BUY_LIST[0]) + "星钻购买本次挑战吗?", function ():void {
                            PayManager.buyItem(MI_BUY_LIST[0], function ():void {
                                FightManager.startFightWithWild(FIGHT_BOSS_LIST[6]);
                            });
                        });
                    }]);
                }
            });
        });
    }

    private function hideLobbyMenu():void {
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function superGaiYaActDispose():void {
        this.clearNpc();
        this.clearOpenMenu();
        this.clearPetList();
        this._resLib = null;
    }

    override public function dispose():void {
        super.dispose();
        this.superGaiYaActDispose();
    }
}
}
