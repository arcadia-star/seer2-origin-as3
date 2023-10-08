package com.taomee.seer2.app.pet.data
{
   internal class PetSkillInfo
   {
       
      
      private var _skillInfoVec:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>;
      
      private var _candidateSkillInfoVec:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>;
      
      private var _gainedSkillInfoVec:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>;
      
      public function PetSkillInfo()
      {
         super();
      }
      
      public function updateSkillInfoVec(param1:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>) : void
      {
         var _loc2_:com.taomee.seer2.app.pet.data.SkillInfo = null;
         var _loc3_:com.taomee.seer2.app.pet.data.SkillInfo = null;
         this._skillInfoVec = new Vector.<com.taomee.seer2.app.pet.data.SkillInfo>();
         for each(_loc2_ in param1)
         {
            _loc3_ = new com.taomee.seer2.app.pet.data.SkillInfo(_loc2_.id);
            this._skillInfoVec.push(_loc3_);
         }
      }
      
      public function hasSkillInfo(param1:com.taomee.seer2.app.pet.data.SkillInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = this._skillInfoVec.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._skillInfoVec[_loc4_].id == param1.id)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function hasCandidateSkillInfo(param1:com.taomee.seer2.app.pet.data.SkillInfo) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:uint = this._candidateSkillInfoVec.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(this._candidateSkillInfoVec[_loc4_].id == param1.id)
            {
               _loc2_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function addGainedSkillInfoVec(param1:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>) : void
      {
         var _loc2_:com.taomee.seer2.app.pet.data.SkillInfo = null;
         for each(_loc2_ in param1)
         {
            if(!this.hasSkillInfo(_loc2_))
            {
               this._candidateSkillInfoVec.push(_loc2_);
            }
         }
      }
      
      public function get skillInfoVec() : Vector.<com.taomee.seer2.app.pet.data.SkillInfo>
      {
         return this._skillInfoVec;
      }
      
      public function get candidateSkillInfoVec() : Vector.<com.taomee.seer2.app.pet.data.SkillInfo>
      {
         return this._candidateSkillInfoVec;
      }
      
      public function get gainedSkillInfoVec() : Vector.<com.taomee.seer2.app.pet.data.SkillInfo>
      {
         return this._gainedSkillInfoVec;
      }
      
      public function set skillInfoVec(param1:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>) : void
      {
         this._skillInfoVec = param1;
      }
      
      public function set candidateSkillInfoVec(param1:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>) : void
      {
         this._candidateSkillInfoVec = param1;
      }
      
      public function set gainedSkillInfoVec(param1:Vector.<com.taomee.seer2.app.pet.data.SkillInfo>) : void
      {
         this._gainedSkillInfoVec = param1;
      }
   }
}
