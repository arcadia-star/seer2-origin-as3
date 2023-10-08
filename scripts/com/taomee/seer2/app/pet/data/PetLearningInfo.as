package com.taomee.seer2.app.pet.data
{
   internal class PetLearningInfo
   {
       
      
      private var _pointUnused:uint;
      
      private var _pointHp:uint;
      
      private var _pointAtk:uint;
      
      private var _pointSpecialAtk:uint;
      
      private var _pointDefence:uint;
      
      private var _pointSpecialDefence:uint;
      
      private var _pointSpeed:uint;
      
      public function PetLearningInfo()
      {
         super();
      }
      
      public function get pointUnused() : uint
      {
         return this._pointUnused;
      }
      
      public function set pointUnused(param1:uint) : void
      {
         this._pointUnused = param1;
      }
      
      public function get pointHp() : uint
      {
         return this._pointHp;
      }
      
      public function set pointHp(param1:uint) : void
      {
         this._pointHp = param1;
      }
      
      public function get pointAtk() : uint
      {
         return this._pointAtk;
      }
      
      public function set pointAtk(param1:uint) : void
      {
         this._pointAtk = param1;
      }
      
      public function get pointSpecialAtk() : uint
      {
         return this._pointSpecialAtk;
      }
      
      public function set pointSpecialAtk(param1:uint) : void
      {
         this._pointSpecialAtk = param1;
      }
      
      public function get pointDefence() : uint
      {
         return this._pointDefence;
      }
      
      public function set pointDefence(param1:uint) : void
      {
         this._pointDefence = param1;
      }
      
      public function get pointSpecialDefence() : uint
      {
         return this._pointSpecialDefence;
      }
      
      public function set pointSpecialDefence(param1:uint) : void
      {
         this._pointSpecialDefence = param1;
      }
      
      public function get pointSpeed() : uint
      {
         return this._pointSpeed;
      }
      
      public function set pointSpeed(param1:uint) : void
      {
         this._pointSpeed = param1;
      }
      
      public function pointTotal() : uint
      {
         return this._pointUnused + this._pointHp + this._pointAtk + this._pointSpecialAtk + this._pointDefence + this._pointSpecialDefence + this._pointSpeed;
      }
   }
}
