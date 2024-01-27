package com.taomee.seer2.app.actives {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.events.FightStartEvent;
import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.PetIsHaveManager;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.serverBuffer.ServerBuffer;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class NianshouAct {

    public static const PET_ID:int = 2589;

    public static const FIGHT_ID:int = 1883;

    private static var _npc:DisplayObject;


    public function NianshouAct() {
        super();
    }

    public static function init():void {
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, onCustomUnitClick);
        initForMap40();
    }

    public static function initForMap40():void {
        PetIsHaveManager.requestIsHavePet(petIds, function ():void {
            var _loc1_:IconDisplayer = null;
            var _loc2_:String = null;
            if (PetIsHaveManager.petIsHave(PET_ID)) {
                return;
            }
            _loc1_ = new IconDisplayer();
            _loc2_ = String(URLUtil.getRes("activity/icon/nianshou.swf"));
            _loc1_.setIconUrl(_loc2_);
            _loc1_.addEventListener(MouseEvent.CLICK, onNpcClick);
            _loc1_.x = 727;
            _loc1_.y = 364;
            _npc = _loc1_;
            SceneManager.active.mapModel.content.addChild(_loc1_);
            _loc1_.mouseChildren = false;
            _loc1_.buttonMode = true;
        });
    }

    public static function leaveMap40():void {
        if (_npc != null) {
            _npc.removeEventListener(MouseEvent.CLICK, onNpcClick);
            _npc = null;
        }
    }

    private static function onCustomUnitClick(param1:DialogPanelEvent):void {
        if (param1.content.params != "nianshou") {
            return;
        }
        onNpcClick();
    }

    private static function onNpcClick(param1:* = null):void {
        var e:* = param1;
        PetIsHaveManager.requestIsHavePet(petIds, function ():void {
            if (PetIsHaveManager.petIsHave(PET_ID)) {
                AlertManager.showAlert("你已经捕捉到精灵“吞”了！");
                return;
            }
            ServerBufferManager.getServerBuffer(ServerBufferType.NIANSHOU_ACT, function (param1:ServerBuffer):void {
                if (param1.readDataAtPostion(1) == 0) {
                    ServerBufferManager.updateServerBuffer(ServerBufferType.NIANSHOU_ACT, 1, 1);
                    NpcDialog.showDialogsByText("activity/dialog/nianshou.json", catchNianshou);
                } else {
                    catchNianshou();
                }
            });
        });
    }

    private static function catchNianshou(param1:Boolean = false):void {
        var isRedo:Boolean = param1;
        var dialogs:Array = [[113, "NONO", [[0, "继续喂他赛尔豆吗？"]], ["喂！(8888赛尔豆)", "不喂了！！"]]];
        if (isRedo) {
            dialogs = [[113, "NONO", [[0, "也许还要再试试…"]], ["喂！(8888赛尔豆)", "不喂了！！"]]];
        }
        NpcDialog.showDialogs(dialogs, function ():void {
            useSaierdou(function (param1:Boolean):void {
                if (param1) {
                    FightManager.addEventListener(FightStartEvent.FIGHT_OVER, onFightOver);
                    FightManager.startFightWithWild(FIGHT_ID);
                } else {
                    catchNianshou(true);
                }
            });
        });
    }

    private static function onFightOver(param1:* = null):void {
        var e:* = param1;
        if (FightManager.currentFightRecord.initData.positionIndex != FIGHT_ID) {
            return;
        }
        FightManager.removeEventListener(FightStartEvent.FIGHT_OVER, onFightOver);
        PetIsHaveManager.requestIsHavePet(petIds, function ():void {
            var sucessDialog:Array = null;
            var dialogs:Array = null;
            if (PetIsHaveManager.petIsHave(PET_ID)) {
                sucessDialog = [[5, "乔修尔", [[0, "呀，小赛尔，你可真是有财力呀——给你拜个小年，给个红包怎么样。"]], ["拒绝！"]]];
                NpcDialog.showDialogs(sucessDialog, function ():void {
                });
            } else {
                dialogs = [[113, "NONO", [[0, "吧唧吧唧…"]], ["可恶…我的赛尔豆…"]]];
                NpcDialog.showDialogs(dialogs, catchNianshou);
            }
        });
    }

    private static function useSaierdou(param1:Function):void {
        var callBack:Function = param1;
        SwapManager.swapItem(4653, 1, function success(param1:IDataInput):void {
            new SwapInfo(param1);
            if (Math.random() * 100 < 40) {
                callBack(true);
            } else {
                callBack(false);
            }
        }, function failed(param1:uint):void {
            AlertManager.showAlert("没有足够的赛尔豆！");
        });
    }

    private static function get petIds():Vector.<uint> {
        return Vector.<uint>([2589, 2590]);
    }
}
}
