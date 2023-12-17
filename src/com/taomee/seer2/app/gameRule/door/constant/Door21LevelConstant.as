package com.taomee.seer2.app.gameRule.door.constant
{
   import com.taomee.seer2.app.config.PetConfig;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   
   public class Door21LevelConstant
   {
      
      private static var _DoorMonData:Class = Door21LevelConstant__DoorMonData;
      
      public static var _GUARD_NPCS:Array;
       
      
      public function Door21LevelConstant()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc5_:Array = null;
         var _loc6_:XML = null;
         var _loc7_:XMLList = null;
         var _loc8_:XML = null;
         var _loc9_:uint = 0;
         var _loc10_:XMLList = null;
         var _loc11_:XML = null;
         var _loc12_:uint = 0;
         var _loc13_:uint = 0;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:String = null;
         var _loc17_:PetDefinition = null;
         var _loc1_:XML = XML(new _DoorMonData());
         var _loc2_:XMLList = _loc1_.child("Method");
         var _loc3_:uint = uint(_loc2_.length());
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = [];
            _loc7_ = (_loc6_ = _loc2_[_loc4_]).child("Gate");
            _loc9_ = 0;
            while(_loc9_ < _loc7_.length())
            {
               _loc10_ = (_loc8_ = _loc7_[_loc9_])["Mons"].child("Mon");
               _loc12_ = 0;
               while(_loc12_ < _loc10_.length())
               {
                  _loc11_ = _loc10_[_loc12_];
                  _loc13_ = uint(_loc8_.attribute("ID"));
                  _loc14_ = uint(_loc11_.attribute("ID"));
                  _loc15_ = uint(_loc11_.attribute("LV"));
                  _loc16_ = " ** ";
                  if((_loc17_ = PetConfig.getPetDefinition(_loc14_)) != null)
                  {
                     _loc16_ = _loc17_.name;
                  }
                  _loc5_.push({
                     "level":_loc13_,
                     "id":_loc14_,
                     "petName":_loc16_,
                     "petLevel":_loc15_
                  });
                  _loc12_++;
               }
               _loc9_++;
            }
            _GUARD_NPCS.push(_loc5_);
            _loc4_++;
         }
      }
      
      public static function get GUARD_NPCS() : Array
      {
         if(_GUARD_NPCS == null)
         {
            _GUARD_NPCS = [];
            setup();
         }
         return _GUARD_NPCS;
      }
   }
}
