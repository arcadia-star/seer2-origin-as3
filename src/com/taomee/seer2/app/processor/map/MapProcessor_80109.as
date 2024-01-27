package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.controls.PetAvatarPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.lobby.LobbyScene;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.manager.DayLimitManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.shopManager.PayManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileLabelPosition;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.utils.DisplayUtil;

public class MapProcessor_80109 extends TitleMapProcessor {

    private static const FIGHT_INDEX:int = 774;

    private static const POWER_MAX:int = 500;

    private static const SWAP_LIST:Vector.<int> = Vector.<int>([2299, 2302]);

    private static const DAY_LIST:Array = [942, 943, 944];

    private static const FOR_LIST:Array = [203630, 203628, 203644];

    private static const MI_LIST:Vector.<uint> = Vector.<uint>([603432]);

    private static const FIGHT_NUM_RULE:Vector.<int> = Vector.<int>([3, 6]);

    private static const GAME_NUM:int = 3;


    private var _npc:Mobile;

    private var _hurtNum:TextField;

    private var _gameNum:TextField;

    private var _bar:MovieClip;

    private var _powerMark:MovieClip;

    private var _func:MovieClip;

    private var _miBuy:SimpleButton;

    private var _scoreVal:int;

    public function MapProcessor_80109(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.kengTeActInit();
    }

