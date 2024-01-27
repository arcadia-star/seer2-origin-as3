package com.taomee.seer2.app.processor.quest.handler.main.quest93 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.rightToolbar.RightToolbarConter;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.constant.MobileType;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_93_3830 extends QuestMapHandler {


    private var _mc2:MovieClip;

    private var _mc3:MovieClip;

    private var _npc1017:Mobile;

    private var _npc1032:Mobile;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_93_3830(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._npc1017 = MobileManager.getMobile(1017, MobileType.NPC);
        this._npc1032 = MobileManager.getMobile(1032, MobileType.NPC);
        if (QuestManager.isAccepted(93) && QuestManager.isComplete(questID) == false) {
            RightToolbarConter.instance.hide();
            if (!QuestManager.isStepComplete(questID, 1)) {
                QuestManager.completeStep(questID, 1);
                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.initStep2);
            } else if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                this.initStep2(null);
            } else if (QuestManager.isStepComplete(questID, 2) && !QuestManager.isStepComplete(questID, 3)) {
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (DialogPanelEventData(evt.content).params == "93_3") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            NpcDialog.show(1017, "瓦利大叔", [[0, ActorManager.actorInfo.nick + "，他马上就会来的。"]], [" 我们等等吧。"], [function ():void {
                _npc1017.visible = false;
                ActorManager.getActor().hide();
                ActorManager.getActor().blockFollowingPet = true;
                ActorManager.getActor().blockNoNo = true;
                _npc1032.visible = false;
                _mc2 = _processor.resLib.getMovieClip("Mc93_1");
                _map.front.addChild(_mc2);
                _mc2.gotoAndStop(1);
                MovieClipUtil.playMc(_mc2, 1, _mc2.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc2);
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("93_0"), function ():void {
                        _mc3 = _processor.resLib.getMovieClip("Mc93_2");
                        _map.front.addChild(_mc3);
                        _mc3.gotoAndStop(1);
                        MovieClipUtil.playMc(_mc3, 1, _mc3.totalFrames, function ():void {
                            DisplayObjectUtil.removeFromParent(_mc3);
                            ActorManager.getActor().show();
                            ActorManager.getActor().blockFollowingPet = false;
                            ActorManager.getActor().blockNoNo = false;
                            _npc1032.visible = true;
                            _npc1017.visible = true;
                            NpcDialog.show(1032, "梵拉", [[0, "小赛尔，我还需要你的帮助，要复兴超能氏族必须召唤我族魂兽。 "]], [" 不愧是通灵师，魂兽都能召唤！"], [function ():void {
                                NpcDialog.show(1032, "梵拉", [[0, "这需要更多地能量碎片来填补能量水晶的缺口。 "]], [" 包在我身上了！"], [function ():void {
                                    QuestManager.completeStep(questID, 3);
                                    QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                                }]);
                            }]);
                        }, true);
                    });
                }, true);
            }]);
        }
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        this._npc1017.visible = true;
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep2(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.initStep2);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 870;
        this._mouseHint.y = 334;
        _map.front.addChild(this._mouseHint);
    }

    override public function processMapDispose():void {
        if (this._mouseHint != null) {
            DisplayObjectUtil.removeFromParent(this._mouseHint);
        }
        if (this._npc1017) {
            this._npc1017 = null;
        }
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        super.processMapDispose();
    }
}
}
