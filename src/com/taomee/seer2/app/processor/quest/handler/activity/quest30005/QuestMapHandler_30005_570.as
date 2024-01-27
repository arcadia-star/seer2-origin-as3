package com.taomee.seer2.app.processor.quest.handler.activity.quest30005 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30005_570 extends QuestMapHandler {


    private var _shootCount:int;

    private var _mc_0:MovieClip;

    private var _clobtn:SimpleButton;

    public function QuestMapHandler_30005_570(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(_quest.id) == false) {
            ActorManager.showRemoteActor = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.loadMc();
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.loadNote();
        }
    }

    private function loadMc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, "冒泡", function ():void {
            _mc_0["leiyi"].buttonMode = true;
            _mc_0["leiyi"].addEventListener(MouseEvent.CLICK, onSeerTalk);
        }, true);
    }

    private function onSeerTalk(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc_0["leiyi"].removeEventListener(MouseEvent.CLICK, this.onSeerTalk);
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "住手！你们究竟想要干嘛！！可恶！这个保护罩我进不去！用射击攻破他！"]], ["（快使用头部射击）"], [function ():void {
            _processor.showMouseHintAt(453, 498);
            ShootController.addEventListener(ShootEvent.PLAY_END, shootComplete);
        }]);
    }

    private function shootComplete(param1:ShootEvent):void {
        var event:ShootEvent = param1;
        var info:ShootInfo = event.info;
        if (this._shootCount == 0) {
            if (info.userID == ActorManager.actorInfo.id && Boolean(this._mc_0["leiyi"].hitTestPoint(info.endPos.x, info.endPos.y))) {
                ++this._shootCount;
                if (this._shootCount == 1) {
                    this._mc_0.gotoAndStop("保护罩三状态");
                }
            }
        } else if (this._shootCount < 3) {
            if (info.userID == ActorManager.actorInfo.id && Boolean(this._mc_0["leier"].hitTestPoint(info.endPos.x, info.endPos.y))) {
                ++this._shootCount;
                if (this._shootCount == 3) {
                    this._mc_0.gotoAndStop("第二种");
                }
            }
        } else if (this._shootCount < 5) {
            if (info.userID == ActorManager.actorInfo.id && Boolean(this._mc_0["leisan"].hitTestPoint(info.endPos.x, info.endPos.y))) {
                ++this._shootCount;
                if (this._shootCount == 5) {
                    this._mc_0.gotoAndStop("第三种");
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30005_2"), function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep4Handler);
                        QuestManager.completeStep(_quest.id, 4);
                    }, true, false, 2);
                }
            }
        }
    }

    private function onStep4Handler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4Handler);
        _processor.hideMouseClickHint();
        this.loadNote();
    }

    private function loadNote():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_6");
        _map.content.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.openNote);
    }

    private function openNote(param1:MouseEvent):void {
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.openNote);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_7");
        _map.front.addChild(this._mc_0);
        this._clobtn = this._mc_0["close_btn"] as SimpleButton;
        this._clobtn.addEventListener(MouseEvent.CLICK, this.onCloseNote);
    }

    private function onCloseNote(param1:MouseEvent):void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        QuestManager.completeStep(_quest.id, 5);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        ActorManager.showRemoteActor = true;
        if (param1.questId == 540) {
            if (this._mc_0) {
                DisplayUtil.removeForParent(this._mc_0);
            }
        }
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep4Handler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
