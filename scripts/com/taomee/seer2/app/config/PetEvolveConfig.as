package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PetEvolveInfo;
   import com.taomee.seer2.app.config.info.PetEvolveNeedInfo;
   import com.taomee.seer2.app.config.info.PetEvolveStarInfo;
   import com.taomee.seer2.core.map.grids.HashMap;
   
   public class PetEvolveConfig
   {
      
      private static var _xmlClass:Class = PetEvolveConfig__xmlClass;
      
      private static var _starClass:Class = PetEvolveConfig__starClass;
      
      private static var _xml:XML;
      
      private static var _conditionMap:HashMap = new HashMap();
      
      private static var _addMap:HashMap = new HashMap();
      
      {
         setup();
      }
      
      public function PetEvolveConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:XMLList = null;
         var _loc4_:uint = 0;
         var _loc5_:Boolean = false;
         var _loc6_:XMLList = null;
         var _loc7_:PetEvolveInfo = null;
         var _loc8_:Vector.<PetEvolveNeedInfo> = null;
         var _loc9_:Vector.<PetEvolveNeedInfo> = null;
         var _loc10_:XMLList = null;
         var _loc11_:PetEvolveNeedInfo = null;
         var _loc12_:PetEvolveStarInfo = null;
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("Monster");
         for each(_loc2_ in _loc1_)
         {
            _loc4_ = uint(_loc2_.@ID);
            _loc5_ = false;
            _loc6_ = _loc2_.descendants("Star");
            for each(_loc2_ in _loc6_)
            {
               _loc7_ = new PetEvolveInfo();
               _conditionMap.put(_loc4_ + "_" + uint(_loc2_.@ID),_loc7_);
               _loc10_ = _loc2_.descendants("Condition");
               for each(_loc2_ in _loc10_)
               {
                  (_loc11_ = new PetEvolveNeedInfo()).id = uint(_loc2_.@ID);
                  _loc11_.level = uint(_loc2_.@Level);
                  _loc11_.count = uint(_loc2_.@Count);
                  _loc11_.evolveLevel = uint(_loc2_.@Star);
                  if(uint(_loc2_.@Flag) == 0)
                  {
                     if(!_loc8_)
                     {
                        _loc8_ = new Vector.<PetEvolveNeedInfo>();
                     }
                     _loc11_.name = ItemConfig.getItemName(_loc11_.id);
                     _loc8_.push(_loc11_);
                  }
                  else
                  {
                     if(!_loc9_)
                     {
                        _loc9_ = new Vector.<PetEvolveNeedInfo>();
                     }
                     _loc11_.name = getPrefix(_loc11_.evolveLevel) + PetConfig.getPetDefinition(_loc11_.id).name;
                     _loc9_.push(_loc11_);
                  }
               }
               if(_loc8_)
               {
                  _loc7_.itemList = _loc8_;
                  _loc8_ = null;
               }
               if(_loc9_)
               {
                  _loc7_.petList = _loc9_;
                  _loc9_ = null;
               }
            }
         }
         _xml = XML(new _starClass());
         _loc3_ = _xml.descendants("Star");
         for each(_loc2_ in _loc3_)
         {
            (_loc12_ = new PetEvolveStarInfo()).ID = uint(_loc2_.@ID);
            _loc12_.Name = String(_loc2_.@Name);
            _loc12_.Atk = uint(_loc2_.@Atk);
            _loc12_.SpAtk = uint(_loc2_.@SpAtk);
            _loc12_.Def = uint(_loc2_.@Def);
            _loc12_.SpDef = uint(_loc2_.@SpDef);
            _loc12_.Spd = uint(_loc2_.@Spd);
            _loc12_.Hp = uint(_loc2_.@Hp);
            _loc12_.All = uint(_loc2_.@All);
            _loc12_.Crystal = uint(_loc2_.@Crystal);
            _loc12_.border = uint(_loc2_.@border);
            _loc12_.bg = uint(_loc2_.@bg);
            _addMap.put(_loc12_.ID,_loc12_);
         }
      }
      
      public static function canEvolve(param1:String) : Boolean
      {
         return _conditionMap.containsKey(param1);
      }
      
      public static function getStarInfo(param1:uint) : PetEvolveStarInfo
      {
         var _loc2_:PetEvolveStarInfo = null;
         var _loc3_:Object = _addMap.getValue(param1);
         if(_loc3_ == null)
         {
            _loc2_ = null;
         }
         else
         {
            _loc2_ = _loc3_ as PetEvolveStarInfo;
         }
         return _loc2_;
      }
      
      public static function getCondition(param1:String) : PetEvolveInfo
      {
         return _conditionMap.getValue(param1) as PetEvolveInfo;
      }
      
      public static function getPrefix(param1:uint) : String
      {
         var _loc2_:String = "";
         if(param1 != 0)
         {
            if(param1 <= 4)
            {
               _loc2_ = "神·";
            }
            else if(param1 <= 8)
            {
               _loc2_ = "圣·";
            }
            else if(param1 <= 1004)
            {
               _loc2_ = "魔·";
            }
            else
            {
               _loc2_ = "冥·";
            }
         }
         return _loc2_;
      }
      
      public static function getStarNum(param1:int) : int
      {
         var _loc2_:uint = uint(param1);
         if(_loc2_ > 1000)
         {
            _loc2_ -= 1000;
         }
         if(_loc2_ != 0 && _loc2_ % 4 == 0 && _loc2_ != 1000)
         {
            _loc2_ = 4;
         }
         else
         {
            _loc2_ %= 4;
         }
         return _loc2_;
      }
   }
}
