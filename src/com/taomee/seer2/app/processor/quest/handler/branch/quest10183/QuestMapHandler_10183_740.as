package com.taomee.seer2.app.processor.quest.handler.branch.quest10183 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10183_740 extends QuestMapHandler {


    private var _npc1:MovieClip;

    private var _npc2:MovieClip;

    private var _npc3:MovieClip;

    private const POS:Array = [[378, 223], [509, 135], [509, 135]];

    public function QuestMapHandler_10183_740(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 1) && !QuestManager.isStepComplete(_quest.id, 2)) {
            this.handle1();
        }
        if (QuestManager.isStepComplete(_quest.id, 2) && !QuestManager.isStepComplete(_quest.id, 3)) {
            this.handle2();
        }
    }

    private function handle1():void {
        this._npc1 = _processor.resLib.getMovieClip("npc");
        this._npc1.x = this.POS[0][0];
        this._npc1.y = this.POS[0][1];
        this._npc1["mark"].visible = true;
        this._npc1.buttonMode = true;
        _map.content.addChild(this._npc1);
        this._npc1.addEventListener(MouseEvent.CLICK, this.onNpc1Click);
    }

    private function onNpc1Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        DisplayUtil.removeForParent(this._npc1);
        this._npc1.removeEventListener(MouseEvent.CLICK, this.onNpc1Click);
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10183_1"), function ():void {
            _npc2 = _processor.resLib.getMovieClip("npc1");
            _npc2.x = POS[1][0];
            _npc2.y = POS[1][1];
            _npc2["mark"].visible = true;
            _npc2.buttonMode = true;
            _map.content.addChild(_npc2);
            _npc2.addEventListener(MouseEvent.CLICK, onNpc2Click);
        }, true, true, 2);
    }

    private function onNpc2Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(575, "神秘女子？？？", [[0, "你终于出现了，我已经等了好久好久了。"]], ["你在等我？"], [function ():void {
            NpcDialog.show(575, "神秘女子？？？", [[0, "是的，你就是被选中的赛尔，我宿命中的主人。"]], ["主人？这太突然了吧？"], [function ():void {
                NpcDialog.show(575, "神秘女子？？？", [[0, "只有被选中的赛尔，才能再次唤醒尘封已久的我。"]], ["真的吗？那你到底是谁？"], [function ():void {
                    MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("10183_2"), function ():void {
                        QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepTwoComplete);
                        QuestManager.completeStep(_quest.id, 2);
                    }, true, true, 2);
                }]);
            }]);
        }]);
    }

    private function onStepTwoComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoComplete);
        DisplayUtil.removeForParent(this._npc2);
        this.handle2();
    }

    private function handle2():void {
        this._npc3 = _processor.resLib.getMovieClip("npc2");
        this._npc3.x = this.POS[2][0];
        this._npc3.y = this.POS[2][1];
        this._npc3["mark"].visible = true;
        this._npc3.buttonMode = true;
        _map.content.addChild(this._npc3);
        this._npc3.addEventListener(MouseEvent.CLICK, this.onNpc3Click);
    }

    private function onNpc3Click(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(400, "赛尔", [[0, "难道你就是那只被我们祖先所留下来的精灵吗？"]], ["……"], [function ():void {
            NpcDialog.show(575, "神秘女子？？？", [[0, "是的，这是我意念的化身，你已经成功解开了我的封印，但是你要获得我，就必须通过我的考核。"]], ["那是怎样的考核呢？"], [function ():void {
                NpcDialog.show(575, "神秘女子？？？", [[0, "你手上的图腾纹身就是关键所在，它是智慧与纯洁象征，只有拥有一颗纯洁心灵的赛尔才有资格成为我的主人。"]], ["咦？我手上怎么有一个图案？"], [function ():void {
                    NpcDialog.show(575, "神秘女子？？？", [[0, "现在这个图案才显示了一点点，还有8个图腾没有显示出来，你必须集齐8个图腾后才能真正的成为我的主人。"]], ["好的，我一定会集齐所有的图腾。"], [function ():void {
                        QuestManager.addEventListener(QuestEvent.COMPLETE, onComplete);
                        QuestManager.completeStep(_quest.id, 3);
                    }]);
                }]);
            }]);
        }]);
    }

    private function onComplete(param1:QuestEvent):void {
        this.processMapDispose();
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        ModuleManager.showModule(URLUtil.getAppModule("HadesPetPanel"), "正在打开面板...");
    }

    override public function processMapDispose():void {
        if (this._npc1) {
            this._npc1.removeEventListener(MouseEvent.CLICK, this.onNpc1Click);
            DisplayUtil.removeForParent(this._npc1);
        }
        if (this._npc2) {
            this._npc2.removeEventListener(MouseEvent.CLICK, this.onNpc2Click);
            DisplayUtil.removeForParent(this._npc2);
        }
        if (this._npc3) {
            this._npc3.removeEventListener(MouseEvent.CLICK, this.onNpc3Click);
            DisplayUtil.removeForParent(this._npc3);
        }
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepTwoComplete);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        super.processMapDispose();
    }
}
}
