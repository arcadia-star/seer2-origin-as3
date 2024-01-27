package com.taomee.seer2.app.processor.quest.handler.story.quest57 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_57_920 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_57_920(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.playFullMC();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.playMC();
        }
    }

    private function playFullMC():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("57_1"), function ():void {
            _mc_0 = _processor.resLib.getMovieClip("mc_2");
            _map.front.addChild(_mc_0);
            _mc_0.buttonMode = true;
            _mc_0.addEventListener(MouseEvent.CLICK, npcTalkHandler);
        }, true, false, 2);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(137, "席德", [[0, "这里就是流离街，风刃氏族普通居民居住的地方。"]], ["（一个人也没有？好萧瑟的感觉。）"], [function ():void {
            NpcDialog.show(137, "席德", [[0, "我们，我，娜娜大姐，弟弟，都出生在这里，也是从这里成长起来的……"]], ["嗯，静静听吧。"], [function ():void {
                MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("57_0"), 3, [[1, 0]], function ():void {
                    NpcDialog.show(137, "席德", [[0, "在这个以出色的技术或者格斗术为荣的氏族，我是不是太没用了呢？"]], ["不！机械上的每一刻螺丝钉都有它的价值！！"], [function ():void {
                        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "一部机器能够顺利运作，纵然离不开那些先进的精密零件，也需要大量的普通零件！"]], ["每个人都有自己的价值，找准自己的位置，然后努力吧！"], [function ():void {
                            NpcDialog.show(137, "席德", [[1, "谢谢——虽然和你相识不久，但总有朋友的感觉。"]], ["谁说我们不是朋友呢？"], [function ():void {
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepTwoCompleteHandler);
                                QuestManager.completeStep(_quest.id, 2);
                            }]);
                        }]);
                    }]);
                });
            }]);
        }]);
    }

    private function onStepTwoCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoCompleteHandler);
        this.playMC();
    }

    private function playMC():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_3");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            NpcDialog.show(137, "席德", [[0, "你……你是！！"]], ["？？？"], [function ():void {
                NpcDialog.show(145, "黑影", [[0, "别来无恙吗席德……"]], ["是熟人？话说你走路好快！"], [function ():void {
                    NpcDialog.show(137, "席德", [[1, "不好！！是暗杀者……快走！！"]], ["暗杀者？？"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("57_2"), function ():void {
                            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "好可怕！他的那只精灵……！！"]], ["他是暗杀者？为什么会有暗杀者？暗杀……我？"], [function ():void {
                                NpcDialog.show(137, "席德", [[0, "看来，还是要告诉你。我曾经和你说过，我族会向整个星球提供雇佣兵，其中最可怕的就是暗杀者……"]], ["但是，为什么冲着我来？"], [function ():void {
                                    NpcDialog.show(137, "席德", [[0, "这颗星球已经被战争腐蚀了，很多人为了利益会用尽各种手段。总之……我会尽可能确保你的安全！"]], ["前途……危机四伏啊！"], [function ():void {
                                        QuestManager.addEventListener(QuestEvent.COMPLETE, onCompleteHandler);
                                        QuestManager.completeStep(_quest.id, 3);
                                    }]);
                                }]);
                            }]);
                        }, true, false, 2);
                    }]);
                }]);
            }]);
        });
    }

    private function onCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoCompleteHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onCompleteHandler);
    }
}
}
