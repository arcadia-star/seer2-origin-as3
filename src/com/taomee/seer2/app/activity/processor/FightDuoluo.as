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

public class FightDuoluo {


    public function FightDuoluo() {
        super();
        DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        var _loc1_:int = int(FightManager.currentFightRecord.initData.positionIndex);
        if (SceneManager.prevSceneType == SceneType.ARENA && _loc1_ == 123) {
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
        if ((evt.content as DialogPanelEventData).params == "FightTouluo") {
            if (ItemManager.getSpecialItem(500508) != null || ItemManager.getSpecialItem(500509) != null) {
                NpcDialog.show(1003, "多罗", [[0, "我可是被大伙投票选举出来的队长哦！我会让你们知道丛林队的厉害！！(击败队长，系统将扣除该队精灵王争霸赛200点积分）"]], ["切！来决斗吧!", "咦！杀气好重哦。"], [function ():void {
                    Connection.addCommandListener(CommandSet.DAILY_LIMIT_1065, onPlayHint);
                    Connection.send(CommandSet.DAILY_LIMIT_1065, 456);
                }]);
            } else {
                NpcDialog.show(1003, "多罗", [[0, "<font color=\'#ffcc00\'>{$name}</font>，我们是队友哦，去挑战其他队伍的队长吧！"]], ["嗯，我知道啦！"], []);
            }
        }
    }

    private function onPlayHint(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
        var _loc2_:Parser_1065 = new Parser_1065(param1.message.getRawDataCopy());
        var _loc3_:uint = _loc2_.count;
        if (_loc3_ < 3) {
            FightManager.startFightWithWild(123);
        } else {
            NpcDialog.show(1003, "多罗", [[0, "今天的较量到此为止！让我好好准备，明天等着瞧！"]], ["OK!"], []);
        }
    }

    private function win():void {
        NpcDialog.show(1003, "多罗", [[0, " 肿么会这样，不行！我要继续和你决斗！"]], ["哈哈！队长的实力也就一般般嘛！"], [function ():void {
            SwapManager.swapItem(473, 1, null, null, new SpecialInfo(1, 3));
        }]);
    }

    private function noWin():void {
        NpcDialog.show(1003, "多罗", [[0, "哈哈哈！尝到我的厉害吧"]], ["啊啊！我要继续挑战你！!", "退出挑战！"], [function ():void {
            FightManager.startFightWithWild(123);
        }]);
    }

    public function dispose():void {
        DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK, this.onActivityUnitClick);
        Connection.removeCommandListener(CommandSet.DAILY_LIMIT_1065, this.onPlayHint);
    }
}
}
