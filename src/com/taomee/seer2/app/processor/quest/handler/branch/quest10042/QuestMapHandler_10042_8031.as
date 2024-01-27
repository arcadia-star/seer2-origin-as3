package com.taomee.seer2.app.processor.quest.handler.branch.quest10042 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.manager.TimeManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_10042_8031 extends QuestMapHandler {


    private var _time:uint;

    private var _pt:Point;

    private var _sprite:Sprite;

    public function QuestMapHandler_10042_8031(param1:QuestProcessor) {
        this._time = new Date(2012, 0, 1, 13).getTime() / 1000;
        this._pt = new Point(335, 269);
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomReply);
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (TimeManager.getServerTime() >= this._time) {
            return;
        }
        if (DialogPanelEventData(param1.content).params == "10042") {
            if (QuestManager.isCanAccepted(_quest.id)) {
                QuestManager.accept(_quest.id);
                this.doStepOne();
            } else if (!QuestManager.isStepComplete(_quest.id, 1)) {
                this.doStepOne();
            } else if (!QuestManager.isStepComplete(_quest.id, 2)) {
                this.doStepTwo();
            }
        }
    }

    private function doStepOne():void {
        NpcDialog.show(61, "法海", [[1, "各位来宾请往上面走！山路较滑，小心行走！不要拥挤！不要推拉！不要进食！人人都可以参观到大胃王的！谢谢您的配合！"]], ["（呃呃呃……参观什么？）"], [function ():void {
            addSprite();
            _processor.showMouseHintAt(_pt.x, _pt.y);
        }]);
    }

    private function onClickSprite(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10042_0"), function ():void {
            removeSprite();
            _processor.hideMouseClickHint();
            QuestManager.completeStep(_quest.id, 1);
            doStepTwo();
        });
    }

    private function doStepTwo():void {
        NpcDialog.show(61, "法海", [[4, "糟糕！！闯祸了！！这可是弥天之灾啊！！！！米……米……奇林复活了！！！！"]], ["（询问详情）"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("10042_0"), 5, [[1, 0]], function ():void {
                var str:* = "<font color=\'#ff0000\'>" + "1月1日，13：00开始" + "</font>" + "是降伏它的唯一机会！！我这里有对付它的秘密武器，记得找我制作！";
                NpcDialog.show(61, "法海", [[0, str]], [" 一言为定！！！"], [function ():void {
                    QuestManager.completeStep(_quest.id, 2);
                }]);
            });
        }]);
    }

    private function addSprite():void {
        this._sprite = UIManager.getSprite("UI_Teleport");
        this._sprite.buttonMode = true;
        this._sprite.addEventListener(MouseEvent.CLICK, this.onClickSprite);
        this._sprite.x = this._pt.x;
        this._sprite.y = this._pt.y;
        LayerManager.uiLayer.addChild(this._sprite);
    }

    private function removeSprite():void {
        if (this._sprite) {
            this._sprite.removeEventListener(MouseEvent.CLICK, this.onClickSprite);
            DisplayObjectUtil.removeFromParent(this._sprite);
            this._sprite = null;
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onCustomReply);
        this.removeSprite();
    }
}
}
