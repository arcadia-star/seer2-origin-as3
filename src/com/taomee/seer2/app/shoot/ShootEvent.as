package com.taomee.seer2.app.shoot
{
   import flash.events.Event;
   
   public class ShootEvent extends Event
   {
      
      public static const OPEN:String = "open";
      
      public static const CLOSE:String = "close";
      
      public static const SERVER_LEFT_PLAY_START:String = "serverLeftPlayStart";
      
      public static const PLAY_START:String = "playStart";
      
      public static const PLAY_END:String = "playEnd";
       
      
      private var _info:ShootInfo;
      
      public function ShootEvent(param1:String, param2:ShootInfo)
      {
         super(param1);
         this._info = param2;
      }
      
      public function get info() : ShootInfo
      {
         return this._info;
      }
   }
}
