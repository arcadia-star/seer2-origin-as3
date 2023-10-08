package com.taomee.seer2.app.home.data
{
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   import com.taomee.seer2.app.pet.constant.PetCharactarNameMap;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.pet.data.SkillInfo;
   import flash.utils.IDataInput;
   
   public class TrainingPetInfo
   {
       
      
      public var id:uint;
      
      public var resourceId:uint;
      
      public var level:uint;
      
      public var character:uint;
      
      public var startTrainingTime:uint;
      
      public var fightExp:uint;
      
      public var maxHp:uint;
      
      public var atk:uint;
      
      public var specialAtk:uint;
      
      public var defence:uint;
      
      public var specialDefence:uint;
      
      public var speed:uint;
      
      public var skillInfoVec:Vector.<SkillInfo>;
      
      public var battlePotential:uint;
      
      private var _name:String;
      
      private var _petDefinition:PetDefinition;
      
      private var _flag:int = -1;
      
      private var _isInBag:Boolean;
      
      private var _isStarting:Boolean;
      
      private var _isFollowing:Boolean;
      
      private var _isInFreeStorage:Boolean;
      
      private var _isTraining:Boolean;
      
      private var _isAggraisal:Boolean;
      
      public function TrainingPetInfo(param1:IDataInput = null)
      {
         super();
         if(param1 != null)
         {
            this.resourceId = param1.readUnsignedInt();
            this.id = param1.readUnsignedInt();
            this.level = param1.readUnsignedInt();
            this.character = param1.readUnsignedInt();
            this.battlePotential = param1.readUnsignedInt();
            this.startTrainingTime = param1.readUnsignedInt();
            this.fightExp = param1.readUnsignedInt();
         }
      }
      
      public function readSkillInfo(param1:IDataInput) : void
      {
         var _loc3_:uint = 0;
         this.skillInfoVec = new Vector.<SkillInfo>();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = uint(param1.readUnsignedInt());
            this.skillInfoVec.push(new SkillInfo(_loc3_));
            _loc4_++;
         }
      }
      
      public function convertToPetInfo() : PetInfo
      {
         var _loc1_:PetInfo = new PetInfo();
         _loc1_.catchTime = this.id;
         _loc1_.resourceId = this.resourceId;
         _loc1_.level = this.level;
         _loc1_.maxHp = this.maxHp;
         _loc1_.atk = this.atk;
         _loc1_.specialAtk = this.specialAtk;
         _loc1_.defence = this.defence;
         _loc1_.specialDefence = this.specialDefence;
         _loc1_.speed = this.speed;
         _loc1_.skillInfo.skillInfoVec = this.skillInfoVec;
         return _loc1_;
      }
      
      public function parseFlag(param1:int) : void
      {
         this._flag = param1;
         this._isInBag = (param1 & 1) == 1;
         this._isStarting = (param1 & 2) == 2;
         this._isFollowing = (param1 & 4) == 4;
         this._isInFreeStorage = (param1 & 8) == 8;
         this._isTraining = (param1 & 16) == 16;
         this._isAggraisal = (param1 & 32) == 32;
      }
      
      public function get name() : String
      {
         if(this._name == null)
         {
            this._name = PetConfig.getPetDefinition(this.resourceId).name;
         }
         return this._name;
      }
      
      public function get type() : int
      {
         var _loc1_:PetDefinition = this.getPetDefinition();
         if(_loc1_)
         {
            return _loc1_.type;
         }
         return 0;
      }
      
      public function get characterName() : String
      {
         return PetCharactarNameMap.getCharactarName(this.character);
      }
      
      public function get foundPlace() : String
      {
         var _loc1_:PetDefinition = this.getPetDefinition();
         if(_loc1_)
         {
            return _loc1_.foundPlace;
         }
         return "未设置";
      }
      
      public function getPetDefinition() : PetDefinition
      {
         if(this._petDefinition == null)
         {
            this._petDefinition = PetConfig.getPetDefinition(this.resourceId);
         }
         return this._petDefinition;
      }
      
      private function updateFlag() : void
      {
         var _loc1_:int = 0;
         _loc1_ += this._isInBag ? 1 : 0;
         _loc1_ += this._isStarting ? 2 : 0;
         _loc1_ += this._isFollowing ? 4 : 0;
         _loc1_ += this._isInFreeStorage ? 8 : 0;
         _loc1_ += this._isTraining ? 16 : 0;
         _loc1_ += this._isAggraisal ? 32 : 0;
         this._flag = _loc1_;
      }
      
      public function get isInStorage() : Boolean
      {
         return !this._isInBag;
      }
      
      public function get isInBag() : Boolean
      {
         return this._isInBag;
      }
      
      public function get isStarting() : Boolean
      {
         return this._isStarting;
      }
      
      public function get isFollowing() : Boolean
      {
         return this._isFollowing;
      }
      
      public function get isInFreeStorage() : Boolean
      {
         return this._isInFreeStorage;
      }
      
      public function get isTraining() : Boolean
      {
         return this._isTraining;
      }
      
      public function get isAggraisal() : Boolean
      {
         return this._isAggraisal;
      }
      
      public function set isInBag(param1:Boolean) : void
      {
         this._isInBag = param1;
         this.updateFlag();
      }
      
      public function set isStarting(param1:Boolean) : void
      {
         this._isStarting = param1;
         this.updateFlag();
      }
      
      public function set isFollowing(param1:Boolean) : void
      {
         this._isFollowing = param1;
         this.updateFlag();
      }
      
      public function set isInFreeStorage(param1:Boolean) : void
      {
         this._isInFreeStorage = param1;
         this.updateFlag();
      }
      
      public function set isTraining(param1:Boolean) : void
      {
         this._isTraining = param1;
         this.updateFlag();
      }
      
      public function set isAggraisal(param1:Boolean) : void
      {
         this._isAggraisal = param1;
         this.updateFlag();
      }
      
      public function get flag() : int
      {
         return this._flag;
      }
   }
}
