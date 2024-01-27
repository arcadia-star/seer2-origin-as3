package com.taomee.seer2.app.processor.quest.handler.main.quest11 {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.events.MoveEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;

import flash.display.MovieClip;
import flash.geom.Point;

public class QuestMapHandler_11_160 extends QuestMapHandler {


    private var _npc_10_11:MovieClip;

    private var _blackAnimation:MovieClip;

    private const NEARPOINT:Point = new Point(585, 425);

    private const CLOSE_DISTANCE:int = 100;

    public function QuestMapHandler_11_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this._npc_10_11 = _processor.resLib.getMovieClip("mc_1");
            this._npc_10_11.gotoAndStop(1);
            _map.front.addChild(this._npc_10_11);
            this.addBlackAnimation();
        }
    }

    private function addBlackAnimation():void {
        this._blackAnimation = _processor.resLib.getMovieClip("mc_2");
        this._blackAnimation.gotoAndStop(1);
        _map.front.addChild(this._blackAnimation);
        var _loc1_:Actor = ActorManager.getActor();
        var _loc2_:Boolean = this.isArrivedPosition(_loc1_.pos);
        if (_loc2_) {
            this.playBlackAnimation();
        } else {
            _loc1_.addEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
        }
    }

    private function onActorMoveFinished(param1:MoveEvent):void {
        var _loc2_:Actor = ActorManager.getActor();
        var _loc3_:Boolean = this.isArrivedPosition(_loc2_.pos);
        if (_loc3_ == true) {
            _loc2_.removeEventListener(MoveEvent.FINISHED, this.onActorMoveFinished);
            this.playBlackAnimation();
        }
    }

    private function playBlackAnimation():void {
        MovieClipUtil.playMc(this._blackAnimation, 1, this._blackAnimation.totalFrames, function ():void {
            _blackAnimation.stop();
            DisplayObjectUtil.removeFromParent(_blackAnimation);
            NpcDialog.show(11, "多罗", [[0, "奇怪……这个家伙看到我们跑什么……"]], ["难道……"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[3, "队长！这个人鬼鬼祟祟的！一定有什么阴谋！"]], ["快追！"], [function ():void {
                    _npc_10_11.gotoAndStop(2);
                    _npc_10_11.addFrameScript(1, function ():void {
                        var mc:*;
                        _npc_10_11.addFrameScript(1, null);
                        mc = _npc_10_11["mc"] as MovieClip;
                        MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                            DisplayObjectUtil.removeFromParent(_npc_10_11);
                            _npc_10_11 = null;
                            _processor.showMouseHintAt(935, 425);
                            QuestManager.completeStep(_quest.id, 1);
                        }, true);
                    });
                }]);
            }]);
        }, true);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
    }

    private function isArrivedPosition(param1:Point):Boolean {
        var _loc2_:int = Math.abs(this.NEARPOINT.x - param1.x);
        var _loc3_:int = Math.abs(this.NEARPOINT.y - param1.y);
        return _loc2_ < this.CLOSE_DISTANCE && _loc3_ < this.CLOSE_DISTANCE;
    }
}
}
