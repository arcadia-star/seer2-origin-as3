package com.taomee.seer2.app.processor.quest.handler.story.quest47 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_47_830 extends QuestMapHandler {


    private var _fightStatus:Boolean;

    private var _fightStatusAgain:Boolean;

    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_47_830(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatus) {
                this._fightStatus = false;
                this.FightMovie();
            } else if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatusAgain) {
                this._fightStatusAgain = false;
                this.playFullMovieTwo();
            } else {
                this.playFullMovieOne();
            }
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkHandler);
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkAgainHandler);
            this.initNpc();
        }
    }

    private function playFullMovieOne():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("47_0"), function ():void {
            _mc_0 = _processor.resLib.getMovieClip("mc_3");
            _map.front.addChild(_mc_0);
        }, true, false, 2);
    }

    private function onNpcTalkHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "47_0") {
            this._fightStatus = true;
            FightManager.startFightBinaryWild(103);
        }
    }

    private function FightMovie():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkHandler);
        _map.front.addChild(this._mc_0);
        this._mc_1 = _processor.resLib.getMovieClip("mc_4");
        _map.front.addChild(this._mc_1);
        MovieClipUtil.playMc(this._mc_1, 1, this._mc_1.totalFrames, function ():void {
            _fightStatusAgain = true;
            FightManager.startFightWithWild(104);
        }, true);
    }

    private function playFullMovieTwo():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("47_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepOneHandler);
            QuestManager.completeStep(_quest.id, 1);
        }, true, false, 2);
    }

    private function onStepOneHandler(param1:QuestEvent):void {
        var evt:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneHandler);
        this.initNpc();
        NpcDialog.show(484, "埃鲁达克", [[3, "老夫在这纠结之藤上驻守了数百年，而他们的侵略却从未停止。老夫佩服他们的耐性！！"]], ["那个……请问……你是双属性咩？！"], [function ():void {
            NpcDialog.show(484, "埃鲁达克", [[0, "小孩，地面和沙漠对应着精灵王的利爪和犄角，原本就是一体的！因此，地面和沙漠全都是如老夫这般……"]], ["不是这样的！（将自己的经历告诉他。）"], [function ():void {
                NpcDialog.show(484, "埃鲁达克", [[3, "可恶！！他们一定是因为惧怕吾等的力量而故意挑拨！！不争气的孩子们……好在地沙二族又言归于好，让他们无机可趁！"]], ["最后一战二大族长领悟了双精灵对战，很帅气！"], [function ():void {
                    NpcDialog.show(484, "埃鲁达克", [[1, "嚯哈——哈——哈——！这让老夫充满干劲！！铁皮的小孩，和老夫并肩作战吧！永远不要放弃！"]], ["嗯！（我不是小孩啦！）"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                        QuestManager.completeStep(_quest.id, 2);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initNpc():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        this._mc_0 = _processor.resLib.getMovieClip("mc_5");
        _map.front.addChild(this._mc_0);
    }

    private function onNpcTalkAgainHandler(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "47_1") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onNpcTalkAgainHandler);
            QuestManager.addEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
            QuestManager.completeStep(_quest.id, 2);
        }
    }

    private function onQuestComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        if (param1.questId == 47) {
            DisplayUtil.removeForParent(this._mc_0);
            DisplayUtil.removeForParent(this._mc_1);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_0);
        DisplayUtil.removeForParent(this._mc_1);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepOneHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }
}
}