    private function kengTeActInit():void {
        this.initHurtAct();
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord.initData.positionIndex == FIGHT_INDEX) {
                DayLimitListManager.getDaylimitList(DAY_LIST, function (param1:DayLimitListInfo):void {
                    var info:DayLimitListInfo = param1;
                    ActiveCountManager.requestActiveCount(FOR_LIST[0], function (param1:uint, param2:int):void {
                        var leaveNum:int = 0;
                        var type:uint = param1;
                        var count:int = param2;
                        if (FOR_LIST[0] == type) {
                            _hurtNum.text = info.getCount(DAY_LIST[2]).toString();
                            if (VipManager.vipInfo.isVip()) {
                                leaveNum = FIGHT_NUM_RULE[1] - info.getCount(DAY_LIST[0]) + count;
                            } else {
                                leaveNum = FIGHT_NUM_RULE[0] - info.getCount(DAY_LIST[0]) + count;
                            }
                            ModuleManager.addEventListener("KengTeFightResultPanel", ModuleEvent.DISPOSE, function onDispose(param1:ModuleEvent):void {
                                ModuleManager.removeEventListener("KengTeFightResultPanel", ModuleEvent.DISPOSE, onDispose);
                                if (leaveNum > 0) {
                                    createNpc();
                                } else {
                                    ModuleManager.toggleModule(URLUtil.getAppModule("FightNumTipPanel"), "正在打开面板...", {"func": createNpc});
                                }
                            });
                            ModuleManager.toggleModule(URLUtil.getAppModule("KengTeFightResultPanel"));
                            updateHurtAct();
                        }
                    });
                });
            }
        } else {
            this.createNpc();
            this.updateHurtAct();
        }
    }

    private function initHurtAct():void {
        this._hurtNum = _map.front["hurtNum"];
        this._hurtNum.text = "0";
        this._gameNum = _map.front["gameNum"];
        this._bar = _map.front["bar"];
        this._func = _map.front["func"];
        this._func.buttonMode = true;
        this._func.addEventListener(MouseEvent.CLICK, this.onFunc);
        this._miBuy = _map.front["miBuy"];
        this._miBuy.addEventListener(MouseEvent.CLICK, this.onMiBuy);
        this._powerMark = _map.front["powerMark"];
        (SceneManager.active as LobbyScene).hideToolbar();
        PetAvatarPanel.show();
    }

    private function onFunc(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DayLimitManager.getDoCount(DAY_LIST[1], function (param1:int):void {
            var val:int = param1;
            ActiveCountManager.requestActiveCount(FOR_LIST[2], function (param1:uint, param2:uint):void {
                var type:uint = param1;
                var count:uint = param2;
                if (_func.currentFrame == 1) {
                    if (val >= GAME_NUM) {
                        AlertManager.showAlert("今天的游戏次数已经用完，明天继续吧.你也可以用星钻注满荣耀。");
                    } else if (count > 0) {
                        AlertManager.showAlert("赶快去挑战哦，使用完荣耀再来玩吧!");
                    } else {
                        ModuleManager.toggleModule(URLUtil.getAppModule("KengTeBitMouseGamePanel"), "", {
                            "func": function (param1:int):void {
                                var score:int = param1;
                                SwapManager.swapItem(SWAP_LIST[1], score, function (param1:IDataInput):void {
                                    new SwapInfo(param1);
                                    ServerMessager.addMessage("你获得了" + score + "点荣耀值!");
                                    updateHurtAct();
                                }, function (param1:uint):void {
                                });
                            }
                        });
                    }
                } else if (count > 0) {
                    AlertManager.showAlert("赶快去挑战哦，使用完荣耀再继续使用吧!");
                } else {
                    SwapManager.swapItem(SWAP_LIST[0], 1, function (param1:IDataInput):void {
                        new SwapInfo(param1);
                        updateHurtAct();
                    });
                }
            });
        });
    }

    private function onMiBuy(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        if (this._scoreVal >= POWER_MAX) {
            AlertManager.showAlert("你已经满进度了!");
            return;
        }
        AlertManager.showConfirm("你确定花费10星钻一键注满超人荣耀吗?", function ():void {
            PayManager.buyItem(MI_LIST[0], function ():void {
                updateHurtAct();
            });
        });
    }

    private function updateHurtAct():void {
        this._miBuy.mouseEnabled = false;
        this._func.mouseEnabled = this._func.mouseChildren = false;
        ActiveCountManager.requestActiveCount(FOR_LIST[1], function (param1:uint, param2:int):void {
            _scoreVal = param2;
            _gameNum.text = param2.toString() + "/" + POWER_MAX.toString();
            _miBuy.mouseEnabled = true;
            var _loc3_:Number = param2 / POWER_MAX;
            if (_loc3_ > 1) {
                _loc3_ = 1;
            }
            _bar.scaleY = _loc3_;
            if (_loc3_ == 1) {
                _func.gotoAndStop(2);
                _powerMark.gotoAndStop(2);
            } else {
                _func.gotoAndStop(1);
                _powerMark.gotoAndStop(1);
            }
            _func.mouseEnabled = _func.mouseChildren = true;
        });
    }

    private function kengTeActInitDispose():void {
        this.clearNpc();
        if (this._func) {
            this._func.removeEventListener(MouseEvent.CLICK, this.onFunc);
        }
        this._hurtNum = null;
        this._gameNum = null;
        this._bar = null;
        this._func = null;
        this._miBuy = null;
    }

    private function createNpc():void {
        if (!this._npc) {
            this._npc = new Mobile();
            this._npc.width = 100;
            this._npc.height = 140;
            this._npc.setPostion(new Point(555, 380));
            this._npc.resourceUrl = URLUtil.getNpcSwf(689);
            this._npc.labelPosition = MobileLabelPosition.OVER_HEAD;
            this._npc.label = "肯特";
            this._npc.labelImage.y = -this._npc.height - 10;
            this._npc.buttonMode = true;
            MobileManager.addMobile(this._npc, MobileType.NPC);
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(689, "肯特", [[0, "雷伊在我眼里也不过是个小角色，不知道你够不够资格和我一战！"]], ["来挑战吧！", "准备一下"], [function ():void {
            FightManager.startFightWithWild(FIGHT_INDEX);
        }]);
    }

    private function clearNpc():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayUtil.removeForParent(this._npc);
            this._npc = null;
        }
    }

    override public function dispose():void {
        this.kengTeActInitDispose();
        super.dispose();
    }
}
}
