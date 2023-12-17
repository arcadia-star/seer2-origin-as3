package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.activeCount.ActiveCountManager;
   import com.taomee.seer2.app.manager.SeatTipsManager;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.net.parser.Parser_1142;
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.app.swap.info.SwapInfo;
   import com.taomee.seer2.core.entity.MobileManager;
   import com.taomee.seer2.core.entity.constant.MobileType;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class MapProcessor_1501 extends MapProcessor
   {
       
      
      private const giftArr:Vector.<int> = Vector.<int>([1620,1621]);
      
      private var _isGiftVec:Vector.<uint>;
      
      private var _giftMCList:Vector.<MovieClip>;
      
      private var _seMC:MovieClip;
      
      private var _seBool:Boolean;
      
      public function MapProcessor_1501(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         StatisticsManager.sendNovice("0x1003394C");
         this.initYuese();
         this.initGift();
         this.initEvetn();
      }
      
      private function initYuese() : void
      {
         this._seMC = _map.content["seMC"];
         ActiveCountManager.requestActiveCount(202987,function(param1:uint, param2:uint):void
         {
            if(param2 == 0)
            {
               _seBool = true;
            }
            else
            {
               _seBool = false;
            }
         });
      }
      
      private function initGift() : void
      {
         var i:int = 0;
         this._giftMCList = Vector.<MovieClip>([]);
         i = 0;
         while(i < 2)
         {
            this._giftMCList.push(_map.content["gift" + i]);
            this._giftMCList[i].buttonMode = true;
            this._giftMCList[i].addEventListener(MouseEvent.CLICK,this.onGift);
            i++;
         }
         ActiveCountManager.requestActiveCountList([202523,202524],function(param1:Parser_1142):void
         {
            _isGiftVec = param1.infoVec;
         });
      }
      
      private function onGift(param1:MouseEvent) : void
      {
         var index:int = 0;
         var event:MouseEvent = param1;
         index = this._giftMCList.indexOf(event.currentTarget as MovieClip);
         if(this._isGiftVec[index] == 0)
         {
            SwapManager.swapItem(this.giftArr[index],1,function(param1:IDataInput):void
            {
               new SwapInfo(param1);
               _isGiftVec[index] = 1;
            });
         }
      }
      
      private function initEvetn() : void
      {
         MobileManager.getMobile(330,MobileType.NPC).addEventListener(MouseEvent.CLICK,this.onClickHandler);
         MobileManager.getMobile(329,MobileType.NPC).addEventListener(MouseEvent.CLICK,this.onClickHandler);
         MobileManager.getMobile(331,MobileType.NPC).addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this._seMC.addEventListener(MouseEvent.CLICK,this.onSe);
      }
      
      private function onSe(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(this._seBool == false)
         {
            return;
         }
         SwapManager.swapItem(1653,1,function(param1:IDataInput):void
         {
            new SwapInfo(param1);
            _seBool = false;
         });
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         SeatTipsManager.removeSeat(new Point(220,353),1501);
         SeatTipsManager.removeSeat(new Point(686,351),1501);
         SeatTipsManager.removeSeat(new Point(334,278),1501);
         SeatTipsManager.removeSeat(new Point(754,111),1501);
      }
      
      override public function dispose() : void
      {
         SeatTipsManager.removeSeat(new Point(220,353),1501);
         SeatTipsManager.removeSeat(new Point(686,351),1501);
         SeatTipsManager.removeSeat(new Point(334,278),1501);
         SeatTipsManager.removeSeat(new Point(754,111),1501);
         super.dispose();
      }
   }
}
