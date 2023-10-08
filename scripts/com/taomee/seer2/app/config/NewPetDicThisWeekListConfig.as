package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.NewPetDicThisWeekInfo;
   import org.taomee.ds.HashMap;
   
   public class NewPetDicThisWeekListConfig
   {
      
      private static var _setting:Class = NewPetDicThisWeekListConfig__setting;
      
      private static var _infos:HashMap;
      
      private static var _newPetIdList:Array = new Array();
       
      
      public function NewPetDicThisWeekListConfig()
      {
         super();
      }
      
      public static function getPetIDForDic() : Vector.<int>
      {
         var _loc5_:NewPetDicThisWeekInfo = null;
         var _loc6_:int = 0;
         var _loc1_:HashMap = getInfos();
         var _loc2_:Vector.<int> = new Vector.<int>();
         var _loc3_:Array = _loc1_.getValues();
         _loc2_.push(0);
         var _loc4_:Array = [];
         for each(_loc5_ in _loc3_)
         {
            _loc4_.push(_loc5_);
         }
         _loc4_.sort(sortPetIdForDic);
         _loc6_ = 0;
         while(_loc6_ < _loc4_.length)
         {
            _loc2_.push(_loc4_[_loc6_].petId);
            _loc6_++;
         }
         return _loc2_;
      }
      
      private static function sortPetIdForDic(param1:NewPetDicThisWeekInfo, param2:NewPetDicThisWeekInfo) : int
      {
         if(param1.index > param2.index)
         {
            return 1;
         }
         if(param1.index < param2.index)
         {
            return -1;
         }
         return 0;
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
         var _loc6_:NewPetDicThisWeekInfo = null;
         var _loc1_:XML = XML(new _setting());
         _newPetIdList = String(_loc1_.@newPetId).split("|");
         var _loc2_:XMLList = _loc1_.child("pet");
         var _loc3_:uint = uint(_loc2_.length());
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = _loc2_[_loc4_];
            (_loc6_ = new NewPetDicThisWeekInfo()).petId = _loc5_.@id;
            _loc6_.index = int(_loc5_.@index);
            _infos.add(_loc6_.petId,_loc6_);
            _loc4_++;
         }
      }
   }
}
