package com.taomee.seer2.app.processor.quest.handler.story.quest36 {
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.entity.Teleport;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.entity.AnimateElementManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

public class QuestMapHandler_36_660 extends QuestMapHandler {


    private var _teleport:Teleport;

    public function QuestMapHandler_36_660(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._teleport = AnimateElementManager.getElement(4) as Teleport;
        if (QuestManager.isCanAccepted(_quest.id)) {
            this._teleport.visible = false;
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && QuestManager.isStepComplete(_quest.id, 3) == false) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "36_0") {
            this.processStep0();
        }
    }

    private function processStep0():void {
        MovieClipUtil.playNpcTalkNew(URLUtil.getQuestNpcTalkAnimation("36_0"), 3, [[1, 0]], function ():void {
            NpcDialog.show(83, "萨伯尔兵团长", [[2, "这个时候，总会产生各种暴乱。说实话，我也很困扰。"]], ["怎么说？"], [function ():void {
                NpcDialog.show(83, "萨伯尔兵团长", [[2, "我的职责是维护飞翼氏族的秩序，对于暴乱的民众，必要的时候我只能选择武力镇压。"]], ["哎，真的只能用武力了吗？"], [function ():void {
                    NpcDialog.show(83, "萨伯尔兵团长", [[2, "然而，那笔巨额的税收也的确超过了部分民众的承受范围。私下里，我也非常不喜欢这种不人道的方式！"]], ["嗯，嗯……"], [function ():void {
                        NpcDialog.show(83, "萨伯尔兵团长", [[1, "所以，作为星际使者！！我想你的身份可以出席这个场合，并且能够妥善处理一些问题！！"]], ["……果然，是要拉我下水啊……"], [function ():void {
                            NpcDialog.show(83, "萨伯尔兵团长", [[1, "一切就拜托了！我会为你打开羽冠之岛的大门的！！"]], ["好吧，看在新场景的份上……"], [function ():void {
                                MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("36_0"), function ():void {
                                    if (_teleport) {
                                        _teleport.visible = true;
                                    }
                                    QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
                                    QuestManager.accept(_quest.id);
                                }, false, false, 2);
                            }]);
                        }]);
                    }]);
                }]);
            }]);
        });
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        SceneManager.changeScene(SceneType.LOBBY, 730);
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
    }
}
}
