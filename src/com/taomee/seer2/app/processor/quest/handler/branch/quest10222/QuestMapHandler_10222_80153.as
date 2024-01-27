package com.taomee.seer2.app.processor.quest.handler.branch.quest10222 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.Interactive_10222;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10222_80153 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _mack:AcceptableMark;

    private var _makeStone:Interactive_10222;

    public function QuestMapHandler_10222_80153(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10222) && QuestManager.isStepComplete(10222, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        ActorManager.getActor().isShow = false;
        ActorManager.getActor().blockNoNo = true;
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        _map.content.addChild(this._mc1);
        MovieClipUtil.playMc(this._mc1, 2, this._mc1.totalFrames, function ():void {
            _mack = new AcceptableMark();
            _mack.x = 480;
            _mack.y = 201;
            _map.content.addChild(_mack);
            _mc1["leiyi"].buttonMode = true;
            _mc1["leiyi"].addEventListener(MouseEvent.CLICK, onLeiyi);
        }, true);
    }

    private function onLeiyi(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(477, "雷伊", [[0, "今天召集大家来，是有一个秘密要告诉大家！"]], ["怪不得那么紧急！"], [function ():void {
            NpcDialog.show(477, "雷伊", [[0, "这个秘密关乎到战神联盟的生死和阿卡迪亚星的存亡！"]], ["威力那么大的秘密？"], [function ():void {
                NpcDialog.show(477, "雷伊", [[0, "这是我们雷神一族代代相传的最高机密！大家听后千万不能外传！"]], ["雷伊别卖关子了，快说吧！"], [function ():void {
                    NpcDialog.show(599, "盖亚", [[0, "雷伊，到底是什么秘密？之前从没听你说过这些。"]], ["连盖亚都不知道的秘密，一定很重要！"], [function ():void {
                        NpcDialog.show(477, "雷伊", [[0, "大家靠我近点，我悄悄告诉大家。"]], ["期待！期待！"], [function ():void {
                            DisplayUtil.removeForParent(_mack);
                            DisplayUtil.removeForParent(_mc1);
                            _mc2 = _processor.resLib.getMovieClip("mc2");
                            _map.content.addChild(_mc2);
                            MovieClipUtil.playMc(_mc2, 2, _mc2.totalFrames, function ():void {
                                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "已经很近了雷伊，还不行吗？"]], ["什么秘密要靠那么近"], [function ():void {
                                    NpcDialog.show(477, "雷伊", [[0, "再再再再近一点我就告诉你们！"]], ["大家头都要撞到了！"], [function ():void {
                                        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "总感觉今天雷伊怪怪的，看上去哪里不对。"]], ["到底哪里不对呢？"], [function ():void {
                                            DisplayUtil.removeForParent(_mack);
                                            DisplayUtil.removeForParent(_mc1);
                                            _makeStone = new Interactive_10222();
                                            _makeStone.setup("interactive_10222");
                                            _makeStone.addEventListener(AnimationEvent.STONE, onMakeBubbleOver);
                                        }]);
                                    }]);
                                }]);
                            }, true);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onMakeBubbleOver(param1:Event):void {
        var event:Event = param1;
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "大家别被骗了！这家伙不是雷伊！"]], ["和雷伊太不像了！"], [function ():void {
            NpcDialog.show(599, "盖亚", [[0, "从刚才就觉得怪怪的！你到底是谁！？"]], ["报上名来！ "], [function ():void {
                NpcDialog.show(477, "雷伊", [[0, "居然被你们发现了……不过我的任务也差不多完成了。"]], ["什么任务！？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10222_1"), function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                        QuestManager.completeStep(10222, 1);
                    }, true, true);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.COPY, 80154);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        DisplayUtil.removeForParent(this._mc1);
        DisplayUtil.removeForParent(this._mc2);
        DisplayUtil.removeForParent(this._mack);
        if (this._makeStone) {
            this._makeStone.dispose();
            this._makeStone = null;
        }
        ActorManager.getActor().isShow = true;
        ActorManager.getActor().blockNoNo = false;
    }
}
}
