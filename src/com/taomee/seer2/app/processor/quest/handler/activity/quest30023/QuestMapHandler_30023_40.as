package com.taomee.seer2.app.processor.quest.handler.activity.quest30023 {
import com.taomee.seer2.app.actor.attach.PetKingTeamAttach;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.constant.FunctionalityType;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.dialog.functionality.BaseUnit;
import com.taomee.seer2.app.dialog.functionality.CustomUnit;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30023_40 extends QuestMapHandler {

    public static const SIGN:String = "i_am_commissary_30023_40";

    public static const TEAM_INDEX:int = 2;

    public static var isPlayTalkMc:Boolean = false;


    private var _decorateMc:MovieClip;

    private var _progressbar:MovieClip;

    public function QuestMapHandler_30023_40(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.talkCompleteHandler);
        }
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.destory);
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
    }

    private function onDialogShow(param1:Event):void {
        var _loc2_:BaseUnit = new CustomUnit(FunctionalityType.QUEST, "我是宣传委员", SIGN);
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.functionalityBox.addUnit(_loc2_);
        }
    }

    private function talkCompleteHandler(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == SIGN) {
            if (PetKingTeamAttach.myTeamIndex == TEAM_INDEX) {
                NpcDialog.show(3, "上尉", [[0, "恩！士气！队员们的士气很重要！好好装扮下我们的主战场吧！"]], ["（点击打工赛尔）"], [function ():void {
                    initMc();
                }]);
            } else {
                NpcDialog.show(3, "上尉", [[0, "你现在不是冰沁队的哦！"]], ["（知道了）"], [function ():void {
                }]);
            }
        }
    }

    private function initMc():void {
        this._decorateMc = _processor.resLib.getMovieClip("daban2");
        LayerManager.topLayer.addChild(this._decorateMc);
        LayerManager.focusOnTopLayer();
        this._progressbar = this._decorateMc["progressbar"]["bar"] as MovieClip;
        _processor.showMouseHintAt(473, 243);
        this._decorateMc.buttonMode = true;
        this._decorateMc.addEventListener(MouseEvent.CLICK, this.playProgressbar);
    }

    private function playProgressbar(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._decorateMc.removeEventListener(MouseEvent.CLICK, this.playProgressbar);
        this._progressbar.play();
        this._progressbar.addFrameScript(this._progressbar.totalFrames - 1, function ():void {
            _progressbar.stop();
            NpcDialog.show(3, "上尉", [[0, "恩！不错！接下来去珊瑚路找些族民一同加入我们其中吧！我想你一定可以完成！"]], ["（我这就前往珊瑚路）"], [function ():void {
                LayerManager.resetOperation();
                isPlayTalkMc = true;
                SceneManager.changeScene(SceneType.LOBBY, 202);
            }]);
        });
    }

    private function destory(param1:Event = null):void {
        _processor.hideMouseClickHint();
        DisplayUtil.removeForParent(this._decorateMc);
        DisplayUtil.removeForParent(this._progressbar);
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.destory);
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.talkCompleteHandler);
    }
}
}
