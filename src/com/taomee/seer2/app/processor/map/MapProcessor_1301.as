package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.holyLight.HolyLightAct;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   
   public class MapProcessor_1301 extends MapProcessor
   {
       
      
      private var _holyLightAct:HolyLightAct;
      
      public function MapProcessor_1301(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         (_map.content["rank"] as MovieClip).gotoAndStop(2);
         this._holyLightAct = new HolyLightAct(_map);
      }
      
      override public function dispose() : void
      {
         this._holyLightAct.dispose();
         this._holyLightAct = null;
      }
   }
}
