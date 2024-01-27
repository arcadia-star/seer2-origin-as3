package com.taomee.seer2.app.processor.quest.handler.main.quest103 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

public class QuestMapHandler_103_80520 extends QuestMapHandler {


    public function QuestMapHandler_103_80520(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            this.initStep0();
        }
    }

    private function initStep0():void {
        var dialog:Array;
        var npc:MovieClip = _processor.resLib.getMovieClip("nnnppp");
        npc.x += 220;
        npc.y += 65;
        SceneManager.active.mapModel.front.addChild(npc);
        npc.mouseChildren = false;
        dialog = [[10, "巴蒂", [[0, "队长，你和斯坦因的对话我们都听清楚了。我认为其中包含的信息量非常大。"]], ["......"]], [11, "多罗", [[0, "队长你快来拯救我吧！我听不懂她说的是什么，只是觉得很厉害……"]], ["这不是经常的么？"]], [400, "小赛尔", [[0, "巴蒂，说来听听。"]], ["........"]], [10, "巴蒂", [[0, "斯坦因上次提到了风刃氏族的事情。后来我想了想，我确实记得有这件事，但是和你当时的情况一样，我不记得自己在掉下机关之后发生了什么。"]], ["......"]], [400, "小赛尔", [[0, "但是斯坦因却记得这件事，感觉很诡异啊。"]], ["看起来很眼熟的样子。"]], [10, "巴蒂", [[0, "不，队长，你这样说是不准确的，他说自己“备份了一些重要的记忆”所以才会记得这件事，所以他才想起来这件事的。参与这件事里的三个人，队长，我，斯坦因，全都遗忘了接下来的事情。"]], ["是的……虽然很惊人，但现在只能这么想了。"]], [10, "巴蒂", [[0, "至于多罗，他那时候似乎在御风中枢差点被吓傻。"]], ["......"]], [11, "多罗", [[0, "我……我怎么不记得……对，我一定也是和你们一样忘了！"]], ["我该对这个活宝说什么……"]], [400, "小赛尔", [[0, "除此之外，他还提到了“希望之光”。"]], ["......"]], [10, "巴蒂", [[0, "是的，这件事我倒是原原本本的记着，但是我也无法解释为什么我们分明没有获得“希望之光”，约瑟却复活了。"]], ["......"]], [400, "小赛尔", [[0, "这也正是事情的可怕之处。斯坦因把这两件事一并提起一定是有他的用意的，也就是说，两件事一定有关。"]], ["......"]], [10, "巴蒂", [[0, "斯坦因一切成谜，我不知道他为什么要向你提供这些消息，但是……队长你之前说过，他确实比我们知道得多。现在只是这样想下去是没有用的，我们必须去验证。"]], ["......"]], [400, "小赛尔", [[0, "你是说，选择相信他，然后用他给我的银色芯片到飞翼研究院……。"]], ["......"]], [10, "巴蒂", [[0, "是的，我希望队长批准我的提议。虽然我是最聪明的，但是在线索缺乏的情况之下，我还是不得不依靠于那个曾经不想去信任的人啊"]], ["......"]], [400, "小赛尔", [[0, "巴蒂，我批准你的提议，而且，现在就出发！。"]], ["......"]], [11, "多罗", [[0, "诶？我们又要去新的地方了吗？如果太危险的话……就不要带上我了……"]], ["......."]], [10, "巴蒂", [[0, "有什么可怕的？跟着我们走不就行了？"]], ["......"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY, 80519);
        });
    }
}
}
