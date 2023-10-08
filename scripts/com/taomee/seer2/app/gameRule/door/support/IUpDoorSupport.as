package com.taomee.seer2.app.gameRule.door.support
{
   import com.taomee.seer2.app.gameRule.core.ISupportable;
   
   public interface IUpDoorSupport extends ISupportable, IDoorSupport
   {
       
      
      function reset() : void;
      
      function get canLevelNow() : Boolean;
      
      function set canLevelNow(param1:Boolean) : void;
   }
}
