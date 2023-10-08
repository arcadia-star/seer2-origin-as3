package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PeakBattlesGoodsInfo;
   
   public class PeakBattleConfig
   {
      
      private static var _xmlClass:Class = PeakBattleConfig__xmlClass;
      
      private static var _goodsXml:XML;
      
      private static var _goodsList:Vector.<PeakBattlesGoodsInfo>;
      
      private static var _bagList:Vector.<PeakBattlesGoodsInfo>;
      
      private static var _gadList:Vector.<PeakBattlesGoodsInfo>;
      
      private static var _petList:Vector.<PeakBattlesGoodsInfo>;
      
      private static var _equipList:Vector.<PeakBattlesGoodsInfo>;
      
      {
         initXml();
      }
      
      public function PeakBattleConfig()
      {
         super();
      }
      
      public static function get equipList() : Vector.<PeakBattlesGoodsInfo>
      {
         return _equipList;
      }
      
      public static function get petList() : Vector.<PeakBattlesGoodsInfo>
      {
         return _petList;
      }
      
      public static function get gadList() : Vector.<PeakBattlesGoodsInfo>
      {
         return _gadList;
      }
      
      public static function get bagList() : Vector.<PeakBattlesGoodsInfo>
      {
         return _bagList;
      }
      
      public static function get goodsList() : Vector.<PeakBattlesGoodsInfo>
      {
         return _goodsList;
      }
      
      private static function initXml() : void
      {
         var goodsXmlList:XMLList = null;
         var info:PeakBattlesGoodsInfo = null;
         var goodsXml:XML = null;
         var bagxmlList:XMLList = null;
         var bagxml:XML = null;
         var gadXmlList:XMLList = null;
         var gadxml:XML = null;
         var petXmlList:XMLList = null;
         var petxml:XML = null;
         var equipXmlList:XMLList = null;
         var equipxml:XML = null;
         _goodsXml = XML(new _xmlClass());
         _goodsList = new Vector.<PeakBattlesGoodsInfo>();
         goodsXmlList = _goodsXml.swap.(@type == "goods").goods;
         for each(goodsXml in goodsXmlList)
         {
            info = new PeakBattlesGoodsInfo();
            info.id = uint(goodsXml.@id);
            info.tips = String(goodsXml.@tips);
            info.price = uint(goodsXml.@price);
            info.swapId = uint(goodsXml.@swapId);
            info.checkID = uint(goodsXml.@checkID);
            info.dayLimitNum = int(goodsXml.@daylimitNum);
            _goodsList.push(info);
         }
         _bagList = new Vector.<PeakBattlesGoodsInfo>();
         bagxmlList = _goodsXml.swap.(@type == "honour").honour.(@type == "bag").goods;
         for each(bagxml in bagxmlList)
         {
            info = new PeakBattlesGoodsInfo();
            info.id = uint(bagxml.@id);
            info.tips = String(bagxml.@tips);
            info.price = uint(bagxml.@price);
            info.swapId = uint(bagxml.@swapId);
            info.checkID = uint(bagxml.@checkID);
            info.isNewItem = parseBool(bagxml,"isNew",false);
            _bagList.push(info);
         }
         _gadList = new Vector.<PeakBattlesGoodsInfo>();
         gadXmlList = _goodsXml.swap.(@type == "honour").honour.(@type == "gad").goods;
         for each(gadxml in gadXmlList)
         {
            info = new PeakBattlesGoodsInfo();
            info.id = uint(gadxml.@id);
            info.tips = String(gadxml.@tips);
            info.price = uint(gadxml.@price);
            info.swapId = uint(gadxml.@swapId);
            info.checkID = uint(gadxml.@checkID);
            info.isNewItem = parseBool(gadxml,"isNew",false);
            _gadList.push(info);
         }
         _petList = new Vector.<PeakBattlesGoodsInfo>();
         petXmlList = _goodsXml.swap.(@type == "honour").honour.(@type == "pet").goods;
         for each(petxml in petXmlList)
         {
            info = new PeakBattlesGoodsInfo();
            info.id = uint(petxml.@id);
            info.tips = String(petxml.@tips);
            info.price = uint(petxml.@price);
            info.swapId = uint(petxml.@swapId);
            info.checkID = uint(petxml.@checkID);
            info.isNewItem = parseBool(petxml,"isNew",false);
            _petList.push(info);
         }
         _equipList = new Vector.<PeakBattlesGoodsInfo>();
         equipXmlList = _goodsXml.swap.(@type == "honour").honour.(@type == "equip").goods;
         for each(equipxml in equipXmlList)
         {
            info = new PeakBattlesGoodsInfo();
            info.id = uint(equipxml.@id);
            info.tips = String(equipxml.@tips);
            info.price = uint(equipxml.@price);
            info.swapId = uint(equipxml.@swapId);
            info.checkID = uint(equipxml.@checkID);
            info.isNewItem = parseBool(equipxml,"isNew",false);
            _equipList.push(info);
         }
      }
      
      private static function parseBool(param1:XML, param2:String, param3:Boolean) : Boolean
      {
         var _loc4_:String;
         if((_loc4_ = String(param1.attribute(param2))) == "")
         {
            return param3;
         }
         if(_loc4_ == "0")
         {
            return false;
         }
         return true;
      }
   }
}
