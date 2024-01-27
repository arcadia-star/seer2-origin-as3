package com.taomee.seer2.app.processor.quest.handler.branch.quest10240 {
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

public class QuestMapHandler_10240_80307 extends QuestMapHandler {


    private var _mc10240_2:MovieClip;

    private var _mc10240_3:MovieClip;

    private var _mc1:MovieClip;

    public function QuestMapHandler_10240_80307(param1:QuestProcessor) {
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
        this._mc1 = null;
        this._mc10240_2 = null;
        this._mc10240_3 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc10240_1");
        _map.content.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, 2, function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "约瑟王已经走了吧？"]], ["辛苦它了"], [function ():void {
                NpcDialog.show(774, "超梦", [[0, "恩，接下来只能靠我们自己了。"]], ["加油！"], [function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    initStep2();
                }]);
            }]);
        });
    }

    private function initStep2():void {
        this._mc10240_2 = _processor.resLib.getMovieClip("Mc10240_1");
        _map.content.addChild(this._mc10240_2);
        this._mc10240_2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10240_2, 1, this._mc10240_2.totalFrames, function ():void {
            NpcDialog.show(774, "超梦", [[0, "小赛尔，看来这些野生精灵已经被邪神黑化了。"]], ["邪神的威力"], [function ():void {
                NpcDialog.show(774, "超梦", [[0, "我来拖住他们！小赛尔你快去召唤创世大帝！"]], ["好的！"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[0, "超梦小心！"]], ["快召唤创世大帝"], [function ():void {
                        DisplayObjectUtil.removeFromParent(_mc10240_2);
                        initStep3();
                    }]);
                }]);
            }]);
        });
    }

    private function initStep3():void {
        this._mc10240_3 = _processor.resLib.getMovieClip("Mc10240_2");
        _map.content.addChild(this._mc10240_3);
        this._mc10240_3.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc10240_3, 1, this._mc10240_3.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(_mc10240_3);
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10240_1"), function ():void {
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                QuestManager.completeStep(questID, 2);
            });
        }, true);
    }
}
}
