package com.taomee.seer2.app.processor.quest.handler.branch.quest10225 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10225_80174 extends QuestMapHandler {

    public static var haveBattle:Boolean = true;


    private var _mc1:MovieClip;

    private var _mack:AcceptableMark;

    public function QuestMapHandler_10225_80174(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!haveBattle) {
            return;
        }
        super.processMapComplete();
        if (QuestManager.isAccepted(10225) && QuestManager.isStepComplete(10225, 1) == false) {
            _map.content.visible = false;
            this.initStep1();
        }
    }

    private function initStep1():void {
        ActorManager.showRemoteActor = false;
        MobileManager.hideMoileVec(MobileType.NPC);
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        this._mc1["he"].visible = false;
        _map.front.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = _mc1["he"].x;
            _mack.y = _mc1["he"].y;
            _mc1.addChild(_mack);
            _mc1["he"].visible = true;
            _mc1["he"].buttonMode = true;
            _mc1["he"].addEventListener(MouseEvent.CLICK, onClick);
        }, true);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this._mc1["he"].removeEventListener(MouseEvent.CLICK, this.onClick);
        NpcDialog.show(736, "赫", [[0, "该死的破飞行舱，摔的我那么惨！"]], ["飞行舱！？"], [function ():void {
            NpcDialog.show(400, ActorManager.actorInfo.nick + "", [[0, "你……是从外星球来的？"]], [" 外星精灵!"], [function ():void {
                NpcDialog.show(736, "赫", [[0, "奇怪了，怎么铁罐子也会说话？"]], ["我不是铁罐子！我是赛尔！"], [function ():void {
                    NpcDialog.show(400, ActorManager.actorInfo.nick + "", [[0, "你从外星来知道关于黑洞的什么事吗？"]], ["可怕的黑洞"], [function ():void {
                        NpcDialog.show(736, "赫", [[0, "没错！那个黑洞的秘密！铁罐子，快带我去见你的老大！"]], [" 什么秘密！还有我不叫铁罐子！"], [function ():void {
                            NpcDialog.show(736, "赫", [[0, "再慢的话！恐怕整个星系就要被它们吞噬了！那群坏蛋！"]], ["好！现在就带你去见我们老大！"], [function ():void {
                                DisplayUtil.removeForParent(_mack);
                                DisplayUtil.removeForParent(_mc1);
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                                QuestManager.completeStep(10225, 1);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    override public function processMapDispose():void {
        MobileManager.showMoileVec(MobileType.NPC);
        ActorManager.showRemoteActor = true;
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mack);
    }
}
}
