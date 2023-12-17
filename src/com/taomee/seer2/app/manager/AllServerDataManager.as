package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1527;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class AllServerDataManager
   {
      
      private static var _callBack:Function;
      
      private static var _type:Object;
      
      private static var _waitList:Array = new Array();
      
      private static var _isRequesting:Boolean = false;
       
      
      public function AllServerDataManager()
      {
         super();
      }
      
      public static function requestTypeData(param1:int, param2:Function) : void
      {
         _waitList.push({
            "type":param1,
            "callBack":param2
         });
         processNextRequest();
      }
      
      public static function requestListData(param1:Array, param2:Function) : void
      {
         _waitList.push({
            "type":param1,
            "callBack":param2
         });
         processNextRequest();
      }
      
      private static function processNextRequest() : void
      {
         var _loc1_:Object = null;
         var _loc2_:int = 0;
         if(Boolean(_waitList.length) && _isRequesting == false)
         {
            _isRequesting = true;
            _loc1_ = _waitList.shift();
            _callBack = _loc1_.callBack;
            _type = _loc1_.type;
            Connection.addCommandListener(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCount);
            Connection.addErrorHandler(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCountError);
            if(_loc1_.type is Array)
            {
               _loc2_ = int(_loc1_.type.length);
            }
            else
            {
               _loc2_ = 1;
            }
            Connection.send(CommandSet.ALL_SERVER_DATA_1527,_loc2_,_loc1_.type);
         }
      }
      
      private static function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCountError);
         AlertManager.showAlert("获取信息失败");
         _isRequesting = false;
         _callBack = null;
         processNextRequest();
      }
      
      private static function onGetActiveCount(param1:MessageEvent) : void
      {
         _isRequesting = false;
         Connection.removeCommandListener(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ALL_SERVER_DATA_1527,onGetActiveCountError);
         var _loc2_:Parser_1527 = new Parser_1527(param1.message.getRawData());
         if(_type is Array)
         {
            _callBack(_loc2_);
         }
         else
         {
            _callBack(_type,_loc2_.infoVec[0]);
         }
         processNextRequest();
      }
   }
}
