package com.taomee.seer2.app.processor.quest.handler.activity.quest30006 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_30006_360 extends QuestMapHandler {


    private var hurtMan:MovieClip;

    private var cartoonMcName:String = "30006_2";

    private var shaEets:MovieClip;

    public function QuestMapHandler_30006_360(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.hurtMan = _processor.resLib.getMovieClip("HurtMan");
            this.hurtMan.buttonMode = true;
            _map.content.addChild(this.hurtMan);
            this.hurtMan.addEventListener(MouseEvent.CLICK, this.showDialogue);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.showShaEets();
        }
    }

    private function showDialogue(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.hurtMan.removeEventListener(MouseEvent.CLICK, this.showDialogue);
        NpcDialog.show(111, "昏死的旅人", [[0, "沙沙……太可怕了…………"]], [" 醒醒！你怎么了！！"], [function ():void {
            NpcDialog.show(111, "昏死的旅人", [[0, "别！别过来！！我不要财宝了！！不要了！！"]], [" 我是来救你的！别害怕！"], [function ():void {
                var waterText:* = undefined;
                waterText = _processor.resLib.getMovieClip("WaterText");
                _map.front.addChild(waterText);
                MovieClipUtil.playMc(waterText, 1, waterText.totalFrames, function ():void {
                    _map.front.removeChild(waterText);
                    playCartoon();
                }, true);
            }]);
        }]);
    }

    private function playCartoon():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation(this.cartoonMcName), 3, [[1, 0]], function ():void {
            NpcDialog.show(111, "昏死的旅人", [[0, "实在是太可怕了，我以后再也不贪财了……"]], [" 我会把事情查明白的！你先回家去吧！"], [function ():void {
                var runMc:* = undefined;
                _map.content.removeChild(hurtMan);
                hurtMan.removeEventListener(MouseEvent.CLICK, showDialogue);
                runMc = _processor.resLib.getMovieClip("RunMc");
                _map.front.addChild(runMc);
                MovieClipUtil.playMc(runMc, 1, runMc.totalFrames, function ():void {
                    _map.front.removeChild(runMc);
                    runMc = null;
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete2);
                    QuestManager.completeStep(_quest.id, 2);
                }, true);
            }]);
        });
    }

    private function onStepComplete2(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 2) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
            this.showShaEets();
        }
    }

    private function showShaEets():void {
        this.shaEets = _processor.resLib.getMovieClip("ShaArise");
        _map.content.addChild(this.shaEets);
        this.shaEets.buttonMode = true;
        this.shaEets.addEventListener(MouseEvent.CLICK, this.showEetsDialogue);
    }

    private function showEetsDialogue(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        this.shaEets.removeEventListener(MouseEvent.CLICK, this.showEetsDialogue);
        NpcDialog.show(472, "沙伊特", [[1, "你也是来寻宝的吗？嘻嘻，我知道哪里有财宝哦！"]], [" 不动声色地问它财宝在哪里"], [function ():void {
            NpcDialog.show(472, "沙伊特", [[1, "那里呀，有一个神秘的洞穴~！里面有成堆成堆的财宝！！绝对可以闪到你头晕~~！"]], [" 还有可怕的响尾蛇对吧。"], [function ():void {
                NpcDialog.show(472, "沙伊特", [[3, "什……什么呀！！你乱说什么呀！！"]], ["  哼！捣蛋鬼沙伊特，决胜负吧！！"], [function ():void {
                    var skill:* = undefined;
                    _map.content.removeChild(shaEets);
                    skill = _processor.resLib.getMovieClip("ShaSkill");
                    skill.gotoAndStop(1);
                    _map.front.addChild(skill);
                    MovieClipUtil.playMc(skill, 1, skill.totalFrames, function ():void {
                        _map.front.removeChild(skill);
                        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "娜钱莱宫殿？飞伊特？"]], ["赶快去娜钱莱宫殿看看！"], [toNextScene]);
                    }, true);
                }]);
            }]);
        }]);
    }

    private function toNextScene():void {
        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete3);
        QuestManager.completeStep(_quest.id, 3);
    }

    private function onStepComplete3(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 3) {
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete3);
            SceneManager.changeScene(SceneType.LOBBY, 340);
        }
    }

    override public function processMapDispose():void {
        if (this.shaEets) {
            this.shaEets.addEventListener(MouseEvent.CLICK, this.showEetsDialogue);
        }
        if (this.hurtMan) {
            this.hurtMan.removeEventListener(MouseEvent.CLICK, this.showDialogue);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete3);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete2);
    }
}
}
