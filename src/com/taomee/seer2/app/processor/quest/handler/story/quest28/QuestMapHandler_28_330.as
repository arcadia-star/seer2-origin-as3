package com.taomee.seer2.app.processor.quest.handler.story.quest28 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

public class QuestMapHandler_28_330 extends QuestMapHandler {


    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_28_330(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && QuestManager.isComplete(27)) {
            this.addMouseHint(639, 367);
        }
    }

    private function addMouseHint(param1:Number, param2:Number):void {
        if (this._mouseHint == null) {
            this._mouseHint = new MouseClickHintSprite();
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
            LayerManager.moduleLayer.addChild(this._mouseHint);
        } else {
            this._mouseHint.x = param1;
            this._mouseHint.y = param2;
        }
    }

    private function clearMouseHint():void {
        if (this._mouseHint) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
            this._mouseHint = null;
        }
    }

    override public function processMapDispose():void {
        this.clearMouseHint();
        super.processMapDispose();
    }
}
}
