package com.taomee.seer2.app.processor.quest.handler.branch.quest10241 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.utils.IDataInput;

public class QuestMapHandler_10241_80311 extends QuestMapHandler {


    private var _mc10241_1:MovieClip;

    private var _mc10241_2:MovieClip;

    public function QuestMapHandler_10241_80311(param1:QuestProcessor) {
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
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            this.initStep1();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        this._mc10241_1 = null;
        this._mc10241_2 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SwapManager.swapItem(3201, 1, function (param1:IDataInput):void {
            SceneManager.changeScene(SceneType.LOBBY, 70);
        });
    }

    private function initStep1():void {
        this._mc10241_1 = _processor.resLib.getMovieClip("Mc10241_1");
        _map.front.addChild(this._mc10241_1);
        this._mc10241_1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10241_1, 1, this._mc10241_1.totalFrames, function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "缪斯，现在情况紧急，你要跟我们走！"]], ["拯救阿卡迪亚"], [function ():void {
                NpcDialog.show(705, "缪斯", [[0, "去哪儿？"]], ["说来话长……"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10241_1"), function ():void {
                        initContinue();
                    });
                }]);
            }]);
        }, true);
    }

    private function initContinue():void {
        NpcDialog.show(705, "缪斯", [[0, "………………"]], ["缪斯还没反应过来吧？"], [function ():void {
            NpcDialog.show(705, "缪斯", [[0, "既然这样，那我就要快点结束这场战斗了！"]], ["缪斯加油！"], [function ():void {
                DisplayObjectUtil.removeFromParent(_mc10241_1);
                initStep2();
            }]);
        }]);
    }

    private function initStep2():void {
        this._mc10241_2 = _processor.resLib.getMovieClip("Mc10241_2");
        _map.content.addChild(this._mc10241_2);
        this._mc10241_2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10241_2, 1, this._mc10241_2.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc10241_2);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10241_2"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(questID, 2);
            });
        }, true);
    }
}
}
