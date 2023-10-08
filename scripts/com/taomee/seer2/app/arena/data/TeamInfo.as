package com.taomee.seer2.app.arena.data
{
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.arena.util.FightSide;
   import flash.utils.IDataInput;
   
   public class TeamInfo
   {
       
      
      private var _leaderId:int;
      
      private var _serverSide:int;
      
      private var _clientSide:int;
      
      private var _fightUserInfoVec:Vector.<com.taomee.seer2.app.arena.data.FightUserInfo>;
      
      public function TeamInfo(param1:IDataInput, param2:uint)
      {
         var _loc5_:com.taomee.seer2.app.arena.data.FightUserInfo = null;
         super();
         this._serverSide = param1.readUnsignedByte();
         this._clientSide = this._serverSide;
         this._leaderId = param1.readUnsignedInt();
         var _loc3_:int = int(param1.readUnsignedInt());
         this._fightUserInfoVec = new Vector.<com.taomee.seer2.app.arena.data.FightUserInfo>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new com.taomee.seer2.app.arena.data.FightUserInfo(param1);
            this._fightUserInfoVec.push(_loc5_);
            _loc4_++;
         }
         if(param2 >= 100)
         {
            if(this.leaderId == ActorManager.actorInfo.id)
            {
               this._clientSide = FightSide.LEFT;
            }
            else
            {
               this._clientSide = FightSide.RIGHT;
            }
         }
      }
      
      public function printInfomation(param1:String = "") : void
      {
         var _loc2_:com.taomee.seer2.app.arena.data.FightUserInfo = null;
         for each(_loc2_ in this._fightUserInfoVec)
         {
            _loc2_.printInfomation(param1 + "     ");
         }
      }
      
      public function get fightUserInfoVec() : Vector.<com.taomee.seer2.app.arena.data.FightUserInfo>
      {
         return this._fightUserInfoVec;
      }
      
      public function get serverSide() : int
      {
         return this._serverSide;
      }
      
      public function get clientSide() : int
      {
         return this._clientSide;
      }
      
      public function get leaderId() : int
      {
         return this._leaderId;
      }
   }
}
