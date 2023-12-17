package com.taomee.seer2.app.swap.sharedObject
{
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.swap.item.SwapItem;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import flash.net.SharedObject;
   
   public class SwapSharedObject
   {
      
      private static var _instance:SwapSharedObject;
       
      
      private const DAY:int = 1;
      
      private const WEEK:int = 2;
      
      private const MONTH:int = 3;
      
      private const LIFETIME:int = 4;
      
      private var _swapItem:SwapItem;
      
      public function SwapSharedObject()
      {
         super();
      }
      
      public static function get instance() : SwapSharedObject
      {
         if(_instance == null)
         {
            _instance = new SwapSharedObject();
         }
         return _instance;
      }
      
      public function startCheck(param1:SwapItem) : Boolean
      {
         this._swapItem = param1;
         if(this.swapNumber() <= 0)
         {
            return false;
         }
         return true;
      }
      
      public function setRewardNum() : void
      {
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SWAP);
         var _loc2_:String = this.generateDateKey();
         var _loc3_:uint = this.generateMineKey();
         var _loc4_:Object = _loc1_.data[_loc2_][_loc3_];
         _loc4_.diggedNum += 1;
         SharedObjectManager.flush(_loc1_);
      }
      
      private function swapNumber() : int
      {
         var _loc4_:Boolean = false;
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.SWAP);
         var _loc2_:String = this.generateDateKey();
         var _loc3_:uint = this.generateMineKey();
         if(_loc1_.data[_loc2_] == null)
         {
            _loc1_.clear();
            _loc1_.data[_loc2_] = {};
            _loc4_ = true;
         }
         var _loc5_:Object;
         if((_loc5_ = _loc1_.data[_loc2_][_loc3_]) == null)
         {
            (_loc5_ = new Object()).diggedNum = 0;
            _loc1_.data[_loc2_][_loc3_] = _loc5_;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            SharedObjectManager.flush(_loc1_);
         }
         return this._swapItem.dayMaxNum - _loc5_.diggedNum;
      }
      
      private function generateDateKey() : String
      {
         var _loc1_:Date = new Date();
         switch(this._swapItem.timeLimit)
         {
            case this.DAY:
               return _loc1_.fullYear + "_" + (_loc1_.month + 1) + "_" + _loc1_.date;
            case this.WEEK:
               return String(_loc1_.day);
            case this.MONTH:
               return _loc1_.fullYear + "_" + (_loc1_.month + 1);
            case this.LIFETIME:
               return String(_loc1_.fullYear);
            default:
               return _loc1_.fullYear + "_" + _loc1_.month + "_" + _loc1_.date;
         }
      }
      
      private function generateMineKey() : uint
      {
         return Connection.netType + this._swapItem.swapId;
      }
   }
}
