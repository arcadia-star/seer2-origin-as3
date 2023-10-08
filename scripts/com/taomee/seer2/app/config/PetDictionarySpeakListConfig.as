package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PetDictionarySpeakListInfo;
   import org.taomee.ds.HashMap;
   
   public class PetDictionarySpeakListConfig
   {
      
      private static var _setting:Class = PetDictionarySpeakListConfig__setting;
      
      private static var _infos:HashMap;
      
      private static var _newPetIdList:Array = new Array();
       
      
      public function PetDictionarySpeakListConfig()
      {
         super();
      }
      
      public static function getNewPetId() : Array
      {
         var _loc1_:HashMap = getInfos();
         return _newPetIdList;
      }
      
      public static function getInfoData(param1:uint) : PetDictionarySpeakListInfo
      {
         var _loc2_:HashMap = getInfos();
         return _loc2_.getValue(param1);
      }
      
      public static function getPetIdList() : Vector.<int>
      {
         var _loc4_:PetDictionarySpeakListInfo = null;
         var _loc1_:HashMap = getInfos();
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:Array = _loc1_.getValues();
         for each(_loc4_ in _loc3_)
         {
            _loc2_.push(_loc4_.petId);
         }
         return _loc2_;
      }
      
      private static function getInfos() : HashMap
      {
         if(_infos == null)
         {
            _infos = new HashMap();
            setup();
         }
         return _infos;
      }
      
      private static function setup() : void
      {
         var _loc5_:XML = null;
         var _loc6_:PetDictionarySpeakListInfo = null;
         var _loc1_:XML = XML(new _setting());
         _newPetIdList = String(_loc1_.@newPetId).split("|");
         var _loc2_:XMLList = _loc1_.child("pet");
         var _loc3_:uint = uint(_loc2_.length());
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            (_loc6_ = new PetDictionarySpeakListInfo()).petId = _loc5_.@id;
            _loc6_.frameIndex = _loc5_.@frame;
            _loc6_.fightIndex = _loc5_.@fightIndex;
            _loc6_.mapId = _loc5_.@mapId;
            _infos.add(_loc6_.petId,_loc6_);
            _loc4_++;
         }
      }
   }
}
