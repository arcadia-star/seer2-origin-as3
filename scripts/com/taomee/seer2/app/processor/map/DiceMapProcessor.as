package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.map.diceThing.DiceMapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class DiceMapProcessor extends MapProcessor
   {
       
      
      public function DiceMapProcessor(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         DiceMapManager.getInstance().setup(_map);
      }
   }
}
