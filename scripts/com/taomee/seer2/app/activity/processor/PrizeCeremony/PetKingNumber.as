package com.taomee.seer2.app.activity.processor.PrizeCeremony
{
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.events.ItemEvent;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class PetKingNumber
   {
      
      private static var _callBack:Function;
      
      private static var _rightCount:uint;
       
      
      public function PetKingNumber()
      {
         super();
      }
      
      public static function getNumber(param1:Function = null) : void
      {
         _callBack = param1;
         ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
         ItemManager.requestSpecialItemList();
      }
      
      private static function onSeer(param1:ItemEvent) : void
      {
         ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS,onSeer);
         Connection.addCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,onGetTotalVote);
         Connection.send(CommandSet.GET_TOTAL_VOTE_INFO_1219,1,1,3);
      }
      
      private static function onGetTotalVote(param1:MessageEvent) : void
      {
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         Connection.removeCommandListener(CommandSet.GET_TOTAL_VOTE_INFO_1219,onGetTotalVote);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc8_:Vector.<uint> = Vector.<uint>([]);
         var _loc9_:Vector.<uint> = Vector.<uint>([]);
         var _loc10_:int = 0;
         while(_loc10_ < _loc4_)
         {
            _loc5_ = uint(_loc2_.readUnsignedInt());
            _loc6_ = uint(_loc2_.readUnsignedInt());
            _loc8_.push(_loc5_);
            _loc9_.push(_loc6_);
            if(getItem() == _loc5_)
            {
               _loc7_ = _loc10_;
            }
            _loc10_++;
         }
         _rightCount = 1;
         var _loc11_:int = 0;
         while(_loc11_ < 3)
         {
            if(_loc9_[_loc11_] > _loc9_[_loc7_])
            {
               ++_rightCount;
            }
            _loc11_++;
         }
         if(_callBack != null)
         {
            _callBack();
         }
         _callBack = null;
      }
      
      public static function getTeam() : uint
      {
         return _rightCount;
      }
      
      public static function getItem() : uint
      {
         if(ItemManager.getSpecialItem(500508) != null)
         {
            return 1;
         }
         if(ItemManager.getSpecialItem(500509) != null)
         {
            return 2;
         }
         if(ItemManager.getSpecialItem(500510) != null)
         {
            return 3;
         }
         return 0;
      }
   }
}
