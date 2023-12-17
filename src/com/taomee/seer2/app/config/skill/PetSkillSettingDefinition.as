package com.taomee.seer2.app.config.skill
{
   public class PetSkillSettingDefinition
   {
       
      
      public var id:uint;
      
      public var learningLv:uint;
      
      public var effectId:String;
      
      private var sounds:Vector.<SoundCondition>;
      
      public function PetSkillSettingDefinition(param1:uint, param2:uint, param3:String, param4:String)
      {
         this.sounds = new Vector.<SoundCondition>();
         super();
         this.id = param1;
         this.learningLv = param2;
         this.effectId = param4;
         this.parserSoundId(param3);
      }
      
      public function getSoundId(param1:int) : String
      {
         var _loc2_:String = null;
         var _loc3_:uint = this.sounds.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(this.sounds[_loc4_].id == param1)
            {
               _loc2_ = this.sounds[_loc4_].soundId;
               break;
            }
            _loc4_++;
         }
         if(_loc2_ == null)
         {
            return this.getSoundId(-1);
         }
         return _loc2_;
      }
      
      private function parserSoundId(param1:String) : void
      {
         var _loc5_:Array = null;
         var _loc6_:int = 0;
         var _loc2_:Array = param1.split(";");
         var _loc3_:uint = _loc2_.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            param1 = (_loc5_ = String(_loc2_[_loc4_]).split(":")).shift();
            _loc6_ = -1;
            if(_loc5_.length > 0)
            {
               _loc6_ = _loc5_.shift();
            }
            this.sounds.push(new SoundCondition(param1,_loc6_));
            _loc4_++;
         }
      }
   }
}

class SoundCondition
{
    
   
   public var soundId:String;
   
   public var id:int = -1;
   
   public function SoundCondition(param1:String, param2:int = -1)
   {
      this.soundId = param1;
      this.id = param2;
      super();
   }
}
