package com.taomee.seer2.app.activity.processor {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1140;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

public class FightSimoce {


    public function FightSimoce() {
        super();
        Connection.addCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
        this.startFight();
    }

    private function startFight():void {
        if (Boolean(SceneManager.active) && SceneManager.active.mapID == 940) {
            if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 161 && FightManager.fightWinnerSide != FightSide.LEFT) {
                NpcDialog.show(155, "艾力克", [[1, "知道迷雾杀手的厉害了吧！今天大爷心情好！放你一马！趁我没后悔之前快走吧！"]], ["继续挑战！", "啊…太恐怖了！快跑！"], [function ():void {
                    FightManager.startFightWithWild(161);
                }]);
            } else if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 162 && FightManager.fightWinnerSide != FightSide.LEFT) {
                NpcDialog.show(155, "艾力克", [[1, "领教了迷雾杀手的厉害了吧！颤抖了吧！我要把你永远的掩埋在迷雾中…害怕了就赶快他逃跑吧！"]], ["继续挑战！", "啊！！！快跑啊！"], [function ():void {
                    FightManager.startFightBinaryWild(162);
                }]);
            }
        }
    }

    private function onEventStart(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        var parser:Parser_1140 = new Parser_1140(evt.message.getRawDataCopy());
        if (parser.id == 1 && parser.index == 27) {
            NpcDialog.show(517, "斯莫克", [[0, "艾力克说你如果这次能够战胜我，就收你做他的迷雾小弟了！然后就可以跟我并肩作战了。"]], ["居然说收我做小弟…"], [function ():void {
                FightManager.startFightWithWild(163);
            }]);
        }
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.RANDOM_EVENT_1140, this.onEventStart);
    }
}
}
