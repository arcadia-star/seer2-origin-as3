package com.taomee.seer2.app.processor.quest.handler.story.quest46 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.FightVerifyManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_46_820 extends QuestMapHandler {


    private var zhanshiMc:MovieClip;

    private var zhanshiNpc:MovieClip;

    private var duoBaMc:MovieClip;

    private var shakenum:int = 0;

    private var moveDis:int = 5;

    public function QuestMapHandler_46_820(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            if (SceneManager.prevSceneType == SceneType.ARENA) {
                this.battleResultHandler();
            } else {
                this.playSceneAnimation();
            }
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.initStep2();
        }
    }

    override public function processMapDispose():void {
        if (this.zhanshiMc) {
            if (_map.content.contains(this.zhanshiMc)) {
                _map.content.removeChild(this.zhanshiMc);
            }
            this.zhanshiMc = null;
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        if (this.zhanshiNpc) {
            this.zhanshiNpc.luoke.removeEventListener(MouseEvent.CLICK, this.zhanshiADia);
        }
    }

    private function battleResultHandler():void {
        if (this.zhanshiNpc) {
            DisplayObjectUtil.removeFromParent(this.zhanshiNpc);
        }
        this.zhanshiNpc = _processor.resLib.getMovieClip("zhanshiNpc");
        _map.content.addChild(this.zhanshiNpc);
        this.zhanshiMc = _processor.resLib.getMovieClip("ZhanShiMc");
        _map.front.addChild(this.zhanshiMc);
        MovieClipUtil.playMc(this.zhanshiMc, 1, this.zhanshiMc.totalFrames, function ():void {
            _map.front.removeChild(zhanshiMc);
            zhanshiMc = null;
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep1);
            QuestManager.completeStep(_quest.id, 1);
        }, true);
    }

    private function onCompleteStep1(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep1);
            this.initStep2();
        }
    }

    private function initStep2():void {
        if (!this.zhanshiNpc) {
            this.zhanshiNpc = _processor.resLib.getMovieClip("zhanshiNpc");
        }
        this.zhanshiNpc.play();
        _map.content.addChild(this.zhanshiNpc);
        this.zhanshiNpc.luoke.buttonMode = true;
        this.zhanshiNpc.luoke.addEventListener(MouseEvent.CLICK, this.zhanshiADia);
    }

    private function zhanshiADia(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        NpcDialog.show(115, "战士亡魂", [[3, "和蛮神说什么战斗方式？！只要畅快地厮杀就可以了！"]], ["那个，你们先息怒……"], [function ():void {
            NpcDialog.show(10, "巴蒂", [[0, "脉流之瀑受到炎热力量的影响八成是因为他们的关系……"]], ["请问，你们能不能冷静一下……"], [function ():void {
                NpcDialog.show(116, "战士亡魂", [[3, "我们都是火幻氏族的战士，带着荣耀战死沙场后，就来到这个地方，继续我们生前的角斗！"]], ["还真是恋战啊……"], [function ():void {
                    NpcDialog.show(116, "战士亡魂", [[3, "这就是火幻氏族的精神！！"]], ["好好好……叫你们管事儿的出来……"], [function ():void {
                        NpcDialog.show(115, "战士亡魂", [[2, "他已经走了……"]], ["啥？！"], [function ():void {
                            NpcDialog.show(116, "战士亡魂", [[2, "我们的角斗，原本都是由他来做裁判。而他走了以后，我们却再也没有办法找到一个公正秩序的决斗环境了……"]], ["守护者，你到底去哪儿了呢……"], [function ():void {
                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("46_1"), function ():void {
                                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                    QuestManager.completeStep(_quest.id, 2);
                                }, false);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        if (param1.questId == 46) {
            _map.content.removeChild(this.zhanshiNpc);
            this.zhanshiNpc.luoke.removeEventListener(MouseEvent.CLICK, this.zhanshiADia);
            QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        }
    }

    private function playSceneAnimation():void {
        this.duoBaMc = _processor.resLib.getMovieClip("DuoBaMc");
        _map.front.addChild(this.duoBaMc);
        MovieClipUtil.playMc(this.duoBaMc, 1, this.duoBaMc.totalFrames, function ():void {
            _map.front.removeChild(duoBaMc);
            NpcDialog.show(11, "多罗", [[1, "哦呵呵呵呵！！队长，我多罗已经检查过了，这里什么都没有，不足为惧！"]], ["这里安静得有点诡异……"], [function ():void {
                NpcDialog.show(10, "巴蒂", [[0, "一般来说，暴风雨前的宁静都是最可怕的。多罗你太掉以轻心了。"]], ["而且，守护者呢？"], [function ():void {
                    LayerManager.mapLayer.addEventListener(Event.ENTER_FRAME, shakHandler);
                }]);
            }]);
        }, true);
    }

    private function shakHandler(param1:Event):void {
        var event:Event = param1;
        ++this.shakenum;
        if (this.shakenum > 10) {
            LayerManager.mapLayer.removeEventListener(Event.ENTER_FRAME, this.shakHandler);
            LayerManager.mapLayer.x = 0;
            LayerManager.mapLayer.y = 0;
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("46_0"), function ():void {
                if (!zhanshiNpc) {
                    zhanshiNpc = _processor.resLib.getMovieClip("zhanshiNpc");
                }
                zhanshiNpc.buttonMode = true;
                zhanshiNpc.addEventListener(MouseEvent.CLICK, fightHandler);
                _map.content.addChild(zhanshiNpc);
                if (FightVerifyManager.validateFightStart()) {
                    fightHandler(null);
                }
            });
            return;
        }
        this.moveDis = -1 * this.moveDis;
        LayerManager.mapLayer.x += this.moveDis;
    }

    private function fightHandler(param1:MouseEvent):void {
        if (FightVerifyManager.validateFightStart()) {
            this.zhanshiNpc.removeEventListener(MouseEvent.CLICK, this.fightHandler);
            FightManager.startFightWithWild(99);
        }
    }
}
}
