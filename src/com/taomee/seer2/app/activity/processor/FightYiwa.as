package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.DialogPanel;
import com.taomee.seer2.app.dialog.DialogPanelEventData;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1065;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class FightYiwa {


    public function FightYiwa() {
        super();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        var _loc1_:int = int(FightManager.currentFightRecord.initData.positionIndex);
        if (SceneManager.prevSceneType == SceneType.ARENA && _loc1_ == 122) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                this.win();
            } else {
                this.noWin();
            }
            return;
        }
    }

    private function onActivityUnitClick(param1:DialogPanelEvent):void {
        var evt:DialogPanelEvent = param1;
        if ((evt.content as DialogPanelEventData).params == "FightYiwa") {
            if (ItemManager.getSpecialItem(500510) != null || ItemManager.getSpecialItem(500509) != null) {
                NpcDialog.show(1001, "伊娃", [[0, "哈哈哈！来挑战我，你这是自取其辱！(击败队长，系统将扣除该队精灵王争霸赛200点积分）"]], ["切！小妞看招！", "伊娃霸气啊！"], [function ():void {
                    Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, onPlayHint);
                    Connection.send(CommandSet.DAILY_LIMIT_1065, 455);
                }]);
            } else {
                NpcDialog.show(1001, "伊娃", [[0, "<font color=\'#ffcc00\'>{$name}</font>，我们是队友哦，去挑战其他队伍的队长吧！"]], ["嗯，我知道啦！"], []);
            }
        }
    }

    private function onPlayHint(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        var _loc3_:uint = _loc2_.count;
        if (_loc3_ < 3) {
            FightManager.startFightWithWild(122);
        } else {
            NpcDialog.show(1001, "伊娃", [[0, "今天的较量到此为止！让我好好准备，明天等着瞧！"]], ["OK!"], []);
        }
    }

    private function win():void {
        NpcDialog.show(1001, "伊娃", [[0, "刚刚是我的失误，下次你可没有这么好的运气！"]], ["呵呵，那咱们继续吧。"], [function ():void {
            SwapManager.swapItem(472, 1, null, null, new SpecialInfo(1, 1));
        }]);
    }

    private function noWin():void {
        NpcDialog.show(1001, "伊娃", [[0, "不自量力的家伙！赶紧走开！"]], ["啊啊！我要继续挑战你！!", "退出挑战！"], [function ():void {
            FightManager.startFightWithWild(122);
        }]);
    }

    public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
    }
}
}
