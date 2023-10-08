package com.taomee.seer2.app.activity
{
   import com.taomee.seer2.app.activity.data.ActivityDefinition;
   import com.taomee.seer2.app.activity.processor.ActivityProcessor;
   import com.taomee.seer2.app.config.ActivityConfig;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.quest.QuestManager;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.net.SharedObject;
   import flash.system.ApplicationDomain;
   import org.taomee.ds.HashMap;
   
   public class ActivityManager
   {
      
      private static var _inProgressActivityMap:HashMap;
      
      {
         initialize();
      }
      
      public function ActivityManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _inProgressActivityMap = new HashMap();
         initCommandListener();
         initTimelessActivity();
      }
      
      private static function initTimelessActivity() : void
      {
         var _loc1_:Vector.<ActivityDefinition> = null;
         var _loc2_:ActivityDefinition = null;
         var _loc3_:ActivityProcessor = null;
         if(QuestManager.isFreshQuestComplete())
         {
            _loc1_ = ActivityConfig.getTimelessActivityVec();
            for each(_loc2_ in _loc1_)
            {
               _loc3_ = createActivityProcessor(_loc2_);
               if(_loc3_ != null)
               {
                  _loc3_.start();
               }
            }
         }
      }
      
      public static function refreshActivity() : void
      {
         var _loc1_:Vector.<ActivityDefinition> = null;
         var _loc2_:ActivityDefinition = null;
         var _loc3_:ActivityProcessor = null;
         if(QuestManager.isFreshQuestComplete())
         {
            _loc1_ = ActivityConfig.getInprogressActivityVec();
            for each(_loc2_ in _loc1_)
            {
               if(_inProgressActivityMap.containsKey(_loc2_.id) == false)
               {
                  _loc3_ = createActivityProcessor(_loc2_);
                  if(_loc3_ != null)
                  {
                     _inProgressActivityMap.add(_loc2_.id,_loc3_);
                     _loc3_.start();
                  }
               }
            }
            _inProgressActivityMap.eachValue(processActivity);
         }
      }
      
      public static function removeActivityProcessor(param1:uint) : void
      {
         var _loc2_:ActivityProcessor = null;
         if(_inProgressActivityMap.containsKey(param1))
         {
            _loc2_ = _inProgressActivityMap.getValue(param1);
            _loc2_.dispose();
            _inProgressActivityMap.remove(param1);
         }
      }
      
      private static function createActivityProcessor(param1:ActivityDefinition) : ActivityProcessor
      {
         var _loc2_:String = "com.taomee.seer2.app.activity.processor." + ActivityConfig.getActivityProcessorName(param1.id);
         var _loc3_:Class = ApplicationDomain.currentDomain.getDefinition(_loc2_) as Class;
         return ActivityProcessor(new _loc3_(param1));
      }
      
      private static function processActivity(param1:ActivityProcessor) : void
      {
         if(param1 == null)
         {
            return;
         }
         param1.refresh();
      }
      
      private static function initCommandListener() : void
      {
         Connection.addErrorHandler(CommandSet.ACTIVITY_FIGHT_MONSTER_1066,onFightActivityMonsterError);
      }
      
      private static function onFightActivityMonsterError(param1:MessageEvent) : void
      {
         if(param1.message.statusCode == 100)
         {
            AlertManager.showAlert("此活动当前未开放");
         }
      }
      
      public static function addActivityAnimationPlayNum(param1:uint, param2:String, param3:int = 1) : void
      {
         var _loc4_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY_ANIMATION);
         var _loc5_:String = generateDateKey();
         var _loc6_:String = generateActivityKey(param1,param2);
         var _loc7_:Object = _loc4_.data[_loc5_][_loc6_];
         _loc7_.playNum += param3;
         SharedObjectManager.flush(_loc4_);
      }
      
      private static function isActivityAnimationPlayed(param1:uint, param2:String) : Boolean
      {
         var _loc3_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY_ANIMATION);
         var _loc4_:String = generateDateKey();
         var _loc5_:String = generateActivityKey(param1,param2);
         if(_loc3_.data[_loc4_] == null)
         {
            resetSharedObject(_loc3_,_loc4_);
         }
         var _loc6_:Object;
         if((_loc6_ = _loc3_.data[_loc4_][_loc5_]) == null)
         {
            (_loc6_ = new Object()).playNum = 0;
            _loc3_.data[_loc4_][_loc5_] = _loc6_;
            SharedObjectManager.flush(_loc3_);
         }
         return _loc6_.playNum > 0;
      }
      
      private static function resetSharedObject(param1:SharedObject, param2:String) : void
      {
         param1.clear();
         param1.data[param2] = new Object();
         param1.flush();
      }
      
      public static function clearSo(param1:uint, param2:String) : void
      {
         var _loc3_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.ACTIVITY_ANIMATION);
         var _loc4_:String = generateDateKey();
         var _loc5_:String = generateActivityKey(param1,param2);
         if(_loc3_.data[_loc4_][_loc5_] != null)
         {
            resetSharedObject(_loc3_,param2);
         }
      }
      
      private static function generateDateKey() : String
      {
         var _loc1_:Date = new Date();
         return Connection.netType.toString() + _loc1_.fullYear + "_" + _loc1_.month + "_" + _loc1_.date;
      }
      
      private static function generateActivityKey(param1:uint, param2:String) : String
      {
         var _loc3_:uint = uint(TimeManager.getServerTime());
         var _loc4_:ActivityDefinition = ActivityConfig.getActivityById(param1);
         return "../res/activity/" + param1 + _loc4_.getPhaseIndex(_loc3_) + param2;
      }
      
      public static function isPlayActivityAnimation(param1:uint, param2:String) : Boolean
      {
         if(isActivityAnimationPlayed(param1,param2) > 0)
         {
            return false;
         }
         return true;
      }
   }
}
