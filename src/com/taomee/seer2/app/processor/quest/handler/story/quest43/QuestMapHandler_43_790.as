package com.taomee.seer2.app.processor.quest.handler.story.quest43 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_43_790 extends QuestMapHandler {


    private var _mc_0:MovieClip;

    public function QuestMapHandler_43_790(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this.loadGlede();
        }
    }

    private function loadGlede():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        this._mc_0.buttonMode = true;
        this._mc_0.addEventListener(MouseEvent.CLICK, this.onGledeSay);
    }

    private function onGledeSay(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(474, "呆目齿轮鹰", [[2, "这年头别的不怕，就怕无赖啊！"]], ["请问发生什么事情了？"], [function ():void {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("43_0"), function ():void {
                _mc_0.removeEventListener(MouseEvent.CLICK, onGledeSay);
                NpcDialog.show(474, "呆目齿轮鹰", [[2, "听说还有很多苦命的飞行系精灵被稻草人袭击了！（虽然其实它根本打不着我们，噗~）但是真的很让人困扰！"]], ["那个稻草人在哪儿？我去找它进行心灵沟通。"], [function ():void {
                    NpcDialog.show(474, "呆目齿轮鹰", [[0, "它就在能源之树的第二层——视界原野。不过我看心灵沟通也没用，它已经走火入魔了！"]], ["哈哈，不管怎么样，先去视界原野看一看吧！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                        QuestManager.accept(_quest.id);
                    }]);
                }]);
            }, true, false, 2);
        }]);
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        SceneManager.changeScene(SceneType.LOBBY, 800);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
