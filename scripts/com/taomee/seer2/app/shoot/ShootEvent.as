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
       
      
      private var _info:com.taomee.seer2.app.shoot.ShootInfo;
      
      public function ShootEvent(param1:String, param2:com.taomee.seer2.app.shoot.ShootInfo)
      {
         super(param1);
         this._info = param2;
      }
      
      public function get info() : com.taomee.seer2.app.shoot.ShootInfo
      {
         return this._info;
      }
   }
}
