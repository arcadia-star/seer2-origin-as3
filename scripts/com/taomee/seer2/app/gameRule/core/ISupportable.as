package com.taomee.seer2.app.gameRule.core
{
   import com.taomee.seer2.core.map.MapModel;
   
   public interface ISupportable
   {
       
      
      function dispose() : void;
      
      function init(param1:MapModel) : void;
   }
}
