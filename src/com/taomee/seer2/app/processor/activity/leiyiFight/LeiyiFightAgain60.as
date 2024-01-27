package com.taomee.seer2.app.processor.activity.leiyiFight {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;

import flash.utils.IDataInput;

public class LeiyiFightAgain60 {


    private var _isFight:Boolean;

    private var _num:uint;

    private var _peyName:String;

    private var _petcCount:uint;

    public function LeiyiFightAgain60() {
        super();
        Connection.addCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209, this.onReadData);
        Connection.send(CommandSet.GET_RANGE_DAY_LIMIT_1209, 1, 486);
    }

    private function GameOver():void {
        if (SceneManager.prevSceneType == SceneType.ARENA && FightManager.currentFightRecord.initData.positionIndex == 160) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                if (this._num % 10 != 0) {
                    this.nineWin();
                } else {
                    this.tenWin();
                }
            } else if (this._num % 10 != 0) {
                this.nineLose();
            } else {
                this.tenLose();
            }
            return;
        }
    }

    private function onReadData(param1:MessageEvent):void {
        var _loc5_:uint = 0;
        Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209, this.onReadData);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc4_:int = 0;
        while (_loc4_ < _loc3_) {
            _loc5_ = uint(_loc2_.readUnsignedInt());
            this._num = _loc2_.readUnsignedInt();
            _loc4_++;
        }
        this.GameOver();
    }

    private function nineWin():void {
        ServerMessager.addMessage("已经连续急速成长训练" + this._num + "场");
        NpcDialog.show(6, "克拉克", [[0, "英雄出少年呀！要不要继续挑战！"]], ["好的！再来！", "下次再来！"], [function ():void {
            FightManager.startFightWithWild(160);
        }]);
    }

    private function nineLose():void {
        NpcDialog.show(6, "克拉克", [[0, "不要大意哦！这个送给你作为鼓励！加油！"]], ["我会加油的！"]);
    }

    private function tenWin():void {
        ServerMessager.addMessage("已经连续急速成长训练" + this._num + "场");
        NpcDialog.show(6, "克拉克", [[0, "厉害！这个是你应得的！拿着吧！"]], ["酷！"]);
    }

    private function tenLose():void {
        NpcDialog.show(6, "克拉克", [[0, "<font color=\'#ffcc00\'>{$name}</font>，相信你已经尽力了！给！这个拿去！我想对你的精灵有所帮助吧！"]], ["下一次！我一定会战胜！"]);
    }

    public function onDispose(param1:ModuleEvent):void {
    }

    public function dispose():void {
        Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209, this.onReadData);
    }
}
}
