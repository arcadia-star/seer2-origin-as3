package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TwelveTurnFight;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80101 extends MapProcessor
   {
       
      
      public function MapProcessor_80101(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         TwelveTurnFight.getInstance().setup();
         super.init();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TwelveTurnFight.getInstance().dispose();
      }
   }
}
