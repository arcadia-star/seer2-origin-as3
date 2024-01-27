package com.taomee.seer2.app.processor.quest.handler.branch.quest10214 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.processor.quest.handler.activity.quest30034.Game30034;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.BlendMode;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.MouseEvent;

public class QuestMapHandler_10214_80092 extends QuestMapHandler {

    private static const FIGHT_INDEX:int = 54;


    private var movie1:MovieClip;

    private var movie4:MovieClip;

    private var movie3:MovieClip;

    private var game:Game30034;

    private var snowBall:MovieClip;

    private var largetRect:Sprite;

    private var smallCirecle:Sprite;

    private var npc0:MovieClip;

    public function QuestMapHandler_10214_80092(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.npc0 = _processor.resLib.getMovieClip("npc0");
        if (this.npc0) {
            _map.content.addChild(this.npc0);
        }
        if (QuestManager.isAccepted(10214) == true && QuestManager.isStepComplete(10214, 1) == false) {
            this.initStep1();
        } else if (QuestManager.isStepComplete(10214, 1) == true && QuestManager.isStepComplete(10214, 2) == false) {
            this.initStep2();
        }
    }

    private function initStep1():void {
        NpcDialog.show(11, "多罗", [[0, "动次哒次！动次哒次！耶耶耶~~~哟哟哟~~~"]], ["这……囧"], [function ():void {
            movie1 = _processor.resLib.getMovieClip("movie1");
            ActorManager.hideActor();
            LayerManager.topLayer.addChild(movie1);
            _map.content.visible = false;
            MovieClipUtil.playMc(movie1, 1, movie1.totalFrames, function ():void {
                DisplayObjectUtil.removeFromParent(movie1);
                _map.content.visible = true;
                ActorManager.getActor().show();
                NpcDialog.show(11, "多罗", [[0, "我感觉我就要想通了！巴蒂再打我一次！让巴掌甩的再猛烈些吧！"]], ["囧囧囧"], [function ():void {
                    game = new Game30034(function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStep1);
                        QuestManager.completeStep(10214, 1);
                    });
                }]);
            });
        }]);
    }

    private function onStep1(param1:QuestEvent):void {
        if (param1.questId == 10214 && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1);
            this.initStep2();
        }
    }

    private function initStep2():void {
        NpcDialog.show(11, "多罗", [[0, "你有没有发现！他们扔烟雾弹的时候，隐约听到石头挪动的声音！莫非！机关就是在石头这里！"]], ["……这家伙真的变聪明了！"], [function ():void {
            snowBall = _map.content["snowBall"];
            if (snowBall) {
                addSnowFunc();
            }
        }]);
    }

    private function addSnowFunc():void {
        this.largetRect = new Sprite();
        this.largetRect.graphics.beginFill(0);
        this.largetRect.alpha = 0.5;
        this.largetRect.graphics.drawRect(0, 0, this._map.content.stage.stageWidth, this._map.content.stage.stageHeight);
        this.largetRect.graphics.endFill();
        LayerManager.topLayer.addChild(this.largetRect);
        this.largetRect.mouseEnabled = false;
        this.largetRect.mouseChildren = false;
        this.smallCirecle = new Sprite();
        this.smallCirecle.graphics.beginFill(16777215);
        this.smallCirecle.graphics.drawCircle(210, 265, 85);
        this.smallCirecle.graphics.endFill();
        this.largetRect.addChild(this.smallCirecle);
        this.largetRect.blendMode = BlendMode.LAYER;
        this.smallCirecle.blendMode = BlendMode.ERASE;
        this.movie4 = _processor.resLib.getMovieClip("movie4");
        LayerManager.topLayer.addChild(this.movie4);
        this.movie4.mouseChildren = this.movie4.mouseEnabled = false;
        this.movie4.gotoAndPlay(1);
        this.snowBall.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        DisplayObjectUtil.removeFromParent(this.largetRect);
        this.snowBall.removeEventListener(MouseEvent.CLICK, this.onClick);
        DisplayObjectUtil.removeFromParent(this.movie4);
        this.movie4 = null;
        SceneManager.changeScene(1, 80100);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep1);
        if (this.snowBall) {
            this.snowBall.removeEventListener(MouseEvent.CLICK, this.onClick);
        }
        if (this.movie4) {
            DisplayObjectUtil.removeFromParent(this.movie4);
        }
        if (this.npc0) {
            DisplayObjectUtil.removeFromParent(this.npc0);
        }
    }
}
}
