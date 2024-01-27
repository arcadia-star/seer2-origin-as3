package com.taomee.seer2.app.processor.quest.handler.main.quest80 {
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
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

public class QuestMapHandler_80_80333 extends QuestMapHandler {


    private var _mc1:MovieClip;

    private var _mc2:MovieClip;

    private var _npc:Mobile;

    private var _npc1:Mobile;

    private var _index:uint;

    private var _ground_mc:MovieClip;

    public function QuestMapHandler_80_80333(param1:QuestProcessor) {
        super(param1);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._ground_mc = _map.ground["mapRes"] as MovieClip;
        if (QuestManager.isAccepted(questID) && QuestManager.isStepComplete(questID, 1) && !QuestManager.isStepComplete(questID, 2)) {
            MobileManager.hideMoileVec(MobileType.NPC);
            this.initStep1();
        }
    }

    private function onComplete(param1:QuestEvent):void {
        this._mc1 = null;
        this._mc2 = null;
        MobileManager.showMoileVec(MobileType.NPC);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onComplete);
        SceneManager.changeScene(SceneType.LOBBY, 70);
    }

    private function initStep1():void {
        this._mc1 = _processor.resLib.getMovieClip("Mc80_0");
        _map.front.addChild(this._mc1);
        this._mc1.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc1, 1, this._mc1.totalFrames, function ():void {
            NpcDialog.show(821, "提尔", [[3, "小赛尔，你们……终于来了……"]], ["发生了什么事！"], [function ():void {
                NpcDialog.show(821, "提尔", [[3, "你们走了以后……萨伦的亲信追了过来，打伤了我……"]], [" ！！然后呢？"], [function ():void {
                    DisplayObjectUtil.removeFromParent(_mc1);
                    initContinue();
                }]);
            }]);
        }, true);
    }

    private function initContinue():void {
        this._mc2 = _processor.resLib.getMovieClip("Mc80_1");
        _map.front.addChild(this._mc2);
        this._mc2.gotoAndStop(1);
        MovieClipUtil.playMc(this._mc2, 1, this._mc2.totalFrames, function ():void {
            NpcDialog.show(11, "多罗", [[0, "怎么、怎么出现了两个提尔？"]], ["好奇怪"], [function ():void {
                NpcDialog.show(821, "提尔", [[2, "他是假的！刚才并没有什么萨伦亲信潜入，唯一的潜入者就是他！我的光剑一直不离身，但是他的光剑在哪里！"]], [" 对啊……"], [function ():void {
                    NpcDialog.show(821, "提尔", [[3, "胡说！我一直守在这里没有离开！他却是半路出现的！哼，恐怕他就是萨伦亲信假扮的吧！"]], ["  好像也有道理……"], [function ():void {
                        NpcDialog.show(10, "巴蒂", [[3, "啊啊啊，到底哪个才是真的啊！"]], ["  （总觉得哪里不对，试试离开这里）"], [function ():void {
                            DisplayObjectUtil.removeFromParent(_mc2);
                            leave();
                        }]);
                    }]);
                }]);
            }]);
        }, true);
    }

    private function leave():void {
        MovieClipUtil.playFullScreen(URLUtil.getQuestFullScreenAnimation("80_1"), function ():void {
            QuestManager.addEventListener(QuestEvent.STEP_COMPLETE, onStepComplete);
            QuestManager.completeStep(questID, 2);
        });
    }

    private function onStepComplete(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_COMPLETE, this.onStepComplete);
        SceneManager.changeScene(SceneType.LOBBY, 3828);
    }

    override public function processMapDispose():void {
        this._npc = null;
        super.processMapDispose();
    }
}
}
