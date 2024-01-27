package com.taomee.seer2.app.processor.quest.handler.main.quest35 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.ui.ButtonPanelData;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.utils.NpcUtil;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_35_240 extends QuestMapHandler {

    private static var _fightStatus:int = 0;


    private var _mc_0:MovieClip;

    private var _mc_1:MovieClip;

    public function QuestMapHandler_35_240(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        if (SceneManager.prevSceneType == SceneType.ARENA && QuestManager.isCanAccepted(_quest.id) && _fightStatus == 1) {
            _fightStatus = 0;
            this.fightComplete();
            return;
        }
        if (QuestManager.isCanAccepted(_quest.id)) {
            DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        }
    }

    private function onStep(param1:DialogPanelEvent):void {
        if ((param1.content as DialogPanelEventData).params == "35_0") {
            this.processStep0();
        }
    }

    private function processStep0():void {
        this._mc_0 = _processor.resLib.getMovieClip("mc_0");
        _map.front.addChild(this._mc_0);
        MovieClipUtil.playMc(this._mc_0, 1, this._mc_0.totalFrames, function ():void {
            NpcDialog.show(94, "老国王", [[0, "洛克……洛克！！收手吧！族民们的生活比一切都重要！"]], ["老……老酋长……（鬼啊！）"], [function ():void {
                NpcDialog.show(32, "洛克", [[4, "现在才跟我说这些？小时候你从没有正眼看过我！我哪里比不过巴尔卡了？我恨你！我要证明我自己！你走开！！！！！！！来人！赶走！"]], ["可恶！！！"], [function ():void {
                    DisplayUtil.removeForParent(_mc_0);
                    _mc_1 = _processor.resLib.getMovieClip("mc_1");
                    _map.front.addChild(_mc_1);
                    MovieClipUtil.playMc(_mc_1, 1, _mc_1.totalFrames, function ():void {
                        fightGo();
                    }, true);
                }]);
            }]);
        }, true);
    }

    private function fightGo():void {
        var btnData:ButtonPanelData = new ButtonPanelData();
        btnData.catchEnabled = false;
        _fightStatus = 1;
        FightManager.startFightBinaryWild(67, null, function ():void {
            DisplayUtil.removeForParent(_mc_1);
        }, btnData);
    }

    private function fightComplete():void {
        NpcDialog.show(NpcUtil.getSeerNpcId(), "我", [[0, "气死我了！！可是他们怎么会一下子变得这么强？有古怪啊！不管了！！先去劝巴尔卡吧！"]], ["残骸通道找巴尔卡"], [function ():void {
            QuestManager.addEventListener(QuestEvent.ACCEPT, onAccept);
            QuestManager.accept(_quest.id);
        }]);
    }

    private function onAccept(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        SceneManager.changeScene(SceneType.LOBBY, 192);
    }

    override public function processMapDispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_REPLY_CLICK, this.onStep);
        QuestManager.removeEventListener(QuestEvent.ACCEPT, this.onAccept);
        DisplayUtil.removeForParent(this._mc_0);
        DisplayUtil.removeForParent(this._mc_1);
        this._mc_0 = null;
        this._mc_1 = null;
    }
}
}
