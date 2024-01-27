package com.taomee.seer2.app.processor.quest.handler.branch.quest10233 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_10233_10 extends QuestMapHandler {


    private var mc1:MovieClip;

    private var mc2:MovieClip;

    public function QuestMapHandler_10233_10(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.accept(questID);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function initStep1():void {
        this.mc1 = _processor.resLib.getMovieClip("mc1");
        _map.content.addChild(this.mc1);
        MovieClipUtil.playMc(this.mc1, 1, this.mc1.totalFrames, function ():void {
            NpcDialog.show(766, "小梦", [[0, "船长……好久不见……555  T T"]], [" 小梦怎么突然哭了？"], [function ():void {
                NpcDialog.show(1, "辛迪", [[0, "小梦，怎么会突然从地球来这里了？"]], ["地球？小梦是地球来的？"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "船长……地球已经……接近毁灭了！"]], ["地球毁灭？！"], [function ():void {
                        NpcDialog.show(1, "辛迪", [[0, "小梦！到底是怎么回事！？"]], ["地球到底怎么了？"], [function ():void {
                            NpcDialog.show(766, "小梦", [[0, "事情是这样的……"]], ["小梦的故事 "], [function ():void {
                                DisplayObjectUtil.removeFromParent(mc1);
                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10233_0"), initStep2);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function onStep(param1:QuestEvent):void {
        if (param1.questId == questID) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            if (param1.stepId == 1) {
                this.initStep2();
            }
            if (param1.stepId == 2) {
                this.initStep3();
            }
            if (param1.stepId == 3) {
                this.initStep4();
            }
            if (param1.stepId == 4) {
                this.initStep5();
            }
        }
    }

    private function initStep5():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10233_2"), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(questID, 1);
        });
    }

    private function initStep4():void {
        this.mc2 = _processor.resLib.getMovieClip("mc2");
        _map.content.addChild(this.mc2);
        this.mc2.gotoAndStop(1);
        NpcDialog.show(766, "小梦", [[0, "事情就是这样……"]], ["地球有危险！"], [function ():void {
            NpcDialog.show(1, "辛迪", [[0, "既然这样……"]], ["船长好像要下命令了！"], [function ():void {
                NpcDialog.show(1, "辛迪", [[0, "各位船员立即做好一级准备！赛尔号2！准备返航地球！"]], ["返航地球？"], [function ():void {
                    NpcDialog.show(1, "辛迪", [[0, "我们必须返回重建地球，越快越好，麻烦小梦带路。"]], ["重建地球！"], [function ():void {
                        NpcDialog.show(766, "小梦", [[0, "没问题！"]], ["好样的！小梦！"], [function ():void {
                            NpcDialog.show(400, "小赛尔", [[0, "可是如果小梦不是犯人的话，又是谁让灵兽们都沉睡了呢？"]], ["会是谁呢？"], [function ():void {
                                MovieClipUtil.playMc(mc2, 1, mc2.totalFrames, function ():void {
                                    DisplayObjectUtil.removeFromParent(mc2);
                                    initStep5();
                                }, true);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        this.mc1 = null;
        this.mc2 = null;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep3():void {
        ModuleManager.closeForName("Quest10233");
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10233_1"), function ():void {
            initStep4();
        });
    }

    private function initStep2():void {
        ModuleManager.showAppModule("Quest10233Panel", {"func": this.initStep3});
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        ActorManager.hideActor();
        if (isNeedToAccept() == true) {
            this.initAccept();
        } else if (QuestManager.isStepComplete(10233, 1) == false) {
            this.initStep1();
        }
    }
}
}
