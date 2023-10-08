package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.SixStarLoopFormationAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80037 extends MapProcessor
   {
       
      
      public function MapProcessor_80037(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         SixStarLoopFormationAct.getInstance().setup();
      }
      
      override public function dispose() : void
      {
         SixStarLoopFormationAct.getInstance().dispose();
         super.dispose();
      }
   }
}
