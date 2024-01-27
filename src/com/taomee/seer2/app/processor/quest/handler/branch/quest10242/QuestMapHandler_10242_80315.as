package com.taomee.seer2.app.processor.quest.handler.branch.quest10242 {
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
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10242_80315 extends QuestMapHandler {


    private var _mc10242_0:MovieClip;

    private var _mc10241_0:MovieClip;

    public function QuestMapHandler_10242_80315(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.hideActor();
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.init();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc10242_0 = null;
        this._mc10241_0 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.COPY, 80316);
    }

    private function init():void {
        this._mc10241_0 = _processor.resLib.getMovieClip("Mc10241_0");
        _map.content.addChild(this._mc10241_0);
        this._mc10241_0.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10241_0, 1, this._mc10241_0.totalFrames, function ():void {
            NpcDialog.show(816, "创世大帝", [[0, "哈哈，你们完成了我的试炼！我就告诉你们开元大帝在哪吧！"]], ["这也能叫试炼……"], [function ():void {
                NpcDialog.show(816, "创世大帝", [[0, "咳咳，不要在意试炼内容这些细节，快听我说吧。"]], ["好的！"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10242_0"), function ():void {
                        initContinue();
                    });
                }]);
            }]);
        }, true);
    }

    private function initContinue():void {
        NpcDialog.show(816, "创世大帝", [[0, "只不过他不小心创造出了比自己还强的精灵……"]], ["更强的精灵？"], [function ():void {
            NpcDialog.show(816, "创世大帝", [[0, "这块开元之石给你们，到幽静珊瑚穴去召唤出他吧。"]], ["谢谢创世！"], [function ():void {
                initStep1();
                DisplayObjectUtil.removeFromParent(_mc10241_0);
            }]);
        }]);
    }

    private function initStep1():void {
        this._mc10242_0 = _processor.resLib.getMovieClip("Mc10242_0");
        _map.content.addChild(this._mc10242_0);
        this._mc10242_0.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10242_0, 1, this._mc10242_0.totalFrames, function ():void {
            NpcDialog.show(816, "创世大帝", [[0, "开元、混沌，我们到底应不应该创造这颗星球……"]], ["…………"], [function ():void {
                DisplayObjectUtil.removeFromParent(_mc10242_0);
                QuestManager.completeStep(questID, 1);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
            }]);
        }, true);
    }
}
}
