package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80069 extends MapProcessor
   {
       
      
      private var sceneGame:SpriteBaseGame;
      
      public function MapProcessor_80069(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.sceneGame = new SpriteBaseGame(_map);
      }
      
      override public function dispose() : void
      {
         if(this.sceneGame)
         {
            this.sceneGame.dispose();
         }
         super.dispose();
      }
   }
}
