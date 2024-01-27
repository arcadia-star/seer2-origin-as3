package com.taomee.seer2.app.processor.quest.handler.story.quest58 {
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.Tick;

public class QuestMapHandler_58_930 extends QuestMapHandler {


    private var gaspot:Vector.<MovieClip>;

    private var collectNum:int = 0;

    private var timeNum:int = 0;

    private var _npcDefinition:NpcDefinition;

    private var _npc:Mobile;

    private var clickMark:MouseClickHintSprite;

    private var countDown:MovieClip;

    public function QuestMapHandler_58_930(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapDispose():void {
        super.processMapDispose();
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.showNpcTalk);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
        Tick.instance.removeRender(this.updateTime);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && !QuestManager.isStepComplete(_quest.id, 1)) {
            this.initStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && !QuestManager.isStepComplete(_quest.id, 4)) {
            this.initStep4();
        }
    }

    private function initStep4():void {
        var _loc1_:MovieClip = _processor.resLib.getMovieClip("gaspotContainer");
        this.gaspot = new Vector.<MovieClip>();
        _map.content.addChild(_loc1_);
        var _loc2_:int = 0;
        while (_loc2_ < 9) {
            this.gaspot.push(_loc1_["gaspot" + _loc2_]);
            this.gaspot[_loc2_].buttonMode = true;
            this.gaspot[_loc2_].mouseChildren = false;
            this.gaspot[_loc2_].mouseEnabled = false;
            this.gaspot[_loc2_].addEventListener(MouseEvent.CLICK, this.collectGaspot);
            _loc2_++;
        }
        this.countDown = _processor.resLib.getMovieClip("CountDown_58");
        _map.front.addChild(this.countDown);
        this.clickMark = new MouseClickHintSprite();
        _loc1_.addChild(this.clickMark);
        this.clickMark.x = this.gaspot[0].x + 10;
        this.clickMark.y = this.gaspot[0].y - 20;
        this.gaspot[0].mouseEnabled = true;
    }

    private function collectGaspot(param1:MouseEvent):void {
        var _loc3_:int = 0;
        ++this.collectNum;
        var _loc2_:MovieClip = param1.currentTarget as MovieClip;
        _loc2_.visible = false;
        if (this.collectNum == 9) {
            Tick.instance.removeRender(this.updateTime);
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStep);
            QuestManager.completeStep(_quest.id, 4);
        }
        if (this.clickMark) {
            DisplayObjectUtil.removeFromParent(this.clickMark);
            this.clickMark = null;
            _loc3_ = 0;
            while (_loc3_ < 9) {
                this.gaspot[_loc3_].mouseEnabled = true;
                _loc3_++;
            }
            if (Tick.instance.hasRender(this.updateTime)) {
                Tick.instance.removeRender(this.updateTime);
            }
            Tick.instance.addRender(this.updateTime, 1000);
            this.countDown.gotoAndStop(41);
        }
    }

    private function updateTime(param1:int):void {
        ++this.timeNum;
        this.countDown.nextFrame();
        if (this.timeNum == 10) {
            Tick.instance.removeRender(this.updateTime);
            if (this.collectNum < 9) {
                AlertManager.showAlert("蒸汽都漏光了，你要重新收集一次。加油！", this.reCollect);
            }
        }
    }

    private function reCollect():void {
        var _loc1_:int = 0;
        while (_loc1_ < 9) {
            this.gaspot[_loc1_].visible = true;
            this.gaspot[_loc1_].mouseEnabled = true;
            _loc1_++;
        }
        this.countDown.gotoAndStop(41);
        this.timeNum = 0;
        this.collectNum = 0;
        if (Tick.instance.hasRender(this.updateTime)) {
            Tick.instance.removeRender(this.updateTime);
        }
        Tick.instance.addRender(this.updateTime, 1000);
    }

    private function onStep(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        if (event.questId == _quest.id && event.stepId == 4) {
            AlertManager.showAlert("你已经成功收集9个蒸汽罐,快前往风涡工厂交给斯摩克吧！", function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 940, 444, 485);
            });
        }
    }

    private function initStep1():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("58_0"), function ():void {
            var _loc1_:XML = <npc id="137" resId="137" name="" dir="1" width="25" height="90" pos="470,320"
                                  actorPos="480,320" path="">
                <dialog npcId="137" npcName="席德" transport="1,300,400">
                    <branch id="default">
                        <node emotion="0"><![CDATA[这就是我们的御风中枢，其中隐藏着许多不为人知的科技结晶。这里人迹罕至，几乎没什么人来往。]]></node>
                        <reply action="goToBranch" params="branch1"><![CDATA[好壮观的地方，谁住在这里？]]></reply>
                    </branch>
                    <branch id="branch1">
                        <node emotion="0"><![CDATA[这里没……没人住，因为暗杀者变多了，这里的科学家全都逃跑了……]]></node>
                        <reply action="goToBranch" params="branch2"><![CDATA[逃跑了？曾经这里的科学家是谁呀？]]></reply>
                    </branch>
                    <branch id="branch2">
                        <node emotion="0"><![CDATA[这个…这个我们早就忘了…好了，今天的行程就到此为止吧，明天我们在继续吧。]]></node>
                        <reply action="goToBranch" params="branch3"><![CDATA[哦？前面那条路是通往哪里的？]]></reply>
                    </branch>
                    <branch id="branch3">
                        <node emotion="0"><![CDATA[不要去那里！那里对于外人太危险！我这里有一份关于它的介绍，你看了之后就知道为什么了]]></node>
                        <reply action="" params="58_930_0"><![CDATA[越说越激动！我看看！]]></reply>
                    </branch>
                </dialog>
            </npc>;
            _npcDefinition = new NpcDefinition(_loc1_);
            _npc = MobileManager.createNpc(_npcDefinition);
            _npc.removeOverHeadMark();
            _npc.addOverHeadMark(new AcceptableMark());
            _npc.buttonMode = true;
            _npc.addEventListener(MouseEvent.CLICK, showDia);
        });
    }

    private function showDia(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.showNpcTalk);
    }

    private function showNpcTalk(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        var params:String = (evt.content as DialogPanelEventData).params;
        if (params == "58_930_0") {
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("58_0"), 2, [[1, 0]], function ():void {
                NpcDialog.show(137, "席德", [[0, "怎么样星际使者？风涡工房中有恐怖的迷雾杀手，我们还是回去吧？"]], ["不！看来新的冒险又要开始啦！"], [function ():void {
                    NpcDialog.show(137, "席德", [[0, "你真的要去吗？我可是不敢去哪个地方，要去你自己去！"]], ["好吧！就由我星际使者开启下一段旅程吧！"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onCompleteStep);
                        QuestManager.completeStep(_quest.id, 1);
                    }]);
                }]);
            });
        }
    }

    private function onCompleteStep(param1:QuestEvent):void {
        if (param1.questId == _quest.id && param1.stepId == 1) {
            SceneManager.changeScene(SceneType.LOBBY, 940);
            QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onCompleteStep);
        }
    }
}
}
