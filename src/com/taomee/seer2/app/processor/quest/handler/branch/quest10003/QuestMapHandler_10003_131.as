package com.taomee.seer2.app.processor.quest.handler.branch.quest10003 {
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.MakeColorAniamtion;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.BranchQuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;

public class QuestMapHandler_10003_131 extends BranchQuestMapHandler {


    private var _colorBtn:MovieClip;

    private var _makeColor:MakeColorAniamtion;

    public function QuestMapHandler_10003_131(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="404" resId="404" name="" dir="0" width="25" height="50" pos="464,456"
                              actorPos="439,520" path="">
            <dialog npcId="404" npcName="呆呆葵" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[哎~~这可真难，谁来帮帮我呀……]]></node>
                    <reply action="close"><![CDATA[不好意思，我现在没空。]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "用调色盘帮我调更多颜色吧！";
        this.createInteractive();
    }

    private function createInteractive():void {
        this._makeColor = new MakeColorAniamtion();
        this._colorBtn = _processor.resLib.getMovieClip("item");
        this._colorBtn.x = 340;
        this._colorBtn.y = 390;
        this._colorBtn.gotoAndStop(1);
        _map.ground.addChild(this._colorBtn);
        if (!QuestManager.isStepComplete(_questId, 1) && QuestManager.isAccepted(_questId)) {
            this.addEventListenerColorBtn();
        }
    }

    private function addEventListenerColorBtn():void {
        this._colorBtn.buttonMode = true;
        this._colorBtn.gotoAndPlay(2);
        this._colorBtn.addEventListener(MouseEvent.CLICK, this.onColorBtn);
    }

    private function removeEventListenerColorBtn():void {
        this._colorBtn.gotoAndStop(1);
        this._colorBtn.buttonMode = false;
        this._colorBtn.removeEventListener(MouseEvent.CLICK, this.onColorBtn);
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        super.onQuestAccept(param1);
        if (_questId == param1.questId) {
            this.addEventListenerColorBtn();
        }
    }

    override protected function onSepComplete(param1:QuestEvent):void {
        super.onSepComplete(param1);
        if (_questId == param1.questId) {
            this.removeEventListenerColorBtn();
        }
    }

    override protected function completeQuest():void {
        DialogPanel.showForSimple(404, "呆呆葵", [[0, "哇~~有新颜色新颜色喽，太棒了！我的朋友一定会很高兴的！"]], "哦，原来这是给你朋友的呀？", this.gotoBranch_1);
    }

    private function gotoBranch_1():void {
        DialogPanel.showForSimple(404, "呆呆葵", [[0, "小时候，为了不害怕，我每天都悄悄地留一个努力的记号。嘻~突然有一天，我发现我的记号边上，多了一个努力的记号……"]], "呀？是谁留的？", this.gotoBranch_2);
    }

    private function gotoBranch_2():void {
        DialogPanel.showForSimple(404, "呆呆葵", [[0, "嗯~~我也不知道。不过，从那天开始，在我每天留下的记号后面，都会多一个记号。现在，我长大了，我想让我的记号更丰富多彩一点。"]], "呵呵，真好呀，你有一个好朋友。", this.onDialogOver);
    }

    private function onDialogOver():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10003_0"), function ():void {
            QuestManager.completeStep(_questId, 2);
        });
    }

    private function onColorBtn(param1:MouseEvent):void {
        this._makeColor.setup("mackColor");
        this._makeColor.addEventListener(AnimationEvent.MAKECOLOR, this.onMakeColor);
        this._makeColor.addEventListener(Event.CLOSE, this.onCloseAnimation);
    }

    private function onMakeColor(param1:Event):void {
        QuestManager.completeStep(_questId, 1);
    }

    private function onCloseAnimation(param1:Event):void {
        this.clearMakeColorAnimation();
    }

    private function clearMakeColorAnimation():void {
        if (this._makeColor) {
            this._makeColor.removeEventListener(AnimationEvent.MAKECOLOR, this.onMakeColor);
            this._makeColor.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        }
    }

    private function clearColorBtn():void {
        if (this._colorBtn) {
            DisplayObjectUtil.removeFromParent(this._colorBtn);
            this._colorBtn.removeEventListener(MouseEvent.CLICK, this.onColorBtn);
            this._colorBtn = null;
        }
    }

    override protected function clearQuest():void {
        this.clearMakeColorAnimation();
        this.clearColorBtn();
        super.clearQuest();
    }
}
}
