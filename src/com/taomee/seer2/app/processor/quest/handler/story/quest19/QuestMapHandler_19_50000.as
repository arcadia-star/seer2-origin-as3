package com.taomee.seer2.app.processor.quest.handler.story.quest19 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_19_50000 extends QuestMapHandler {


    private var _letterMC:MovieClip;

    private var _npc:MovieClip;

    public function QuestMapHandler_19_50000(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (QuestManager.isCanAccepted(_quest.id)) {
            this._letterMC = _processor.resLib.getMovieClip("mc_2");
            this._npc = _processor.resLib.getMovieClip("mc_1");
            _map.ground.addChild(this._letterMC);
            _map.front.addChild(this._npc);
            this._npc.buttonMode = true;
            this._npc.addEventListener(MouseEvent.CLICK, this.onNpcClick);
        }
    }

    private function onNpcClick(param1:MouseEvent):void {
        var evt:MouseEvent = param1;
        NpcDialog.show(442, "冰湖豚", [[0, "（羞……）"]], ["（……）"]);
        NpcDialog.addFunctionUnit("", "冰冷的阴谋", "", function ():void {
            NpcDialog.show(442, "冰湖豚", [[0, "（露出了想要逃走的样子）"]], ["喂，那封信是你带来的吧？"], [function ():void {
                NpcDialog.show(442, "冰湖豚", [[0, "嗯……恩人把我救出来后……我为了报答它……就一直为它带信……"]], ["恩人？说的是目之魂吧？"], [function ():void {
                    NpcDialog.show(442, "冰湖豚", [[0, "（又一次露出了想要逃走的样子）"]], ["你得告诉我们信上写什么！我们看不懂……"], [function ():void {
                        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("19_0"), function ():void {
                            NpcDialog.show(442, "冰湖豚", [[2, "爸爸……妈妈……恩人真的会救它们……"]], [" 跟我们一起来吧！去救你的爸爸妈妈！"], [function ():void {
                                NpcDialog.show(442, "冰湖豚", [[2, "嗯……嗯！"]], ["（去冰之谷！）"], [function ():void {
                                    QuestManager.accept(_quest.id);
                                    disposeNPC();
                                }]);
                            }]);
                        });
                    }]);
                }]);
            }]);
        });
    }

    private function disposeNPC():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onNpcClick);
            DisplayObjectUtil.removeFromParent(this._npc);
            DisplayObjectUtil.removeFromParent(this._letterMC);
            this._letterMC = null;
            this._npc = null;
        }
    }

    override public function processMapDispose():void {
        this.disposeNPC();
        super.processMapDispose();
    }
}
}
