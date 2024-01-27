package com.taomee.seer2.app.processor.quest.handler.main.quest113 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.events.MouseEvent;

public class QuestMapHandler_113_80577 extends QuestMapHandler {


    private var _npc:SimpleButton;

    private var _arrow:MovieClip;

    public function QuestMapHandler_113_80577(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        if (!QuestManager.isAccepted(_quest.id)) {
            this.initStep0();
        }
    }

    private function initStep0():void {
        SceneManager.active.mapModel.content["mv2"].visible = false;
        SceneManager.active.mapModel.content["badi"].addEventListener(MouseEvent.CLICK, this.onClick);
    }

    protected function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        var dialog:Array = [[11, "多罗", [[0, "好一番寻寻觅觅，终于等到了这一天。"]], ["……"]], [10, "巴蒂", [[0, "好有成就感啊，斯坦因那个老家伙给我们的谜题最终还是被最聪明的我揭开了！"]], ["话说，你不好奇自己掉到了哪里吗？"]], [11, "多罗", [[0, "当然好奇，不过从现在的情况看，当年发生的不都是有惊无险吗？"]], ["说的也是。"]], [10, "巴蒂", [[0, "我……我很好奇！那个研究所底下究竟是什么……而且，我想知道那段时间究竟有没有人欠我钱…… "]], ["这姑且也算吧。"]], [10, "巴蒂", [[0, "在逐渐揭开的谜团之前，有再多的话，感慨也好，疑惑也好，都化为了沉默。那么，就迈出我们的步伐吧，去我们的过去，去我们的未来！"]], ["……"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            var mv:MovieClip = SceneManager.active.mapModel.content["mv2"];
            mv.visible = true;
            MovieClipUtil.playMc(mv, 2, mv.totalFrames, function ():void {
                QuestManager.accept(_quest.id);
                SceneManager.changeScene(SceneType.COPY, 80578);
            });
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
