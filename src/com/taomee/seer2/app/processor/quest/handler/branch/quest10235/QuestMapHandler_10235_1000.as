package com.taomee.seer2.app.processor.quest.handler.branch.quest10235 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10235_1000 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    public function QuestMapHandler_10235_1000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        MobileManager.hideMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(questID)) {
            return;
        }
        ActorManager.hideActor();
        MobileManager.hideMoileVec(MobileType.NPC);
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        } else if (!QuestManager.isStepComplete(questID, 2) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc1 = null;
        this._mc2 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.COPY, 80145);
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc10235_0");
        _map.content.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            NpcDialog.show(406, "目灵兽", [[0, "谢谢你们，小赛尔，小梦，让我从永恒的噩梦中苏醒了"]], ["摔疼了吧？"], [function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "不客气目灵兽！"]], ["醒了就好！"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "小事一桩！"]], ["明明差点被干掉"], [function ():void {
                        NpcDialog.show(406, "目灵兽", [[0, "只是这场危机还没过去，我的灵兽伙伴们还在沉睡之中。"]], ["可恶的萨伦帝国！ "], [function ():void {
                            NpcDialog.show(766, "小梦", [[0, "没事！有了这些石头，看我把萨伦帝国打的落花流水！"]], ["好样的小梦"], [function ():void {
                                NpcDialog.show(400, "小赛尔", [[0, "一定要阻止他们！"]], ["和他们一决胜负！"], [function ():void {
                                    NpcDialog.show(406, "目灵兽", [[0, "为了报答你们，就让我来助你们一臂之力吧。"]], ["好啊~ "], [function ():void {
                                        DisplayObjectUtil.removeFromParent(_mc1);
                                        initStep2();
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function initStep2():void {
        this._mc2 = _processor.resLib.getMovieClip("Mc10235_1");
        _map.content.addChild(this._mc2);
        MovieClipUtil.playMc(this._mc2, 1, this._mc2.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc2);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
            QuestManager.completeStep(questID, 1);
        }, true);
    }
}
}
