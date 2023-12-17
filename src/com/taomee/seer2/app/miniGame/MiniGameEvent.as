package com.taomee.seer2.app.miniGame
{
   import flash.events.Event;
   
   public class MiniGameEvent extends Event
   {
      
      public static const START_PLAY_GAME:String = "startPlayGame";
      
      public static const END_PLAY_GAME:String = "endPlayGame";
       
      
      private var _gameId:int;
      
      private var _gameInfo:MiniGameInfo;
      
      public function MiniGameEvent(param1:String, param2:int, param3:MiniGameInfo = null, param4:Boolean = false, param5:Boolean = false)
      {
         this._gameId = param2;
         this._gameInfo = param3;
         super(param1,param4,param5);
      }
      
      public function get gameInfo() : MiniGameInfo
      {
         return this._gameInfo;
      }
      
      public function get gameId() : int
      {
         return this._gameId;
      }
   }
}
