package com.taomee.seer2.app.dream
{
   import flash.utils.IDataInput;
   
   public class DreamMapInfo
   {
       
      
      public var id:uint;
      
      public var type:uint;
      
      public var fightId:uint;
      
      public var goldenBoxCount:uint;
      
      public var sliverBoxCount:uint;
      
      public var list:Vector.<DreamMapMiniInfo>;
      
      public var itemList:Vector.<DreamItem>;
      
      public var isComWinMap:Boolean;
      
      public var starIndex:int;
      
      public var isOneWin:int;
      
      public function DreamMapInfo(param1:IDataInput)
      {
         super();
         this.id = param1.readUnsignedInt();
         this.type = param1.readUnsignedByte();
         this.fightId = param1.readUnsignedInt();
         this.goldenBoxCount = param1.readUnsignedByte();
         this.sliverBoxCount = param1.readUnsignedByte();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         this.list = Vector.<DreamMapMiniInfo>([]);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.list.push(new DreamMapMiniInfo(param1));
            _loc3_++;
         }
         this.isComWinMap = param1.readUnsignedByte() == 1 ? true : false;
         this.starIndex = param1.readUnsignedInt();
         this.isOneWin = param1.readUnsignedByte();
         this.itemList = Vector.<DreamItem>([]);
         var _loc4_:int = 0;
         while(_loc4_ < 3)
         {
            this.itemList.push(new DreamItem(param1));
            _loc4_++;
         }
      }
   }
}

import flash.utils.IDataInput;

class DreamMapMiniInfo
{
    
   
   public var petId:uint;
   
   public var killPetCount:uint;
   
   public var totalPetCount:uint;
   
   public var isBoss:uint;
   
   public function DreamMapMiniInfo(param1:IDataInput)
   {
      super();
      this.petId = param1.readUnsignedInt();
      this.killPetCount = param1.readUnsignedInt();
      this.totalPetCount = param1.readUnsignedInt();
      this.isBoss = param1.readUnsignedInt();
   }
}
