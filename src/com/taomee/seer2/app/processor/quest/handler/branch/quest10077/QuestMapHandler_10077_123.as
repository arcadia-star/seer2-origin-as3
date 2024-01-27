package com.taomee.seer2.app.processor.quest.handler.branch.quest10077 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootEvent;
import com.taomee.seer2.app.shoot.ShootInfo;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10077_123 extends QuestMapHandler {


    private var chongBlood:MovieClip;

    private var chongEets:MovieClip;

    private var tips:MovieClip;

    public function QuestMapHandler_10077_123(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAsccept);
            QuestManager.accept(_quest.id);
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            this.showchongEets();
        }
    }

    private function onAsccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAsccept);
            this.showchongEets();
        }
    }

    private function showchongEets():void {
        this.chongEets = _processor.resLib.getMovieClip("ChongEets");
        this.chongEets.gotoAndStop(1);
        this.chongEets.buttonMode = true;
        this.chongEets.addEventListener(MouseEvent.CLICK, this.showDia);
        this.chongBlood = _processor.resLib.getMovieClip("BloodBar");
        this.chongBlood.gotoAndStop(1);
        this.chongBlood.width = 52;
        this.chongBlood.height = 7.5;
        this.chongBlood.x = this.chongEets.x + 10;
        this.chongBlood.y = 50;
        _map.content.addChild(this.chongEets);
        _map.content.addChild(this.chongBlood);
        this.tips = _processor.resLib.getMovieClip("TipsText");
        this.tips.stop();
    }

    private function showDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        MovieClipUtil.playMc(this.chongEets, 1, this.chongEets.totalFrames, function ():void {
            _map.front.addChild(tips);
            MovieClipUtil.playMc(tips, 1, tips.totalFrames, function ():void {
                _map.front.removeChild(tips);
                ShootController.addEventListener(ShootEvent.PLAY_END, chekTarget);
            }, true);
        }, true);
    }

    private function chekTarget(param1:ShootEvent):void {
        var event:ShootEvent = param1;
        var info:ShootInfo = event.info;
        if (info.userID == ActorManager.actorInfo.id && this.chongEets.hitTestPoint(info.endPos.x, info.endPos.y)) {
            ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
            this.chongBlood.gotoAndStop(2);
            NpcDialog.show(473, "虫伊特", [[2, "哼！都不懂得享受生活！扫兴！"]], [" 我会孜孜不倦地阻止你的！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, completeQuest);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }
    }

    private function completeQuest(param1:QuestEvent):void {
        if (param1.questId == 10077) {
            _map.content.removeChild(this.chongEets);
            _map.content.removeChild(this.chongBlood);
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.completeQuest);
            if (!QuestManager.isComplete(10075) || !QuestManager.isComplete(10076)) {
                this.showActivePanel();
            }
        }
    }

    private function showActivePanel():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("NewTurnBeatPanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        if (this.chongEets) {
            this.chongEets.removeEventListener(MouseEvent.CLICK, this.showDia);
        }
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAsccept);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.completeQuest);
    }
}
}
