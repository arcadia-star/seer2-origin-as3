package com.taomee.seer2.app.processor.quest.handler.main.quest92 {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.component.MouseClickHintSprite;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.quest.mark.AcceptableMark;
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
import flash.events.MouseEvent;
import flash.geom.Point;

public class QuestMapHandler_92_3828 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _npc1016:Mobile;

    private var _npc:Mobile;

    private var NPCID:int = 1032;

    private var _mouseHint:MouseClickHintSprite;

    public function QuestMapHandler_92_3828(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.Quest92Start();
    }

    private function onAccepted(param1:QuestEvent):void {
        this.initStep1();
    }

    private function Quest92Start():void {
        this._npc1016 = MobileManager.getMobile(1016, MobileType.NPC);
        RightToolbarConter.instance.hide();
        ActorManager.getActor().hide();
        ActorManager.getActor().blockFollowingPet = true;
        ActorManager.getActor().blockNoNo = true;
        if (!QuestManager.isAccepted(questID)) {
            this.initAccept();
        }
        if (QuestManager.isAccepted(questID) && QuestManager.isComplete(questID) == false) {
            if (QuestManager.isStepComplete(questID, 1) == false) {
                this.initStep1();
            } else if (QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
                this.initStep2(null);
            } else if (QuestManager.isStepComplete(questID, 3) && !QuestManager.isStepComplete(questID, 4)) {
                RightToolbarConter.instance.show();
                ActorManager.getActor().show();
                ActorManager.getActor().blockFollowingPet = false;
                ActorManager.getActor().blockNoNo = false;
                DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            }
        }
        if (QuestManager.isComplete(questID)) {
            this.onComplete(null);
        }
    }

    private function initAccept():void {
        QuestManager.addEventListener(QuestEvent.ACCEPT, this.onAccept);
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == 92) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            this.initStep1();
        }
    }

    private function onCustomReply(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if (DialogPanelEventData(evt.content).params == "92_4") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onCustomReply);
            if (this._npc != null) {
                MobileManager.removeMobile(this._npc, MobileType.NPC);
            }
            RightToolbarConter.instance.hide();
            ActorManager.getActor().hide();
            ActorManager.getActor().blockFollowingPet = true;
            ActorManager.getActor().blockNoNo = true;
            NpcDialog.show(1016, "里格", [[0, ActorManager.actorInfo.nick + "，不要相信你在穹顶大厅听到的任何事。那里充斥着谎言和骗局。"]], ["你们把我搞糊涂了！到底谁在说谎？"], [function ():void {
                _npc1016.visible = false;
                _mc2 = _processor.resLib.getMovieClip("Mc92_3");
                _map.front.addChild(_mc2);
                _mc2.gotoAndStop(1);
                MovieClipUtil.playMc(_mc2, 1, _mc2.totalFrames, function ():void {
                    DisplayObjectUtil.removeFromParent(_mc2);
                    if (_npc1016 != null) {
                        _npc1016.visible = true;
                    }
                    createNpc();
                }, true);
            }]);
        }
    }

    private function createNpc():void {
        this._npc = new Mobile();
        this._npc.setPostion(new Point(672, 460));
        this._npc.label = "梵拉";
        this._npc.resourceUrl = URLUtil.getNpcSwf(this.NPCID);
        this._npc.buttonMode = true;
        MobileManager.addMobile(this._npc, MobileType.NPC);
        var _loc1_:AcceptableMark = new AcceptableMark();
        this._npc.addChild(_loc1_);
        _loc1_.y = -130;
        this._npc.addEventListener(MouseEvent.CLICK, this.dialogShow);
    }

    private function dialogShow(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(1032, "梵拉", [[0, ActorManager.actorInfo.nick + "，我能解答你的疑惑。不过在此之前，还需要你有耐心等待一下，时间会证明一切的。"]], ["（你不是什么都没说嘛……）"], [function ():void {
            NpcDialog.show(1032, "梵拉", [[0, "当时机成熟的时候，来能量之源找我，在那里你会得到答案的。 "]], ["（是存放能量球的地方嘛？）"], [function ():void {
                if (_npc != null) {
                    MobileManager.removeMobile(_npc, MobileType.NPC);
                }
                QuestManager.completeStep(questID, 4);
                QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
            }]);
        }]);
    }

    private function initStep1():void {
        NpcDialog.show(400, "赛尔", [[0, "@#￥%……&*（告诉里格队长事情的来龙去脉）……"]], [" 能量碎片还需要放在地球一段时间，他们正在进行研究"], [function ():void {
            NpcDialog.show(1016, "里格", [[0, "是这样啊，真是太可惜了。你不在这段时间里，族长大人受到萨伦的蛊惑，正在大肆追捕反萨联盟的成员。"]], ["你们大家都没事吧！"], [function ():void {
                NpcDialog.show(1016, "里格", [[0, "我们只能隐藏在暗处，低调行事。勇敢的" + ActorManager.actorInfo.nick + "，既然你回来了，能不能帮我们一个忙？"]], ["义不容辞，我也是萨伦的反对者。"], [function ():void {
                    NpcDialog.show(1016, "里格", [[0, "我们需要进行最后一次尝试，劝说族长大人醒悟过来。" + ActorManager.actorInfo.nick + "，你不是我们的族人，容易进入穹顶大厅见到族长。请替我们转告族长，梵拉想要与他单独见面，他应该会明白的。"]], ["梵拉是谁？"], [function ():void {
                        NpcDialog.show(1016, "里格", [[0, "梵拉是联盟的元老，为了你的安全，还是少知道为好。去找瓦利吧，他能帮你们进入穹顶大厅。"]], ["那好吧，我这就去。"], [function ():void {
                            _npc1016.visible = false;
                            ActorManager.getActor().show();
                            ActorManager.getActor().blockFollowingPet = false;
                            ActorManager.getActor().blockNoNo = false;
                            _mc1 = _processor.resLib.getMovieClip("Mc92_0");
                            _map.front.addChild(_mc1);
                            _mc1.gotoAndStop(1);
                            MovieClipUtil.playMc(_mc1, 1, _mc1.totalFrames, function ():void {
                                DisplayObjectUtil.removeFromParent(_mc1);
                                _npc1016.visible = true;
                                QuestManager.completeStep(questID, 1);
                                QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, initStep2);
                            }, true);
                        }]);
                    }]);
                }]);
            }]);
        }]);
    }

    private function initStep2(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.initStep2);
        this._mouseHint = new MouseClickHintSprite();
        this._mouseHint.x = 800;
        this._mouseHint.y = 250;
        _map.front.addChild(this._mouseHint);
    }

    private function onClickTeleport(param1:MouseEvent):void {
        SceneManager.changeScene(SceneType.LOBBY, 3830);
    }

    private function onComplete(param1:QuestEvent):void {
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        RightToolbarConter.instance.show();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    override public function processMapDispose():void {
        RightToolbarConter.instance.show();
        ActorManager.getActor().show();
        ActorManager.getActor().blockFollowingPet = false;
        ActorManager.getActor().blockNoNo = false;
        if (this._npc != null) {
            MobileManager.removeMobile(this._npc, MobileType.NPC);
        }
        super.processMapDispose();
    }
}
}
