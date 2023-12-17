package com.taomee.seer2.app.gameRule.behavior
{
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import flash.net.SharedObject;
   
   public class SOMultiBehavior
   {
       
      
      public function SOMultiBehavior()
      {
         super();
      }
      
      public static function getKey(param1:uint) : String
      {
         return "invite_" + param1;
      }
      
      public static function readDefaultPets(param1:String) : Array
      {
         var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.INVITIE_FIGHT);
         return _loc2_.data[param1];
      }
      
      public static function writeDefaultPets(param1:String, param2:Array) : void
      {
         var _loc3_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.INVITIE_FIGHT);
         _loc3_.data[param1] = param2;
         _loc3_.flush();
      }
   }
}
