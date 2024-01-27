package com.taomee.seer2.app.pet {
import com.taomee.seer2.app.arena.FightManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.core.entity.Mobile;
import com.taomee.seer2.core.entity.MobileManager;
import com.taomee.seer2.core.entity.definition.NpcDefinition;

import flash.events.MouseEvent;

public class MysteryNpc {


    private const feiniaoID:int = 555;

    private var _npcDefinition:NpcDefinition;

    private var _npc:Mobile;

    public function MysteryNpc() {
        super();
        var _loc1_:XML = <npc id="555" resId="555" name="" dir="1" width="25" height="50" path="">
        </npc>;
        this.initNpc(_loc1_);
    }

    private function initNpc(param1:XML):void {
        this._npcDefinition = new NpcDefinition(param1);
        this._npc = MobileManager.createNpc(this._npcDefinition);
        this._npc.buttonMode = true;
        this._npc.addEventListener(MouseEvent.CLICK, this.onClick);
    }

    private function onClick(param1:MouseEvent):void {
        var e:MouseEvent = param1;
        NpcDialog.show(this.feiniaoID, "肥鸟", [[0, "哈哈，你被骗了吧，我不是什么神秘伊特哟"]], ["气愤！"], [function ():void {
            NpcDialog.show(feiniaoID, "肥鸟", [[0, "我只是一只喜欢带着伊特帽子到处晃悠的肥鸟。"]], ["啊！大骗子，你是大骗子！"], [function ():void {
                NpcDialog.show(feiniaoID, "肥鸟", [[0, "不过真正的神秘伊特也会出现的哟，在伊特锦标赛的闭幕式中，神秘伊特会来给大家见面的。"]], ["太好了太好了。"], [function ():void {
                    NpcDialog.show(feiniaoID, "肥鸟", [[0, "既然你找到了我，那我就和你来一场战斗，你可以捕捉我哟，不过" + "<font color=\'#ff00ff\'>5回合</font>" + "后我会逃跑。当然，有" + "<font color=\'#ff00ff\'>无敌精灵胶囊</font>" + "会更容易捕捉到我。"]], ["开战吧", "我准备下"], [function ():void {
                        FightManager.startFightWithWild(336);
                        MysteryNpcManager.isNpcAppear = 0;
                    }, null]);
                }]);
            }]);
        }]);
    }

    public function get npc():Mobile {
        return this._npc;
    }

    public function dispose():void {
        if (this._npc) {
            this._npc.removeEventListener(MouseEvent.CLICK, this.onClick);
            this._npc.dispose();
        }
        this._npc = null;
        this._npcDefinition = null;
    }
}
}
