package com.taomee.seer2.app.processor.quest.handler.main.quest110 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_110_80560 extends QuestMapHandler {


    private var _npc:MovieClip;

    public function QuestMapHandler_110_80560(param1:QuestProcessor) {
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
        var dialog:Array = [[11, "多罗", [[0, "队长你终于来了！快来给我主持公道啊！"]], ["怎么了？一开始就哭哭啼啼的。"]], [10, "巴蒂", [[0, "队长你别听他胡说，我可什么都没做。"]], ["这……刚才发生了什么？"]], [11, "多罗", [[0, "队长，刚刚我们谈到凯萨，我说凯萨好可怜，孤零零地从北半球打到南半球，还被萨伦帝国利用……队长，我说的不对吗？"]], ["听起来有些道理。"]], [10, "巴蒂", [[0, "什么嘛，凯萨作为强者，在北半球所向披靡，在南半球也受到了器重，他明明就是一个大写的成功者，哪里可怜了？"]], ["你刚才就是这么对多罗说的？"]], [10, "巴蒂", [[0, "是啊，我说的没错吧？"]], ["没错是没错，但是多罗说的也不无道理啊。"]], [10, "巴蒂", [[0, "不过队长你要相信，他是自己说着说着就哭起来的。"]], ["这可以理解，但是你也要注意言辞啊。"]], [400, "小赛尔", [[0, "正好说到凯萨了。我们今天要去拜访的正是他，凯萨究竟是个什么角色，就由我们亲自体会吧。"]], ["……"]]];
        NpcDialog.showDialogs(dialog, function ():void {
            QuestManager.accept(_quest.id);
            SceneManager.changeScene(SceneType.COPY, 80561);
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
