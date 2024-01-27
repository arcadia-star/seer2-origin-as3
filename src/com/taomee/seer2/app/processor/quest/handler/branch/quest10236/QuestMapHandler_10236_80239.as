package com.taomee.seer2.app.processor.quest.handler.branch.quest10236 {
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
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10236_80239 extends QuestMapHandler {

    private static var haveFight:int = 0;


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    public function QuestMapHandler_10236_80239(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.hideActor();
        MobileManager.hideMoileVec(MobileType.NPC);
        if (haveFight == 1) {
            haveFight = 0;
            return;
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
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
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10236_0"), function ():void {
            _mc1 = _processor.resLib.getMovieClip("Mc10236_0");
            _map.content.addChild(_mc1);
            _mc1.gotoAndStop(1);
            NpcDialog.show(766, "小梦", [[0, "你是谁！这里是哪里？！"]], ["前面明明还在和梦神战斗呢！"], [function ():void {
                NpcDialog.show(775, "星魂神", [[0, "不要害怕小梦，我是星魂神。"]], ["星魂神？"], [function ():void {
                    NpcDialog.show(775, "星魂神", [[0, "这里是星魂空间，是只有被选中的精灵才能到达的地方。"]], ["被选中的精灵？"], [function ():void {
                        NpcDialog.show(766, "小梦", [[0, "可现在阿卡迪亚星与地球都在危机之中！没时间在这耽搁了！"]], ["快送我回去！"], [function ():void {
                            NpcDialog.show(775, "星魂神", [[0, "不要操之过急小梦，我会让你领悟更强大的力量。"]], ["更强大的力量？"], [function ():void {
                                NpcDialog.show(766, "小梦", [[0, "强大到足以解决这场危机的力量！"]], ["期待！"], [function ():void {
                                    MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                                        initStep2();
                                    }, true);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        });
    }

    private function initStep2():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10236_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
            QuestManager.completeStep(questID, 1);
        });
    }
}
}
