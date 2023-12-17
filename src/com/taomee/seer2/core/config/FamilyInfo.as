package com.taomee.seer2.core.config
{
   public class FamilyInfo
   {
       
      
      public var familyId:int;
      
      public var mapInfoList:Vector.<DreamInfo>;
      
      public var isSwapPet:int;
      
      public var petType:int;
      
      public var itemIdList:Array;
      
      public var totalItemCountList:Array;
      
      public var clickMapIdList:Array;
      
      private var _currStarCount:int;
      
      public function FamilyInfo()
      {
         super();
      }
      
      public function set currStarCount(param1:int) : void
      {
         this._currStarCount = param1;
      }
      
      public function get currStarCount() : int
      {
         return this._currStarCount;
      }
   }
}
