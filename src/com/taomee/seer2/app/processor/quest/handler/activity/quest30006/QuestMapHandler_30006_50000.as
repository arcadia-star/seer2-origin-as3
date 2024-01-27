package com.taomee.seer2.app.processor.quest.handler.activity.quest30006 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30006_50000 extends QuestMapHandler {


    private var new_letter:MovieClip;

    private var letterName:String = "30006_0";

    public function QuestMapHandler_30006_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id) && SceneManager.active && SceneManager.active.mapID == ActorManager.actorInfo.id) {
            this.playAcceptQuest();
        }
    }

    private function playAcceptQuest():void {
        this.new_letter = _processor.resLib.getMovieClip("NewLetter");
        _map.content.addChild(this.new_letter);
        this.new_letter.buttonMode = true;
        this.new_letter.addEventListener(MouseEvent.CLICK, this.playLetter);
    }

    private function playLetter(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        this.new_letter.removeEventListener(MouseEvent.CLICK, this.playLetter);
        mc = _processor.resLib.getMovieClip("ReadLetter");
        _map.front.addChild(mc);
        _map.content.removeChild(this.new_letter);
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            _map.front.removeChild(mc);
            NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "斯坦因的信？（话说他是怎么潜入这里的？！）三个全新属性捣蛋鬼？（该不会是伊特吧？！）各就各位？（准备开始捣蛋了？！）"]], ["总之先去向辛迪船长汇报！"], [toAccept]);
        }, true);
    }

    private function onAccept(param1:QuestEvent = null):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        SceneManager.changeScene(SceneType.LOBBY, 10);
    }

    private function toAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.accept(_quest.id);
    }

    override public function processMapDispose():void {
        if (this.new_letter) {
            this.new_letter.removeEventListener(MouseEvent.CLICK, this.playLetter);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
