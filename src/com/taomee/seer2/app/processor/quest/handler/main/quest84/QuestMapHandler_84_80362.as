package com.taomee.seer2.app.processor.quest.handler.main.quest84 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.InProgressMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_84_80362 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _npc:Mobile;

    public function QuestMapHandler_84_80362(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (!QuestManager.isAccepted(questID)) {
            QuestManager.accept(questID);
            QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccepted);
        }
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.createNpc();
        }
    }

    private function onAccepted(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccepted);
        if (QuestManager.isAccepted(questID) && !QuestManager.isStepComplete(questID, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._npc = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("84_0"), function ():void {
            NpcDialog.show(1022, "阿修雷", [[0, "哼，99场，没想到你们这样的弱者，居然连胜了99场！"]], ["为什么……不可能？"], [function ():void {
                NpcDialog.show(1021, "帕斯塔", [[0, "你们的表现真是出乎了我们意料。99连胜意味着什么？这么多年来，这里只有一只精灵和训练师达到过100连胜，而你们，离这个目标只有一步之遥！"]], ["居然是这样！"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "所以，我们即将成功了吗！"]], [" 看上去是的！"], [function ():void {
                        NpcDialog.show(1022, "阿修雷", [[0, "不！你们不可能胜利！你们不可能走出这里！"]], [" ？！"], [function ():void {
                            NpcDialog.show(1022, "阿修雷", [[0, "毁灭者，又该轮到你上场了！"]], [" 又是他！"], [function ():void {
                                initContinue();
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }, false);
    }

    private function initContinue():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc84_0");
        _map.front.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            initStep1Complete();
        }, true);
    }

    private function initStep1Complete():void {
        QuestManager.completeStep(questID, 1);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete1);
    }

    private function onComplete1(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete1);
        this.initStep2();
    }

    private function initStep2():void {
        this.createNpc();
    }

    private function createNpc():void {
        var _loc1_:InProgressMark = null;
        if (!this._npc) {
            this._npc = MobileManager.getMobile(1021, MobileType.NPC);
            this._npc.buttonMode = true;
            _loc1_ = new InProgressMark();
            _loc1_.y = -120;
            this._npc.addChild(_loc1_);
            this._npc.addEventListener(MouseEvent.CLICK, this.initStep2Continue);
        }
    }

    private function initStep2Continue(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1021, "帕斯塔", [[0, "此战，你们可以使用任何精灵与他对战。"]], ["限制终于去除了么！"], [function ():void {
            NpcDialog.show(1021, "帕斯塔", [[0, "但是，你们的精灵，依然还能战斗的也已经所剩无几。所以，不要高兴的太早。"]], ["……"], [function ():void {
                NpcDialog.show(831, "毁灭者", [[0, "弱者，我们又见面了！"]], ["我们不是弱者！"], [function ():void {
                    NpcDialog.show(766, "小梦", [[0, "或许你很强大，但我们也已经不再弱小！"]], ["没错！"], [function ():void {
                        NpcDialog.show(831, "毁灭者", [[0, "是不是弱者，一战便知！"]], ["来战！"], [function ():void {
                            NpcDialog.show(829, "雷霆", [[0, "小赛尔，这一战，让我来！"]], ["好"], [function ():void {
                                initStep2FullScreenAnimation2();
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep2FullScreenAnimation2():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("84_1"), function ():void {
            NpcDialog.show(766, "小梦", [[0, "我们赢了！"]], ["雷霆好样的！"], [function ():void {
                NpcDialog.show(400, "小赛尔", [[0, "这下我们可以离开这里了吧！ "]], ["……"], [function ():void {
                    NpcDialog.show(1022, "阿修雷", [[0, "哼，一切还没有结束！"]], ["什么！"], [function ():void {
                        initStep2FullScreenAnimation3();
                    }]);
                }]);
            }]);
        }, false);
    }

    private function initStep2FullScreenAnimation3():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("84_2"), function ():void {
            NpcDialog.show(1022, "阿修雷", [[0, "哈哈哈哈，你们会提高，难道毁灭者的实力就会止步不前吗！现在，他已经完成了超进化，变得更加强大！等待你们的，将会是失败和死亡！"]], ["你！"], [function ():void {
                NpcDialog.show(766, "小梦", [[0, "为了家园，为了梦想，我们誓死而战！ "]], ["决不放弃！"], [function ():void {
                    initStep2FullScreenAnimation4();
                }]);
            }]);
        }, false);
    }

    private function initStep2FullScreenAnimation4():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("84_3"), function ():void {
            QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            QuestManager.completeStep(questID, 2);
        }, false);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.initStep2Continue);
        }
        this._npc = null;
        super.processMapDispose();
    }
}
}
