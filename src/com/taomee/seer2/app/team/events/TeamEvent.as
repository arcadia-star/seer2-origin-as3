package com.taomee.seer2.app.team.events
{
   import flash.events.Event;
   
   public class TeamEvent extends Event
   {
      
      public static const CREATE:String = "teamCreate";
      
      public static const CHANGE:String = "teamInfoChange";
      
      public static const DISOLVE:String = "teamDisolve";
      
      public static const TRANFER_LEADER:String = "transferLeader";
      
      public static const ADD:String = "AddTeam";
      
      public static const QUIT:String = "QuitTeam";
       
      
      public var _content:*;
      
      public function TeamEvent(param1:String, param2:* = null, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param3,param4);
         this._content = param2;
      }
      
      public function get content() : *
      {
         return this._content;
      }
   }
}
