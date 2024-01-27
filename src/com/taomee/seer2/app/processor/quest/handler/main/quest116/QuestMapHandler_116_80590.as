package com.taomee.seer2.app.processor.quest.handler.main.quest116 {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.processor.quest.QuestProcessor;
import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
import com.taomee.seer2.app.quest.QuestManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.scene.events.SceneEvent;

import flash.display.MovieClip;
import flash.events.MouseEvent;

public class QuestMapHandler_116_80590 extends QuestMapHandler {


    private var isStartFight:Boolean = false;

    private var _fightId:int = 1882;

    public function QuestMapHandler_116_80590(param1:QuestProcessor) {
        super(param1);
    }

    override public function processMapComplete():void {
        SceneManager.active.mapModel.content["boss"].visible = false;
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        if (this.isStartFight) {
            return;
        }
        this.initStep2();
    }

    private function initStep2():void {
        NpcDialog.showDialogsByText("quest/dialog/116/3.json", function ():void {
            fight();
        }, null);
    }

    private function fight():void {
        SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE, this.onFightOver);
        this.isStartFight = true;
        FightManager.startFightWithWild(this._fightId);
    }

    private function onFightOver(param1:* = null):void {
        var dialog0:Array = null;
        var dialog1:Array = null;
        var e:* = param1;
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (this._fightId == FightManager.currentFightRecord.initData.positionIndex) {
                this.isStartFight = false;
                dialog0 = [[400, "小赛尔", [[0, "收手吧，暗杀者！"]], ["......"]], [145, "暗杀者", [[0, "收手吧，暗杀者！"]], ["有两下子，但是你休想阻止我！"]]];
                dialog1 = [[145, "暗杀者", [[0, "就凭这点能力，还想阻止我？"]], ["......"]], [400, "小赛尔", [[0, "还没完呢，再来！"]], ["......"]]];
                if (FightManager.isJustWinFight()) {
                    NpcDialog.showDialogs(dialog0, this.initStep3);
                } else {
                    NpcDialog.showDialogs(dialog1, function ():void {
                        SceneManager.active.mapModel.content["boss"].visible = true;
                        SceneManager.active.mapModel.content["boss"].addEventListener(MouseEvent.CLICK, onBossClick);
                    });
                }
            }
        }
    }

    private function initStep3():void {
        var mc:MovieClip = null;
        var firstFrame:int = 0;
        var dialogs:Array = null;
        var dialogs1:Array = null;
        mc = SceneManager.active.mapModel.content["mv"];
        firstFrame = 40;
        dialogs = [[137, "席德", [[0, "你休想！"]], ["......"]]];
        dialogs1 = [[145, "暗杀者", [[0, "看起来有两下子，但是，如果我踩上去呢？"]], ["糟了！Σ( ° △ °|||)︴"]], [400, "小赛尔", [[0, "啊啊啊o(≧口≦)o想想就好可怕！宝宝被吓得崩溃啦！怎么办？！谁来救救我们？"]], ["......"]]];
        MovieClipUtil.playMc(mc, 2, firstFrame, function ():void {
            NpcDialog.showDialogs(dialogs, function ():void {
                MovieClipUtil.playMc(mc, firstFrame, mc.totalFrames, function ():void {
                    NpcDialog.showDialogs(dialogs1, function ():void {
                        QuestManager.completeStep(questID, 1);
                        SceneManager.changeScene(SceneType.LOBBY, 70);
                    });
                });
            });
        });
    }

    private function onBossClick(param1:* = null):void {
        if (QuestManager.isComplete(_quest.id)) {
            return;
        }
        this.fight();
    }

    override public function dispose():void {
        SceneManager.active.mapModel.content["boss"].removeEventListener(MouseEvent.CLICK, this.onBossClick);
        super.dispose();
    }
}
}
