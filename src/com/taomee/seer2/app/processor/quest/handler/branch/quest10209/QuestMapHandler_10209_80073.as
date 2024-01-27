package com.taomee.seer2.app.processor.quest.handler.branch.quest10209 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10209_80073 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _accept:AcceptableMark;

    public function QuestMapHandler_10209_80073(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(10209) && QuestManager.isStepComplete(10209, 1) == false) {
            this.initQuest1();
        }
    }

    private function initQuest1():void {
        this._mc1 = _processor.resLib.getMovieClip("mc1");
        this._accept = new AcceptableMark();
        _map.content.addChild(this._mc1);
        _map.front.addChild(this._accept);
        this._accept.x = 449;
        this._accept.y = 257;
        this._mc1.buttonMode = true;
        this._mc1.addEventListener(MouseEvent.CLICK, this.onMC1);
    }

    private function onMC1(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(646, "小当家", [[0, "我要去寻找“冰封魔域”了，你愿意陪我一起去吗？"]], ["那只是传说中的地方，怎么可能存在呢？"], [function ():void {
            NpcDialog.show(646, "小当家", [[0, "经过我多日的探索，这个地方一定存在的！"]], ["真的吗？你知道在哪里了？"], [function ():void {
                NpcDialog.show(646, "小当家", [[0, "我已经找到一些线索了，相信很快就能找到了！"]], ["切~那就是还没找到咯。"], [function ():void {
                    NpcDialog.show(646, "小当家", [[0, "快了，快了，你愿意陪我一起去吗？"]], ["还是算了，我还有很多精灵没练呢！"], [function ():void {
                        NpcDialog.show(646, "小当家", [[0, "那我自己去了，到时候找到好吃的你可别嘴馋哦！"]], ["加油！相信你一定可以的！"], [function ():void {
                            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10209_1"), function ():void {
                                DisplayUtil.removeForParent(_mc1);
                                DisplayUtil.removeForParent(_accept);
                                NpcDialog.show(10, "巴蒂", [[0, "小当家已经不见几天了，我们要不要去找找它呢？"]], ["好的！但我们应该去哪里找它呢？"], [function ():void {
                                    NpcDialog.show(11, "多罗", [[0, "几天前我曾碰到过小当家一次，它给了我一本日记，然后就匆匆离开了。"]], ["看样子小当家一定有什么急事。"], [function ():void {
                                        NpcDialog.show(11, "多罗", [[0, "但是这本日记上就说到最后去了<font color=\'#ff0000\'>" + "冰沁氏族" + "</font>的<font color=\'#ff0000\'>" + "冰沁宫殿" + "</font>，其他就没有了。"]], ["好的，第七小队立即出发，目标“冰沁宫殿”！"], [function ():void {
                                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                                            QuestManager.completeStep(10209, 1);
                                        }]);
                                    }]);
                                }]);
                            }, true, true, 2);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.COPY, 80074);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DisplayUtil.removeForParent(this._accept);
        if (this._mc1) {
            this._mc1.removeEventListener(MouseEvent.CLICK, this.onMC1);
        }
        DisplayUtil.removeForParent(this._mc1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
    }
}
}
