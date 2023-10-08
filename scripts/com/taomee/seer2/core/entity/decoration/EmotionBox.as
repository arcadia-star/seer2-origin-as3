package com.taomee.seer2.core.entity.decoration
{
   import flash.display.Sprite;
   
   public class EmotionBox extends Sprite
   {
       
      
      public function EmotionBox()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.mouseChildren = false;
         this.mouseEnabled = false;
      }
   }
}
