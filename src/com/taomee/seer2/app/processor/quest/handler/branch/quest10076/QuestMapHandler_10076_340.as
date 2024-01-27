package com.taomee.seer2.app.processor.quest.handler.branch.quest10076 {
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
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10076_340 extends QuestMapHandler {


    private var flyEets:MovieClip;

    private var flyBlood:MovieClip;

    private var tips:MovieClip;

    public function QuestMapHandler_10076_340(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAsccept);
            QuestManager.accept(_quest.id);
        }
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isComplete(_quest.id)) {
            this.showflyEets();
        }
    }

    private function onAsccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAsccept);
            this.showflyEets();
        }
    }

    private function showflyEets():void {
        this.flyEets = _processor.resLib.getMovieClip("FlyEets");
        this.flyEets.gotoAndStop(1);
        this.flyEets.buttonMode = true;
        this.flyEets.addEventListener(MouseEvent.CLICK, this.showDia);
        this.flyBlood = _processor.resLib.getMovieClip("BloodBar");
        this.flyBlood.gotoAndStop(1);
        this.flyBlood.width = 52;
        this.flyBlood.height = 7.5;
        this.flyBlood.x = this.flyEets.x;
        this.flyBlood.y = 20;
        _map.front.addChild(this.flyEets);
        _map.front.addChild(this.flyBlood);
        this.tips = _processor.resLib.getMovieClip("TipsText");
        this.tips.stop();
    }

    protected function showDia(param1:Event):void {
        var event:Event = param1;
        MovieClipUtil.playMc(this.flyEets, 1, this.flyEets.totalFrames, function ():void {
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
        if (info.userID == ActorManager.actorInfo.id && this.flyEets.hitTestPoint(info.endPos.x, info.endPos.y)) {
            this.flyBlood.gotoAndStop(2);
            ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
            NpcDialog.show(476, "飞伊特", [[3, "哼！都不懂得享受生活！扫兴！"]], [" 我会孜孜不倦地阻止你的！"], [function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, completeQuest);
                QuestManager.completeStep(_quest.id, 1);
            }]);
        }
    }

    private function completeQuest(param1:QuestEvent):void {
        if (param1.questId == 10076) {
            _map.front.removeChild(this.flyEets);
            _map.front.removeChild(this.flyBlood);
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.completeQuest);
            if (!QuestManager.isComplete(10075) || !QuestManager.isComplete(10077)) {
                this.showActivePanel();
            }
        }
    }

    private function showActivePanel():void {
        ModuleManager.toggleModule(URLUtil.getAppModule("NewTurnBeatPanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        if (this.flyEets) {
            this.flyEets.removeEventListener(MouseEvent.CLICK, this.showDia);
        }
        ShootController.removeEventListener(ShootEvent.PLAY_END, this.chekTarget);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAsccept);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.completeQuest);
    }
}
}
