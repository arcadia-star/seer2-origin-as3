package com.taomee.seer2.app.processor.quest.handler.main.quest9 {
import com.taomee.seer2.app.arena.data.FightResultInfo;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.pet.data.PetInfoManager;
import com.taomee.seer2.app.pet.events.PetInfoEvent;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.quest.events.QuestEvent;

import flash.display.DisplayObject;
import flash.display.MovieClip;

public class QuestMapHandler_9_170 extends QuestMapHandler {


    private var _stepAnimation:MovieClip;

    private var _resultInfo:FightResultInfo;

    public function QuestMapHandler_9_170(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        super.processMapComplete();
        this._stepAnimation = _map.front["quest_9"];
        if (Boolean(_quest.isStepCompete(6)) && !_quest.isStepCompete(7)) {
            PetInfoManager.addEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
            this.processStep7();
        }
    }

    private function processStep7():void {
        NpcDialog.show(25, "莱斯", [[4, "神谕祭祀有命！任何人等不准靠近水源！"]], ["可是她会有危险啊！"], [function ():void {
            NpcDialog.show(25, "莱斯", [[4, "祭祀说无论发生任何事情听到任何声音都不能违背命令！！！！快走开！！！"]], [" 这里一定有蹊跷！先走吧！"], [function ():void {
                NpcDialog.show(26, "莱克", [[2, "不准靠近水源！违反者驱逐水脉氏族！！！走开！！"]], ["这里到底发生了什么？"], [function ():void {
                    NpcDialog.show(26, "莱克", [[2, "走开！！！！"]], ["这可怎么办？先走吧！"], [function ():void {
                        MovieClipUtil.getChildList(_stepAnimation, 2, [0], function (param1:Vector.<DisplayObject>):void {
                            var children:Vector.<DisplayObject> = param1;
                            var mc:* = children[0] as MovieClip;
                            MovieClipUtil.playMc(mc, 1, mc.totalFrames, function ():void {
                                _stepAnimation.gotoAndStop(1);
                                QuestManager.addEventListener(QuestEvent.COMPLETE, onQuestComplete);
                                QuestManager.completeStep(_quest.id, 7);
                            }, true);
                        });
                    }]);
                }]);
            }]);
        }]);
    }

    private function onQuestComplete(param1:QuestEvent):void {
        ModuleManager.addEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
    }

    private function onPetLevelUp(param1:PetInfoEvent):void {
        this._resultInfo = param1.content.resultInfo;
    }

    private function teacherPlayerHandler(param1:ModuleEvent):void {
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
    }

    override public function processMapDispose():void {
        PetInfoManager.removeEventListener(PetInfoEvent.PET_LEVEL_UP, this.onPetLevelUp);
        ModuleManager.removeEventListener("FightResultPanel", ModuleEvent.HIDE, this.teacherPlayerHandler);
        QuestManager.removeEventListener(QuestEvent.COMPLETE, this.onQuestComplete);
        super.processMapDispose();
    }
}
}
