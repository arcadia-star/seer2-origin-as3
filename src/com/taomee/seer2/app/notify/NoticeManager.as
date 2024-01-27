package com.taomee.seer2.app.notify {
import com.taomee.seer2.app.actor.ActorManager;
import com.taomee.seer2.app.chat.data.ChatReceivedMessage;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.notify.data.notice.BuddyNotice;
import com.taomee.seer2.app.notify.data.notice.ChatNotice;
import com.taomee.seer2.app.notify.data.notice.ChristmasNotice;
import com.taomee.seer2.app.notify.data.notice.CommonNotice;
import com.taomee.seer2.app.notify.data.notice.LeiyiKaisaNotice;
import com.taomee.seer2.app.notify.data.notice.LocalMsgNotice;
import com.taomee.seer2.app.notify.data.notice.Notice;
import com.taomee.seer2.app.notify.data.notice.NoticeType;
import com.taomee.seer2.app.notify.data.notice.PetKingNotice;
import com.taomee.seer2.app.notify.data.notice.SysMsgNotice;
import com.taomee.seer2.app.notify.data.notice.TeamChatNotice;
import com.taomee.seer2.app.notify.data.notice.TeamNotice;
import com.taomee.seer2.app.notify.data.notice.VipNotice;
import com.taomee.seer2.app.notify.data.queue.NoticeQueue;
import com.taomee.seer2.app.team.TeamManager;
import com.taomee.seer2.app.team.data.TeamMainInfo;

import flash.events.Event;
import flash.events.EventDispatcher;

import org.taomee.ds.HashMap;

public class NoticeManager {

    public static const NEW_NOTICE:String = "newNotice";

    private static var _map:HashMap;

    private static var _dispatcher:EventDispatcher = new EventDispatcher();

    {
        initialize();
    }

    public function NoticeManager(param1:Blocker) {
        super();
    }

    public static function block():void {
        Connection.blockCommand(CommandSet.BUDDY_NOTIFY_ADD_1026);
        Connection.blockCommand(CommandSet.VIP_PAY_NOTICE);
        Connection.blockCommand(CommandSet.CHAT_1102);
        Connection.blockCommand(CommandSet.TEAM_INVITE_NOTIFY_1085);
        Connection.blockCommand(CommandSet.VIP_LUCKY_MSG_1168);
        Connection.blockCommand(CommandSet.BEAT_CAPTAIN_1070);
        Connection.blockCommand(CommandSet.NOTIFY_SYS_MSG_1073);
    }

    public static function relase():void {
        Connection.releaseCommand(CommandSet.BUDDY_NOTIFY_ADD_1026);
        Connection.releaseCommand(CommandSet.CHAT_1102);
        Connection.releaseCommand(CommandSet.VIP_PAY_NOTICE);
        Connection.releaseCommand(CommandSet.TEAM_INVITE_NOTIFY_1085);
        Connection.releaseCommand(CommandSet.VIP_LUCKY_MSG_1168);
        Connection.releaseCommand(CommandSet.BEAT_CAPTAIN_1070);
        Connection.releaseCommand(CommandSet.NOTIFY_SYS_MSG_1073);
    }

    private static function initialize():void {
        _map = new HashMap();
        _map.add(NoticeType.BUDDY, new NoticeQueue());
        _map.add(NoticeType.CHAT, new NoticeQueue());
        _map.add(NoticeType.TEAM, new NoticeQueue());
        _map.add(NoticeType.VIP, new NoticeQueue());
        _map.add(NoticeType.TEAM_CHAT, new NoticeQueue());
        _map.add(NoticeType.CHRISTMAS, new NoticeQueue());
        _map.add(NoticeType.COMMON, new NoticeQueue());
        _map.add(NoticeType.SYSMSG, new NoticeQueue());
        _map.add(NoticeType.LOCALMSG, new NoticeQueue());
        _map.add(NoticeType.PET_KING_PANEL, new NoticeQueue());
        _map.add(NoticeType.LEIYI_KAISA_FIGHT, new NoticeQueue());
    }

    public static function addBuddyNotice(param1:uint, param2:String):void {
        var _loc4_:Notice = null;
        var _loc3_:NoticeQueue = getNoticeQueue(NoticeType.BUDDY);
        if (!_loc3_.getNotice(param1)) {
            _loc4_ = new BuddyNotice(param1, param2);
            _loc3_.enQueue(_loc4_);
            dispatchEvent(NEW_NOTICE);
        }
    }

    public static function addChatNotice(param1:uint, param2:ChatReceivedMessage):void {
        var _loc3_:NoticeQueue = getNoticeQueue(NoticeType.CHAT);
        var _loc4_:ChatNotice;
        if ((_loc4_ = _loc3_.getNotice(param1) as ChatNotice) == null) {
            _loc4_ = new ChatNotice(param1);
            _loc3_.enQueue(_loc4_);
        }
        _loc4_.addMessage(param2);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addLeiyiKaisaFightNotici():void {
        var _loc1_:NoticeQueue = getNoticeQueue(NoticeType.LEIYI_KAISA_FIGHT);
        var _loc2_:Notice = new LeiyiKaisaNotice(NoticeType.LEIYI_KAISA_FIGHT, ActorManager.actorInfo.id);
        _loc1_.enQueue(_loc2_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addTeamChatNotice(param1:ChatReceivedMessage):void {
        var _loc2_:NoticeQueue = getNoticeQueue(NoticeType.TEAM_CHAT);
        var _loc3_:TeamChatNotice = _loc2_.getNotice(ActorManager.actorInfo.id) as TeamChatNotice;
        if (_loc3_ == null && Boolean(TeamManager.teamId)) {
            _loc3_ = new TeamChatNotice();
            _loc2_.enQueue(_loc3_);
        }
        _loc3_.addMessage(param1);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addPetKingPanel():void {
        var _loc1_:NoticeQueue = getNoticeQueue(NoticeType.PET_KING_PANEL);
        var _loc2_:Notice = new PetKingNotice(NoticeType.PET_KING_PANEL, ActorManager.actorInfo.id);
        _loc1_.enQueue(_loc2_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addTeamNotice(param1:uint, param2:uint, param3:TeamMainInfo, param4:String = "", param5:uint = 0):void {
        var _loc7_:Notice = null;
        var _loc6_:NoticeQueue;
        if (!(_loc6_ = getNoticeQueue(NoticeType.TEAM)).getNotice(param2)) {
            _loc7_ = new TeamNotice(param1, param2, param3, param4, param5);
            _loc6_.enQueue(_loc7_);
            dispatchEvent(NEW_NOTICE);
        }
    }

    public static function addVipNotice(param1:int, param2:int):void {
        var _loc3_:NoticeQueue = getNoticeQueue(NoticeType.VIP);
        var _loc4_:Notice = new VipNotice(param1, param2);
        _loc3_.enQueue(_loc4_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addChristmasNotice(param1:String, param2:uint):void {
        var _loc3_:NoticeQueue = getNoticeQueue(NoticeType.CHRISTMAS);
        var _loc4_:Notice = new ChristmasNotice(param1, param2);
        _loc3_.enQueue(_loc4_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addCommNotice(param1:String):void {
        var _loc2_:NoticeQueue = getNoticeQueue(NoticeType.COMMON);
        var _loc3_:Notice = new CommonNotice(param1);
        _loc2_.enQueue(_loc3_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addSysMsgNotice(param1:Object):void {
        var _loc2_:NoticeQueue = getNoticeQueue(NoticeType.SYSMSG);
        var _loc3_:Notice = new SysMsgNotice(param1);
        _loc2_.enQueue(_loc3_);
        dispatchEvent(NEW_NOTICE);
    }

    public static function addLocalMsgNotice(param1:Object):void {
        var _loc2_:NoticeQueue = getNoticeQueue(NoticeType.LOCALMSG);
        var _loc3_:Notice = new LocalMsgNotice(param1);
        _loc2_.enQueue(_loc3_);
        dispatchEvent(NEW_NOTICE);
    }

    private static function getNoticeQueue(param1:String):NoticeQueue {
        if (_map.containsKey(param1)) {
            return _map.getValue(param1);
        }
        return new NoticeQueue();
    }

    public static function getNoticeCount():int {
        var _loc2_:NoticeQueue = null;
        var _loc1_:int = 0;
        for each(_loc2_ in _map.getValues()) {
            _loc1_ += _loc2_.length;
        }
        return _loc1_;
    }

    public static function shiftNotice():Notice {
        var _loc1_:Notice = null;
        var _loc2_:NoticeQueue = null;
        for each(_loc2_ in _map.getValues()) {
            if (_loc2_.length > 0) {
                _loc1_ = _loc2_.deQueue();
                break;
            }
        }
        return _loc1_;
    }

    public static function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false):void {
        _dispatcher.addEventListener(param1, param2, param3, param4, param5);
    }

    public static function removeEventListener(param1:String, param2:Function, param3:Boolean = false):void {
        _dispatcher.removeEventListener(param1, param2, param3);
    }

    public static function dispatchEvent(param1:String):void {
        if (_dispatcher.hasEventListener(param1)) {
            _dispatcher.dispatchEvent(new Event(param1));
        }
    }
}
}

class Blocker {


    public function Blocker() {
        super();
    }
}
