package com.taomee.seer2.app.arena.controller
{
   import com.taomee.seer2.app.arena.Fighter;
   
   public interface IFighterChange
   {
       
      
      function dispose() : void;
      
      function changeFighter(param1:uint, param2:uint, param3:uint, param4:uint = 1) : void;
      
      function changeLeftMainFighter(param1:Fighter, param2:uint) : void;
      
      function changeLeftSubFighter(param1:Fighter, param2:uint) : void;
      
      function checkRightFighterChanged() : void;
   }
}
