package com.taomee.seer2.app.processor.quest.handler.story.quest15 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_15_390 extends QuestMapHandler {


    private var _mc_1:MovieClip;

    public function QuestMapHandler_15_390(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.showNpc();
        }
    }

    private function showNpc():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        this._mc_1.x = 0;
        this._mc_1.y = 0;
        _map.front.addChild(this._mc_1);
        this._mc_1.gotoAndStop(1);
        NpcDialog.show(440, "暗伊特", [[0, "呆在这种地方有什么好？我们兄弟搭档，加上博士的技术，一定可以把这个星球搅得乱七八糟！"]], ["这究竟是怎么回事？"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("15_1"), 2, [[1, 0]], function ():void {
                NpcDialog.show(429, "伊特", [[3, "不要再说了！！我再也不要吃药片！！再也不要被泡在大水缸里！再也不要一觉睡醒却忘记了昨天的事！……"]], ["伊特？！"], [function ():void {
                    NpcDialog.show(440, "暗伊特", [[0, "那么从现在开始，我就要在这里尽情地搞破坏！反正我们那么像，大家一定会都讨厌你的！"]], ["喂，这可不是闹着玩儿的！"], [function ():void {
                        NpcDialog.show(440, "暗伊特", [[0, "嘻嘻，这样，大家都会讨厌你了~~你就只能跟我回去啦~~"]], ["我绝对不会让它发生的！"], [function ():void {
                            QuestManager.completeStep(_quest.id, 5);
                        }]);
                    }]);
                }]);
            });
        }]);
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
    }
}
}
