package com.taomee.seer2.app.gameRule.door.core.vo
{
   import flash.utils.IDataInput;
   
   public class HomeHonorInfo
   {
       
      
      public var medalVec:Vector.<int>;
      
      public var sptInfoVec:Vector.<HomeHonorSptInfo>;
      
      public var gateInfoVec:Vector.<HomeHonorGateInfo>;
      
      public function HomeHonorInfo(param1:IDataInput)
      {
         super();
         this.medalVec = new Vector.<int>();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.medalVec.push(param1.readUnsignedInt());
            _loc3_++;
         }
         this.sptInfoVec = new Vector.<HomeHonorSptInfo>();
         var _loc4_:int = int(param1.readUnsignedInt());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this.sptInfoVec.push(new HomeHonorSptInfo(param1));
            _loc5_++;
         }
         this.gateInfoVec = new Vector.<HomeHonorGateInfo>();
         var _loc6_:int = int(param1.readUnsignedInt());
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            this.gateInfoVec.push(new HomeHonorGateInfo(param1));
            _loc7_++;
         }
      }
      
      public function getMaxLevelHistory(param1:int) : uint
      {
         var _loc4_:HomeHonorGateInfo = null;
         var _loc2_:uint = 1;
         var _loc3_:int = int(this.gateInfoVec.length);
         var _loc5_:uint = 0;
         while(_loc5_ < _loc3_)
         {
            if((_loc4_ = this.gateInfoVec[_loc5_]).id == param1)
            {
               _loc2_ = uint(_loc4_.pveNormal);
               break;
            }
            _loc5_++;
         }
         return _loc2_;
      }
   }
}
