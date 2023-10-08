package com.taomee.seer2.app.shoot
{
   import com.taomee.seer2.core.utils.DateUtil;
   import org.taomee.ds.HashMap;
   
   public class ShootXMLInfo
   {
      
      private static var _specialShootItemMap:HashMap = new HashMap();
      
      private static var _vipShootList:Vector.<int> = new Vector.<int>();
      
      private static var _isYearVipShootList:Vector.<int> = new Vector.<int>();
      
      private static var xmlClass:Class = ShootXMLInfo_xmlClass;
      
      private static var _map:HashMap = new HashMap();
      
      {
         initialize();
      }
      
      public function ShootXMLInfo()
      {
         super();
      }
      
      private static function initialize() : void
      {
         var _loc2_:XML = null;
         var _loc3_:ShootInfo = null;
         var _loc1_:XMLList = XML(new xmlClass()).elements("item");
         for each(_loc2_ in _loc1_)
         {
            asignSpecial(_loc2_);
            asignVip(_loc2_);
            asignYearVip(_loc2_);
            _loc3_ = new ShootInfo();
            parseShootInfo(_loc3_,_loc2_);
            _map.add(_loc3_.id,_loc3_);
         }
      }
      
      private static function asignVip(param1:XML) : void
      {
         if(Boolean(param1.attribute("isVip")) && String(param1.@isVip) == "true")
         {
            _vipShootList.push(int(param1.@id));
         }
      }
      
      private static function asignYearVip(param1:XML) : void
      {
         if(Boolean(param1.attribute("isYearVip")) && String(param1.@isYearVip) == "true")
         {
            _isYearVipShootList.push(int(param1.@id));
         }
      }
      
      public static function isVipShoot(param1:uint) : Boolean
      {
         return _vipShootList.indexOf(param1) != -1;
      }
      
      public static function isYearShoot(param1:uint) : Boolean
      {
         return _isYearVipShootList.indexOf(param1) != -1;
      }
      
      private static function asignSpecial(param1:XML) : void
      {
         if(Boolean(param1.attribute("itemId")) && Boolean(uint(param1.@itemId)))
         {
            _specialShootItemMap.add(int(param1.@id),uint(param1.@itemId));
         }
      }
      
      public static function isSpecialShootItem(param1:uint) : Boolean
      {
         return _specialShootItemMap.containsKey(param1);
      }
      
      public static function getSpecialItemId(param1:uint) : uint
      {
         if(_specialShootItemMap.containsKey(param1))
         {
            return _specialShootItemMap.getValue(param1);
         }
         return 0;
      }
      
      private static function parseShootInfo(param1:ShootInfo, param2:XML) : void
      {
         param1.id = int(param2.@id);
         param1.type = !!param2.attribute("type") ? String(param2.attribute("type")) : "";
         param1.name = !!param2.attribute("name") ? String(param2.attribute("name")) : "";
         param1.speed = !!param2.attribute("speed") ? int(String(param2.attribute("speed"))) : 36;
         param1.stateType = !!param2.attribute("stateType") ? int(String(param2.attribute("stateType"))) : 0;
         param1.lastTime = !!param2.attribute("lastTime") ? int(Number(String(param2.attribute("lastTime"))) * DateUtil.MILLISECONDS_PER_SECOND) : 0;
         param1.isOverlap = Boolean(param2.attribute("overlap")) && String(param2.attribute("overlap")) == "false" ? false : true;
         param1.soundId = !!int(param2.attribute("sound")) ? int(param2.attribute("sound")) : -1;
      }
      
      public static function getShootInfo(param1:int) : ShootInfo
      {
         var _loc2_:ShootInfo = _map.getValue(param1);
         return _loc2_.clone();
      }
      
      public static function getIDs() : Vector.<int>
      {
         return Vector.<int>(_map.getKeys());
      }
   }
}
