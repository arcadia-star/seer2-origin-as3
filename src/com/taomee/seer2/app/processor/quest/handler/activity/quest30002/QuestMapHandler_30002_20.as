package com.taomee.seer2.app.processor.quest.handler.activity.quest30002 {
import com.taomee.seer2.app.animationInteractive.Quest30002TurnTable;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.npc.NpcEvent;
import com.taomee.seer2.app.npc.NpcManager;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.constant.QuestStatus;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_30002_20 extends QuestMapHandler {


    private var _mc_1:MovieClip;

    private var _turnTable:Quest30002TurnTable;

    public function QuestMapHandler_30002_20(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.getQuest(_quest.id).status == QuestStatus.ACCEPTABLE) {
            this.initQuestStepAccept();
        }
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            this.initQuestStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            this.initQuestStep3();
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            this.initQuestStep1();
        }
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            this.initQuestStep5();
        }
    }

    private function initQuestStepAccept():void {
        DialogPanel.addCloseEventListener(this.onShowAnimation);
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var event:DialogCloseEvent = param1;
        var params:String = event.params;
        if (params == "30002_0") {
            DialogPanel.removeCloseEventListener(this.onShowAnimation);
            this._mc_1 = _processor.resLib.getMovieClip("mc_1");
            this._mc_1.x = 480;
            this._mc_1.y = 280;
            _map.front.addChild(this._mc_1);
            MovieClipUtil.playMc(this._mc_1, 2, 42, function ():void {
                NpcDialog.show(2, "伊娃博士", [[0, "一张空白的芯片。雷克斯的秘密？难道？雷克斯不是雷克的最终形态？"]], ["你是说，雷克斯还能进化？"], [function ():void {
                    MovieClipUtil.playMc(_mc_1, 43, _mc_1.totalFrames, function ():void {
                        DisplayUtil.removeForParent(_mc_1);
                        NpcDialog.show(2, "伊娃博士", [[0, "这个，我也不敢确定。也许这个空白芯片上还有其它的东西。听说水系<font color=\'#ffcc00\'>神谕祭司</font>有一种<font color=\'#ffcc00\'>显形水</font>。你去向她要一点来。"]], ["好的，我马上就去。"], [function ():void {
                            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                            QuestManager.accept(_quest.id);
                        }]);
                    });
                }]);
            });
        }
    }

    private function initQuestStep1():void {
        NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
    }

    private function onNpc(param1:NpcEvent):void {
        var _loc2_:XML = null;
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        param1.npcDefinition.resetFunctionalityData();
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            if (param1.npcDefinition.id == 2) {
                _loc2_ = <node type="quest" name="雷克斯的秘密" params="30002_1"/>;
                param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 3);
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            }
        } else if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (param1.npcDefinition.id == 2) {
                _loc2_ = <node type="quest" name="雷克斯的秘密" params="30002_2"/>;
                param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 3);
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            }
        } else if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            if (param1.npcDefinition.id == 2) {
                _loc2_ = <node type="quest" name="雷克斯的秘密" params="30002_3"/>;
                param1.npcDefinition.addFunctionalityUnitAt(_loc2_, 3);
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
            }
        }
    }

    private function onUnit(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if (event.content.params == "30002_1") {
            NpcDialog.show(2, "伊娃博士", [[0, "显形水带回来了，太好了！我们这就试试看！"]], ["好期待啊……"], [function ():void {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(_quest.id, 3);
            }]);
        } else if (event.content.params == "30002_2") {
            NpcDialog.show(2, "伊娃博士", [[0, "<font color=\'#ffcc00\'>显形水</font>带来了吗？听说水脉氏族的<font color=\'#ffcc00\'>神谕祭司</font>有这个东西。"]], ["好的，我马上就去。"]);
        } else if (event.content.params == "30002_3") {
            this.initQuestStep4();
        }
    }

    private function onStepComplete(param1:QuestEvent):void {
        var event:QuestEvent = param1;
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        if (QuestManager.isStepComplete(_quest.id, 4) && QuestManager.isStepComplete(_quest.id, 5) == false) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30002_1"), function ():void {
                initQuestStep5();
            });
        }
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("30002_0"), function ():void {
                initQuestStep4();
            }, false);
        }
    }

    private function initQuestStep5():void {
        NpcDialog.show(453, "光伊特", [[0, "嘻嘻，你还不笨嘛！飞翼之芯交给你了！它能让60级的雷克斯进化成雷克萨斯哦！"]], ["哇，谢谢~~"], [function ():void {
            NpcManager.addEventListener(NpcEvent.ACTOR_ARRIVE, onActorArriveShow);
            QuestManager.completeStep(_quest.id, 5);
        }]);
    }

    private function onActorArriveShow(param1:NpcEvent):void {
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        if (param1.npcDefinition.id == 2) {
            param1.npcDefinition.removeFunctionalityUnit("雷克斯的秘密");
        }
    }

    private function initQuestStep4():void {
        NpcDialog.show(2, "伊娃博士", [[0, "这个机灵鬼，不知道又打了什么主意！"]], ["管它呢，我们拭目以待！"], [function ():void {
            _turnTable = new Quest30002TurnTable();
            playGame();
        }]);
    }

    private function playGame():void {
        this._turnTable.setup("quest30002TurnTable", function (param1:Boolean):void {
            var isSuccess:Boolean = param1;
            if (isSuccess) {
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
                QuestManager.completeStep(_quest.id, 4);
            } else {
                NpcDialog.show(2, "伊娃博士", [[0, "看来，只有完成光伊特的条件，答案才能揭晓啊。"]], ["我再试一次。", "不玩了，下次再来！"], [function ():void {
                    playGame();
                }, function ():void {
                    initQuestStep1();
                }]);
            }
        });
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            ServerMessager.addMessage("向水脉氏族的神谕祭司要一瓶显形水。");
            this.initQuestStep1();
        }
    }

    private function initQuestStep3():void {
        this.initQuestStep1();
    }

    override public function processMapDispose():void {
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onActorArriveShow);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onUnit);
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_1 = null;
        NpcManager.removeEventListener(NpcEvent.ACTOR_ARRIVE, this.onNpc);
        this._turnTable = null;
    }
}
}
