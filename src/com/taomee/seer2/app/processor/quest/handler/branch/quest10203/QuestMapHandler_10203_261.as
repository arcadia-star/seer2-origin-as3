package com.taomee.seer2.app.processor.quest.handler.branch.quest10203 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_10203_261 extends QuestMapHandler {


    private var _fireMc:MovieClip;

    public function QuestMapHandler_10203_261(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this.addFire();
        if (QuestManager.isStepComplete(10203, 2) == false) {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        }
    }

    private function addFire():void {
        _processor.showMouseHintAt(260, 370);
        this._fireMc = _map.content["fireMC"];
        this._fireMc.addEventListener(MouseEvent.CLICK, this.onFire);
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        this.step3();
    }

    private function step3():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10203_2"), function ():void {
            NpcDialog.show(400, "小赛尔", [[0, "啊……那是传说中的器灵？"]], ["啊？"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "看样子是的，难道凯萨也要超进化了？"]], ["他们现在去了哪里？"], [function ():void {
                    NpcDialog.show(400, "小赛尔", [[0, "凯萨到底怎么样了？骤雨他们又一次潜逃了？"]], ["一切无从得知"], [function ():void {
                        QuestManager.completeStep(10203, 3);
                    }]);
                }]);
            }]);
        });
    }

    private function onFire(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        _processor.hideMouseClickHint();
        this._fireMc.removeEventListener(MouseEvent.CLICK, this.onFire);
        if (QuestManager.isStepComplete(10203, 2) == false) {
            NpcDialog.show(6, "克拉克", [[0, "不好，这个微弱的小火苗可能是凯萨留下的，难道……"]], ["不会吧，凯萨出事了？"], [function ():void {
                NpcDialog.show(6, "克拉克", [[0, "不好猜测，难道是骤雨出现了？"]], ["骤雨？"], [function ():void {
                    NpcDialog.show(6, "克拉克", [[0, "是的，幻灵骑士团第三个成员——幻齿骤雨！"]], ["啊?"], [function ():void {
                        QuestManager.completeStep(10203, 2);
                    }]);
                }]);
            }]);
        } else {
            this.step3();
        }
    }

    override public function processMapDispose():void {
        this._fireMc.removeEventListener(MouseEvent.CLICK, this.onFire);
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        super.processMapDispose();
    }
}
}
