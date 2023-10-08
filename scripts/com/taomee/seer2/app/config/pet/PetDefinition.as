package com.taomee.seer2.app.config.pet
{
   public class PetDefinition
   {
       
      
      public var bunchId:uint;
      
      public var resId:int;
      
      public var name:String;
      
      public var type:int;
      
      public var growthType:int;
      
      public var evolvingLv:uint;
      
      public var catchRatio:uint;
      
      public var heightRange:String;
      
      public var weightRange:String;
      
      public var chara:String;
      
      public var charaPoint:String;
      
      public var featureId:uint;
      
      public var featureDescription:String;
      
      public var emblemId:uint;
      
      public var gender:String;
      
      public var foundPlace:String;
      
      public var isFreeable:Boolean;
      
      public var description:String;
      
      public var maxHp:uint;
      
      public var atk:uint;
      
      public var specialAtk:uint;
      
      public var defence:uint;
      
      public var specialDefence:uint;
      
      public var speed:uint;
      
      public var sloganVec:Vector.<String>;
      
      public var starLevel:uint;
      
      public var chgMonId:uint;
      
      public var realId:uint;
      
      public function PetDefinition(param1:uint, param2:int, param3:String, param4:int, param5:int, param6:String, param7:String, param8:uint, param9:uint, param10:String, param11:String, param12:uint, param13:String, param14:uint, param15:String, param16:String, param17:uint, param18:uint, param19:uint, param20:uint, param21:uint, param22:uint, param23:Boolean, param24:String, param25:Array, param26:uint, param27:uint, param28:uint)
      {
         super();
         this.bunchId = param1;
         this.resId = param2;
         this.name = param3;
         this.type = param4;
         this.growthType = param5;
         this.chara = param6;
         this.charaPoint = param7;
         this.evolvingLv = param8;
         this.catchRatio = param9;
         this.heightRange = param10;
         this.weightRange = param11;
         this.featureId = param12;
         this.featureDescription = param13;
         this.emblemId = param14;
         this.gender = param15;
         this.foundPlace = param16;
         this.maxHp = param17;
         this.atk = param18;
         this.specialAtk = param19;
         this.defence = param20;
         this.specialDefence = param21;
         this.speed = param22;
         this.isFreeable = param23;
         this.description = param24;
         this.sloganVec = Vector.<String>(param25);
         this.starLevel = param26;
         this.chgMonId = param27;
         this.realId = param28;
         if(param28 == 0)
         {
            this.realId = param2;
         }
      }
   }
}
