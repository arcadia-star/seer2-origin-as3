package com.taomee.seer2.app.processor.quest.handler.main.quest104 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_104_80524 extends QuestMapHandler {


    public function QuestMapHandler_104_80524(param1:QuestProcessor) {
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
        if (QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initStep1();
        }
    }

    private function initStep1():void {
        var dialog0:Array;
        var dialog2:Array;
        var dialog1:Array = null;
        var npc12:MovieClip = _processor.resLib.getMovieClip("duoLuoaa");
        npc12.x -= 358;
        npc12.y -= 211;
        _map.front.addChild(npc12);
        dialog0 = [[10, "巴蒂", [[0, "就是那里了，那扇门之后应该是这个设施的控制室，这个设施应该能够帮助我们找到真相。但是它被来自翼灵兽的力量封锁着，我想那是斯坦因当时做的，所以找你帮忙。"]], ["......"]], [93, "刚铎", [[0, "（看着那扇门，似乎在思考什么）……"]], ["......"]], [11, "多罗", [[0, "刚……刚铎大佬，啊不，刚铎先生，你想到了什么？"]], ["........"]]];
        dialog1 = [[93, "刚铎", [[0, "没想到这里变成了这样……不过放心吧，我会帮你们打开门。"]], ["那就拜托了！"]], [93, "刚铎", [[0, "门后面也许不是你们所希望的东西，但是，也许会有你们需要的东西。"]], ["那就拜托了！"]], [10, "巴蒂", [[0, "……你说什么？"]], ["点击地面上的传送点！"]]];
        dialog2 = [];
        NpcDialog.showDialogs(dialog0, function ():void {
            var movie1:MovieClip;
            var npc:MovieClip = null;
            npc = _processor.resLib.getMovieClip("qq_2");
            npc.x += 96;
            npc.y += 100;
            SceneManager.active.mapModel.front.addChild(npc);
            npc.addEventListener(MouseEvent.CLICK, onClick);
            movie1 = _processor.resLib.getMovieClip("movie");
            movie1.x += 246;
            movie1.y += 170;
            _map.front.addChild(movie1);
            MovieClipUtil.playMc(movie1, 2, movie1.totalFrames, function ():void {
                NpcDialog.showDialogs(dialog1, function ():void {
                });
            });
        });
    }

    protected function onClick(param1:MouseEvent):void {
        QuestManager.completeStep(_quest.id, 2);
        SceneManager.changeScene(SceneType.COPY, 80523);
    }
}
}
