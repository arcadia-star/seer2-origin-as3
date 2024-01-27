package com.taomee.seer2.app.processor.quest.handler.branch.quest10119 {
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.branch.quest10115.DreamQuest50000;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10119_50000 extends DreamQuest50000 {


    private var _accpetableMark:AcceptableMark;

    public function QuestMapHandler_10119_50000(param1:QuestProcessor) {
        super(param1);
    }

    private function playFullMovieI(param1:Event):void {
        var event:Event = param1;
        if (QuestManager.isAccepted(_quest.id)) {
            this.onAccept(null);
        } else {
            MovieClipUtil.playFullScreen(URLUtil.getRes("active/fullScreen/10119_1.swf"), function ():void {
                changeScene();
            });
        }
    }

    private function changeScene(param1:Event = null):void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
        QuestManager.accept(_quest.id);
    }

    override protected function clickSeer(param1:MouseEvent):void {
        this.playFullMovieI(null);
    }

    override protected function onAccept(param1:QuestEvent):void {
        if (10119 == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, 1013);
        }
    }
}
}
