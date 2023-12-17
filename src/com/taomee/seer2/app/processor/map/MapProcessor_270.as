package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.gameRule.spt.SptHuoKeSupport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   
   public class MapProcessor_270 extends MapProcessor
   {
       
      
      private var _fire0:MovieClip;
      
      private var _fire2:MovieClip;
      
      public function MapProcessor_270(param1:MapModel)
      {
         super(param1);
      }
      
      override public function dispose() : void
      {
         SptHuoKeSupport.getInstance().dispose();
         this.disposeFireAnimation();
      }
      
      override public function init() : void
      {
         SptHuoKeSupport.getInstance().init(_map);
         this.initFireAnimation();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_169);
      }
      
      private function initFireAnimation() : void
      {
         this._fire0 = _map.content["fire0"];
         this._fire2 = _map.content["fire2"];
      }
      
      private function disposeFireAnimation() : void
      {
         this._fire0.gotoAndStop(2);
         this._fire2.gotoAndStop(2);
         this._fire0 = null;
         this._fire2 = null;
      }
   }
}
