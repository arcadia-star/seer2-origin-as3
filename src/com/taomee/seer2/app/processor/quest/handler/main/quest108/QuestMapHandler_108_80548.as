package com.taomee.seer2.app.processor.quest.handler.main.quest108 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_108_80548 extends QuestMapHandler {


    private var _npc:MovieClip;

    public function QuestMapHandler_108_80548(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            this.initStep0();
        }
    }

    private function initStep0():void {
        this._npc = _processor.resLib.getMovieClip("npc");
        SceneManager.active.mapModel.front.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.mouseChildren = false;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    protected function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var dialog:Array = [[10, "巴蒂", [[0, "这次的任务真是特殊啊，虽然如此，但是当我把怀疑放到那个伟大的存在的身上时，就早已预料到了。"]], ["是啊，最终还是要面对这个最艰涩的谜团。"]], [11, "多罗", [[0, "好……好激动！马上就可以见到男神了！"]], ["看来多罗是去追星的……"]], [400, "小赛尔", [[0, "这次的任务比较特殊，一定要斟酌好言辞再说话，因为我们的每一句话都有可能影响到局势的变化。"]], ["……"]], [11, "多罗", [[0, "放心好了，我只要静静地膜拜男神就够了……"]], ["现在还是无视他吧。"]], [10, "巴蒂", [[0, "队长，我准备好了！就由最聪明的我寻找答案吧！"]], ["很好，那么我们这就启程！"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY, 80549);
        });
    }

    override public function dispose():void {
        super.dispose();
        if (this._npc != null) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
    }
}
}
