package com.taomee.seer2.app.processor.quest.handler.activity.quest30013 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30013_320 extends QuestMapHandler {


    private var cryEet:MovieClip;

    private var adMc:MovieClip;

    public function QuestMapHandler_30013_320(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initNpc();
        }
    }

    private function initNpc():void {
        this.cryEet = _processor.resLib.getMovieClip("CryEet");
        _map.content.addChild(this.cryEet);
        this.cryEet.buttonMode = true;
        this.cryEet.addEventListener(MouseEvent.CLICK, this.showEetDia);
    }

    private function showEetDia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(429, "哭泣的伊特", [[0, "不要你管！走开走开！55555……我们团结在一起不是挺好的嘛！干嘛要分高低！5555……"]], ["怎么啦？"], [function ():void {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("30013_0"), 3, [[1, 0]], function ():void {
                NpcDialog.show(400, "你", [[0, "可恶的家伙！我要去教训一下他！他现在在哪里？"]], ["老虎不发威！你当我病猫！"], [function ():void {
                    adMc = _processor.resLib.getMovieClip("FightEetAd");
                    adMc.x = 230;
                    adMc.y = 130;
                    adMc["gotoMapBtn"].addEventListener(MouseEvent.CLICK, to470);
                    LayerManager.focusOnTopLayer();
                    LayerManager.topLayer.addChild(adMc);
                }]);
            });
        }]);
    }

    private function to470(param1:MouseEvent):void {
        LayerManager.resetOperation();
        LayerManager.topLayer.removeChild(this.adMc);
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        QuestManager.completeStep(_quest.id, 1);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
            SceneManager.changeScene(SceneType.LOBBY, 470);
        }
    }

    override public function processMapDispose():void {
        if (this.cryEet) {
            this.cryEet.removeEventListener(MouseEvent.CLICK, this.showEetDia);
        }
        if (this.adMc) {
            this.adMc["gotoMapBtn"].removeEventListener(MouseEvent.CLICK, this.to470);
        }
        LayerManager.resetOperation();
        if (this.adMc) {
            DisplayUtil.removeForParent(this.adMc);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onComplete);
        super.processMapDispose();
    }
}
}
