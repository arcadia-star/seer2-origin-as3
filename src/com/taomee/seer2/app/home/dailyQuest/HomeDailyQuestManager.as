package com.taomee.seer2.app.home.dailyQuest
{
   import com.taomee.seer2.app.config.HomeDailyQuestConfig;
   import com.taomee.seer2.app.config.ItemGroupConfig;
   import com.taomee.seer2.app.inventory.ItemDescription;
   import com.taomee.seer2.app.inventory.ItemGroup;
   import com.taomee.seer2.app.inventory.ItemUtil;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class HomeDailyQuestManager
   {
      
      private static var _onQuerySuccess:Function;
      
      private static var _onCompleteSuccess:Function;
      
      {
         initialize();
      }
      
      public function HomeDailyQuestManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
      }
      
      private static function onNotify(param1:MessageEvent) : void
      {
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:HomeDailyQuest = HomeDailyQuestConfig.getDailyQuest(_loc2_.readUnsignedInt());
         _loc3_.status = _loc2_.readUnsignedByte();
         _loc3_.completeCount = _loc2_.readUnsignedByte();
         if(_loc3_.completeCount < _loc3_.count)
         {
            ServerMessager.addMessage(_loc3_.des + ": " + _loc3_.completeCount + "/" + (_loc3_.count - 1));
         }
         else if(_onCompleteSuccess != null)
         {
            _onCompleteSuccess(_loc3_);
            _onCompleteSuccess = null;
         }
      }
      
      public static function query(param1:Function) : void
      {
         _onQuerySuccess = param1;
      }
      
      private static function onQuery(param1:MessageEvent) : void
      {
         var _loc7_:int = 0;
         var _loc8_:HomeDailyQuest = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:int = int(_loc2_.readUnsignedInt());
         var _loc4_:Vector.<HomeDailyQuest> = new Vector.<HomeDailyQuest>();
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            _loc7_ = int(_loc2_.readUnsignedInt());
            (_loc8_ = HomeDailyQuestConfig.getDailyQuest(_loc7_)).status = _loc2_.readUnsignedByte();
            _loc8_.completeCount = _loc2_.readUnsignedByte();
            _loc4_.push(_loc8_);
            _loc5_++;
         }
         var _loc6_:int = int(_loc2_.readUnsignedInt());
         if(_onQuerySuccess != null)
         {
            _onQuerySuccess(_loc4_,_loc6_);
            _onQuerySuccess = null;
         }
      }
      
      public static function complete(param1:int, param2:Function) : void
      {
         _onCompleteSuccess = param2;
      }
      
      private static function onComplete(param1:MessageEvent) : void
      {
         var _loc4_:ItemDescription = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new ItemDescription(_loc2_.readUnsignedInt(),_loc2_.readUnsignedShort(),_loc2_.readUnsignedInt(),false,true);
            _loc3_.push(_loc4_);
            _loc6_++;
         }
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new ItemDescription(_loc2_.readUnsignedInt(),_loc2_.readUnsignedShort(),_loc2_.readUnsignedInt(),false,false);
            _loc3_.push(_loc4_);
            _loc6_++;
         }
         var _loc7_:uint = uint(_loc2_.readUnsignedInt());
         var _loc8_:uint = uint(_loc2_.readUnsignedInt());
         if(_loc7_ != 0)
         {
            _loc4_ = new ItemDescription(_loc7_,1,_loc8_,true,true);
            _loc3_.push(_loc4_);
         }
         ItemUtil.updateLocal(_loc3_);
         ItemUtil.showItemVec(_loc3_);
      }
      
      public static function reward() : void
      {
      }
      
      private static function onReward(param1:MessageEvent) : void
      {
         var _loc4_:ItemDescription = null;
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:Vector.<ItemDescription> = new Vector.<ItemDescription>();
         var _loc5_:int = int(_loc2_.readUnsignedInt());
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new ItemDescription(_loc2_.readUnsignedInt(),_loc2_.readUnsignedShort(),_loc2_.readUnsignedInt(),false);
            _loc3_.push(_loc4_);
            _loc6_++;
         }
         _loc5_ = int(_loc2_.readUnsignedInt());
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = new ItemDescription(_loc2_.readUnsignedInt(),1,_loc2_.readUnsignedInt(),true);
            _loc3_.push(_loc4_);
            _loc6_++;
         }
         ItemUtil.showRandomReward(ItemGroup.DAILY_QUEST,ItemGroupConfig.getGroup(ItemGroup.DAILY_QUEST,_loc3_));
      }
      
      public static function cancelCallBack() : void
      {
         _onQuerySuccess = null;
         _onCompleteSuccess = null;
      }
   }
}
