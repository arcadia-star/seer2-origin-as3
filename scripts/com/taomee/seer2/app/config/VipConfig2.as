package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.giftRemind.VipGiftInfo;
   import com.taomee.seer2.app.vip.data.VipRightInfo;
   import com.taomee.seer2.app.vip.data.VipSwapInfo;
   import com.taomee.seer2.app.vip.data.VipTurnTableInfo;
   import org.taomee.ds.HashMap;
   
   public class VipConfig2
   {
      
      private static var _xmlClass:Class = VipConfig2__xmlClass;
      
      private static var _xml:XML;
      
      public static var rightVec:Vector.<VipRightInfo>;
      
      public static var swapVec:Vector.<VipSwapInfo>;
      
      private static var _giftMap:HashMap;
      
      private static var _luckyGiftMap:HashMap;
      
      private static var _turnTableMap:HashMap;
      
      {
         setup();
      }
      
      public function VipConfig2()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         rightVec = new Vector.<VipRightInfo>();
         swapVec = new Vector.<VipSwapInfo>();
         _giftMap = new HashMap();
         _luckyGiftMap = new HashMap();
         _turnTableMap = new HashMap();
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("vip");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = int(_loc2_.attribute("type"));
            switch(_loc3_)
            {
               case 1:
                  parserSawp(_loc2_);
                  break;
               case 2:
                  parserGift(_loc2_);
                  break;
               case 3:
                  parserRight(_loc2_);
                  break;
               case 4:
                  parseLuckyGift(_loc2_);
                  break;
               case 5:
                  parseTurnTable(_loc2_);
                  break;
            }
         }
      }
      
      private static function parserSawp(param1:XML) : void
      {
         var _loc2_:VipSwapInfo = new VipSwapInfo();
         _loc2_.cost = int(param1.attribute("cost"));
         _loc2_.index = int(param1.attribute("index"));
         _loc2_.isNew = int(param1.attribute("isNew"));
         _loc2_.id = int(param1.attribute("id"));
         var _loc3_:String = String(param1.attribute("tip"));
         _loc2_.tip = _loc3_.replace(/,/g,"\n");
         _loc2_.swapType = int(param1.attribute("swapType"));
         _loc2_.vipLevel = int(param1.attribute("vipLevel"));
         _loc2_.limitId = int(param1.attribute("limitId"));
         swapVec.push(_loc2_);
      }
      
      private static function parserGift(param1:XML) : void
      {
         var _loc2_:int = int(param1.attribute("level"));
         var _loc3_:VipGiftInfo = new VipGiftInfo();
         _loc3_.monthIndex = int(param1.attribute("monthIndex"));
         _loc3_.weekIndex = int(param1.attribute("weekIndex"));
         _loc3_.monthCheck = int(param1.attribute("checkMonth"));
         _loc3_.weekCheck = int(param1.attribute("checkWeek"));
         _giftMap.add(_loc2_,_loc3_);
      }
      
      private static function parserRight(param1:XML) : void
      {
         var _loc2_:VipRightInfo = new VipRightInfo();
         _loc2_.id = int(param1.attribute("id"));
         _loc2_.map = int(param1.attribute("map"));
         rightVec.push(_loc2_);
      }
      
      private static function parseLuckyGift(param1:XML) : void
      {
         var _loc2_:int = int(param1.attribute("id"));
         var _loc3_:String = param1.attribute("tip");
         _loc3_ = _loc3_.replace(/,/g,"\n");
         _luckyGiftMap.add(_loc2_,_loc3_);
      }
      
      private static function parseTurnTable(param1:XML) : void
      {
         var _loc2_:int = int(param1.attribute("level"));
         var _loc3_:VipTurnTableInfo = new VipTurnTableInfo();
         var _loc4_:String = param1.attribute("rewardIcon");
         _loc3_.rewardIconVec = Vector.<int>(_loc4_.split(","));
         _loc4_ = param1.attribute("count");
         _loc3_.rewardCntVec = Vector.<int>(_loc4_.split(","));
         _turnTableMap.add(_loc2_,_loc3_);
      }
      
      public static function getGiftInfo(param1:int) : VipGiftInfo
      {
         return _giftMap.getValue(param1);
      }
      
      public static function getLuckyTip(param1:int) : String
      {
         if(_luckyGiftMap.containsKey(param1))
         {
            return _luckyGiftMap.getValue(param1);
         }
         return "";
      }
      
      public static function getTurnTableInfo(param1:int) : VipTurnTableInfo
      {
         if(_turnTableMap.containsKey(param1))
         {
            return _turnTableMap.getValue(param1);
         }
         return null;
      }
   }
}
