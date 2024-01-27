package com.taomee.seer2.app.processor.map {
import com.taomee.seer2.app.animationInteractive.PipeAnimation;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.manager.StatisticsManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.map.MapModel;
import com.taomee.seer2.core.map.MapProcessor;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.utils.IDataInput;

public class MapProcessor_520 extends MapProcessor {


    private var _rope:MovieClip;

    private var _goldMine:MovieClip;

    private var _pet:MovieClip;

    private var _pipeAnimation:PipeAnimation;

    public function MapProcessor_520(param1:MapModel) {
        super(param1);
    }

    override public function init():void {
        this.initRope();
        this.initGoldMine();
        this.initRarePet();
        StatisticsManager.sendNovice(StatisticsManager.ui_interact_152);
    }

    private function initRope():void {
        this._rope = _map.content["rope"];
        this._rope.addEventListener(MouseEvent.CLICK, this.onRopeClick);
    }

    private function onRopeClick(param1:MouseEvent):void {
        this._rope.removeEventListener(MouseEvent.CLICK, this.onRopeClick);
        if (SwapManager.isSwapNumberMax(94)) {
            SwapManager.entrySwap(94);
        }
    }

    private function initGoldMine():void {
        this._goldMine = _map.content["goldMine"];
        this._goldMine.addEventListener(MouseEvent.CLICK, this.onGoldMineClick);
    }

    private function onGoldMineClick(param1:MouseEvent):void {
        this._goldMine.removeEventListener(MouseEvent.CLICK, this.onGoldMineClick);
        if (SwapManager.isSwapNumberMax(95)) {
            SwapManager.entrySwap(95);
        }
    }

    private function initRarePet():void {
        this._pet = _map.content["rarePetMC"];
        this._pet.gotoAndStop(1);
        this._pipeAnimation = new PipeAnimation();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomReply);
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (evt.content.params == "getScorpion") {
            if (this._pet.currentFrame >= 151) {
                NpcDialog.show(42, "大板牙", [[0, "嘿！你刚引出的三眼石蝎还傻乎乎的站在那呢，快去抓吧！"]], ["啊，好的！"]);
            } else {
                NpcDialog.show(42, "大板牙", [[0, "小本买卖，小本买卖啦~~给我2个闪闪霓虹灯，让你吹一次笛子。告诉你，笛声可以引出三眼石蝎哦！"]], ["吹一次笛子！", "到哪找闪闪霓虹灯？"], [function ():void {
                    ItemManager.requestItemList(function ():void {
                        if (ItemManager.getItemQuantityByReferenceId(400027) >= 2) {
                            SwapManager.swapItem(106, 2, function (param1:IDataInput):void {
                                ItemManager.reduceItemQuantity(400027, 2);
                                _pipeAnimation.setup("piping", showPet);
                            });
                        } else {
                            NpcDialog.show(42, "大板牙", [[0, "你需要先去找那2个闪闪霓虹灯给我"]], ["我这就去找找，再见！"]);
                        }
                    });
                }, function ():void {
                    NpcDialog.show(42, "大板牙", [[0, "闪闪霓虹灯，很多地方都有哦！比如淘米市场、沙之迷穴、地下黑市等等，你去找找看吧！"]], ["我这就去找找，再见！"]);
                }]);
            }
        }
    }

    private function showPet(param1:Boolean):void {
        var isSuccess:Boolean = param1;
        if (isSuccess == false) {
            NpcDialog.show(42, "大板牙", [[0, "哦，这是你自己不吹的，我可不会把闪闪霓虹灯还给你。"]], ["知道啦！小气鬼！"]);
            return;
        }
        MovieClipUtil.playMc(this._pet, 1, this._pet.totalFrames, function ():void {
            _pet.buttonMode = true;
            _pet.addEventListener(MouseEvent.CLICK, onPetClick);
        }, true);
    }

    private function onPetClick(param1:MouseEvent):void {
        FightManager.startFightWithWild(32);
    }

    override public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
        this._pet.removeEventListener(MouseEvent.CLICK, this.onPetClick);
        this._rope.removeEventListener(MouseEvent.CLICK, this.onRopeClick);
        this._rope = null;
        this._goldMine.removeEventListener(MouseEvent.CLICK, this.onGoldMineClick);
        this._goldMine = null;
        super.dispose();
    }
}
}
