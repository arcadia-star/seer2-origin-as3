package com.taomee.seer2.app.processor.quest.handler.main.quest103 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_103_80519 extends QuestMapHandler {


    private var npc:MovieClip;

    public function QuestMapHandler_103_80519(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (!QuestManager.isAccepted(_quest.id)) {
            return;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var dialog0:Array;
        var nm:MovieClip = _processor.resLib.getMovieClip("nnnppp");
        nm.x += 226;
        nm.y -= 50;
        SceneManager.active.mapModel.front.addChild(nm);
        nm.mouseChildren = false;
        this.npc = _processor.resLib.getMovieClip("qq_1");
        SceneManager.active.mapModel.front.addChild(this.npc);
        this.npc.addEventListener(MouseEvent.CLICK, this.onClick);
        dialog0 = [[400, "小赛尔", [[0, "主城的道路四通八达，通往研究院的道路应该也在这里，但是究竟是哪个呢？"]], ["......"]], [10, "巴蒂", [[0, "（仔细打量银色的芯片）这芯片上面好像有字符。这应该是一组坐标，所对应的位置就在这附近。找找哪里可能有[隐藏的入口]吧！"]], ["（寻找隐藏的传送点！）"]]];
        NpcDialog.showDialogs(dialog0, function ():void {
        });
    }

    protected function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        var dialog1:Array = [[400, "小赛尔", [[0, "就是这里了，我们走吧！"]], ["......"]], [400, "小赛尔", [[0, "（冷静下来）是的，我应该见过这个机关……在什么时候？我看见了它的运作……？"]], ["......"]]];
        NpcDialog.showDialogs(dialog1, function ():void {
            QuestManager.completeStep(_quest.id, 1);
            SceneManager.changeScene(SceneType.COPY, 80521);
        });
    }
}
}
