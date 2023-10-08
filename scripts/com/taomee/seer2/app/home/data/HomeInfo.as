package com.taomee.seer2.app.home.data
{
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import flash.utils.IDataInput;
   
   public class HomeInfo
   {
       
      
      private var _userInfo:UserInfo;
      
      private var _leftFightCount:int;
      
      private var _trainingPetInfoVec:Vector.<com.taomee.seer2.app.home.data.TrainingPetInfo>;
      
      private var _birthPetInfo:PetInfo;
      
      private var _suleAwardCount:uint;
      
      private var _semiyaCount:uint;
      
      public var garbageCount:int;
      
      public var decorateInfo:com.taomee.seer2.app.home.data.DecorateInfo;
      
      public var nextyearActivityInfo:com.taomee.seer2.app.home.data.NextyearActivityInfo;
      
      public function HomeInfo()
      {
         super();
      }
      
      public function parse1038(param1:IDataInput) : void
      {
         var _loc6_:com.taomee.seer2.app.home.data.TrainingPetInfo = null;
         this._leftFightCount = param1.readUnsignedByte();
         var _loc2_:int = int(param1.readUnsignedInt());
         this._trainingPetInfoVec = new Vector.<com.taomee.seer2.app.home.data.TrainingPetInfo>();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            (_loc6_ = new com.taomee.seer2.app.home.data.TrainingPetInfo(param1)).maxHp = param1.readUnsignedInt();
            _loc6_.atk = param1.readUnsignedShort();
            _loc6_.specialAtk = param1.readUnsignedShort();
            _loc6_.defence = param1.readUnsignedShort();
            _loc6_.specialDefence = param1.readUnsignedShort();
            _loc6_.speed = param1.readUnsignedShort();
            _loc6_.readSkillInfo(param1);
            _loc6_.parseFlag(param1.readUnsignedInt());
            this._trainingPetInfoVec.push(_loc6_);
            _loc3_++;
         }
         this.garbageCount = param1.readByte();
         var _loc4_:int = int(param1.readUnsignedInt());
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._birthPetInfo = new PetInfo();
            PetInfo.readPetInfo(this._birthPetInfo,param1);
            _loc5_++;
         }
         this._suleAwardCount = param1.readUnsignedInt();
         this.decorateInfo = new com.taomee.seer2.app.home.data.DecorateInfo(param1);
         this._semiyaCount = param1.readUnsignedInt();
      }
      
      public function parseSpecialInfo(param1:IDataInput) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         param1.readUnsignedByte();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedInt();
            param1.readUnsignedShort();
            param1.readUnsignedShort();
            param1.readUnsignedShort();
            param1.readUnsignedShort();
            param1.readUnsignedShort();
            _loc4_ = int(param1.readUnsignedInt());
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               param1.readUnsignedInt();
               _loc5_++;
            }
            param1.readUnsignedInt();
            _loc3_++;
         }
         param1.readByte();
      }
      
      public function get trainingPetInfoVec() : Vector.<com.taomee.seer2.app.home.data.TrainingPetInfo>
      {
         return this._trainingPetInfoVec.concat();
      }
      
      public function addTrainingPetInfo(param1:com.taomee.seer2.app.home.data.TrainingPetInfo) : void
      {
         if(this.isAlreadyExist(param1) == false)
         {
            this._trainingPetInfoVec.push(param1);
         }
      }
      
      private function isAlreadyExist(param1:com.taomee.seer2.app.home.data.TrainingPetInfo) : Boolean
      {
         var _loc2_:com.taomee.seer2.app.home.data.TrainingPetInfo = null;
         for each(_loc2_ in this._trainingPetInfoVec)
         {
            if(_loc2_.id == param1.id)
            {
               return true;
            }
         }
         return false;
      }
      
      public function removeTrainingPetInfo(param1:uint) : void
      {
         var _loc2_:int = int(this._trainingPetInfoVec.length);
         var _loc3_:int = _loc2_ - 1;
         while(_loc3_ >= 0)
         {
            if(this._trainingPetInfoVec[_loc3_].id == param1)
            {
               this._trainingPetInfoVec.splice(_loc3_,1);
               break;
            }
            _loc3_--;
         }
      }
      
      public function get userInfo() : UserInfo
      {
         return this._userInfo;
      }
      
      public function set userInfo(param1:UserInfo) : void
      {
         this._userInfo = param1;
      }
      
      public function get userId() : uint
      {
         return this._userInfo.id;
      }
      
      public function get name() : String
      {
         return this._userInfo.nick;
      }
      
      public function get birthPetInfo() : PetInfo
      {
         return this._birthPetInfo;
      }
      
      public function set birthPetInfo(param1:PetInfo) : void
      {
         this._birthPetInfo = param1;
      }
      
      public function get leftFightCount() : int
      {
         return this._leftFightCount;
      }
      
      public function get semiyaCount() : uint
      {
         return this._semiyaCount;
      }
      
      public function get suleAwardCount() : uint
      {
         return this._suleAwardCount;
      }
      
      public function set suleAwardCount(param1:uint) : void
      {
         this._suleAwardCount = param1;
      }
   }
}
