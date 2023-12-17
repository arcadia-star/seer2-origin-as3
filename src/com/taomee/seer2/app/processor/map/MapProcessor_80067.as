package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   
   public class MapProcessor_80067 extends MapProcessor
   {
       
      
      private var $game:SpriteLianYiGame;
      
      public function MapProcessor_80067(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.$game = new SpriteLianYiGame(_map);
      }
      
      override public function dispose() : void
      {
         if(this.$game)
         {
            this.$game.dispose();
         }
         super.dispose();
      }
   }
}
