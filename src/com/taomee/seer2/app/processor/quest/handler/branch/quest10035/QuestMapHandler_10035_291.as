package com.taomee.seer2.app.processor.quest.handler.branch.quest10035 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.core.quest.events.QuestEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.display.MovieClip;
import flash.events.MouseEvent;

import org.taomee.utils.DisplayUtil;

public class QuestMapHandler_10035_291 extends QuestMapHandler {

    private static var _fightStatic:uint;

    public static var count:uint = 0;


    private var _npc:MovieClip;

    public function QuestMapHandler_10035_291(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        var _loc1_:int = 0;
        super.processMapComplete();
        if (QuestManager.isAccepted(_quest.id) && QuestManager.isStepComplete(_quest.id, 1) == false) {
            if (SceneManager.prevSceneType == SceneType.ARENA && _fightStatic == 1) {
                _fightStatic = 0;
                _loc1_ = int(_quest.getStepData(1, 0));
                if (_loc1_ < 5) {
                    ServerMessager.addMessage("还差" + (5 - _quest.getStepData(1, 0)) + "次战斗");
                } else {
                    ServerMessager.addMessage("战斗完成");
                }
            }
            this.initNpc();
        }
    }

    private function initNpc():void {
        this._npc = _processor.resLib.getMovieClip("npc");
        _map.front.addChild(this._npc);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (_quest.getStepData(1, 0) < 5) {
            NpcDialog.show(414, "尤尼大哥", [[0, "只有不断的磨练自己我想我才能保护我的兄弟姐妹！喂！怎么样你愿意做那个训练我的人吗？"]], ["来对战吧！", "我一会再来找你。"], [function ():void {
                _fightStatic = 1;
                FightManager.startFightWithWild(10);
                var _loc1_:* = _quest.getStepData(1, 0);
                _loc1_++;
                _quest.setStepData(1, 0, _loc1_);
                QuestManager.addEventListener(QuestEvent.STEP_UPDATE_BUFFER, onUpdateStepBufferStep);
                QuestManager.setStepBufferServer(_quest.id, 1);
            }]);
        } else {
            NpcDialog.show(414, "尤尼大哥", [[0, "每个父母总是望子成龙、望女成凤！希望兄弟们不要怪我太苛刻……只希望他们能有出息……"]], ["父母好伟大!"], [function ():void {
                QuestManager.completeStep(_quest.id, 1);
                DisplayUtil.removeForParent(_npc);
            }]);
        }
    }

    private function onUpdateStepBufferStep(param1:QuestEvent):void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep);
    }

    override public function processMapDispose():void {
        QuestManager.removeEventListener(QuestEvent.STEP_UPDATE_BUFFER, this.onUpdateStepBufferStep);
        DisplayUtil.removeForParent(this._npc);
        this._npc = null;
    }
}
}
