package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.info.DayLimitInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1060;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class MineManger
   {
      
      private static var _waitVec:Vector.<DayLimitInfo> = new Vector.<DayLimitInfo>();
      
      private static var _isBusy:Boolean = false;
      
      private static var _currentInfo:DayLimitInfo;
      
      private static var _callBack:Function;
      
      private static var _failBack:Function;
       
      
      public function MineManger()
      {
         super();
      }
      
      public static function getMineItem(param1:int, param2:Function, param3:Function = null) : void
      {
         var _loc4_:DayLimitInfo;
         (_loc4_ = new DayLimitInfo()).type = param1;
         _loc4_.callBack = param2;
         _loc4_.failBack = param3;
         _waitVec.push(_loc4_);
         if(!_isBusy)
         {
            connectServer();
         }
      }
      
      private static function connectServer() : void
      {
         if(_waitVec.length >= 1)
         {
            _currentInfo = _waitVec.shift();
            _callBack = _currentInfo.callBack;
            _failBack = _currentInfo.failBack;
            Connection.addCommandListener(CommandSet.DIGGER_MINE_1060,onGetMine);
            Connection.addErrorHandler(CommandSet.DIGGER_MINE_1060,onError);
            Connection.send(CommandSet.DIGGER_MINE_1060,_currentInfo.type);
            _isBusy = true;
         }
      }
      
      private static function onError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,onGetMine);
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,onError);
         if(_failBack != null)
         {
            _failBack(param1.message.statusCode);
         }
         _failBack = null;
         _isBusy = false;
         connectServer();
      }
      
      private static function onGetMine(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DIGGER_MINE_1060,onGetMine);
         Connection.removeErrorHandler(CommandSet.DIGGER_MINE_1060,onError);
         var _loc2_:Parser_1060 = new Parser_1060(param1.message.getRawDataCopy());
         _callBack(_loc2_);
         _callBack = null;
         _isBusy = false;
         connectServer();
      }
   }
}
