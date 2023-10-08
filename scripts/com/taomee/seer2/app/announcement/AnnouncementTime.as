package com.taomee.seer2.app.announcement
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.config.ItemConfig;
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.manager.TrainerManager;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.notify.NoticeManager;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.app.vip.VipManager;
   import com.taomee.seer2.app.vip.data.VipInfo;
   import com.taomee.seer2.core.net.MessageEvent;
   import com.taomee.seer2.core.ui.Proclaim;
   import flash.events.Event;
   import flash.utils.IDataInput;
   
   public class AnnouncementTime
   {
      
      private static var _timeArray:Array;
      
      private static var _filterTime:String;
      
      private static var _activityTimeControl:Array = [14,15,19,20];
      
      private static var _announcementInfo:com.taomee.seer2.app.announcement.AnnouncementInfo;
      
      {
         startRingerAnnoumce();
      }
      
      public function AnnouncementTime()
      {
         super();
      }
      
      public static function checkTime(param1:String) : void
      {
         var _loc2_:uint = 0;
         if(!QuestManager.isFreshQuestComplete())
         {
            return;
         }
         _timeArray = param1.split("-");
         if(int(_timeArray[0]) != 5 && int(_timeArray[0]) != 6 && int(_timeArray[0]) != 0)
         {
            return;
         }
         for each(_loc2_ in _activityTimeControl)
         {
            if(int(_timeArray[1]) == _loc2_)
            {
               isIntervalAnnouncement();
               return;
            }
         }
      }
      
      private static function isIntervalAnnouncement() : void
      {
         requestBeatCaptain();
         if(isAgainLogin())
         {
            intervalAnnouncement();
            return;
         }
      }
      
      private static function isAgainLogin() : Boolean
      {
         var _loc2_:com.taomee.seer2.app.announcement.AnnouncementInfo = null;
         var _loc1_:Array = AnnouncementConfig.getAnnouncementInfoList();
         for each(_loc2_ in _loc1_)
         {
            if(isHasFirstAnnouncement(_loc2_))
            {
               return true;
            }
         }
         return false;
      }
      
      private static function isHasFirstAnnouncement(param1:com.taomee.seer2.app.announcement.AnnouncementInfo) : Boolean
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Array = null;
         var _loc2_:Array = param1.getFrequencyArray();
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = int(_timeArray[2]);
         var _loc8_:int = 0;
         while(_loc8_ < _loc3_)
         {
            _loc7_ = _loc2_[_loc8_].split(":");
            if((_loc5_ = int(_loc7_[0])) == int(_timeArray[1]))
            {
               _loc6_ = int(_loc7_[1]);
               if(_loc4_ == _loc6_)
               {
                  _announcementInfo = param1;
                  return true;
               }
            }
            _loc8_++;
         }
         return false;
      }
      
      private static function intervalAnnouncement() : void
      {
         var _loc4_:int = 0;
         var _loc5_:Array = null;
         var _loc1_:Array = _announcementInfo.getFrequencyArray();
         var _loc2_:int = int(_loc1_.length);
         var _loc3_:int = int(_timeArray[2]);
         var _loc6_:int = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = _loc1_[_loc6_].split(":");
            _loc4_ = int(_loc5_[1]);
            if(_loc3_ == _loc4_)
            {
               if(_filterTime != String(_loc5_[0]) + String(_loc5_[1]))
               {
                  checkCanAnnouncement();
                  _filterTime = String(_loc5_[0]) + String(_loc5_[1]);
               }
            }
            _loc6_++;
         }
      }
      
      private static function checkCanAnnouncement() : void
      {
         if(_announcementInfo.name == "")
         {
            Proclaim.addText(_announcementInfo.content);
         }
         else
         {
            Proclaim.addText("[" + _announcementInfo.name + "]" + _announcementInfo.content);
         }
      }
      
      public static function playAnnouncement(param1:String) : void
      {
         Proclaim.addText(param1);
      }
      
      public static function startRingerAnnoumce() : void
      {
         if(!QuestManager.isFreshQuestComplete())
         {
            return;
         }
         requestBeatCaptain();
      }
      
      private static function requestBeatCaptain() : void
      {
         Connection.addCommandListener(CommandSet.BEAT_CAPTAIN_1070,onBeatCaptain);
      }
      
      private static function onBeatCaptain(param1:MessageEvent) : void
      {
         var i:uint;
         var data_1:uint;
         var data_2:uint;
         var data_3:uint;
         var data_4:uint;
         var userID:uint = 0;
         var cActor:Actor = null;
         var curActor1:Actor = null;
         var curActor2:Actor = null;
         var itemId:uint = 0;
         var itemName:String = null;
         var itemCount:uint = 0;
         var obj:Object = null;
         var event:MessageEvent = param1;
         var func:Function = function(param1:int):void
         {
            var _loc3_:String = null;
            var _loc2_:int = param1 - 1500;
            if(_loc2_ < 0)
            {
               _loc2_ = 0;
            }
            switch(userID)
            {
               case 1:
                  _loc3_ = "热辣队";
                  break;
               case 2:
                  _loc3_ = "冰沁队";
                  break;
               case 3:
                  _loc3_ = "丛林队";
            }
            ServerMessager.addMessage("今天的训练师争霸赛结束，你为" + _loc3_ + "贡献了" + _loc2_ + "个争霸赛积分。");
         };
         var data:IDataInput = event.message.getRawData();
         var type:uint = uint(data.readUnsignedInt());
         userID = uint(data.readUnsignedInt());
         var name:String = String(data.readUTFBytes(16));
         var items:Array = new Array();
         var len:uint = uint(data.readUnsignedInt());
         if(type == 2008)
         {
            if(userID != ActorManager.actorInfo.id)
            {
               cActor = ActorManager.getRemoteActor(userID);
            }
            else
            {
               cActor = ActorManager.getActor();
            }
            cActor.setTaoLeJieData(data.readUnsignedInt());
            return;
         }
         if(type == 2007)
         {
            return;
         }
         if(type == 2003)
         {
            return;
         }
         if(type == 2009)
         {
            if(userID != ActorManager.actorInfo.id)
            {
               curActor1 = ActorManager.getRemoteActor(userID);
            }
            else
            {
               curActor1 = ActorManager.getActor();
            }
            curActor1.setNewTeamData(data.readUnsignedInt());
            return;
         }
         if(type == 2005)
         {
            if(userID != ActorManager.actorInfo.id)
            {
               curActor2 = ActorManager.getRemoteActor(userID);
            }
            else
            {
               curActor2 = ActorManager.getActor();
            }
            curActor2.setSelfBarData(data.readUnsignedInt(),data.readUnsignedInt());
            return;
         }
         if(type == 2006)
         {
            return;
         }
         i = 0;
         while(i < len)
         {
            itemId = uint(data.readUnsignedInt());
            itemName = ItemConfig.getItemName(itemId);
            itemCount = uint(data.readUnsignedInt());
            items.push({
               "iName":itemName,
               "iCounter":itemCount
            });
            i++;
         }
         data_1 = uint(data.readUnsignedInt());
         data_2 = uint(data.readUnsignedInt());
         data_3 = uint(data.readUnsignedInt());
         data_4 = uint(data.readUnsignedInt());
         if(type != 107)
         {
            if(type != 108)
            {
               if(type != 109)
               {
                  if(type != 110)
                  {
                     if(type != 111)
                     {
                        if(type != 112)
                        {
                           if(type == 113)
                           {
                           }
                        }
                     }
                  }
               }
            }
         }
         if(type > 51 && type <= 60)
         {
            _announcementInfo = AnnouncementConfig.getAnnouncementInfo(51);
         }
         else if(type == 66)
         {
            TrainerManager.dispatcheEvent(data_1,data_2,data_3,data_4);
         }
         else if(type == 67)
         {
            VipManager.vipInfo.luckyFlag = 0;
            VipManager.vipInfo.dispatchEvent(new Event(VipInfo.LUCKY_UPDATE));
         }
         else
         {
            if(type == 61)
            {
               NoticeManager.addChristmasNotice(name,itemId);
               return;
            }
            if(type == 64)
            {
               NoticeManager.addCommNotice("恭喜你获得联运任务奖励功夫猴面具");
               return;
            }
            if(type == 83)
            {
               return;
            }
            if(type == 84)
            {
            }
            _announcementInfo = AnnouncementConfig.getAnnouncementInfo(type);
         }
         if(_announcementInfo != null)
         {
            if(type >= 51 && type <= 60)
            {
               _announcementInfo.content = "以第" + (type - 50) + "名通关的金字塔精灵挑战，获得初级资质果实1颗，初级成长果实10颗";
            }
            else if(type == 76)
            {
               switch(userID)
               {
                  case 1:
                     _announcementInfo.content = "红队在刚才的争夺赛中已经胜了一局，加油啊！";
                     break;
                  case 2:
                     _announcementInfo.content = "蓝队在刚才的争夺赛中已经胜了一局，加油啊！";
                     break;
                  case 3:
                     _announcementInfo.content = "绿队在刚才的争夺赛中已经胜了一局，加油啊！";
               }
            }
            else if(type != 81)
            {
               if(type == 82)
               {
               }
            }
            if(userID == 0)
            {
               _announcementInfo.name = "";
            }
            else if(type == 114 || type == 115)
            {
               _announcementInfo.name = PetConfig.getPetDefinition(userID).name;
            }
            else
            {
               _announcementInfo.name = name;
            }
            while(items.length > 0)
            {
               obj = items.pop();
               _announcementInfo.content += ", 获取装备[" + obj.iName + "]" + obj.iCounter;
            }
            checkCanAnnouncement();
         }
      }
   }
}
