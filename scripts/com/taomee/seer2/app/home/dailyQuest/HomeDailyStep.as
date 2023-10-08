package com.taomee.seer2.app.home.dailyQuest
{
   import com.taomee.seer2.app.inventory.ItemDescription;
   
   internal class HomeDailyStep
   {
       
      
      public var id:int;
      
      public var itemDesVec:Vector.<ItemDescription>;
      
      public function HomeDailyStep(param1:int, param2:Array)
      {
         var _loc3_:Object = null;
         super();
         this.id = param1;
         this.itemDesVec = new Vector.<ItemDescription>();
         for each(_loc3_ in param2)
         {
            this.itemDesVec.push(new ItemDescription(_loc3_.id,_loc3_.count,0,_loc3_.isPet,_loc3_.isAdd));
         }
      }
   }
}
