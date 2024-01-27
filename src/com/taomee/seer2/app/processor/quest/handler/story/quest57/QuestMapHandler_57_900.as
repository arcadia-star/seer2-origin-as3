package com.taomee.seer2.app.processor.quest.handler.story.quest57 {
import com.taomee.seer2.app.arena.FightManager;
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

public class QuestMapHandler_57_900 extends QuestMapHandler {


    private var _fightStatus:Boolean;

    private var _mc_0:MovieClip;

    public function QuestMapHandler_57_900(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (SceneManager.prevSceneType == SceneType.ARENA && this._fightStatus) {
                this._fightStatus = false;
                this.fightOver();
            } else {
                this.playFullMC();
            }
        }
    }

    private function playFullMC():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("57_0"), function ():void {
            _mc_0 = _processor.resLib.getMovieClip("mc_1");
            _map.content.addChild(_mc_0);
            _mc_0.buttonMode = true;
            _mc_0.addEventListener(MouseEvent.CLICK, npcTalkHandler);
        }, true, false, 2);
    }

    private function npcTalkHandler(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(137, "席德", [[0, "欢迎——来到风涡中的民族——风刃氏族。"]], ["哇，风暴中居然藏着这样的天地！"], [function ():void {
            NpcDialog.show(148, "娜娜", [[3, "席德——！你小子！那么久不见人，想要我人道毁灭你？！"]], ["（这位很凶的大姐是……？）"], [function ():void {
                NpcDialog.show(148, "娜娜", [[3, "喂你？你是可以直立行走的大型零件吗？刚才你在心里说我是个很凶的大姐了吧？嗯？嗯？！"]], ["没，没有！（话说大型零件？我？）"], [function ():void {
                    NpcDialog.show(148, "娜娜", [[2, "哎……席德，以后不要带着种古怪的零件过来，就让我来为你收场吧。"]], ["收场？啥？啊喂——！"], [function ():void {
                        _fightStatus = true;
                        FightManager.startFightWithWild(129);
                    }]);
                }]);
            }]);
        }]);
    }

    private function fightOver():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_1");
        _map.content.addChild(this._mc_0);
        this._mc_0.removeEventListener(MouseEvent.CLICK, this.npcTalkHandler);
        NpcDialog.show(148, "娜娜", [[1, "哈哈哈哈——整天对着那些要命的器械，偶尔这么活动一下胫骨也不错！"]], ["=。=你消遣我……"], [function ():void {
            NpcDialog.show(137, "席德", [[0, "娜娜大姐，你明明就一直向往着能和星际使者切磋一番，还偏偏要说人家是零件……"]], ["……"], [function ():void {
                NpcDialog.show(148, "娜娜", [[1, "哈哈，你别介意！我早就知道你是谁了！风刃氏族也算是星球上最庞大的情报交流场所了，没有什么能够瞒得住风！"]], ["最庞大的情报交流场所？"], [function ():void {
                    NpcDialog.show(137, "席德", [[0, "这个我之后会慢慢给你介绍的。嗯，时间差不多了，我们去流离街看看吧？"]], ["好哦！我还有很多想了解的事情！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepCompleteHandler);
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onStepCompleteHandler(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        SceneManager.changeScene(SceneType.LOBBY, 920);
    }

    override public function processMapDispose():void {
        if (this._mc_0) {
            DisplayUtil.removeForParent(this._mc_0);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepCompleteHandler);
    }
}
}
