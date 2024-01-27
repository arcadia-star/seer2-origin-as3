package com.taomee.seer2.app.processor.quest.handler.activity.quest30037 {
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
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30037_20 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_30037_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initFirstMC();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initSecondMC();
        }
    }

    private function initFirstMC():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.content.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_1);
        this._mc_1.buttonMode = true;
        this._mc_1.addEventListener(MouseEvent.CLICK, this.onDuoluoTalkHandler);
    }

    private function onDuoluoTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(11, "多罗", [[2, "队长，怎么办，我心爱的草泥马宝宝不行了！……救救草泥马宝宝！"]], ["这是长颈鹿，不是草泥马！"], [function ():void {
            NpcDialog.show(10, "巴蒂", [[2, "伊娃博士说，好像是吸入了什么气体，导致呼吸不畅……现在生命垂危……怎么办啊！"]], ["伊娃博士，这到底是为什么呢？"], [function ():void {
                NpcDialog.show(2, "伊娃", [[0, "这只草泥马宝宝吸入了过多的二氧化碳。长时间处于低浓度的二氧化碳中会导致头晕、昏昏欲睡、甚至记忆力衰退……"]], ["那我们怎么才能帮助它呢？"], [function ():void {
                    NpcDialog.show(2, "伊娃", [[0, "当务之急，先给它吸入一些氧气吧！"]], ["看看吸入氧气会发生什么事!"], [function ():void {
                        if (_mc_0 != null) {
                            DisplayUtil.removeForParent(_mc_0);
                        }
                        if (_mc_1 != null) {
                            DisplayUtil.removeForParent(_mc_1);
                        }
                        _mc_2 = _processor.resLib.getMovieClip("mc_2");
                        _map.content.addChild(_mc_2);
                        MovieClipUtil.playMc(_mc_2, 1, _mc_2.totalFrames, function ():void {
                            QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                            QuestManager.accept(_quest.id);
                        }, true);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        this.initSecondMC();
        this.duoluoTalk();
    }

    private function initSecondMC():void {
        if (this._mc_2 != null) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_3");
        _map.content.addChild(this._mc_1);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onDuoluoTalkAgainHandler);
    }

    private function onDuoluoTalkAgainHandler(param1:MouseEvent):void {
        this.duoluoTalk();
    }

    private function duoluoTalk():void {
        NpcDialog.show(11, "多罗", [[4, "太好了！！草泥马宝宝复活了！！！！"]], ["本来就没死啊！不对，这不是草泥马啊！"], [function ():void {
            NpcDialog.show(516, "草泥马宝宝", [[2, "谢谢大家……救活了我……本来我真的以为自己快死了……嘤嘤嘤……"]], ["……"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[1, "草泥马宝宝，你是从哪儿来的？怎么会吸入过多二氧化碳呢？"]], ["快告诉我们吧！"], [function ():void {
                    NpcDialog.show(516, "卜古塔", [[3, "我不是草泥马！我是长颈鹿！！……嘤嘤嘤，我叫卜古塔，出生在普兰特山麓……"]], ["普兰特山麓？"], [function ():void {
                        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30037_0"), 2, [[1, 0]], function ():void {
                            NpcDialog.show(2, "伊娃", [[0, "看来，对于资源的贪婪索取毁了精灵们的家园。<font color=\'#ffcc00\'>{$name}</font>，我希望你们能够前往普兰特山麓，找寻一个好的解决办法！"]], ["好！第七绿色环保小队出发！"], [function ():void {
                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30037_0"), function ():void {
                                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1CompleteHandler);
                                    QuestManager.completeStep(_quest.id, 1);
                                }, true, false, 2);
                            }]);
                        });
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStep1CompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1CompleteHandler);
        SceneManager.changeScene(SceneType.LOBBY, 990);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        if (this._mc_0 != null) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        if (this._mc_1 != null) {
            DisplayUtil.removeForParent(this._mc_1);
        }
        if (this._mc_2 != null) {
            DisplayUtil.removeForParent(this._mc_2);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1CompleteHandler);
    }
}
}
