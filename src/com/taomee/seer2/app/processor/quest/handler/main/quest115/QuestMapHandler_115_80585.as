package com.taomee.seer2.app.processor.quest.handler.main.quest115 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class QuestMapHandler_115_80585 extends QuestMapHandler {


    private var _dialogs0:Array;

    public function QuestMapHandler_115_80585(param1:QuestProcessor) {
        this._dialogs0 = [[10, "巴蒂", [[0, "什么嘛！明明计划得那么完美，居然还是晕倒了！现在看着还是感觉很火大啊！"]], ["放宽心吧，只要没事就好了。"]], [11, "多罗", [[0, "真……真是有惊无险啊…… "]], ["不过为什么巴蒂会晕倒呢？"]], [10, "巴蒂", [[0, "我也纳闷啊！明明从机关那里掉下来都没事！ "]], ["现在生气也没有用了，看看之后是怎样的吧。"]], [10, "巴蒂", [[0, "说的也是，我倒要看看究竟是什么居然能让最聪明的我晕倒！"]], ["……"]]];
        super(param1);
    }

    override public function processMapComplete():void {
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (!QuestManager.isAccepted(_quest.id)) {
            QuestManager.accept(_quest.id);
            this.initStep0();
        }
    }

    private function initStep0():void {
        NpcDialog.showDialogs(this._dialogs0, function ():void {
            SceneManager.changeScene(SceneType.COPY, 80584);
        });
    }
}
}
