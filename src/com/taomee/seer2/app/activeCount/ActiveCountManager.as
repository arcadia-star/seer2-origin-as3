package com.taomee.seer2.app.activeCount
{
   import com.taomee.seer2.app.net.CommandSet;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.core.debugTools.MapPanelProtocolPanel;
   import com.taomee.seer2.core.net.MessageEvent;
   
   public class ActiveCountManager
   {
      
      private static var _callBack:Function;
      
      private static var _type:Object;
      
      private static var _waitList:Array = new Array();
      
      private static var _isRequesting:Boolean = false;
       
      
      public function ActiveCountManager()
      {
         super();
      }
      
      public static function requestActiveCount(param1:int, param2:Function) : void
      {
         _waitList.push({
            "type":param1,
            "callBack":param2
         });
         processNextRequest();
      }
      
      public static function requestActiveCountList(param1:Array, param2:Function) : void
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
            Connection.addCommandListener(CommandSet.ACTIVE_COUNT_1142,onGetActiveCount);
            Connection.addErrorHandler(CommandSet.ACTIVE_COUNT_1142,onGetActiveCountError);
            if(_loc1_.type is Array)
            {
               _loc2_ = int(_loc1_.type.length);
            }
            else
            {
               _loc2_ = 1;
            }
            Connection.send(CommandSet.ACTIVE_COUNT_1142,_loc2_,_loc1_.type);
            if(_loc1_.type is Array)
            {
               MapPanelProtocolPanel.instance().foreverLimitArr = _loc1_.type;
            }
            else
            {
               MapPanelProtocolPanel.instance().foreverLimitArr = [_loc1_.type];
            }
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,"\n活动次数: " + CommandSet.ACTIVE_COUNT_1142.toString());
         }
      }
      
      private static function onGetActiveCountError(param1:MessageEvent) : void
      {
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,onGetActiveCountError);
         AlertManager.showAlert("获取信息失败");
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,"\n活动次数：回包异常");
         _isRequesting = false;
         _callBack = null;
         processNextRequest();
      }
      
      private static function onGetActiveCount(param1:MessageEvent) : void
      {
         _isRequesting = false;
         Connection.removeCommandListener(CommandSet.ACTIVE_COUNT_1142,onGetActiveCount);
         Connection.removeErrorHandler(CommandSet.ACTIVE_COUNT_1142,onGetActiveCountError);
         var _loc2_:Parser_1142 = new Parser_1142(param1.message.getRawData());
         if(_type is Array)
         {
            _callBack(_loc2_);
         }
         else
         {
            _callBack(_type,_loc2_.infoVec[0]);
         }
         MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,"\n活动次数：成功回包\n");
         var _loc3_:int = 0;
         var _loc4_:Array = MapPanelProtocolPanel.instance().foreverLimitArr;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.infoVec.length)
         {
            MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,_loc4_[_loc3_] + "=" + _loc2_.infoVec[_loc3_] + ";");
            if((_loc3_ + 1) % 3 == 0 && _loc3_ + 1 != _loc2_.infoVec.length)
            {
               MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,"\n");
            }
            else
            {
               MapPanelProtocolPanel.instance().addLog(MapPanelProtocolPanel.ACTIVE_COUNT,"   \t");
            }
            _loc3_++;
         }
         processNextRequest();
      }
   }
}
