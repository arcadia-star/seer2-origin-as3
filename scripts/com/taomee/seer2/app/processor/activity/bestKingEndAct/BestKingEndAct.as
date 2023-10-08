package com.taomee.seer2.app.processor.activity.bestKingEndAct
{
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.Connection;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.DateUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class BestKingEndAct
   {
      
      private static const DAY_LIST:Array = [5179];
      
      private static const GET_SWAP:int = 4166;
      
      private static const FULL_NAME:Vector.<String> = Vector.<String>(["bestKingWinner0","bestKingWinner1"]);
      
      private static const SEAT_POS:Point = new Point(955,315);
       
      
      private var _mapModel:MapModel;
      
      public function BestKingEndAct(param1:MapModel)
      {
         super();
         this._mapModel = param1;
         this.init();
      }
      
      private function init() : void
      {
         var date:Date = null;
         (this._mapModel.content["award"] as SimpleButton).mouseEnabled = false;
         (this._mapModel.content["award"] as SimpleButton).addEventListener(MouseEvent.CLICK,this.onGetAward);
         (this._mapModel.content["winnerMc"] as MovieClip).buttonMode = true;
         (this._mapModel.content["winnerMc"] as MovieClip).addEventListener(MouseEvent.CLICK,this.onWinner);
         date = new Date(TimeManager.getServerTime() * 1000);
         ServerBufferManager.getServerBuffer(ServerBufferType.BEST_KING_END,function(param1:ServerBuffer):void
         {
            var server:ServerBuffer = param1;
            if(server.readDataAtPostion(date.date) == 0)
            {
               MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen(FULL_NAME[Connection.netType]),function():void
               {
                  ServerBufferManager.updateServerBuffer(ServerBufferType.BEST_KING_END,date.date,1);
                  update();
               },true,true,2,true);
            }
            else
            {
               update();
            }
         });
      }
      
      private function onWinner(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("BestKingEndAwardPanel");
      }
      
      private function isInAct() : Boolean
      {
         var _loc1_:Boolean = false;
         if(DateUtil.isInTime(new Date(2015,7,28),new Date(2015,7,31,23,59,59)))
         {
            if(DateUtil.isInHourScope(15,15,0,15))
            {
               _loc1_ = true;
            }
         }
         return _loc1_;
      }
      
      private function update() : void
      {
         (this._mapModel.content["award"] as SimpleButton).mouseEnabled = false;
         DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
         {
            if(param1.getCount(DAY_LIST[0]))
            {
               (_mapModel.content["award"] as SimpleButton).visible = false;
            }
            else
            {
               (_mapModel.content["award"] as SimpleButton).visible = true;
               SeatTipsManager.registerSeat(SEAT_POS,3853);
            }
            (_mapModel.content["award"] as SimpleButton).mouseEnabled = true;
         });
      }
      
      private function onGetAward(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         if(!this.isInAct())
         {
            AlertManager.showAlert("8月28日~8月31日，每天15：00~15：15才可领取!");
            return;
         }
         SwapManager.swapItem(GET_SWAP,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            (_mapModel.content["award"] as SimpleButton).visible = false;
            SeatTipsManager.removeSeat(SEAT_POS,3853);
         });
      }
      
      public function dispose() : void
      {
         (this._mapModel.content["award"] as SimpleButton).removeEventListener(MouseEvent.CLICK,this.onGetAward);
         (this._mapModel.content["winnerMc"] as MovieClip).removeEventListener(MouseEvent.CLICK,this.onWinner);
         SeatTipsManager.removeSeat(SEAT_POS,3853);
      }
   }
}
