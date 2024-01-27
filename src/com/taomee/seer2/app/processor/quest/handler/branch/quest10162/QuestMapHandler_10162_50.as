package com.taomee.seer2.app.processor.quest.handler.branch.quest10162 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.guide.info.GudieDirectionType;
import com.taomee.seer2.app.guide.manager.GuideManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.IDataInput;

import org.taomee.manager.EventManager;
import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10162_50 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_10162_50(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "10162_0") {
            this.playFull();
        } else if ((param1.content as DialogPanelEventData).params == "10162_1") {
            this.openPanel();
        } else if ((param1.content as DialogPanelEventData).params == "10162_2") {
            this.openOnePanel();
        } else if ((param1.content as DialogPanelEventData).params == "10162_3") {
            SwapManager.swapItem(924, 1, this.onSwapHandler);
        }
    }

    private function onSwapHandler(param1:IDataInput):void {
        var data:IDataInput = param1;
        var swap:SwapInfo = new SwapInfo(data);
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            if (_mc_0) {
                DisplayUtil.removeForParent(_mc_0);
            }
            ModuleManager.toggleModule(URLUtil.getAppModule("ItemBagPanel"), "正在打开背包...");
            var _loc1_:Rectangle = new Rectangle(0, 0, 47, 45);
            GuideManager.instance.addTarget(_loc1_, 0);
            GuideManager.instance.addGuide2Target(_loc1_, 0, 0, new Point(747, 335), false, false, GudieDirectionType.CONTENT);
            GuideManager.instance.startGuide(0);
            EventManager.addEventListener("clickElement", onEvent);
        }, true);
    }

    private function onEvent(param1:Event):void {
        var event:Event = param1;
        EventManager.removeEventListener("clickElement", this.onEvent);
        GuideManager.instance.pause();
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        LayerManager.topLayer.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            if (_mc_0) {
                DisplayUtil.removeForParent(_mc_0);
            }
            QuestManager.addEventListener(QuestEvent.COMPLETE, onCompleteQuestHandler);
            QuestManager.completeStep(_quest.id, 3);
        }, true);
    }

    private function onCompleteQuestHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteQuestHandler);
    }

    private function playFull():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10162_0"), function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
            QuestManager.accept(_quest.id);
        }, true, false, 2);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        NpcDialog.show(4, "菲鲁", [[0, "小战士，你想成为最强训练师吗？那就和我一起锻造这套传说中的装备吧！"]], ["哇，好厉害哦！"], [function ():void {
            openPanel();
        }]);
    }

    private function openPanel():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("BlackGoldSuitPanel"), "正在打开面板...");
    }

    private function openOnePanel():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("GoldScrollOnePanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteQuestHandler);
    }
}
}
