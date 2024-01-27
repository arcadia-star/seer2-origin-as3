package com.taomee.seer2.app.processor.quest.handler.activity.quest30039 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30039_124 extends QuestMapHandler {


    private var _duomo:MovieClip;

    public function QuestMapHandler_30039_124(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initFirstMc();
        }
    }

    private function initFirstMc():void {
        this._duomo = _processor.resLib.getMovieClip("duomo");
        _map.content.addChild(this._duomo);
        this._duomo.buttonMode = true;
        this._duomo.addEventListener(MouseEvent.CLICK, this.onNPCTalkHandler);
    }

    private function onNPCTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(49, "多摩", [[2, "太可怕了！太可怕了！赛尔求求你一定要帮帮我！"]], ["怎么啦？这里发生什么了？"], [function ():void {
            NpcDialog.show(49, "多摩", [[2, "就在刚才，我和芙拉正玩的时候，一头狼妖向我冲了过来，并且把芙拉也带走了！"]], ["居然有这种事？！"], [function ():void {
                NpcDialog.show(49, "多摩", [[2, "他觉得我不好吃所以才没有把我带走…赛尔！你一定要救救芙拉呀！"]], ["你知道它往哪个方向走了吗…"], [function ():void {
                    NpcDialog.show(49, "多摩", [[2, "太可怕了，我根本没敢睁眼看它…呜呜呜……"]], ["我该怎么找到那只怪物呢？"], [function ():void {
                        var talkMC:* = _processor.resLib.getMovieClip("talkMC");
                        _map.front.addChild(talkMC);
                        MovieClipUtil.playMc(talkMC, 1, talkMC.totalFrames, function ():void {
                            _duomo.removeEventListener(MouseEvent.CLICK, onNPCTalkHandler);
                            NpcDialog.show(49, "多摩", [[2, "一定是那只狼妖！赛尔没有芙拉我也不活了！你一定要把它救来呀！"]], ["放心吧！我先去乌黑矿坑调查一下"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1CompleteHandler);
                                QuestManager.completeStep(_quest.id, 1);
                            }]);
                        }, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep1CompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1CompleteHandler);
        SceneManager.changeScene(SceneType.LOBBY, 520);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._duomo != null) {
            DisplayUtil.removeForParent(this._duomo);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1CompleteHandler);
    }
}
}
