package com.taomee.seer2.app.processor.quest.handler.activity.quest30014 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.data.DialogDefinition;
import com.taomee.seer2.core.scene.LayerManager;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_30014_320 extends QuestMapHandler {


    private var _fightMovie:MovieClip;

    private var _ticketMovie:MovieClip;

    public function QuestMapHandler_30014_320(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 2) && false == QuestManager.isStepComplete(_quest.id, 3)) {
            this.playSceneMovie(null);
        }
    }

    private function playSceneMovie(param1:Event):void {
        var mc:MovieClip = null;
        var event:Event = param1;
        mc = _processor.resLib.getMovieClip("FightMovie_30014");
        this._fightMovie = mc;
        LayerManager.topLayer.addChild(mc);
        LayerManager.focusOnTopLayer();
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            _processor.showMouseHintAt(717.4, 217);
            mc["ElectricityEtes"].addEventListener(MouseEvent.CLICK, playSharpMovie);
            (mc["ElectricityEtes"] as MovieClip).buttonMode = true;
        });
    }

    private function playSharpMovie(param1:MouseEvent):void {
        var actor:Sprite = null;
        var mc:MovieClip = null;
        var event:MouseEvent = param1;
        this._fightMovie["ElectricityEtes"].removeEventListener(MouseEvent.CLICK, this.playSharpMovie);
        actor = ActorManager.getActor();
        _processor.mouseHint.removeEventListener(MouseEvent.CLICK, this.playSharpMovie);
        _processor.hideMouseClickHint();
        actor.visible = false;
        mc = _processor.resLib.getMovieClip("SharpMoive_30014");
        LayerManager.topLayer.addChild(mc);
        mc.x = actor.x;
        mc.y = actor.y;
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.topLayer.removeChild(mc);
            actor.visible = true;
            LayerManager.topLayer.removeChild(_fightMovie);
            playTicketMovie();
        });
    }

    private function playTicketMovie():void {
        var data:XML;
        var dialogDefinition:DialogDefinition;
        this.playEtesBreakMovie();
        data = new XML("<dialog npcId=\"498\" npcName=\"电伊特\" transport=\"\">" + "<branch id=\"default\"><node emotion=\"0\"><![CDATA[走！赛尔来了！这次7月伊特大乱斗不容许出任何岔子！都快走！]]></node>" + "<reply action=\"close\" params=\"yes\"><![CDATA[(掉在地上的是什么......)]]></reply></branch>" + "</dialog>");
        dialogDefinition = new DialogDefinition(data);
        DialogPanel.showForCommon(dialogDefinition, function ():void {
            var _loc1_:MovieClip = _processor.resLib.getMovieClip("Ticket_30014");
            _ticketMovie = _loc1_;
            _ticketMovie.buttonMode = true;
            LayerManager.topLayer.addChild(_loc1_);
            _loc1_.addEventListener(MouseEvent.CLICK, finishQuest);
        });
    }

    private function playEtesBreakMovie():void {
        var mc:MovieClip = null;
        mc = _processor.resLib.getMovieClip("EtesBreaks_30014");
        LayerManager.topLayer.addChild(mc);
        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
            LayerManager.topLayer.removeChild(mc);
        });
    }

    private function finishQuest(param1:MouseEvent):void {
        LayerManager.resetOperation();
        QuestManager.completeStep(_quest.id, 3);
        LayerManager.topLayer.removeChild(this._ticketMovie);
    }
}
}
