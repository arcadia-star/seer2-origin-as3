package com.taomee.seer2.app.processor.quest.handler.main.quest9 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_9_192 extends QuestMapHandler {


    private var _stepAnimation:MovieClip;

    public function QuestMapHandler_9_192(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.extractAssets();
        if (_quest.status == QuestStatus.IN_PROGRESS) {
            if (_quest.isStepCompete(1)) {
                if (!_quest.isStepCompete(2)) {
                    this.processStep2();
                } else if (!_quest.isStepCompete(3)) {
                    this.processStep3();
                } else if (!_quest.isStepCompete(4)) {
                    this.processStep4();
                }
            }
        }
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
    }

    private function extractAssets():void {
        this._stepAnimation = _map.content["quest_9"];
    }

    private function processStep2():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            this._stepAnimation.gotoAndStop(3);
            MovieClipUtil.playFullScreen(URLUtil.getQuestAnimation("9/fullScreen_0"), function ():void {
                NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[2, "很明显……那是他们的爸爸啊……我究竟在干嘛……"]], ["这样的行为和海盗有什么区别？"], [function ():void {
                    NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[2, "我……我简直是混蛋！我怎么能为了一锅可笑的汤去伤害精灵呢？我……我……"]], ["快为精灵包扎伤口吧！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep2);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            });
        } else {
            this.showFightFlag();
        }
    }

    private function showFightFlag():void {
        MovieClipUtil.getChildList(this._stepAnimation, 2, [0], function (param1:Vector.<DisplayObject>):void {
            var children:Vector.<DisplayObject> = param1;
            var mc:MovieClip = children[0] as MovieClip;
            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                _stepAnimation.addEventListener(MouseEvent.CLICK, onStepAnimationClick1);
                DisplayObjectUtil.enableButtonMode(_stepAnimation);
                _processor.showMouseHintAt(210, 360);
            }, true);
        });
    }

    private function onStepAnimationClick1(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._stepAnimation.removeEventListener(MouseEvent.CLICK, this.onStepAnimationClick1);
        DisplayObjectUtil.disableButtonMode(this._stepAnimation);
        NpcDialog.show(413, "蓝虎鲸", [[0, "是“水”（谁）？想要抓俺的小崽子？看俺的铁头神功不教训……"]], ["让我再酝酿一下吧！", "不管这么多了！上！"], [function ():void {
            showFightFlag();
        }, function ():void {
            fightPet();
        }]);
    }

    private function onCompleteStep2(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep2);
            this.processStep3();
        }
    }

    private function processStep3():void {
        this._stepAnimation.gotoAndStop(3);
        this._stepAnimation.addEventListener(MouseEvent.CLICK, this.onStepAnimationClick2);
        DisplayObjectUtil.enableButtonMode(this._stepAnimation);
        _processor.showMouseHintAt(220, 370);
    }

    private function onStepAnimationClick2(param1:MouseEvent):void {
        _processor.hideMouseClickHint();
        this._stepAnimation.removeEventListener(MouseEvent.CLICK, this.onStepAnimationClick2);
        this._stepAnimation.addEventListener(MouseEvent.CLICK, this.onStepAnimationClick3);
        this._stepAnimation.gotoAndStop(4);
    }

    private function onStepAnimationClick3(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        this._stepAnimation.addEventListener(MouseEvent.CLICK, this.onStepAnimationClick3);
        DisplayObjectUtil.disableButtonMode(this._stepAnimation);
        this._stepAnimation.gotoAndStop(5);
        NpcDialog.show(413, "蓝虎鲸", [[0, "是俺错怪你了……你是个好人……俺以为你是来抓俺，拿鱼翅的！"]], ["（其实……我来的目的也是……）"], [function ():void {
            NpcDialog.show(413, "蓝虎鲸", [[0, "最近很多外来人都为了要俺们的鱼翅刺杀我们……俺们蓝喵族已经越来越少了……俺走啦！谢谢你恩公！"]], [" 小家伙们要健康成长哦！"], [function ():void {
                MovieClipUtil.getChildList(_stepAnimation, 6, [0], function (param1:Vector.<DisplayObject>):void {
                    var children:Vector.<DisplayObject> = param1;
                    var mc:* = children[0] as MovieClip;
                    MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[3, "不管了！！婆婆生气也没办法！猎杀精灵我是做不出！最多我去顶替多罗做苦工！"]], ["（返回狂暴漩涡）"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep3);
                            QuestManager.completeStep(_quest.id, 3);
                        }]);
                    }, true);
                });
            }]);
        }]);
    }

    private function onCompleteStep3(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep3);
            this.processStep4();
        }
    }

    private function processStep4():void {
        _processor.showMouseHintAt(10, 450);
    }

    private function fightPet():void {
        FightManager.startFightWithWild(10);
    }
}
}
