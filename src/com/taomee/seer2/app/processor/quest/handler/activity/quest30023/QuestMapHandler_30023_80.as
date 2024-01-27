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

public class QuestMapHandler_30023_80 extends QuestMapHandler {

    public static const SIGN:String = "i_am_commissary_30023_80";

    public static const TEAM_INDEX:int = 1;

    public static var isPlayTalkMc:Boolean = false;


    private var _decorateMc:MovieClip;

    private var _progressbar:MovieClip;

    private var _unit:BaseUnit;

    public function QuestMapHandler_30023_80(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.startTalkWithDuoluo);
        }
        DialogPanel.addEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        SceneManager.addEventListener(SceneEvent.SWITCH_START, this.destory);
    }

    private function onDialogShow(param1:Event):void {
        var _loc2_:BaseUnit = new CustomUnit(FunctionalityType.QUEST, "我是宣传委员", SIGN);
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            DialogPanel.functionalityBox.addUnit(_loc2_);
        }
    }

    private function startTalkWithDuoluo(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == SIGN) {
            if (PetKingTeamAttach.myTeamIndex == TEAM_INDEX) {
                NpcDialog.show(2, "伊娃", [[0, "精灵王争霸赛！听说这次还有神秘精灵乱入！冠军队伍更能轻松获得！看来我们要加把劲！"]], ["（叙述会见船长一事）"], [function ():void {
                    NpcDialog.show(2, "伊娃", [[0, "建设主战场你绝对可以担当一面！去吧！"]], ["（点击场景工作人员）"], [function ():void {
                        initMc();
                    }]);
                }]);
            } else {
                NpcDialog.show(2, "伊娃", [[0, "你现在不是热辣队的哦！"]], ["（知道了）"], [function ():void {
                }]);
            }
        }
    }

    private function initMc():void {
        this._decorateMc = _processor.resLib.getMovieClip("daban1");
        LayerManager.topLayer.addChild(this._decorateMc);
        LayerManager.focusOnTopLayer();
        this._progressbar = this._decorateMc["progressbar"]["bar"] as MovieClip;
        _processor.showMouseHintAt(729.05, 123);
        this._decorateMc.buttonMode = true;
        this._decorateMc.addEventListener(MouseEvent.CLICK, this.playProgressbar);
    }

    private function playProgressbar(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._decorateMc.removeEventListener(MouseEvent.CLICK, this.playProgressbar);
        this._progressbar.gotoAndPlay(2);
        this._progressbar.addFrameScript(this._progressbar.totalFrames - 1, function ():void {
            _progressbar.stop();
            _decorateMc.gotoAndStop(2);
            NpcDialog.show(2, "伊娃", [[0, "很能干的赛尔！接下来是更重要的环节，拉取族民加入！"]], ["（快去赤炼山脉看看吧！）"], [function ():void {
                LayerManager.resetOperation();
                isPlayTalkMc = true;
                SceneManager.changeScene(SceneType.LOBBY, 261);
            }]);
        });
    }

    private function destory(param1:Event):void {
        _processor.hideMouseClickHint();
        SceneManager.removeEventListener(SceneEvent.SWITCH_START, this.destory);
        DialogPanel.removeEventListener(DialogPanelEvent.DIALOG_SHOW, this.onDialogShow);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.startTalkWithDuoluo);
        DisplayUtil.removeForParent(this._decorateMc);
        DisplayUtil.removeForParent(this._progressbar);
    }
}
}
