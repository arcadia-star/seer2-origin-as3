package com.taomee.seer2.app.processor.quest.handler.branch.quest10006 {
import com.taomee.seer2.app.animationInteractive.AnimationEvent;
import com.taomee.seer2.app.animationInteractive.StoneInteractive;
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

public class QuestMapHandler_10006_291 extends BranchQuestMapHandler {


    private var _stoneBtn:MovieClip;

    private var _laugh:MovieClip;

    private var _makeStone:StoneInteractive;

    public function QuestMapHandler_10006_291(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        var _loc1_:XML = <npc id="414" resId="414" name="" dir="1" width="25" height="50" pos="442,297"
                              actorPos="500,400" path="">
            <dialog npcId="414" npcName="" transport="">
                <branch id="default" npcId="414" npcName="尤尼">
                    <node emotion="0"><![CDATA[哈~~你是谁？来陪我玩吧！]]></node>
                    <reply action="close"><![CDATA[不好意思，我现在没空。]]></reply>
                </branch>
            </dialog>
        </npc>;
        initNpc(_loc1_);
        tip = "点点尤尼附近的石头堆看看。";
        this.npcStartEnterFrame();
        _npc.removeEventListener(MouseEvent.CLICK, this.onQuestClick);
        this._makeStone = new StoneInteractive();
        this.createStone();
    }

    private function npcStartEnterFrame():void {
        _npc.gotoAndPlay(1);
        _npc.addEventListener(Event.ENTER_FRAME, this.onNpcFrame);
    }

    private function onNpcFrame(param1:Event):void {
        if (_npc.currentFrameIndex >= 100) {
            _npc.removeEventListener(Event.ENTER_FRAME, this.onNpcFrame);
            _npc.stop();
            this._laugh = _processor.resLib.getMovieClip("mc_1");
            _map.ground.addChild(this._laugh);
            _npc.addEventListener(MouseEvent.CLICK, this.onQuestClick);
        }
    }

    override protected function onQuestAccept(param1:QuestEvent):void {
        super.onQuestAccept(param1);
        if (_questId == param1.questId) {
            this.openStoneClick();
        }
    }

    private function createStone():void {
        this._stoneBtn = _processor.resLib.getMovieClip("mc_2");
        _map.ground.addChild(this._stoneBtn);
        if (QuestManager.isAccepted(_questId)) {
            this.openStoneClick();
        }
    }

    private function openStoneClick():void {
        if (!QuestManager.isStepComplete(_questId, 1)) {
            this._stoneBtn.addEventListener(MouseEvent.CLICK, this.onStoneClick);
            this._stoneBtn.buttonMode = true;
        }
    }

    private function onStoneClick(param1:MouseEvent):void {
        this._makeStone.setup("stoneInteractive");
        this._makeStone.addEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.addEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
    }

    private function onCloseAnimation(param1:Event):void {
        this._makeStone.removeEventListener(Event.CLOSE, this.onCloseAnimation);
        this._makeStone.removeEventListener(AnimationEvent.STONE, this.onMakeBubbleOver);
    }

    private function onMakeBubbleOver(param1:Event):void {
        QuestManager.completeStep(_questId, 1);
        DialogPanel.showForSimple(414, "尤尼", [[0, "哈哈~~~你真能干！现在看我的，好玩的来喽"]], "？？什么呀？", this.onDialogOver);
    }

    private function onDialogOver():void {
        var _loc1_:String = String(URLUtil.getQuestFullScreenAnimation("10006_0"));
        MovieClipUtil.playFullScreen(_loc1_, this.animationStart);
        QuestManager.completeStep(_questId, 2);
    }

    private function animationStart():void {
        if (QuestManager.isStepComplete(_questId, 2) && QuestManager.isStepComplete(_questId, 3) == false) {
            DialogPanel.showForSimple(414, "尤尼", [[0, "哈哈哈，好玩好玩，你再帮我把它们找回来摆好吧！我能每次都把它们全撞飞，一个都不剩！"]], "—。—//•••上当了……", this.onDialogContinue);
        }
    }

    override protected function onQuestClick(param1:MouseEvent):void {
        if (QuestManager.isStepComplete(_questId, 1) && QuestManager.isStepComplete(_questId, 2) == false) {
            DialogPanel.showForSimple(414, "尤尼", [[0, "哈哈~~~你真能干！现在看我的，好玩的来喽"]], "？？什么呀？", this.onDialogOver);
        }
        this.animationStart();
        super.onQuestClick(param1);
    }

    private function onDialogContinue():void {
        DialogPanel.showForSimple(414, "尤尼", [[0, "咦，不玩了？唉…还是撞一排排的大将岩浮最好玩，哈哈，我去找它们了~~~"]], "真是太坏了……我走啦！", this.onDialogQuestComplete);
    }

    private function onDialogQuestComplete():void {
        QuestManager.completeStep(_questId, 3);
    }

    override protected function clearQuest():void {
        this.clearStone();
        super.clearQuest();
    }

    private function clearStone():void {
        if (this._stoneBtn) {
            this._stoneBtn.removeEventListener(MouseEvent.CLICK, this.onStoneClick);
            this._stoneBtn.buttonMode = false;
            DisplayObjectUtil.removeFromParent(this._stoneBtn);
            this._stoneBtn = null;
        }
        if (this._laugh) {
            DisplayObjectUtil.removeFromParent(this._laugh);
            this._laugh = null;
        }
    }
}
}
