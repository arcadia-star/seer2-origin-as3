package com.taomee.seer2.core.config
{
   import org.taomee.ds.HashMap;
   
   public class DreamConfig
   {
      
      private static var _xmlClass:Class = DreamConfig__xmlClass;
      
      private static var _xml:XML;
      
      private static var _familyInfoVec:Vector.<com.taomee.seer2.core.config.FamilyInfo>;
      
      private static var _map:HashMap = new HashMap();
      
      private static var _dreamMap:HashMap = new HashMap();
      
      private static var _isDreamMap:HashMap = new HashMap();
      
      {
         setup();
      }
      
      public function DreamConfig()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc1_:DreamInfo = null;
         var _loc3_:uint = 0;
         var _loc4_:XMLList = null;
         var _loc5_:com.taomee.seer2.core.config.FamilyInfo = null;
         var _loc6_:Vector.<DreamInfo> = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Vector.<DreamItemInfo> = null;
         var _loc13_:Vector.<DreamPetInfo> = null;
         var _loc14_:Vector.<DreamPetInfo> = null;
         _xml = XML(new _xmlClass());
         var _loc2_:XMLList = _xml.descendants("family");
         _familyInfoVec = Vector.<com.taomee.seer2.core.config.FamilyInfo>([]);
         for each(_loc7_ in _loc2_)
         {
            _loc5_ = new com.taomee.seer2.core.config.FamilyInfo();
            _loc3_ = uint(_loc7_.attribute("id"));
            _loc4_ = _loc7_.descendants("map");
            _loc5_.isSwapPet = int(_loc7_.attribute("isSwapPet"));
            _loc5_.petType = int(_loc7_.attribute("petType"));
            _loc5_.itemIdList = String(_loc7_.attribute("itemIdList")).split(",");
            _loc5_.totalItemCountList = String(_loc7_.attribute("totalItemCountList")).split(",");
            _loc5_.clickMapIdList = String(_loc7_.attribute("clickMapIdList")).split(",");
            _loc5_.familyId = _loc3_;
            _familyInfoVec.push(_loc5_);
            _loc6_ = Vector.<DreamInfo>([]);
            for each(_loc8_ in _loc4_)
            {
               _loc1_ = new DreamInfo();
               _loc1_.familyId = _loc3_;
               _loc9_ = uint(_loc8_.attribute("id"));
               _loc10_ = uint(_loc8_.attribute("prevMapId"));
               _loc11_ = uint(_loc8_.attribute("fightIndex"));
               _loc1_.fightIndex = _loc11_;
               _loc1_.id = _loc9_;
               _loc1_.mapId = uint(_loc8_.attribute("mapId"));
               _loc1_.name = String(_loc8_.attribute("name"));
               _loc1_.isWelfare = uint(_loc8_.attribute("isWelfare"));
               _loc1_.prevMapId = _loc10_;
               _loc1_.monster = uint(_loc8_.attribute("monsterId"));
               _loc1_.monsterCount = uint(_loc8_.attribute("monsterCount"));
               _loc1_.present = String(_loc8_.attribute("present"));
               _loc1_.threeStar = String(_loc8_.attribute("threeStar"));
               _loc1_.nextIdList = String(_loc8_.attribute("nextId")).split(",");
               _loc12_ = Vector.<DreamItemInfo>([]);
               _loc13_ = Vector.<DreamPetInfo>([]);
               _loc14_ = Vector.<DreamPetInfo>([]);
               _loc1_.itemList = getItemList(_loc8_.descendants("item"),_loc12_);
               _loc1_.petList = getPetList(_loc8_.descendants("pet"),_loc13_,false);
               _loc1_.bossList = getPetList(_loc8_.descendants("boss"),_loc14_,true);
               _isDreamMap.add(_loc10_,_loc9_);
               _loc6_.push(_loc1_);
               _loc5_.mapInfoList = _loc6_;
               _map.add(_loc1_.mapId,_loc1_);
               _dreamMap.add(_loc1_.id,_loc1_);
            }
         }
      }
      
      private static function getItemList(param1:XMLList, param2:Vector.<DreamItemInfo>) : Vector.<DreamItemInfo>
      {
         var _loc3_:XML = null;
         var _loc4_:DreamItemInfo = null;
         for each(_loc3_ in param1)
         {
            (_loc4_ = new DreamItemInfo()).id = uint(_loc3_.attribute("id"));
            _loc4_.count = uint(_loc3_.attribute("count"));
            param2.push(_loc4_);
         }
         return param2;
      }
      
      private static function getPetList(param1:XMLList, param2:Vector.<DreamPetInfo>, param3:Boolean) : Vector.<DreamPetInfo>
      {
         var _loc4_:XML = null;
         var _loc5_:DreamPetInfo = null;
         for each(_loc4_ in param1)
         {
            (_loc5_ = new DreamPetInfo()).id = uint(_loc4_.attribute("id"));
            _loc5_.level = uint(_loc4_.attribute("level"));
            _loc5_.isBoss = param3;
            _loc5_.pointX = Number(_loc4_.attribute("pointX"));
            _loc5_.pointY = Number(_loc4_.attribute("pointY"));
            param2.push(_loc5_);
         }
         return param2;
      }
      
      public static function getFamily(param1:int) : com.taomee.seer2.core.config.FamilyInfo
      {
         var _loc2_:com.taomee.seer2.core.config.FamilyInfo = null;
         for each(_loc2_ in _familyInfoVec)
         {
            if(_loc2_.familyId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public static function getFamilyMax() : int
      {
         return _familyInfoVec.length;
      }
      
      public static function getInfo(param1:uint) : DreamInfo
      {
         if(!_map.containsKey(param1))
         {
            return null;
         }
         return _map.getValue(param1);
      }
      
      public static function getMapInfo(param1:uint) : DreamInfo
      {
         if(!_dreamMap.containsKey(param1))
         {
            return null;
         }
         return _dreamMap.getValue(param1);
      }
      
      public static function isDream(param1:uint) : Boolean
      {
         if(_map.containsKey(param1))
         {
            return true;
         }
         return false;
      }
      
      public static function getDreamInfo(param1:uint) : DreamInfo
      {
         if(_isDreamMap.containsKey(param1))
         {
            return getInfo(_isDreamMap.getValue(param1));
         }
         return null;
      }
   }
}
