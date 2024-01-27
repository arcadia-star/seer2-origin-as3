package com.taomee.seer2.app.cmdl {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.actor.Actor;
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.actor.data.UserInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1142;
import com.taomee.seer2.app.notify.NoticeManager;
import com.taomee.seer2.app.utils.MovieClipUtil;
import com.taomee.seer2.app.vip.VipManager;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.events.Event;
import flash.utils.IDataInput;

import org.taomee.bean.BaseBean;
import org.taomee.utils.BitUtil;

public class VipListener extends BaseBean {


    private var _mc1:MovieClip;

    public function VipListener() {
        super();
        Connection.addCommandListener(CommandSet.VIP_PAY_NOTICE, this.onVipPayNotice);
        Connection.addCommandListener(CommandSet.VIP_UPDATE, this.onVipUpdate);
        Connection.addCommandListener(CommandSet.VIP_LUCKY_MSG_1168, this.onVipLuckyMsg);
        finish();
    }

    private function onVipUpdate(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        var data:IDataInput = evt.message.getRawData();
        var userId:uint = uint(data.readUnsignedInt());
        var actor:Actor = ActorManager.getActorById(userId);
        var userInfo:UserInfo = !!actor ? actor.getInfo() : null;
        if (userInfo) {
            userInfo.vipInfo.parseVipUpdate(data);
            if (userInfo.vipInfo.vipFlag == 1) {
                MovieClipUtil.getSwfContent(URLUtil.getQuestFullScreenAnimation("10246_0"), function (param1:MovieClip):void {
                    ModuleManager.closeForName("PetBagPanel");
                    _mc1 = param1;
                    LayerManager.topLayer.addChild(_mc1);
                    _mc1.addEventListener(Event.ENTER_FRAME, onFrame);
                    _mc1.play();
                });
            }
            ModuleManager.showAppModule("VipRechargeSuccessPanel");
        }
    }

    private function onFrame(param1:Event):void {
        if (this._mc1.currentFrame == this._mc1.totalFrames) {
            this._mc1.removeEventListener(Event.ENTER_FRAME, this.onFrame);
            LayerManager.topLayer.removeChild(this._mc1);
            this._mc1.gotoAndStop(1);
            this._mc1 = null;
        }
    }

    private function onVipPayNotice(param1:MessageEvent):void {
        var evt:MessageEvent = param1;
        var data:IDataInput = evt.message.getRawData();
        var payFlag:int = int(data.readUnsignedInt());
        var leftDays:int = int(data.readUnsignedInt());
        ItemManager.changeEquipValidity();
        if (VipManager.energyLotteryCnt != -1) {
            VipManager.energyLotteryCnt = 5;
        }
        if (leftDays > 0) {
            NoticeManager.addVipNotice(payFlag, leftDays);
        }
        ActiveCountManager.requestActiveCountList([205735, 205703, 205689], function (param1:Parser_1142):void {
            if (param1.infoVec[1]) {
                if (param1.infoVec[2]) {
                    ActorManager.actorInfo.isYearVip = 2;
                } else {
                    ActorManager.actorInfo.isYearVip = 1;
                }
            } else {
                ActorManager.actorInfo.isYearVip = 0;
            }
            ActorManager.getActor().updateYearIcon();
        });
    }

    private function onVipLuckyMsg(param1:MessageEvent):void {
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readByte());
        var _loc4_:Boolean = Boolean(BitUtil.getBit(_loc3_, 0));
        var _loc5_:Boolean = Boolean(BitUtil.getBit(_loc3_, 1));
        if (_loc4_) {
            VipManager.vipInfo.luckyMsgType = 0;
        }
        if (_loc5_) {
            VipManager.vipInfo.luckyMsgType = 1;
        }
    }
}
}
