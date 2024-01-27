package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.shoot.ShootController;
import com.taomee.seer2.app.shoot.ShootXMLInfo;
import com.taomee.seer2.core.net.MessageEvent;

import flash.geom.Point;
import flash.utils.ByteArray;

import org.taomee.bean.BaseBean;

public class ShootCmdListener extends BaseBean {


    public function ShootCmdListener() {
        super();
    }

    override public function start():void {
        Connection.addCommandListener(CommandSet.SHOOT_1075, this.onData);
        finish();
    }

    private function onData(param1:MessageEvent):void {
        var _loc7_:Actor = null;
        var _loc2_:ByteArray = param1.message.getRawData();
        var _loc3_:uint = _loc2_.readUnsignedInt();
        var _loc4_:int = int(_loc2_.readUnsignedInt());
        var _loc5_:uint = _loc2_.readUnsignedInt();
        var _loc6_:Point = new Point(_loc2_.readUnsignedInt(), _loc2_.readUnsignedInt());
        if (_loc3_ == ActorManager.actorInfo.id) {
            this.processShootItem(_loc5_);
            ShootController.execute(_loc5_, _loc3_, ActorManager.getActor(), _loc6_);
        } else if (ActorManager.showRemoteActor) {
            if (_loc7_ = ActorManager.getRemoteActor(_loc3_)) {
                ShootController.execute(_loc5_, _loc3_, _loc7_, _loc6_);
            }
        }
    }

    private function processShootItem(param1:uint):void {
        if (ShootXMLInfo.isSpecialShootItem(param1)) {
            ItemManager.reduceItemQuantity(ShootXMLInfo.getSpecialItemId(param1), 1);
        }
    }
}
}
