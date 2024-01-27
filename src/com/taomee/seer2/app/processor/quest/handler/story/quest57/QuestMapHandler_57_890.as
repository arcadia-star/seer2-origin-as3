package com.taomee.seer2.app.processor.quest.handler.story.quest57 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_57_890 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_57_890(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.playNpcTalk();
        }
    }

    private function playNpcTalk():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkHandler);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(137, "席德", [[0, "听说你来南半球是有特殊的使命的，我呢……受了秘密的委托，特别指引你的南半球行程。"]], ["（我的名气那么响？不愧是星际使者啊=v=）"], [function ():void {
            NpcDialog.show(137, "席德", [[0, "嗯……和你想象的差不多，相比北半球，南半球要来的更为险要。不过你放心，风刃氏族是中立地区，不用担心被卷入什么事件。"]], ["哦？中立地区？能更仔细讲讲吗？"], [function ():void {
                NpcDialog.show(137, "席德", [[1, "呵呵，这个嘛，不如我们先进入这暴风里面，带你亲身领略一下风刃氏族的风采再慢慢介绍吧？"]], ["好啊！不过，这风暴……"], [function ():void {
                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAcceptHandler);
                    QuestManager.accept(_quest.id);
                }]);
            }]);
        }]);
    }

    private function onAcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        SceneManager.changeScene(SceneType.LOBBY, 900);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAcceptHandler);
    }
}
}
