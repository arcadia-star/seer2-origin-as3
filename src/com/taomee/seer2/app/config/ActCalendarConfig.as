package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.ActDetailInfo;
   import com.taomee.seer2.core.manager.TimeManager;
   
   public class ActCalendarConfig
   {
      
      private static var _xmlClass:Class = ActCalendarConfig__xmlClass;
      
      private static var weekActList:Vector.<Vector.<ActDetailInfo>>;
      
      private static var _curActIndex:int = -1;
      
      {
         setup();
      }
      
      public function ActCalendarConfig()
      {
         super();
      }
      
      public static function getActList(param1:int) : Vector.<ActDetailInfo>
      {
         return weekActList[param1];
      }

      private static function setup() : void
      {
         loadConfig(XML(new _xmlClass()));
      }
      
      public static function loadConfig(xml:XML) : void
      {
         var _loc4_:Array = null;
         var _loc5_:XML = null;
         var _loc6_:XMLList = null;
         var _loc7_:Vector.<ActDetailInfo> = null;
         var _loc8_:XML = null;
         var _loc9_:ActDetailInfo = null;
         var _loc10_:XMLList = null;
         var _loc11_:XML = null;
         var _loc12_:XMLList = null;
         var _loc13_:XML = null;
         weekActList = new Vector.<Vector.<ActDetailInfo>>(7);
         var _loc1_:XML = xml;
         var _loc2_:XMLList = _loc1_.descendants("acts");
         var _loc3_:Date = new Date(TimeManager.getServerTime() * 1000);
         for each(_loc5_ in _loc2_)
         {
            _loc6_ = _loc5_.descendants("act");
            _loc7_ = new Vector.<ActDetailInfo>();
            for each(_loc8_ in _loc6_)
            {
               (_loc9_ = new ActDetailInfo()).name = _loc8_.@name;
               _loc9_.isPet = Boolean(int(_loc8_.@isPet));
               _loc9_.willOver = Boolean(int(_loc8_.@willOver));
               _loc9_.detailDes = _loc8_.@detailDes;
               _loc9_.timeDes = _loc8_.@timeDes;
               _loc4_ = String(_loc8_.@startTime).split(":");
               _loc3_.hours = int(_loc4_[0]);
               _loc3_.minutes = int(_loc4_[1]);
               _loc9_.startTime = _loc3_.getTime() / 1000;
               _loc4_ = String(_loc8_.@endTime).split(":");
               _loc3_.hours = int(_loc4_[0]);
               _loc3_.minutes = int(_loc4_[1]);
               _loc9_.endTime = _loc3_.getTime() / 1000;
               _loc9_.go = String(_loc8_.@go);
               _loc9_.iconId = uint(_loc8_.@iconId);
               _loc10_ = _loc8_.descendants("item");
               for each(_loc11_ in _loc10_)
               {
                  _loc9_.itemReward.push(int(_loc11_.@id));
               }
               _loc12_ = _loc8_.descendants("pet");
               for each(_loc13_ in _loc12_)
               {
                  _loc9_.petReward.push(int(_loc13_.@id));
               }
               _loc7_.push(_loc9_);
            }
            weekActList[int(_loc5_.@day)] = _loc7_;
         }
      }
      
      public static function get curActIndex() : int
      {
         return _curActIndex;
      }
      
      public static function setCurActIndex() : void
      {
         var _loc5_:ActDetailInfo = null;
         var _loc6_:Vector.<ActDetailInfo> = null;
         var _loc7_:ActDetailInfo = null;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc1_:Date = new Date(TimeManager.getServerTime() * 1000);
         var _loc2_:Vector.<ActDetailInfo> = getActList(_loc1_.day);
         var _loc3_:Vector.<ActDetailInfo> = new Vector.<ActDetailInfo>();
         var _loc4_:Vector.<ActDetailInfo> = new Vector.<ActDetailInfo>();
         for each(_loc5_ in _loc2_)
         {
            if(_loc5_.timeDes == "全天候")
            {
               _loc3_.push(_loc5_);
            }
            else
            {
               _loc4_.push(_loc5_);
            }
         }
         _loc6_ = new Vector.<ActDetailInfo>();
         for each(_loc7_ in _loc4_)
         {
            if(TimeManager.getServerTime() > _loc7_.startTime && TimeManager.getServerTime() < _loc7_.endTime)
            {
               _loc6_.push(_loc7_);
            }
         }
         if(_loc6_.length >= 1)
         {
            if(_loc6_.length == 1)
            {
               _curActIndex = _loc2_.indexOf(_loc6_[0]);
            }
            else
            {
               if(_curActIndex == -1)
               {
                  _curActIndex = _loc2_.indexOf(_loc6_[0]);
                  return;
               }
               if((_loc8_ = _loc6_.indexOf(_loc2_[_curActIndex])) != -1)
               {
                  if(_loc8_ < _loc6_.length - 1)
                  {
                     _curActIndex = _loc2_.indexOf(_loc6_[_loc8_ + 1]);
                  }
                  else
                  {
                     _curActIndex = _loc2_.indexOf(_loc6_[0]);
                  }
               }
               else
               {
                  _curActIndex = _loc2_.indexOf(_loc6_[0]);
               }
            }
         }
         else
         {
            if(_curActIndex == -1)
            {
               _curActIndex = _loc2_.indexOf(_loc3_[0]);
               return;
            }
            if((_loc9_ = _loc3_.indexOf(_loc2_[_curActIndex])) != -1)
            {
               if(_loc9_ < _loc3_.length - 1)
               {
                  _curActIndex = _loc2_.indexOf(_loc3_[_loc9_ + 1]);
               }
               else
               {
                  _curActIndex = _loc2_.indexOf(_loc3_[0]);
               }
            }
            else
            {
               _curActIndex = _loc2_.indexOf(_loc3_[0]);
            }
         }
      }
   }
}
