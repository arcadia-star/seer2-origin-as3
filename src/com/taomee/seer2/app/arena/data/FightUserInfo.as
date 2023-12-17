package com.taomee.seer2.app.arena.data
{
   import flash.utils.IDataInput;
   
   public class FightUserInfo
   {
       
      
      private var _userId:int;
      
      private var _nick:String;
      
      private var _fighterInfoVec:Vector.<FighterInfo>;
      
      private var _changeFighterInfoVec:Vector.<FighterInfo>;
      
      public function FightUserInfo(param1:IDataInput)
      {
         var _loc4_:FighterInfo = null;
         var _loc5_:FighterInfo = null;
         super();
         this._userId = param1.readUnsignedInt();
         this._nick = param1.readUTFBytes(16);
         var _loc2_:int = int(param1.readUnsignedInt());
         this._fighterInfoVec = new Vector.<FighterInfo>();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc4_ = new FighterInfo(this._userId,param1)).isChangePet = false;
            _loc4_.isChange = 0;
            this._fighterInfoVec.push(_loc4_);
            _loc3_++;
         }
         _loc2_ = int(param1.readUnsignedInt());
         this._changeFighterInfoVec = Vector.<FighterInfo>([]);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc5_ = new FighterInfo(this._userId,param1)).isChangePet = true;
            _loc5_.isChange = 0;
            this._changeFighterInfoVec.push(_loc5_);
            _loc3_++;
         }
      }
      
      public function printInfomation(param1:String = "") : void
      {
         var _loc2_:FighterInfo = null;
         for each(_loc2_ in this._fighterInfoVec)
         {
            _loc2_.printInfomation(param1 + "     ");
         }
      }
      
      public function get userId() : int
      {
         return this._userId;
      }
      
      public function get nick() : String
      {
         return this._nick;
      }
      
      public function get fighterInfoVec() : Vector.<FighterInfo>
      {
         return this._fighterInfoVec;
      }
      
      public function get changeFighterInfoVec() : Vector.<FighterInfo>
      {
         return this._changeFighterInfoVec;
      }
   }
}
