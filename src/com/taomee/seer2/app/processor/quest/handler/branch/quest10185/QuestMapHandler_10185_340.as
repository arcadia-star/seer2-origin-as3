package com.taomee.seer2.app.processor.quest.handler.branch.quest10185 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10185_340 extends QuestMapHandler {


    private var monkeyMobile:Mobile;

    private var mark:AcceptableMark;

    private var monkeyID:uint = 577;

    private var sceneMc:MovieClip;

    private var mouseHit:MouseClickHintSprite;

    public function QuestMapHandler_10185_340(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (isNeedCompleteStep(2)) {
            this.createMonkey();
        }
    }

    private function createMonkey():void {
        this.monkeyMobile = new Mobile();
        this.monkeyMobile.resourceUrl = URLUtil.getNpcSwf(this.monkeyID);
        this.monkeyMobile.x = 628;
        this.monkeyMobile.y = 275;
        this.monkeyMobile.height = 100;
        this.monkeyMobile.mouseChildren = false;
        this.monkeyMobile.buttonMode = true;
        this.mark = new AcceptableMark();
        this.monkeyMobile.addOverHeadMark(this.mark);
        MobileManager.addMobile(this.monkeyMobile, MobileType.NPC);
        this.monkeyMobile.addEventListener(MouseEvent.CLICK, this.clickMonkey);
    }

    private function clickMonkey(param1:MouseEvent):void {
        var seerId:int = 0;
        var event:MouseEvent = param1;
        this.monkeyMobile.removeOverHeadMark();
        if (ActorManager.actorInfo.sex == 1) {
            seerId = 501;
        } else {
            seerId = 502;
        }
        NpcDialog.show(this.monkeyID, "火爆猴", [[2, "你怎么敢带我来这个地方？！你故意的是吧？！我恨这里！"]], ["啊？这里多好玩啊，你不觉得吗？"], [function ():void {
            NpcDialog.show(seerId, "小赛尔", [[0, "你看，哔叽哔叽的小鸭子、小球、旋转木马、还能游泳，是不是很开心？嗯？"]], ["你幼稚吧你！别逼我啊"], [function ():void {
                NpcDialog.show(monkeyID, "火爆猴", [[3, "（气死我了，一定要修理一下这家伙）喂，想让我开心是吧？呶！那里有个按钮，你按下我心情说不定就好了！"]], ["就这样？你可别耍我！"], [function ():void {
                    sceneMc = _map.content["sceneMc"];
                    sceneMc.buttonMode = true;
                    mouseHit = new MouseClickHintSprite();
                    mouseHit.x = sceneMc.x;
                    mouseHit.y = sceneMc.y;
                    _map.content.addChild(mouseHit);
                    sceneMc.addEventListener(MouseEvent.CLICK, playFull);
                }]);
            }]);
        }]);
    }

    private function playFull(param1:MouseEvent):void {
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        mc = _processor.resLib.getMovieClip("MiGongYu");
        LayerManager.topLayer.addChild(mc);
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            DisplayObjectUtil.removeFromParent(mc);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, completeStep);
            QuestManager.completeStep(questID, 2);
        }, true);
    }

    private function completeStep(param1:QuestEvent):void {
        if (param1.questId == questID && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.completeStep);
            SceneManager.changeScene(SceneType.LOBBY, 330);
        }
    }
}
}
