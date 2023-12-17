package com.taomee.seer2.app.pet
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   import org.taomee.ds.HashMap;
   
   public class PetIsHaveManager
   {
      
      private static var _successCallBack:Function;
      
      private static var _errorCallBack:Function;
      
      private static var _waitList:Array = [];
      
      private static var _isRequesting:Boolean = false;
      
      private static var _petIdList:Vector.<uint>;
      
      private static var _petMap:HashMap = new HashMap();
       
      
      public function PetIsHaveManager()
      {
         super();
      }
      
      public static function requestIsHavePet(param1:Vector.<uint>, param2:Function) : void
      {
         _waitList.push({
            "list":param1,
            "success":param2
         });
         processNextRequest();
      }
      
      private static function processNextRequest() : void
      {
         var _loc1_:Object = null;
         var _loc2_:LittleEndianByteArray = null;
         var _loc3_:uint = 0;
         if(Boolean(_waitList.length) && _isRequesting == false)
         {
            _isRequesting = true;
            _loc1_ = _waitList.shift();
            _petIdList = _loc1_.list;
            _loc2_ = new LittleEndianByteArray();
            _loc2_.writeInt(_petIdList.length);
            for each(_loc3_ in _petIdList)
            {
               _loc2_.writeInt(_loc3_);
            }
            _successCallBack = _loc1_.success;
            Connection.addCommandListener(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244,onGetRewardSuccess);
            Connection.send(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244,123,_loc2_);
         }
      }
      
      private static function onGetRewardSuccess(param1:MessageEvent) : void
      {
         var _loc5_:uint = 0;
         Connection.removeCommandListener(CommandSet.CLI_CHECK_HAVE_THIS_NUM_ID_1244,onGetRewardSuccess);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:uint = uint(_loc2_.readUnsignedInt());
         var _loc6_:int = 0;
         while(_loc6_ < _loc4_)
         {
            _loc5_ = uint(_loc2_.readUnsignedInt());
            _petMap.add(_petIdList[_loc6_],_loc5_);
            _loc6_++;
         }
         _successCallBack();
         _successCallBack = null;
         _isRequesting = false;
         processNextRequest();
      }
      
      public static function petIsHave(param1:uint) : Boolean
      {
         if(_petMap.containsKey(param1))
         {
            return _petMap.getValue(param1) == 1 ? true : false;
         }
         return false;
      }
   }
}
