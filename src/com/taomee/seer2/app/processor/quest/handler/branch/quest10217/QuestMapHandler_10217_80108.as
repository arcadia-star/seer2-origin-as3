package com.taomee.seer2.app.processor.quest.handler.branch.quest10217 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10217_80108 extends QuestMapHandler {


    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    public function QuestMapHandler_10217_80108(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10217) && QuestManager.isStepComplete(10217, 2) == false) {
            this.initStep2();
        }
    }

    private function initStep2():void {
        this._mc2 = _processor.resLib.getMovieClip("mc2");
        _map.content.addChild(this._mc2);
        NpcDialog.show(688, "斯派克上校", [[0, ActorManager.actorInfo.nick + "，你终于来了。"]], ["你就是斯派克上校吗？"], [function ():void {
            NpcDialog.show(688, "斯派克上校", [[0, "是的，你的事情小汤姆都已经和我说过了！"]], ["啊，你们消息真灵通呀。"], [function ():void {
                NpcDialog.show(688, "斯派克上校", [[0, "呵呵，现在情况很不妙啊。"]], ["有多不妙啊？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10217_2"), function ():void {
                        NpcDialog.show(688, "斯派克上校", [[0, "事情就是这样的……"]], ["额……不会吧，怎么会有那么多的士兵？"], [function ():void {
                            NpcDialog.show(688, "斯派克上校", [[0, "一定是库贝萨在捣的鬼。"]], ["可恶的库贝萨。"], [function ():void {
                                NpcDialog.show(688, "斯派克上校", [[0, "我们赶紧回去报告这个消息吧！"]], ["好的，我们走吧。"], [function ():void {
                                    DisplayUtil.removeForParent(_mc2);
                                    _mc3 = _processor.resLib.getMovieClip("mc3");
                                    _map.front.addChild(_mc3);
                                    MovieClipUtil.playMc(_mc3, 2, _mc3.totalFrames, function ():void {
                                        DisplayUtil.removeForParent(_mc3);
                                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10217_3"), function ():void {
                                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                                            QuestManager.completeStep(10217, 2);
                                        }, true, true);
                                    }, true);
                                }]);
                            }]);
                        }]);
                    }, true, true);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mc3);
        super.processMapDispose();
    }
}
}
