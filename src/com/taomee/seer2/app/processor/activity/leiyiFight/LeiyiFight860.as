package com.taomee.seer2.app.processor.activity.leiyiFight {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.arena.util.FightSide;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.popup.ServerMessager;
import com.taomee.seer2.core.module.ModuleEvent;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.IDataInput;

public class LeiyiFight860 {


    private var _isFight:Boolean;

    private var _num:uint;

    private var _peyName:String;

    private var _petcCount:uint;

    public function LeiyiFight860() {
        super();
        ModuleManager.addEventListener("AppearResultPanel", ModuleEvent.DISPOSE, this.onDispose);
        Connection.addCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209, this.onData);
        Connection.send(CommandSet.GET_RANGE_DAY_LIMIT_1209, 1, 406);
    }

    private function GameOver():void {
        if (SceneManager.prevSceneType == SceneType.ARENA) {
            if (FightManager.fightWinnerSide == FightSide.LEFT) {
                if (this._num < 10) {
                    this.nineWin();
                } else {
                    this.tenWin();
                }
            } else if (this._num < 10) {
                this.nineLose();
            } else {
                this.tenLose();
            }
            return;
        }
    }

    private function onData(param1:MessageEvent):void {
        var _loc5_:uint = 0;
        Connection.removeCommandListener(CommandSet.GET_RANGE_DAY_LIMIT_1209, this.onData);
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
        ServerMessager.addMessage("已经连续战胜雷神" + this._num + "场");
    }

    private function nineLose():void {
        NpcDialog.show(477, "雷伊", [[0, "小小的失败就气馁了？屡败屡战，这才是王者必须拥有的气度！下一次你会成功的！"]], ["我一定会加油的！", "下次再来！"], [function ():void {
            FightManager.startFightWithWild(113);
        }]);
    }

    private function tenWin():void {
        ServerMessager.addMessage("已经连续战胜雷神" + this._num + "场");
        ModuleManager.toggleModule(URLUtil.getAppModule("AptitudeSelectPetPanel"), "正在打开精灵面板...");
    }

    private function tenLose():void {
        NpcDialog.show(477, "雷伊", [[0, "{$name}，你已经很厉害了！给！这个拿去！我想对你的精灵有所帮助吧！"]], ["下一次！我一定会战胜！"], [function ():void {
            FightManager.startFightWithWild(113);
        }]);
    }

    private function onDispose(param1:ModuleEvent):void {
        var e:ModuleEvent = param1;
        if (this._num < 10) {
            NpcDialog.show(477, "雷伊", [[0, "呵呵……英雄出少年！我想这些奖励是你应得的！再接再厉吧！你会是王者！"]], ["太好了！"], []);
        } else {
            NpcDialog.show(477, "雷伊", [[0, "可以啊！竟然揭下了我的悬赏令！作为奖励，我将给你一次提高精灵资质的机会"]], ["酷！"], [function ():void {
                SceneManager.changeScene(SceneType.LOBBY, 70);
            }]);
        }
    }

    public function dispose():void {
        ModuleManager.removeEventListener("AppearResultPanel", ModuleEvent.DISPOSE, this.onDispose);
    }
}
}
