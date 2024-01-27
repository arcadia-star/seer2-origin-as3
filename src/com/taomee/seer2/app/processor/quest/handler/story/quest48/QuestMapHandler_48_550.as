package com.taomee.seer2.app.processor.quest.handler.story.quest48 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.pet.MonsterManager;
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
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;

public class QuestMapHandler_48_550 extends QuestMapHandler {


    private var sceneMc1:MovieClip;

    private var stiffNpc:Mobile;

    public function QuestMapHandler_48_550(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        var _loc1_:XML = null;
        var _loc2_:AcceptableMark = null;
        super.processMapComplete();
        if (!QuestManager.isAccepted(_quest.id)) {
            MonsterManager.hideAllMonster();
            _loc1_ = <npc id="114" resId="114" name="蒂芙伦" dir="1" width="25" height="120" pos="421,464"
                          actorPos="465,522" path="">
                <dialog npcId="114" transport="1,300,400">
                    <branch id="default">
                        <node emotion="0"><![CDATA[琳达……哎……真的只能这样了吗……]]></node>
                        <reply action="close"><![CDATA[不知道她在嘀咕什么]]></reply>
                    </branch>
                </dialog>
                <eventHandler>
                    <click>
                        <HandlerOpenDialogPanel/>
                    </click>
                </eventHandler>
            </npc>;
            this.stiffNpc = MobileManager.createNpc(new NpcDefinition(_loc1_));
            this.stiffNpc.buttonMode = true;
            _loc2_ = new AcceptableMark();
            this.stiffNpc.addOverHeadMark(_loc2_);
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playNpcTalk);
        }
    }

    private function playNpcTalk(param1:DialogPanelEvent):void {
        var event:DialogPanelEvent = param1;
        if ((event.content as DialogPanelEventData).params == "Dia48_0") {
            DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playNpcTalk);
            MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("48_0"), 3, [[1, 0]], function ():void {
                NpcDialog.show(114, "蒂芙伦", [["2", "我相信，如果冰后和守护兽从沉眠中醒来，冰沁氏族会再次强大，族人们就可以回来了……"]], ["难怪冰沁氏族如此杳无人烟"], [function ():void {
                    NpcDialog.show(114, "蒂芙伦", [["2", "但是！萨伦帝国的坏蛋从来没有放弃！他们自打冰后还在的时候就一直偷偷寻找我族的某样东西！"]], ["直到现在还……"], [function ():void {
                        NpcDialog.show(114, "蒂芙伦", [["0", "所以……他们去神殿也好……被冰住也好……！"]], ["喂喂，你莫非是故意带他们过去的……"], [function ():void {
                            sceneMc1 = _processor.resLib.getMovieClip("AoAoMc");
                            _map.front.addChild(sceneMc1);
                            MovieClipUtil.playMc(sceneMc1, 1, sceneMc1.totalFrames, function ():void {
                                NpcDialog.show(114, "蒂芙伦", [["0", "这声音……难道是詹姆斯？去冰之谷看看！"]], ["去冰之谷！！"], [function ():void {
                                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                                    QuestManager.accept(_quest.id);
                                }]);
                            }, true);
                        }]);
                    }]);
                }]);
            });
        }
    }

    private function onAccept(param1:QuestEvent):void {
        if (param1.questId == _quest.id) {
            QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
            SceneManager.changeScene(SceneType.LOBBY, 540);
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.playNpcTalk);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        super.processMapDispose();
    }
}
}
