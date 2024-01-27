package com.taomee.seer2.app.processor.quest.handler.story.quest74 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.controls.MapTitlePanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.MonsterManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_74_1220 extends QuestMapHandler {

    public static var haveBattle:Boolean = true;


    private var _mc2:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_74_1220(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!haveBattle) {
            return;
        }
        super.processMapComplete();
        if (QuestManager.isAccepted(74) && QuestManager.isStepComplete(74, 3) == false) {
            this.initStep1();
            MapTitlePanel.hide();
            MonsterManager.hideAllMonster();
        }
    }

    private function initStep2():void {
        DisplayUtil.removeForParent(this._mack);
        DisplayUtil.removeForParent(this._mc2);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("74_1"), function ():void {
            ModuleManager.showModule(URLUtil.getAppModule("FindPanel"), "打开保护的挑战面板...", {
                "func": function ():void {
                    initStep3();
                }
            });
        }, true, true);
    }

    private function initStep1():void {
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        this._mc2.gotoAndPlay(1);
        _map.front.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 2, this._mc2.totalFrames, function ():void {
            onClick();
        }, true);
    }

    private function initStep3():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        QuestManager.completeStep(74, 3);
    }

    private function onClick():void {
        NpcDialog.show(757, "萤火虫", [[0, "你们好……之后的一段路……由我来……当你们的……向导……"]], ["向导你好"], [function ():void {
            NpcDialog.show(324, "白雪公主", [[0, "事不宜迟，萤火虫，带着第七小队出发吧。"]], ["好的！"], [function ():void {
                NpcDialog.show(757, "萤火虫", [[0, "是的……女王大人…… "]], ["出发！第七小队！"], [function ():void {
                    initStep2();
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        ModuleManager.closeForName("FindPanel");
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        MonsterManager.showAllMonster();
        MapTitlePanel.show();
        SceneManager.changeScene(SceneType.LOBBY, 1210);
    }

    override public function processMapDispose():void {
        MapTitlePanel.show();
        MobileManager.showMoileVec(MobileType.NPC);
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        _map.content.visible = true;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
