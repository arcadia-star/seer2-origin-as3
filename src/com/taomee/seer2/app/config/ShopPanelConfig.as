package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.ShopItemInfo;
   import com.taomee.seer2.app.config.item.EquipItemDefinition;
   import com.taomee.seer2.app.vip.VipManager;
   import org.taomee.ds.HashMap;
   
   public class ShopPanelConfig
   {
      
      private static var _class:Class = ShopPanelConfig__class;
      
      private static var _xml:XML;
      
      private static var _miXml:XMLList;
      
      private static var _coinsXml:XMLList;
      
      private static var _currXmlList:XMLList;
      
      private static var _search:String;
      
      private static var _newShopList:Vector.<ShopItemInfo>;
      
      private static var _limitedShopList:Vector.<ShopItemInfo>;
      
      private static var _hotShop:Vector.<ShopItemInfo>;
      
      private static var _catch:Vector.<ShopItemInfo>;
      
      private static var _strengthen:Vector.<ShopItemInfo>;
      
      private static var _auxiliary:Vector.<ShopItemInfo>;
      
      private static var _newEquip:Vector.<ShopItemInfo>;
      
      private static var _seerEquip:Vector.<ShopItemInfo>;
      
      private static var _vipMount:Vector.<ShopItemInfo>;
      
      private static var _nonoEquip:Vector.<ShopItemInfo>;
      
      private static var _branch:Vector.<ShopItemInfo>;
      
      private static var _trend:Vector.<ShopItemInfo>;
      
      private static var _expression:Vector.<ShopItemInfo>;
      
      private static var _gadList:Vector.<ShopItemInfo>;
      
      private static var _seyenList:Vector.<ShopItemInfo>;
      
      private static var _evoluList:Vector.<ShopItemInfo>;
      
      private static var _petOther:Vector.<ShopItemInfo>;
      
      private static var _giftList:Vector.<ShopItemInfo>;
      
      private static var _rankingList:Vector.<ShopItemInfo>;
      
      private static var _fightShop:Vector.<ShopItemInfo>;
      
      private static var _otherShop:Vector.<ShopItemInfo>;
      
      private static var _suitShop:Vector.<ShopItemInfo>;
      
      private static var _equipStrengthen:Vector.<ShopItemInfo>;
      
      private static var _newSuit:Vector.<ShopItemInfo>;
      
      private static var _suit:Vector.<ShopItemInfo>;
      
      private static var _newVipFly:Vector.<ShopItemInfo>;
      
      private static var _vipFly:Vector.<ShopItemInfo>;
      
      private static var _equip:Vector.<ShopItemInfo>;
      
      private static var _hideList:Vector.<ShopItemInfo>;
      
      private static var _allShopItemMap:HashMap = new HashMap();
      
      public static var oddsLimit:uint;
      
      public static var oddsRewardLimit:uint;
      
      public static var oddsType:uint;
      
      public static var buyId:Array;
      
      {
         setup();
      }
      
      public function ShopPanelConfig()
      {
         super();
      }

      private static function setup() : void
      {
         loadConfig(XML(new _class()))
      }

      public static function loadConfig(xml:XML) : void
      {
         _xml = xml;
         _search = _xml.attribute("search");
         _miXml = _xml.descendants("miRegion");
         _currXmlList = _miXml.descendants("newShop");
         _newShopList = Vector.<ShopItemInfo>([]);
         entryMi(_newShopList);
         _currXmlList = _miXml.descendants("limitedShop");
         _limitedShopList = Vector.<ShopItemInfo>([]);
         entryMi(_limitedShopList,true);
         _currXmlList = _miXml.descendants("hotShop");
         _hotShop = Vector.<ShopItemInfo>([]);
         entryMi(_hotShop);
         _currXmlList = _miXml.descendants("giftShop");
         _giftList = Vector.<ShopItemInfo>([]);
         entryMi(_giftList);
         _currXmlList = _miXml.descendants("rankingShop");
         _rankingList = Vector.<ShopItemInfo>([]);
         entryMi(_rankingList);
         _currXmlList = _miXml.descendants("fightShop");
         _fightShop = Vector.<ShopItemInfo>([]);
         entryMi(_fightShop);
         _currXmlList = _miXml.descendants("otherShop");
         _otherShop = Vector.<ShopItemInfo>([]);
         entryMi(_otherShop);
         _currXmlList = _miXml.descendants("suitShop");
         _suitShop = Vector.<ShopItemInfo>([]);
         entryMi(_suitShop);
         _currXmlList = _miXml.descendants("equipStrengthen");
         _equipStrengthen = Vector.<ShopItemInfo>([]);
         entryMi(_equipStrengthen);
         _currXmlList = _xml.descendants("catch");
         _catch = Vector.<ShopItemInfo>([]);
         entryMi(_catch);
         _currXmlList = _xml.descendants("strengthen");
         _strengthen = Vector.<ShopItemInfo>([]);
         entryMi(_strengthen);
         _currXmlList = _xml.descendants("auxiliary");
         _auxiliary = Vector.<ShopItemInfo>([]);
         entryMi(_auxiliary);
         _currXmlList = _xml.descendants("newEquip");
         _newEquip = Vector.<ShopItemInfo>([]);
         entryMi(_newEquip);
         _currXmlList = _xml.descendants("seerEquip");
         _seerEquip = Vector.<ShopItemInfo>([]);
         entryMi(_seerEquip);
         _currXmlList = _xml.descendants("gad");
         _gadList = Vector.<ShopItemInfo>([]);
         entryMi(_gadList);
         _currXmlList = _xml.descendants("vipMount");
         _vipMount = Vector.<ShopItemInfo>([]);
         entryMi(_vipMount);
         _currXmlList = _xml.descendants("nonoEquip");
         _nonoEquip = Vector.<ShopItemInfo>([]);
         entryMi(_nonoEquip);
         _currXmlList = _xml.descendants("branch");
         _branch = Vector.<ShopItemInfo>([]);
         entrybranch(_branch);
         _currXmlList = _xml.descendants("trend");
         _trend = Vector.<ShopItemInfo>([]);
         entryMi(_trend);
         _currXmlList = _xml.descendants("expression");
         _expression = Vector.<ShopItemInfo>([]);
         entryMi(_expression);
         _currXmlList = _xml.descendants("hideShop");
         _hideList = Vector.<ShopItemInfo>([]);
         entryMi(_hideList);
         _currXmlList = _xml.descendants("seyen");
         _seyenList = Vector.<ShopItemInfo>([]);
         entryMi(_seyenList);
         _currXmlList = _xml.descendants("evolu");
         _evoluList = Vector.<ShopItemInfo>([]);
         entryMi(_evoluList);
         _currXmlList = _xml.descendants("petOther");
         _petOther = Vector.<ShopItemInfo>([]);
         entryMi(_petOther);
         _coinsXml = _xml.descendants("coinsRegion");
         _currXmlList = _coinsXml.descendants("newSuit");
         _newSuit = Vector.<ShopItemInfo>([]);
         entryCoins(_newSuit);
         _currXmlList = _coinsXml.descendants("suit");
         _suit = Vector.<ShopItemInfo>([]);
         entryCoins(_suit);
         _currXmlList = _coinsXml.descendants("newVipFly");
         _newVipFly = Vector.<ShopItemInfo>([]);
         entryCoins(_newVipFly);
         _currXmlList = _coinsXml.descendants("vipFly");
         _vipFly = Vector.<ShopItemInfo>([]);
         entryCoins(_vipFly);
         _currXmlList = _coinsXml.descendants("equip");
         _equip = Vector.<ShopItemInfo>([]);
         entryCoins(_equip);
         oddsLimit = uint(_xml.odds.@limit);
         oddsRewardLimit = uint(_xml.odds.@rewardLimit);
         oddsType = uint(_xml.odds.@type);
         buyId = String(_xml.odds.@buyid).split(",");
      }
      
      private static function entryMi(param1:Vector.<ShopItemInfo>, param2:Boolean = false) : void
      {
         var _loc3_:ShopItemInfo = null;
         var _loc4_:XML = null;
         for each(_loc4_ in _currXmlList.descendants("item"))
         {
            _loc3_ = new ShopItemInfo();
            _loc3_.referenceId = uint(_loc4_.attribute("referenceId"));
            _loc3_.price = Number(_loc4_.attribute("price"));
            if(!_allShopItemMap.getValue(_loc3_.referenceId))
            {
               _allShopItemMap.add(_loc3_.referenceId,_loc3_);
            }
            if(String(_loc4_.attribute("name")) != "")
            {
               _loc3_.name = String(_loc4_.attribute("name"));
            }
            _loc3_.itemType = "normal";
            if(param2)
            {
               _loc3_.limitedTotalCountTxt = uint(_loc4_.attribute("limitedTotalCountTxt"));
               _loc3_.itemType = "limited";
            }
            if(String(_loc4_.attribute("type")) != "")
            {
               _loc3_.itemType = String(_loc4_.attribute("type"));
               _loc3_.limitedTotalCountTxt = uint(_loc4_.attribute("limitedTotalCountTxt"));
            }
            if(String(_loc4_.attribute("tip")) != "")
            {
               _loc3_.tip = String(_loc4_.attribute("tip"));
            }
            else
            {
               _loc3_.tip = ItemConfig.getItemDefinition(_loc3_.referenceId).tip;
            }
            if(String(_loc4_.attribute("discount")) != "")
            {
               _loc3_.discount = Number(_loc4_.attribute("discount")) / 10;
            }
            else
            {
               _loc3_.discount = 1;
            }
            if(String(_loc4_.attribute("isNew")) != "")
            {
               _loc3_.isNew = 1;
            }
            else
            {
               _loc3_.isNew = 0;
            }
            if(String(_loc4_.attribute("down")) != "")
            {
               _loc3_.isDown = uint(_loc4_.attribute("down"));
            }
            else
            {
               _loc3_.isDown = 0;
            }
            if(String(_loc4_.attribute("isHelp")) != "")
            {
               _loc3_.isHelp = uint(_loc4_.attribute("isHelp"));
            }
            else
            {
               _loc3_.isHelp = 0;
            }
            if(String(_loc4_.attribute("twoGround")) != "")
            {
               _loc3_.isTwoGro = uint(_loc4_.attribute("twoGround"));
            }
            else
            {
               _loc3_.isTwoGro = 0;
            }
            if(String(_loc4_.attribute("noVipDiscount")) != "")
            {
               _loc3_.noVipDiscount = Number(_loc4_.attribute("noVipDiscount")) / 10;
            }
            else
            {
               _loc3_.noVipDiscount = 1;
            }
            _loc3_.shopType = "mi";
            param1.push(_loc3_);
         }
      }
      
      private static function entryCoins(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:ShopItemInfo = null;
         var _loc3_:XML = null;
         for each(_loc3_ in _currXmlList.descendants("item"))
         {
            _loc2_ = new ShopItemInfo();
            _loc2_.referenceId = uint(_loc3_.attribute("referenceId"));
            _loc2_.price = Number(_loc3_.attribute("price"));
            _loc2_.itemType = "normal";
            _loc2_.shopType = "coins";
            if(String(_loc3_.attribute("name")) != "")
            {
               _loc2_.name = String(_loc3_.attribute("name"));
            }
            if(String(_loc3_.attribute("type")) != "")
            {
               _loc2_.itemType = String(_loc3_.attribute("type"));
               _loc2_.limitedTotalCountTxt = uint(_loc3_.attribute("limitedTotalCountTxt"));
            }
            if(String(_loc3_.attribute("tip")) != "")
            {
               _loc2_.tip = String(_loc3_.attribute("tip"));
            }
            else
            {
               _loc2_.tip = ItemConfig.getItemDefinition(_loc2_.referenceId).tip;
            }
            if(String(_loc3_.attribute("discount")) != "")
            {
               _loc2_.discount = Number(_loc3_.attribute("discount")) / 10;
            }
            else
            {
               _loc2_.discount = 1;
            }
            if(String(_loc3_.attribute("isNew")) != "")
            {
               _loc2_.isNew = 1;
            }
            else
            {
               _loc2_.isNew = 0;
            }
            if(String(_loc3_.attribute("down")) != "")
            {
               _loc2_.isDown = uint(_loc3_.attribute("down"));
            }
            else
            {
               _loc2_.isDown = 0;
            }
            param1.push(_loc2_);
         }
      }
      
      private static function entrybranch(param1:Vector.<ShopItemInfo>) : void
      {
         var _loc2_:ShopItemInfo = null;
         var _loc3_:XML = null;
         for each(_loc3_ in _currXmlList.descendants("item"))
         {
            _loc2_ = new ShopItemInfo();
            _loc2_.referenceId = uint(_loc3_.attribute("referenceId"));
            _loc2_.price = Number(_loc3_.attribute("price"));
            _loc2_.swapId = uint(_loc3_.attribute("swapId"));
            _loc2_.itemType = "branch";
            _loc2_.shopType = "branch";
            if(String(_loc3_.attribute("name")) != "")
            {
               _loc2_.name = String(_loc3_.attribute("name"));
            }
            if(String(_loc3_.attribute("type")) != "")
            {
               _loc2_.itemType = String(_loc3_.attribute("type"));
               _loc2_.limitedTotalCountTxt = uint(_loc3_.attribute("limitedTotalCountTxt"));
            }
            if(String(_loc3_.attribute("tip")) != "")
            {
               _loc2_.tip = String(_loc3_.attribute("tip"));
            }
            else
            {
               _loc2_.tip = ItemConfig.getItemDefinition(_loc2_.referenceId).tip;
            }
            _loc2_.discount = 1;
            _loc2_.isNew = 0;
            param1.push(_loc2_);
         }
      }
      
      public static function getInfoList(param1:String) : Vector.<ShopItemInfo>
      {
         var _loc2_:Vector.<ShopItemInfo> = null;
         switch(param1)
         {
            case "trend":
               _loc2_ = _trend;
               break;
            case "branch":
               _loc2_ = _branch;
               break;
            case "newEquip":
               _loc2_ = _newEquip;
               break;
            case "seerEquip":
               _loc2_ = _seerEquip;
               break;
            case "vipMount":
               _loc2_ = _vipMount;
               break;
            case "nonoEquip":
               _loc2_ = _nonoEquip;
               break;
            case "catch":
               _loc2_ = _catch;
               break;
            case "strengthen":
               _loc2_ = _strengthen;
               break;
            case "auxiliary":
               _loc2_ = _auxiliary;
               break;
            case "newShop":
               _loc2_ = _newShopList;
               break;
            case "limitedShop":
               _loc2_ = _limitedShopList;
               break;
            case "hotShop":
               _loc2_ = _hotShop;
               break;
            case "allShop":
               _loc2_ = allShop();
               break;
            case "expression":
               _loc2_ = _expression;
               break;
            case "gad":
               _loc2_ = _gadList;
               break;
            case "hideShop":
               _loc2_ = _hideList;
               break;
            case "gift":
               _loc2_ = _giftList;
               break;
            case "ranking":
               _loc2_ = _rankingList;
               break;
            case "fight":
               _loc2_ = _fightShop;
               break;
            case "other":
               _loc2_ = _otherShop;
               break;
            case "suit":
               _loc2_ = _suitShop;
               break;
            case "equipStrengthen":
               _loc2_ = _equipStrengthen;
               break;
            case "seyen":
               _loc2_ = _seyenList;
               break;
            case "evolu":
               _loc2_ = _evoluList;
               break;
            case "petOther":
               _loc2_ = _petOther;
         }
         return _loc2_;
      }
      
      public static function getCoinsInfoList(param1:String) : Vector.<ShopItemInfo>
      {
         var _loc2_:Vector.<ShopItemInfo> = null;
         switch(param1)
         {
            case "newSuit":
               _loc2_ = _newSuit;
               break;
            case "newVipFly":
               _loc2_ = _newVipFly;
               break;
            case "suit":
               _loc2_ = _suit;
               break;
            case "vipFly":
               _loc2_ = _vipFly;
               break;
            case "allShop":
               _loc2_ = coinsAllShop();
         }
         return _loc2_;
      }
      
      public static function getCoinsEquipInfoList(param1:uint) : Vector.<ShopItemInfo>
      {
         var _loc3_:EquipItemDefinition = null;
         var _loc4_:uint = 0;
         var _loc5_:ShopItemInfo = null;
         var _loc2_:Vector.<ShopItemInfo> = Vector.<ShopItemInfo>([]);
         for each(_loc5_ in _equip)
         {
            _loc3_ = ItemConfig.getItemDefinition(_loc5_.referenceId) as EquipItemDefinition;
            switch(_loc3_.slotIndex)
            {
               case 1:
                  _loc4_ = 1;
                  break;
               case 2:
                  _loc4_ = 2;
                  break;
               case 10:
                  _loc4_ = 2;
                  break;
               case 3:
                  _loc4_ = 6;
                  break;
               case 5:
                  _loc4_ = 3;
                  break;
               case 6:
                  _loc4_ = 4;
                  break;
               case 7:
                  _loc4_ = 5;
            }
            if(param1 == _loc4_)
            {
               _loc2_.push(_loc5_);
            }
         }
         return _loc2_;
      }
      
      private static function allShop() : Vector.<ShopItemInfo>
      {
         var _loc2_:ShopItemInfo = null;
         var _loc3_:ShopItemInfo = null;
         var _loc4_:ShopItemInfo = null;
         var _loc1_:HashMap = new HashMap();
         for each(_loc2_ in _newShopList)
         {
            _loc1_.add(_loc2_.referenceId,_loc2_);
         }
         for each(_loc3_ in _limitedShopList)
         {
            _loc1_.add(_loc3_.referenceId,_loc3_);
         }
         for each(_loc4_ in _hotShop)
         {
            _loc1_.add(_loc4_.referenceId,_loc4_);
         }
         return Vector.<ShopItemInfo>(_loc1_.getValues());
      }
      
      private static function coinsAllShop() : Vector.<ShopItemInfo>
      {
         var _loc2_:ShopItemInfo = null;
         var _loc3_:ShopItemInfo = null;
         var _loc4_:ShopItemInfo = null;
         var _loc1_:HashMap = new HashMap();
         for each(_loc2_ in _newShopList)
         {
            _loc1_.add(_loc2_.referenceId,_loc2_);
         }
         for each(_loc3_ in _limitedShopList)
         {
            _loc1_.add(_loc3_.referenceId,_loc3_);
         }
         for each(_loc4_ in _hotShop)
         {
            _loc1_.add(_loc4_.referenceId,_loc4_);
         }
         return Vector.<ShopItemInfo>(_loc1_.getValues());
      }
      
      public static function getItemPrice(param1:uint) : Number
      {
         var _loc2_:Number = NaN;
         if(_allShopItemMap.getValue(param1))
         {
            return (_allShopItemMap.getValue(param1) as ShopItemInfo).price * 10;
         }
         return 0;
      }
      
      public static function getItemDiscountPrice(param1:uint) : Number
      {
         var _loc2_:ShopItemInfo = null;
         var _loc3_:Number = NaN;
         if(_allShopItemMap.getValue(param1))
         {
            _loc2_ = _allShopItemMap.getValue(param1) as ShopItemInfo;
            _loc3_ = _loc2_.price * 10;
            if(VipManager.vipInfo.isVip())
            {
               _loc3_ *= _loc2_.discount;
            }
            else
            {
               _loc3_ *= _loc2_.noVipDiscount;
            }
            return _loc3_;
         }
         return 0;
      }
      
      public static function getSearch() : String
      {
         return _search;
      }
   }
}
