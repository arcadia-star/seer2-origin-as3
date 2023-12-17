package com.taomee.seer2.core.animation.frame
{
   public class FrameLabelInfo
   {
       
      
      public var name:String;
      
      public var startIndex:uint;
      
      public var endIndex:uint;
      
      public function FrameLabelInfo(param1:String, param2:uint, param3:uint)
      {
         super();
         this.name = param1;
         this.startIndex = param2;
         this.endIndex = param3;
      }
   }
}
