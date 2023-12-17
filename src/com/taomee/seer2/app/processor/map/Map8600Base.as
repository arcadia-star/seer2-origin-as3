package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class Map8600Base extends MapProcessor
   {
       
      
      private var _gameHandler:MapDiLao;
      
      public function Map8600Base(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._gameHandler = new MapDiLao(_map);
      }
      
      override public function dispose() : void
      {
         if(this._gameHandler)
         {
            this._gameHandler.dispose();
            this._gameHandler = null;
         }
         super.dispose();
      }
   }
}
