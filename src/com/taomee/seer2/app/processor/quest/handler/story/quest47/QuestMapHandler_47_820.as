package com.taomee.seer2.app.processor.quest.handler.story.quest47 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_47_820 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_47_820(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.initmc();
        }
    }

    private function initmc():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        this._mc_2 = _processor.resLib.getMovieClip("mc_2");
        _map.front.addChild(this._mc_2);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.npcTalkHandler);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(115, "战士亡魂", [[0, "关于守护者的离开，我似乎回想起了一点线索。"]], ["什么线索？"], [function ():void {
            NpcDialog.show(116, "战士亡魂", [[0, "那一次，我们仿佛说到了关于萨伦帝国侵略本族的事情。不过当时守护者什么都没有说。打那之后，他就有些心神不宁……"]], ["他该不会，该不会……"], [function ():void {
                NpcDialog.show(115, "战士亡魂", [[3, "但是，能源之树一直没有逃脱萨伦帝国的威胁！作为星球的能源之心，帝国的人虎视眈眈。"]], ["嗯，的确是哪儿都有他们的踪迹。"], [function ():void {
                    NpcDialog.show(117, "战士亡魂", [[1, "据说第五层也不太平。不过厮杀的声音反而更引起了我们的斗志！！"]], ["=，=第五层……我去伸张正义去！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, AcceptHandler);
                        QuestManager.accept(_quest.id);
                    }]);
                }]);
            }]);
        }]);
    }

    private function AcceptHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
        SceneManager.changeScene(SceneType.LOBBY, 830);
    }

    override public function processMapDispose():void {
        this._mc_0 = null;
        this._mc_1 = null;
        this._mc_2 = null;
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.AcceptHandler);
    }
}
}
