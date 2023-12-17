package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_3041 extends MapProcessor
   {
       
      
      private var _game:Map3041Game;
      
      public function MapProcessor_3041(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice("0x10034181");
         this._game = new Map3041Game(_map);
      }
      
      override public function dispose() : void
      {
         if(this._game)
         {
            this._game.dispose();
            this._game = null;
         }
         super.dispose();
      }
   }
}
