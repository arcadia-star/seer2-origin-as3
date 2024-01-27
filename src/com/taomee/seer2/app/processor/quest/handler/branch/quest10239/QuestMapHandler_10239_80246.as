package com.taomee.seer2.app.processor.quest.handler.branch.quest10239 {
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

public class QuestMapHandler_10239_80246 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    public function QuestMapHandler_10239_80246(param1:QuestProcessor) {
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
        this._mc3 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.COPY, 80301);
    }

    private function initStep1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10239_0"), function ():void {
            _mc1 = _processor.resLib.getMovieClip("Mc10239_0");
            _map.content.addChild(_mc1);
            _mc1.gotoAndStop(1);
            MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "约瑟王！超进化了！"]], ["好厉害！"], [function ():void {
                    NpcDialog.show(774, "超梦", [[0, "               这就是精灵王……真正的实力吗……"]], ["太强大了"], [function ():void {
                        NpcDialog.show(814, "约瑟王", [[0, "快回去吧魔域军团，胜负已分了。"]], ["约瑟王完胜"], [function ():void {
                            NpcDialog.show(12, "萨伦", [[0, "哈哈哈哈哈哈，终于进展到这一步了，一切都在我的计算之中。"]], ["萨伦还不投降？"], [function ():void {
                                NpcDialog.show(12, "萨伦", [[0, "约瑟，你们还记得我们在风系氏族找到的那个梦神石吗？"]], ["封印梦神的石头"], [function ():void {
                                    NpcDialog.show(12, "萨伦", [[0, "那块石头的秘密，远不止这些……"]], ["石头的秘密 "], [function ():void {
                                        DisplayObjectUtil.removeFromParent(_mc1);
                                        initStep2();
                                    }]);
                                }]);
                            }]);
                        }]);
                    }]);
                }]);
            }, true);
        });
    }

    private function initStep2():void {
        this._mc2 = _processor.resLib.getMovieClip("Mc10239_1");
        _map.content.addChild(this._mc2);
        this._mc2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc2, 1, this._mc2.totalFrames, function ():void {
            NpcDialog.show(12, "萨伦", [[0, "约瑟！看清这阿卡迪亚最邪恶的力量！"]], ["最邪恶！？"], [function ():void {
                NpcDialog.show(814, "约瑟王", [[0, "萨伦！难道你释放了那家伙吗！"]], ["谁？"], [function ():void {
                    NpcDialog.show(12, "萨伦", [[0, "没错……降临吧！邪神！"]], ["邪神？"], [function ():void {
                        DisplayObjectUtil.removeFromParent(_mc2);
                        initStep3();
                    }]);
                }]);
            }]);
        }, true);
    }

    private function initStep3():void {
        this._mc3 = _processor.resLib.getMovieClip("Mc10239_2");
        _map.content.addChild(this._mc3);
        this._mc3.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc3, 1, this._mc3.totalFrames, function ():void {
            QuestManager.completeStep(questID, 1);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onComplete);
        }, true);
    }
}
}
