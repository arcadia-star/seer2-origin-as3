package com.taomee.seer2.app.processor.quest.handler.main.quest94 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_94_3830 extends QuestMapHandler {


    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _npc1032:Mobile;

    private const NPCID:int = 3017;

    private var _npc:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_94_3830(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._npc1032 = MobileManager.getMobile(1032, MobileType.NPC);
        if (QuestManager.isAccepted(94) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            } else if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                this.onStep(null);
            } else if (QuestManager.isStepComplete(questID, 3) && !QuestManager.isStepComplete(questID, 4)) {
                this.createNPC3017();
            }
        }
    }

    private function createNPC3017():void {
        this._npc = new Mobile();
        this._npc.setPostion(new Point(552, 500));
        this._npc.label = "神秘人";
        this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
        this._npc.buttonMode = true;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        var _loc1_:AcceptableMark = new AcceptableMark();
        this._npc.addChild(_loc1_);
        _loc1_.y = -130;
        this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function removeNPC3017():void {
        if (this._npc) {
            MobileManager.removeMobile(this._npc, MobileType.NPC);
            this._npc = null;
        }
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(3017, "神秘人", [[0, "你就是" + ActorManager.actorInfo.nick + "吧。"]], ["你是什么人？"], [function ():void {
            NpcDialog.show(3017, "神秘人", [[0, "放弃吧，你是追不上我的。"]], ["你跑到哪我都能追上！"], [function ():void {
                _mc2 = _processor.resLib.getMovieClip("Mc94_1");
                _mc2.x = 600;
                _mc2.y = 334;
                _map.front.addChild(_mc2);
                _mc2.gotoAndStop(1);
                MovieClipUtil.playMc(_mc2, 1, _mc2.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc2);
                    ModuleManager.showAppModule("MomeryGamePanel");
                }, true);
            }]);
        }]);
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        if (DialogPanelEventData(param1.content).params == "94_2") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.completeStep(questID, 2);
        }
    }

    private function onStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 870;
        this._mouseHint.y = 334;
        _map.front.addChild(this._mouseHint);
    }

    override public function processMapDispose():void {
        if (this._mouseHint != null) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
        }
        this.removeNPC3017();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
