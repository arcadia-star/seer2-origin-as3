package com.taomee.seer2.app.component
{
   import flash.display.MovieClip;
   
   public class Guider
   {
      
      private static var _instance:Guider;
       
      
      private var _guider:MovieClip;
      
      public function Guider()
      {
         super();
      }
      
      private static function get instance() : Guider
      {
         if(!_instance)
         {
            _instance = new Guider();
         }
         return _instance;
      }
      
      public static function show(param1:int, param2:int) : void
      {
      }
      
      public static function hide() : void
      {
      }
      
      private function show(param1:int, param2:int) : void
      {
      }
      
      private function hide() : void
      {
      }
   }
}
