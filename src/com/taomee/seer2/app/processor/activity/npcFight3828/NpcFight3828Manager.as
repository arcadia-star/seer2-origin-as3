package com.taomee.seer2.app.processor.activity.npcFight3828 {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class NpcFight3828Manager {

    private static var _isDualPet:Boolean;


    public function NpcFight3828Manager() {
        super();
    }

    public static function init():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.currentFightRecord && FightManager.currentFightRecord.initData && Boolean(FightManager.currentFightRecord.initData.positionIndex)) {
                if (FightManager.fightWinnerSide == FightSide.LEFT) {
                    if (FightManager.currentFightRecord.initData.positionIndex == 1317) {
                        ActiveCountManager.requestActiveCount(204992, onLimit);
                    }
                } else if (FightManager.currentFightRecord.initData.positionIndex == 1317) {
                    NpcDialog.show(1016, "里格", [[0, "你的实力不足以成为反萨联盟成员，回去吧。"]], ["哎……那我还是走了", "继续挑战！"], [null, function ():void {
                        FightManager.startFightWithWild(1317);
                    }]);
                } else if (FightManager.currentFightRecord.initData.positionIndex == 1319) {
                    NpcDialog.show(1016, "里格", [[0, "你的实力不足以成为反萨联盟成员，回去吧。"]], ["哎……那我还是走了", "继续挑战！"], [null, function ():void {
                        FightManager.startFightBinaryWild(1319);
                    }]);
                }
            }
        }
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, onActivityUnitClick);
    }

    private static function onLimit(param1:uint, param2:uint):void {
        var type:uint = param1;
        var count:uint = param2;
        if (count == 1) {
            NpcDialog.show(1016, "受打击的里格", [[2, "伟恩在我手下刻苦训练了那么多年，竟然败给一个铁皮人。如果你能战胜它，就让它跟你接受训练吧！"]], ["让你见识一下我的实力！"], [function ():void {
                FightManager.startFightWithWild(1318);
            }]);
        }
    }

    private static function onActivityUnitClick(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "fight_dual_npc_3828") {
            NpcDialog.show(1016, "里格", [[1, "伟恩军团经过我多年的训练，你想挑战它们吗？"]], ["我……还要再准备一下", "我想见识一下它们有多厉害！"], [null, function ():void {
                _isDualPet = true;
                FightManager.startFightWithWild(1317);
            }]);
        } else if ((evt.content as DialogPanelEventData).params == "fight_single_npc_3828") {
            NpcDialog.show(1016, "里格", [[1, "双精灵？我会派出最优秀的伟恩组合参战。"]], ["我还得再研究一下精灵组合……", "我的精灵很强大！"], [null, function ():void {
                _isDualPet = false;
                FightManager.startFightBinaryWild(1319);
            }]);
        }
    }

    public static function clear():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, onActivityUnitClick);
    }
}
}
