package com.taomee.seer2.app.gameRule.spt.support
{
   public class SptDialogConfig
   {
      
      private static var _xmlClass:Class = SptDialogConfig__xmlClass;
      
      private static var _xml:XML;
      
      public static var infoVec:Vector.<SptDialogInfo>;
      
      {
         setup();
      }
      
      public function SptDialogConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc2_:XML = null;
         var _loc3_:SptDialogInfo = null;
         infoVec = new Vector.<SptDialogInfo>();
         _xml = XML(new _xmlClass());
         var _loc1_:XMLList = _xml.descendants("spt");
         for each(_loc2_ in _loc1_)
         {
            _loc3_ = new SptDialogInfo();
            _loc3_.bossId = _loc2_.attribute("sptid");
            _loc3_.setUpTalks(_loc2_["talks"]);
            _loc3_.setUpContents(_loc2_["dialogs"]);
            infoVec.push(_loc3_);
         }
      }
      
      public static function getTalkContent(param1:uint) : String
      {
         var _loc2_:String = "";
         var _loc3_:uint = infoVec.length;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if(infoVec[_loc4_].bossId == param1)
            {
               _loc2_ = infoVec[_loc4_].getTalkContent();
               break;
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public static function getSptDialog(param1:uint, param2:uint, param3:Array = null) : String
      {
         var _loc4_:String = "";
         var _loc5_:uint = infoVec.length;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_)
         {
            if(infoVec[_loc6_].bossId == param1)
            {
               _loc4_ = infoVec[_loc6_].getDialogContent(param2,param3);
               break;
            }
            _loc6_++;
         }
         return _loc4_;
      }
   }
}
