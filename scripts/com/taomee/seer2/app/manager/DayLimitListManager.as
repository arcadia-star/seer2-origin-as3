package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1065;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   import com.taomee.seer2.core.net.MessageEvent;
   import flash.utils.IDataInput;
   
   public class DayLimitListManager
   {
      
      private static var _waitVec:Vector.<DayLimitListInfo> = new Vector.<DayLimitListInfo>();
      
      private static var _isBusy:Boolean = false;
      
      private static var _callBack:Function;
      
      private static var _currentInfo:DayLimitListInfo;
       
      
      public function DayLimitListManager()
      {
         super();
      }
      
      public static function getDoCount(param1:LittleEndianByteArray, param2:Function) : void
      {
         var _loc3_:DayLimitListInfo = new DayLimitListInfo();
         _loc3_.data = param1;
         _loc3_.callBack = param2;
         _waitVec.push(_loc3_);
         if(_isBusy == false)
         {
            connectServer();
         }
      }
      
      public static function getDaylimitList(param1:Array, param2:Function) : void
      {
         var _loc3_:LittleEndianByteArray = new LittleEndianByteArray();
         var _loc4_:uint = param1.length;
         _loc3_.writeUnsignedInt(_loc4_);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_.writeUnsignedInt(param1[_loc5_]);
            _loc5_++;
         }
         var _loc6_:DayLimitListInfo;
         (_loc6_ = new DayLimitListInfo()).data = _loc3_;
         _loc6_.callBack = param2;
         _waitVec.push(_loc6_);
         if(_isBusy == false)
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
            Connection.addCommandListener(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCount);
            Connection.addErrorHandler(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCountError);
            Connection.send(CommandSet.DAY_LIMIT_LIST_1241,_currentInfo.data);
            _isBusy = true;
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,"\n每日限制： " + CommandSet.DAY_LIMIT_LIST_1241.toString());
         }
      }
      
      private static function onGetDoCount(param1:MessageEvent) : void
      {
         var _loc5_:Parser_1065 = null;
         Connection.removeCommandListener(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCount);
         Connection.removeErrorHandler(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCountError);
         var _loc2_:IDataInput = param1.message.getRawData();
         var _loc3_:uint = uint(_loc2_.readUnsignedInt());
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _currentInfo.dayLimitList.push(new Parser_1065(_loc2_));
            _loc4_++;
         }
         _callBack(_currentInfo);
         _callBack = null;
         _isBusy = false;
         connectServer();
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,"\n每日限制：成功回包\n");
         _loc4_ = 0;
         while(_loc4_ < _currentInfo.dayLimitList.length)
         {
            _loc5_ = _currentInfo.dayLimitList[_loc4_] as Parser_1065;
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,_loc5_.id + "=" + _loc5_.count + ";");
            if((_loc4_ + 1) % 3 == 0 && _loc4_ + 1 != _currentInfo.dayLimitList.length)
            {
               MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,"\n");
            }
            else
            {
               MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,"   \t");
            }
            _loc4_++;
         }
      }
      
      private static function onGetDoCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCount);
         Connection.removeErrorHandler(CommandSet.DAY_LIMIT_LIST_1241,onGetDoCountError);
         _isBusy = false;
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.DAY_LIMIT,"\n每日限制：回包异常");
         connectServer();
      }
   }
}
