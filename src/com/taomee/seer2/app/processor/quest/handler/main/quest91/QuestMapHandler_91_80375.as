package com.taomee.seer2.app.processor.quest.handler.main.quest91 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_91_80375 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var equipMc:MovieClip;

    public function QuestMapHandler_91_80375(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        RightToolbarConter.instance.hide();
        ActorManager.getActor().hide();
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().blockNoNo = true;
        this.equipMc = _map.content["teleportMc"];
        this.equipMc.visible = false;
        _map.content["npcMc"].visible = false;
        (_map.content["npcMc"] as MovieClip).addEventListener(MouseEvent.CLICK, this.onNpc);
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
            this.startStep();
        }
        if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onNpc(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1026, "伊鲁维塔将军", [[0, "这里是阿尔达要塞，人类最后的净土。"]], ["我们一定会拯救人类！"], [function ():void {
        }]);
    }

    private function startStep():void {
        NpcDialog.show(1026, "伊鲁维塔", [[0, "极梦！你受了好严重的伤！发生了什么事？  "]], ["先送极梦去治疗吧！"], [function ():void {
            NpcDialog.show(1026, "伊鲁维塔", [[0, "阿兹尔，带极梦去治疗吧。 "]], ["是，将军！"], [function ():void {
                _mc1 = _processor.resLib.getMovieClip("Mc91_1");
                _map.front.addChild(_mc1);
                _mc1.gotoAndStop(1);
                MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    NpcDialog.show(1026, "伊鲁维塔", [[0, "我们需要重新研制更稳定的能量转化器，这需要一定的时间。能量碎片能不能留在地球进行进一步研究？  "]], ["我们需要回超能氏族向里格队长报告"], [function ():void {
                        NpcDialog.show(845, "宇宙骑士", [[0, "                     这个就交给我吧。 "]], ["你能带我们回阿卡迪亚吗？"], [function ():void {
                            _mc2 = _processor.resLib.getMovieClip("Mc91_2");
                            _map.front.addChild(_mc2);
                            _mc2.gotoAndStop(1);
                            MovieClipUtil.playMc(_mc2, 1, _mc2.totalFrames, function ():void {
                                DisplayObjectUtil.removeFromParent(_mc2);
                                ActorManager.getActor().show();
                                ActorManager.getActor().blockFollowingPet = false;
                                ActorManager.getActor().blockNoNo = false;
                                _map.content["npcMc"].visible = true;
                                equipMc.visible = true;
                                equipMc.buttonMode = true;
                                equipMc.addEventListener(MouseEvent.CLICK, onOver);
                            }, true);
                        }]);
                    }]);
                }, true);
            }]);
        }]);
    }

    private function onOver(param1:MouseEvent):void {
        QuestManager.completeStep(questID, 3);
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        RightToolbarConter.instance.show();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        super.processMapDispose();
    }
}
}
