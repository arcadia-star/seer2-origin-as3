package com.taomee.seer2.app.arena.data
{
   import com.taomee.seer2.app.config.skill.SkillTypeRelation;
   import flash.utils.IDataInput;
   
   public class TurnResultInfo
   {
       
      
      private var _notifyIndex:int;
      
      private var _isCritical:Boolean;
      
      private var _atkTimes:int;
      
      private var _changedHp:int;
      
      private var _fighterTurnResultInfoVec:Vector.<FighterTurnResultInfo>;
      
      private var _skillTypeDelation:uint;
      
      public function TurnResultInfo(param1:IDataInput)
      {
         var _loc3_:FighterTurnResultInfo = null;
         var _loc5_:FighterBuffInfo = null;
         super();
         this._fighterTurnResultInfoVec = new Vector.<FighterTurnResultInfo>();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = new FighterTurnResultInfo(param1);
            this._fighterTurnResultInfoVec.push(_loc3_);
            for each(_loc5_ in _loc3_.buffInfoVec)
            {
            }
            _loc4_++;
         }
         this._notifyIndex = param1.readUnsignedInt();
         this._isCritical = param1.readUnsignedInt() >= 1;
         this._skillTypeDelation = param1.readUnsignedInt();
         this._atkTimes = param1.readUnsignedInt();
         this._changedHp = param1.readUnsignedInt();
         if(this._skillTypeDelation > 100)
         {
            this._skillTypeDelation = SkillTypeRelation.KEZHI;
         }
         else if(this._skillTypeDelation < 100)
         {
            this._skillTypeDelation = SkillTypeRelation.WEIRUO;
         }
         else
         {
            this._skillTypeDelation = SkillTypeRelation.YIBAN;
         }
      }
      
      public function get notifyIndex() : int
      {
         return this._notifyIndex;
      }
      
      public function get isCritical() : Boolean
      {
         return this._isCritical;
      }
      
      public function get atkTimes() : int
      {
         return this._atkTimes;
      }
      
      public function get changedHp() : int
      {
         return this._changedHp;
      }
      
      public function get fighterTurnResultInfoVec() : Vector.<FighterTurnResultInfo>
      {
         return this._fighterTurnResultInfoVec;
      }
      
      public function get skillTypeDelation() : uint
      {
         return this._skillTypeDelation;
      }
   }
}
