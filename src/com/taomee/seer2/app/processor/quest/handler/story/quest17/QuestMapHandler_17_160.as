package com.taomee.seer2.app.processor.quest.handler.story.quest17 {
import com.taomee.seer2.app.animationInteractive.Interactive_17;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogCloseEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;

public class QuestMapHandler_17_160 extends QuestMapHandler {


    private var _interactive_17:Interactive_17;

    public function QuestMapHandler_17_160(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isStepComplete(_quest.id, 3) && QuestManager.isStepComplete(_quest.id, 4) == false) {
            DialogPanel.addCloseEventListener(this.onShowAnimation);
        }
    }

    private function onShowAnimation(param1:DialogCloseEvent):void {
        var event:DialogCloseEvent = param1;
        if (event.params == "17_3") {
            NpcDialog.show(23, "神谕祭司", [[0, "夜明珠。它的粉末可以让一些已经消失的东西短暂地显出原形。"]], ["我这里就有！"], [function ():void {
                ItemManager.requestItemList(function ():void {
                    if (ItemManager.getItemQuantityByReferenceId(400009) >= 1) {
                        DialogPanel.removeCloseEventListener(onShowAnimation);
                        _interactive_17 = new Interactive_17();
                        _interactive_17.setup("interactive_17", function (param1:Boolean):void {
                            var isSuccess:Boolean = param1;
                            if (isSuccess) {
                                NpcDialog.show(11, "多罗", [[4, "哇，出来了，真的出来了！！队长，我们赶快把这封信拿给神目酋长吧！"]], ["（去权力之帐找神目酋长吧）"], [function ():void {
                                    QuestManager.completeStep(_quest.id, 4);
                                }]);
                            }
                        });
                    } else {
                        NpcDialog.show(23, "神谕祭司", [[0, "我还需要夜明珠，不然无法还原信件。"]], ["（去找夜明珠吧）"]);
                    }
                });
            }]);
        }
    }

    override public function processMapDispose():void {
        DialogPanel.removeCloseEventListener(this.onShowAnimation);
        if (this._interactive_17) {
            this._interactive_17.dispose();
            this._interactive_17 = null;
        }
    }
}
}
