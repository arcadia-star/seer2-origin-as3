package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.actor.ActorManager;
   import com.taomee.seer2.app.dialog.DialogPanel;
   import com.taomee.seer2.app.dialog.DialogPanelEventData;
   import com.taomee.seer2.app.dialog.events.DialogPanelEvent;
   import com.taomee.seer2.app.info.DayLimitListInfo;
   import com.taomee.seer2.app.manager.DayLimitListManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.popup.AlertManager;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.app.utils.ActsHelperUtil;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_3844 extends MapProcessor
   {
      
      private static const DAY_LIST:Array = [5067,5068,5069];
      
      private static const FOR_LIST:Array = [250149,250150,250151];
      
      private static const SWAP_LIST:Vector.<int> = Vector.<int>([3914]);
      
      private static const MI_ID_LIST:Vector.<uint> = Vector.<uint>([605744,605745]);
      
      private static const GAME_SET:Vector.<int> = Vector.<int>([60,5]);
       
      
      private var _par:Parser_1142;
      
      private var _info:DayLimitListInfo;
      
      public function MapProcessor_3844(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.miKaChangeAct();
      }
      
      private function miKaChangeAct() : void
      {
         DialogPanel.addEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onChangeUint);
      }
      
      private function onChangeUint(param1:DialogPanelEvent) : void
      {
         var _loc2_:String = (param1.content as DialogPanelEventData).params;
         if(_loc2_ == "MiKaNormalChange")
         {
            this.onChangeHandle(0);
         }
         else
         {
            this.onChangeHandle(1);
         }
      }
      
      private function setFuncDisable() : void
      {
      }
      
      private function update(param1:Function = null) : void
      {
         var callBack:Function = param1;
         this.setFuncDisable();
         ActiveCountManager.requestActiveCountList(FOR_LIST,function(param1:Parser_1142):void
         {
            var par:Parser_1142 = param1;
            DayLimitListManager.getDaylimitList(DAY_LIST,function(param1:DayLimitListInfo):void
            {
               _par = par;
               _info = param1;
               if(callBack != null)
               {
                  callBack();
               }
            });
         });
      }
      
      private function onChangeHandle(param1:int) : void
      {
         var index:int = param1;
         this.update(function():void
         {
            var canNum:int;
            if(_par.infoVec[2] > 0)
            {
               AlertManager.showAlert("变身中不可再变身哦!");
               return;
            }
            if(TimeManager.getPrecisionServerTime() < _info.getCount(DAY_LIST[2]))
            {
               AlertManager.showAlert("处于变身cd等待中,不可变身哦!");
               return;
            }
            canNum = ActsHelperUtil.getCanNum(_info.getCount(DAY_LIST[0]),_par.infoVec[0],GAME_SET[1]);
            if(canNum <= 0)
            {
               ShopManager.buyItemForId(MI_ID_LIST[0]);
               return;
            }
            if(index == 0)
            {
               SwapManager.swapItem(SWAP_LIST[0],1,function(param1:IDataInput):void
               {
                  new SwapInfo(param1);
                  ActorManager.getActor().updateMiKaChangeAct();
               });
            }
            else
            {
               ShopManager.buyItemForId(MI_ID_LIST[1],function(param1:*):void
               {
                  ActorManager.getActor().updateMiKaChangeAct();
               });
            }
         });
      }
      
      private function actDispose() : void
      {
         SeatTipsManager.removeSeat(new Point(480,310),3844);
         DialogPanel.removeEventListener(DialogPanelEvent.CUSTOM_UNIT_CLICK,this.onChangeUint);
      }
      
      override public function dispose() : void
      {
         this.actDispose();
         super.dispose();
      }
   }
}
