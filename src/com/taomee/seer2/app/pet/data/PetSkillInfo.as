package com.taomee.seer2.app.pet.data
{
   internal class PetSkillInfo
   {
       
      
      private var _skillInfoVec:Vector.<SkillInfo>;
      
      private var _candidateSkillInfoVec:Vector.<SkillInfo>;
      
      private var _gainedSkillInfoVec:Vector.<SkillInfo>;
      
      public function PetSkillInfo()
      {
         super();
      }
      
      public function updateSkillInfoVec(param1:Vector.<SkillInfo>) : void
      {
         var _loc2_:SkillInfo = null;
         var _loc3_:SkillInfo = null;
         this._skillInfoVec = new Vector.<SkillInfo>();
         for each(_loc2_ in param1)
         {
            _loc3_ = new SkillInfo(_loc2_.id);
            this._skillInfoVec.push(_loc3_);
         }
      }
      
      public function hasSkillInfo(param1:SkillInfo) : Boolean
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
      
      public function hasCandidateSkillInfo(param1:SkillInfo) : Boolean
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
      
      public function addGainedSkillInfoVec(param1:Vector.<SkillInfo>) : void
      {
         var _loc2_:SkillInfo = null;
         for each(_loc2_ in param1)
         {
            if(!this.hasSkillInfo(_loc2_))
            {
               this._candidateSkillInfoVec.push(_loc2_);
            }
         }
      }
      
      public function get skillInfoVec() : Vector.<SkillInfo>
      {
         return this._skillInfoVec;
      }
      
      public function get candidateSkillInfoVec() : Vector.<SkillInfo>
      {
         return this._candidateSkillInfoVec;
      }
      
      public function get gainedSkillInfoVec() : Vector.<SkillInfo>
      {
         return this._gainedSkillInfoVec;
      }
      
      public function set skillInfoVec(param1:Vector.<SkillInfo>) : void
      {
         this._skillInfoVec = param1;
      }
      
      public function set candidateSkillInfoVec(param1:Vector.<SkillInfo>) : void
      {
         this._candidateSkillInfoVec = param1;
      }
      
      public function set gainedSkillInfoVec(param1:Vector.<SkillInfo>) : void
      {
         this._gainedSkillInfoVec = param1;
      }
   }
}
