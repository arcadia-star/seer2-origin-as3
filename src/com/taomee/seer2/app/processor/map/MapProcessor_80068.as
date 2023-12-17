package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.actives.TwelveTurnFightAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80068 extends MapProcessor
   {
       
      
      public function MapProcessor_80068(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         TwelveTurnFightAct.getInstance().setup(_map);
         super.init();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         TwelveTurnFightAct.getInstance().dispose();
      }
   }
}
