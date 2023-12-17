package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.data.BuffResultInfo;
   import com.taomee.seer2.app.arena.data.FightResultInfo;
   import com.taomee.seer2.app.arena.data.FighterTeam;
   import com.taomee.seer2.app.arena.data.PvpFightChangeInfo;
   import com.taomee.seer2.app.arena.data.RevenueInfo;
   import com.taomee.seer2.app.arena.data.TurnResultInfo;
   import flash.display.Sprite;
   
   public interface IFightController
   {
       
      
      function addPar(param1:Sprite) : void;
      
      function parseTurnResult() : void;
      
      function changeFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1) : void;
      
      function checkRightFighterChanged() : void;
      
      function changeFighterState(param1:String) : void;
      
      function get state() : String;
      
      function addBuffResultInfo(param1:BuffResultInfo) : void;
      
      function addTurnResultInfo(param1:TurnResultInfo) : void;
      
      function addPvpFightInfo(param1:PvpFightChangeInfo) : void;
      
      function dispose() : void;
      
      function startFighter() : void;
      
      function exitFight() : void;
      
      function set resultInfo(param1:FightResultInfo) : void;
      
      function set revenueInfo(param1:RevenueInfo) : void;
      
      function get leftTeam() : FighterTeam;
      
      function get rightTeam() : FighterTeam;
      
      function get arenaUIController() : IArenaUIController;
      
      function get rightMainFighter() : Fighter;
      
      function get leftMainFighter() : Fighter;
      
      function get rightSubFighter() : Fighter;
      
      function get leftSubFighter() : Fighter;
   }
}
