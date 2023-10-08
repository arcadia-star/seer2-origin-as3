package com.taomee.seer2.app.config.questAnswer
{
   public class FestivalAnswerConfig
   {
      
      private static var _xmlClass:Class = FestivalAnswerConfig__xmlClass;
      
      private static var _allItems:Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>;
      
      {
         setup();
      }
      
      public function FestivalAnswerConfig()
      {
         super();
      }
      
      private static function setup() : void
      {
         var _loc3_:com.taomee.seer2.app.config.questAnswer.QuestInfo = null;
         var _loc4_:Vector.<String> = null;
         var _loc5_:int = 0;
         var _loc6_:Array = null;
         var _loc7_:XML = null;
         _allItems = new Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>();
         var _loc1_:XML = XML(new _xmlClass());
         var _loc2_:XMLList = _loc1_.elements();
         for each(_loc7_ in _loc2_)
         {
            _loc3_ = new com.taomee.seer2.app.config.questAnswer.QuestInfo();
            _loc3_.id = int(_loc7_.@id);
            _loc3_.ask = String(_loc7_.@ask);
            _loc4_ = new Vector.<String>();
            _loc6_ = String(_loc7_.@selectItems).split(";");
            _loc5_ = 0;
            while(_loc5_ < _loc6_.length)
            {
               _loc4_.push(_loc6_[_loc5_]);
               _loc5_++;
            }
            _loc3_.selectItems = _loc4_;
            _loc3_.answer = int(_loc7_.@answer);
            _allItems.push(_loc3_);
         }
      }
      
      public static function getItemByType(param1:int) : Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>
      {
         var _loc3_:com.taomee.seer2.app.config.questAnswer.QuestInfo = null;
         var _loc2_:Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo> = new Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>();
         for each(_loc3_ in _allItems)
         {
            if(int(_loc3_.id / 1000) == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
      
      public static function getItemBuyTypeArr(param1:Vector.<int>) : Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>
      {
         var _loc3_:com.taomee.seer2.app.config.questAnswer.QuestInfo = null;
         var _loc2_:Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo> = new Vector.<com.taomee.seer2.app.config.questAnswer.QuestInfo>();
         for each(_loc3_ in _allItems)
         {
            if(param1.indexOf(int(_loc3_.id / 1000)) != -1)
            {
               _loc2_.push(_loc3_);
            }
         }
         return _loc2_;
      }
   }
}
