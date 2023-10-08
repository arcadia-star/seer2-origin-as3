package com.taomee.seer2.app.gameRule.door.core
{
   public interface IDoorServerPetable
   {
       
      
      function getPetSimpleInfo(param1:uint, param2:uint) : void;
      
      function get petId() : uint;
      
      function get resourceId() : uint;
   }
}
