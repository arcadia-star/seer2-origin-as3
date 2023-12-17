package com.taomee.seer2.app.arena.data
{
   import flash.utils.IDataInput;
   
   public class FighterTurnResultInfo
   {
       
      
      private const CENTER_VALUE:int = 6;
      
      private var _isAtker:Boolean = false;
      
      private var _userId:uint;
      
      private var _catchTime:uint;
      
      private var _skillId:uint;
      
      private var _position:uint;
      
      private var _hp:uint;
      
      private var _maxHp:uint;
      
      private var _anger:uint;
      
      private var _isDying:Boolean;
      
      private var _atk:int;
      
      private var _defence:int;
      
      private var _specialAtk:int;
      
      private var _specialDefence:int;
      
      private var _speed:int;
      
      private var _buffInfoVec:Vector.<FighterBuffInfo>;
      
      public function FighterTurnResultInfo(param1:IDataInput)
      {
         super();
         var _loc2_:int = int(param1.readUnsignedByte());
         if(_loc2_ == 1)
         {
            this._isAtker = true;
         }
         this._userId = param1.readUnsignedInt();
         this._catchTime = param1.readUnsignedInt();
         this._skillId = param1.readUnsignedInt();
         this._position = param1.readUnsignedByte();
         this._hp = param1.readUnsignedInt();
         this._maxHp = param1.readUnsignedInt();
         this._anger = param1.readUnsignedShort();
         this._isDying = param1.readUnsignedByte() == 1;
         this._atk = param1.readUnsignedByte();
         this._defence = param1.readUnsignedByte();
         this._specialAtk = param1.readUnsignedByte();
         this._specialDefence = param1.readUnsignedByte();
         this._speed = param1.readUnsignedByte();
         this._buffInfoVec = new Vector.<FighterBuffInfo>();
         var _loc3_:uint = uint(param1.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._buffInfoVec.push(new FighterBuffInfo(param1));
            _loc4_++;
         }
      }
      
      public function get anger() : uint
      {
         return this._anger;
      }
      
      public function get isDying() : Boolean
      {
         return this._isDying;
      }
      
      public function get changedAtk() : int
      {
         return this._atk - this.CENTER_VALUE;
      }
      
      public function get changedDefence() : int
      {
         return this._defence - this.CENTER_VALUE;
      }
      
      public function get changedSpecialAtk() : int
      {
         return this._specialAtk - this.CENTER_VALUE;
      }
      
      public function get changedSpecialDefence() : int
      {
         return this._specialDefence - this.CENTER_VALUE;
      }
      
      public function get changedSpeed() : int
      {
         return this._speed - this.CENTER_VALUE;
      }
      
      public function get buffInfoVec() : Vector.<FighterBuffInfo>
      {
         return this._buffInfoVec;
      }
      
      public function get catchTime() : uint
      {
         return this._catchTime;
      }
      
      public function get hp() : uint
      {
         return this._hp;
      }
      
      public function get maxHp() : uint
      {
         return this._maxHp;
      }
      
      public function get skillId() : uint
      {
         return this._skillId;
      }
      
      public function get userId() : uint
      {
         return this._userId;
      }
      
      public function get isAtker() : Boolean
      {
         return this._isAtker;
      }
   }
}
