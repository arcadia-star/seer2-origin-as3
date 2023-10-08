package com.taomee.seer2.app.actor.group
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import org.taomee.ds.HashMap;
   
   internal class UserGroup
   {
       
      
      private var _type:String;
      
      private var _map:HashMap;
      
      public function UserGroup(param1:String)
      {
         super();
         this._type = param1;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._map = new HashMap();
      }
      
      public function addUser(param1:UserInfo) : void
      {
         if(this.containsUser(param1.id) == false)
         {
            this._map.add(param1.id,param1);
         }
      }
      
      public function removeUser(param1:UserInfo) : void
      {
         if(this.containsUser(param1.id) == true)
         {
            this._map.remove(param1.id);
         }
      }
      
      public function clear() : void
      {
         this._map.clear();
      }
      
      public function updateUser(param1:UserInfo) : void
      {
         if(this.containsUser(param1.id) == true)
         {
            this.getUser(param1.id).update(param1);
         }
      }
      
      public function getUser(param1:uint) : UserInfo
      {
         if(this.containsUser(param1) == true)
         {
            return this._map.getValue(param1);
         }
         return null;
      }
      
      public function containsUser(param1:uint) : Boolean
      {
         if(this._map.containsKey(param1) == true)
         {
            return true;
         }
         return false;
      }
      
      public function getAllUser() : Vector.<UserInfo>
      {
         return Vector.<UserInfo>(this._map.getValues());
      }
   }
}
