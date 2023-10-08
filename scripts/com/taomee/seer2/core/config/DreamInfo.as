package com.taomee.seer2.core.config
{
   public class DreamInfo
   {
       
      
      public var familyId:uint;
      
      public var fightIndex:uint;
      
      public var id:uint;
      
      public var mapId:uint;
      
      public var name:String;
      
      public var prevMapId:uint;
      
      public var isWelfare:int;
      
      public var itemList:Vector.<com.taomee.seer2.core.config.DreamItemInfo>;
      
      public var petList:Vector.<com.taomee.seer2.core.config.DreamPetInfo>;
      
      public var bossList:Vector.<com.taomee.seer2.core.config.DreamPetInfo>;
      
      public var monster:uint;
      
      public var monsterCount:uint;
      
      public var present:String;
      
      public var threeStar:String;
      
      public var nextIdList:Array;
      
      public function DreamInfo()
      {
         super();
      }
      
      public function getBossInfo(param1:uint) : com.taomee.seer2.core.config.DreamPetInfo
      {
         var _loc2_:com.taomee.seer2.core.config.DreamPetInfo = null;
         for each(_loc2_ in this.bossList)
         {
            if(_loc2_.id == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}
