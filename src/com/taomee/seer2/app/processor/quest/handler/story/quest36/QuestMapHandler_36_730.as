package com.taomee.seer2.app.processor.quest.handler.story.quest36 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_36_730 extends QuestMapHandler {

    private static var _fightStatus:uint = 0;


    private var _npc:Mobile;

    private var _npcDefinition:NpcDefinition;

    private var _npc_2:Mobile;

    private var _npcDefinition_2:NpcDefinition;

    private var _npc_3:Mobile;

    private var _npcDefinition_3:NpcDefinition;

    private var _npc_4:Mobile;

    private var _npcDefinition_4:NpcDefinition;

    private var _npc_5:Mobile;

    private var _npcDefinition_5:NpcDefinition;

    private var _npc_6:Mobile;

    private var _npcDefinition_6:NpcDefinition;

    private var _npc_7:Mobile;

    private var _npcDefinition_7:NpcDefinition;

    private var _mc_1:MovieClip;

    private var _mc_2:MovieClip;

    public function QuestMapHandler_36_730(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false && _fightStatus == 1) {
            _fightStatus = 0;
            this.initNpc();
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.win();
            } else {
                this.noWin();
            }
            return;
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initNpc();
            this.initNpcEvent(1);
            this._npc_3.visible = false;
            this._npc_4.visible = false;
            this._npc_5.visible = false;
            this._npc_6.visible = false;
            this._npc_7.visible = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            this.initNpc();
            this.initNpcEvent(3);
            this._npc_3.visible = true;
            this._npc_6.visible = true;
            this._npc_7.visible = true;
            this._npc_4.visible = false;
            this._npc_5.visible = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initNpc();
            this.initNpcEvent(4);
            this._npc_3.visible = true;
            this._npc_4.visible = true;
            this._npc_6.visible = true;
            this._npc_7.visible = true;
            this._npc_5.visible = false;
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.initNpc();
            this.initNpcEvent(5);
            this._npc_6.visible = true;
            this._npc_7.visible = true;
            this._npc_3.visible = true;
            this._npc_4.visible = true;
            this._npc_5.visible = true;
        }
    }

    private function win():void {
        NpcDialog.show(96, "巴顿", [[2, "财务官大人输了？！怎么办，如果下个月翻3倍……4倍……呜哇，孩子他妈，我们怎么办好？？"]], ["这种收税方式是错的！"], [function ():void {
            NpcDialog.show(93, "刚铎", [[0, "表现非常好！你可以考虑加入我的刚铎小队，我们要和恶势力对抗到底！！"]], ["刚铎小队……=。="], [function ():void {
                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("36_1"), function ():void {
                    QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                    QuestManager.completeStep(_quest.id, 3);
                }, false, false, 2);
            }]);
        }]);
    }

    private function noWin():void {
        NpcDialog.show(97, "财务官", [[1, "呵——呵——呵——使者大人，玩得尽兴了，我们就继续收税吧？"]], ["我还没玩够呢！", "还是算啦"], [function ():void {
            processStep3();
        }]);
    }

    private function initNpc():void {
        var _loc1_:XML = <npc id="95" resId="95" name="" dir="0" width="25" height="90" pos="539,512" actorPos="489,433"
                              path="">
            <dialog npcId="95" npcName="克莉斯蒂" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[听说某个星球上的一些奢侈品牌很不错，据说叫香奈儿什么的，很称我也！]]></node>
                    <reply action="close"><![CDATA[（那有什么，我妈妈有一橱子~）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition = new NpcDefinition(_loc1_);
        this._npc = MobileManager.createNpc(this._npcDefinition);
        var _loc2_:XML = <npc id="96" resId="96" name="" dir="1" width="25" height="90" pos="470,543" actorPos="489,433"
                              path="">
            <dialog npcId="96" npcName="巴顿" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[听说某个星球上的一些奢侈品牌很不错，据说叫香奈儿什么的，很称我也！]]></node>
                    <reply action="close"><![CDATA[（那有什么，我妈妈有一橱子~）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_2 = new NpcDefinition(_loc2_);
        this._npc_2 = MobileManager.createNpc(this._npcDefinition_2);
        var _loc3_:XML = <npc id="97" resId="97" name="" dir="0" width="25" height="90" pos="687,457" actorPos="487,398"
                              path="">
            <dialog npcId="97" npcName="财务官" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[经济基础决定上层建筑。]]></node>
                    <reply action="close"><![CDATA[……]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_3 = new NpcDefinition(_loc3_);
        this._npc_3 = MobileManager.createNpc(this._npcDefinition_3);
        var _loc4_:XML = <npc id="93" resId="93" name="" dir="1" width="25" height="90" pos="639,528" actorPos="478,395"
                              path="">
            <dialog npcId="93" npcName="刚铎" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[命运与巧合，往往只有一线之差……]]></node>
                    <reply action="close"><![CDATA[（离他远点……）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_4 = new NpcDefinition(_loc4_);
        this._npc_4 = MobileManager.createNpc(this._npcDefinition_4);
        var _loc5_:XML = <npc id="98" resId="98" name="" dir="1" width="25" height="90" pos="582,421" actorPos="389,438"
                              path="">
            <dialog npcId="98" npcName="萨伯尔兵团长" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[命运与巧合，往往只有一线之差……]]></node>
                    <reply action="close"><![CDATA[（离他远点……）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_5 = new NpcDefinition(_loc5_);
        this._npc_5 = MobileManager.createNpc(this._npcDefinition_5);
        var _loc6_:XML = <npc id="99" resId="99" name="" dir="1" width="25" height="90" pos="663,436" actorPos="710,209"
                              path="">
            <dialog npcId="99" npcName="财务官卫兵" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[命运与巧合，往往只有一线之差……]]></node>
                    <reply action="close"><![CDATA[（离他远点……）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_6 = new NpcDefinition(_loc6_);
        this._npc_6 = MobileManager.createNpc(this._npcDefinition_6);
        var _loc7_:XML = <npc id="99" resId="99" name="" dir="0" width="25" height="90" pos="772,454" actorPos="710,209"
                              path="">
            <dialog npcId="99" npcName="财务官卫兵" transport="1,300,400">
                <branch id="default">
                    <node emotion="0"><![CDATA[命运与巧合，往往只有一线之差……]]></node>
                    <reply action="close"><![CDATA[（离他远点……）]]></reply>
                </branch>
            </dialog>
        </npc>;
        this._npcDefinition_7 = new NpcDefinition(_loc7_);
        this._npc_7 = MobileManager.createNpc(this._npcDefinition_7);
    }

    private function initNpcEvent(param1:int):void {
        if (param1 == 1) {
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpc);
        } else if (param1 == 3) {
            this._npc_3.buttonMode = true;
            this._npc_3.addEventListener(MouseEvent.CLICK, this.onNpc3);
        } else if (param1 == 4) {
            this._npc_4.buttonMode = true;
            this._npc_4.addEventListener(MouseEvent.CLICK, this.onNpc4);
        } else if (param1 == 5) {
            this._npc_5.buttonMode = true;
            this._npc_5.addEventListener(MouseEvent.CLICK, this.onNpc5);
        }
    }

    private function onNpc(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function onNpc3(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition_3);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function onNpc4(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition_4);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function onNpc5(param1:MouseEvent):void {
        DialogPanel.showForNpc(this._npcDefinition_5);
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "36_1") {
            this.processStep1();
        }
        if ((param1.content as DialogPanelEventData).params == "36_2") {
            this.processStep2();
        }
        if ((param1.content as DialogPanelEventData).params == "36_3") {
            this.processStep3();
        }
        if ((param1.content as DialogPanelEventData).params == "36_4") {
            this.processStep4();
        }
    }

    private function processStep3():void {
        _fightStatus = 1;
        FightManager.startFightWithWild(71);
    }

    private function processStep2():void {
        this._mc_2 = _processor.resLib.getMovieClip("mc_2");
        _map.front.addChild(this._mc_2);
        MovieClipUtil.playMc(this._mc_2, 1, this._mc_2.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 2);
        }, true);
    }

    private function processStep1():void {
        this._mc_1 = _processor.resLib.getMovieClip("mc_1");
        _map.front.addChild(this._mc_1);
        MovieClipUtil.playMc(this._mc_1, 1, this._mc_1.totalFrames, function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(_quest.id, 1);
        }, true);
    }

    private function processStep4():void {
        QuestManager.addEventListener(QuestEvent.COMPLETE, this.onComplete);
        QuestManager.completeStep(_quest.id, 4);
    }

    private function onComplete(param1:QuestEvent):void {
        if (this._npc) {
            this._npc.dispose();
        }
        if (this._npc_2) {
            this._npc_2.dispose();
        }
        if (this._npc_3) {
            this._npc_3.dispose();
        }
        if (this._npc_4) {
            this._npc_4.dispose();
        }
        if (this._npc_5) {
            this._npc_5.dispose();
        }
        if (this._npc_6) {
            this._npc_6.dispose();
        }
        if (this._npc_7) {
            this._npc_7.dispose();
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 1) && QuestManager.isStepComplete(_quest.id, 2) == false) {
            DisplayUtil.removeForParent(this._mc_1);
            this._npc_3.visible = true;
            this._npc_6.visible = true;
            this._npc_7.visible = true;
            this._npc_3.buttonMode = true;
            this._npc_3.addEventListener(MouseEvent.CLICK, this.onNpc3);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DisplayUtil.removeForParent(this._mc_2);
            this._npc_4.visible = true;
            this._npc_4.buttonMode = true;
            this._npc_4.addEventListener(MouseEvent.CLICK, this.onNpc4);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (param1.questId == _quest.id && QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this._npc_5.visible = true;
            this._npc_5.buttonMode = true;
            this._npc_5.addEventListener(MouseEvent.CLICK, this.onNpc5);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    override public function processMapDispose():void {
        DisplayUtil.removeForParent(this._mc_1);
        DisplayUtil.removeForParent(this._mc_2);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        this.onComplete(null);
        this._npcDefinition = null;
        this._npcDefinition_2 = null;
        this._npcDefinition_3 = null;
        this._npcDefinition_4 = null;
        this._npcDefinition_5 = null;
        this._npcDefinition_6 = null;
        this._npcDefinition_7 = null;
        this._npc = null;
        this._npc_2 = null;
        this._npc_3 = null;
        this._npc_4 = null;
        this._npc_5 = null;
        this._npc_6 = null;
        this._npc_7 = null;
    }
}
}
