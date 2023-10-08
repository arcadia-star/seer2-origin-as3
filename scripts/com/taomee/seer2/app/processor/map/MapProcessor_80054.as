package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.moPetProcessAct.MoFightAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80054 extends MapProcessor
   {
       
      
      public function MapProcessor_80054(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         MoFightAct.getInstance().setup(_map);
      }
      
      override public function dispose() : void
      {
         MoFightAct.getInstance().dispose();
         super.dispose();
      }
   }
}
