package com.taomee.seer2.app.activity.data
{
   public class ActivityPetDefinition
   {
       
      
      public var resId:int;
      
      public var name:String;
      
      public var sloganVec:Vector.<String>;
      
      public function ActivityPetDefinition(param1:int, param2:String, param3:Array)
      {
         super();
         this.resId = param1;
         this.name = param2;
         this.sloganVec = Vector.<String>(param3);
      }
   }
}
