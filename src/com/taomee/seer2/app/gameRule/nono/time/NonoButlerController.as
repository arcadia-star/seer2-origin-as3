package com.taomee.seer2.app.gameRule.nono.time
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.gameRule.cavingNotice.CavingNoticeData;
   import com.taomee.seer2.app.gameRule.nono.core.NonoTimeInfo;
   import flash.utils.IDataInput;
   import org.taomee.utils.Tick;
   
   public class NonoButlerController
   {
      
      private static var _instance:NonoButlerController;
      
      private static const SEC:uint = 30;
       
      
      private var _timeVec:Vector.<NonoTimeInfo>;
      
      private var _isHeadLock:Boolean = false;
      
      private var _activitySpeed:uint = 20;
      
      private var _activityCount:int;
      
      public function NonoButlerController(param1:PrivateClass)
      {
         this._activityCount = this._activitySpeed;
         super();
      }
      
      public static function getInstance() : NonoButlerController
      {
         if(_instance == null)
         {
            _instance = new NonoButlerController(new PrivateClass());
         }
         return _instance;
      }
      
      private function createNonoTimeInfos() : void
      {
         this._timeVec = new Vector.<NonoTimeInfo>();
         var _loc1_:NonoTimeInfo = new NonoTimeInfo();
         _loc1_.type = 5;
         _loc1_.catch_time = 0;
         _loc1_.end_time = 10000;
         this._timeVec.push(_loc1_);
      }
      
      public function parserData(param1:IDataInput) : void
      {
         var _loc3_:NonoTimeInfo = null;
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this.createNonoTimeInfos();
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new NonoTimeInfo();
            _loc3_.type = param1.readUnsignedByte();
            _loc3_.catch_time = param1.readUnsignedInt();
            _loc3_.end_time = param1.readUnsignedInt();
            this.add(_loc3_);
            _loc4_++;
         }
         this.run();
      }
      
      public function update(param1:IDataInput) : void
      {
         var _loc2_:uint = uint(param1.readUnsignedByte());
         var _loc3_:NonoTimeInfo = new NonoTimeInfo();
         _loc3_.type = param1.readUnsignedByte();
         _loc3_.catch_time = param1.readUnsignedInt();
         _loc3_.end_time = param1.readUnsignedInt();
         if(_loc2_ == 0)
         {
            this.add(_loc3_);
         }
         else
         {
            this.quit(_loc3_);
         }
      }
      
      private function add(param1:NonoTimeInfo) : void
      {
         this._timeVec.push(param1);
      }
      
      private function quit(param1:NonoTimeInfo) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this._timeVec.length)
         {
            if(this._timeVec[_loc2_].catch_time == param1.catch_time)
            {
               this._timeVec.splice(_loc2_,1);
               break;
            }
            _loc2_++;
         }
      }
      
      public function playComAnimation() : void
      {
         if(Boolean(ActorManager.actorInfo) && Boolean(ActorManager.getActor().getNono().nonoInfo))
         {
            if(ActorManager.getActor().getNono().isClock() == false && ActorManager.getActor().getNono().isFollowing)
            {
               ActorManager.getActor().getNono().showClock();
            }
         }
      }
      
      private function run() : void
      {
         Tick.instance.addRender(this.onTimer,SEC * 1000);
      }
      
      private function onTimer(param1:int) : void
      {
         ++this._activityCount;
         if(this._activityCount >= this._activitySpeed)
         {
            this._activityCount = 0;
            if(CavingNoticeData.hasNoticeActivity())
            {
               this.playComAnimation();
            }
         }
         this.checkTimeVec();
      }
      
      private function checkTimeVec() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this._timeVec.length)
         {
            if(this._timeVec[_loc1_].end_time <= 0)
            {
               this.playComAnimation();
            }
            else
            {
               this._timeVec[_loc1_].end_time -= SEC;
            }
            _loc1_++;
         }
      }
      
      public function getData() : Vector.<NonoTimeInfo>
      {
         return this._timeVec;
      }
   }
}

class PrivateClass
{
    
   
   public function PrivateClass()
   {
      super();
   }
}
