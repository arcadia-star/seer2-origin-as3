package com.taomee.seer2.app.config.info
{
   public class EvolveInfo
   {
       
      
      public var monId:int;
      
      public var needLevel:int;
      
      public var itemVec:Vector.<int>;
      
      public function EvolveInfo()
      {
         super();
         this.itemVec = new Vector.<int>();
      }
   }
}
