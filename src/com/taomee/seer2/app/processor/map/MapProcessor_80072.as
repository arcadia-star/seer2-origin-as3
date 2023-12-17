package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.info.BuyPropInfo;
   import com.taomee.seer2.app.serverBuffer.ServerBuffer;
   import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
   import com.taomee.seer2.app.serverBuffer.ServerBufferType;
   import com.taomee.seer2.app.shopManager.ShopManager;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80072 extends CopyMapProcessor
   {
       
      
      private const WENZHANG_ID:uint = 203224;
      
      private const JUANZHOU_ID:uint = 200378;
      
      private const SHOW_PANE:Array = ["BuyItemPanel","SpriteQuickChangePanel"];
      
      private var buyBtnList:Vector.<SimpleButton>;
      
      private var buyPropInfo:BuyPropInfo;
      
      public function MapProcessor_80072(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this.buyPropInfo = new BuyPropInfo();
         this.buyBtnList = new Vector.<SimpleButton>();
         this.buyBtnList.push(_map.content["buyBtn0"]);
         this.buyBtnList.push(_map.content["buyBtn1"]);
         this.buyBtnList.push(_map.content["buyBtn2"]);
         this.buyBtnList.push(_map.content["buyBtn3"]);
         ServerBufferManager.getServerBuffer(ServerBufferType.BUFFER_SEAT_57,this.getFullState);
         this.initEvent();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this.buyBtnList[0].removeEventListener(MouseEvent.CLICK,this.showPanel);
         this.buyBtnList[1].removeEventListener(MouseEvent.CLICK,this.showPanel);
         this.buyBtnList[2].removeEventListener(MouseEvent.CLICK,this.toBuyItem);
         this.buyBtnList[3].removeEventListener(MouseEvent.CLICK,this.toBuyItem);
      }
      
      private function initEvent() : void
      {
         this.buyBtnList[0].addEventListener(MouseEvent.CLICK,this.showPanel);
         this.buyBtnList[1].addEventListener(MouseEvent.CLICK,this.showPanel);
         this.buyBtnList[2].addEventListener(MouseEvent.CLICK,this.toBuyItem);
         this.buyBtnList[3].addEventListener(MouseEvent.CLICK,this.toBuyItem);
      }
      
      protected function toBuyItem(param1:MouseEvent) : void
      {
         if(param1.target == this.buyBtnList[2])
         {
            this.buyPropInfo.itemId = this.WENZHANG_ID;
         }
         else
         {
            this.buyPropInfo.itemId = this.JUANZHOU_ID;
         }
         ShopManager.buyBagItem(this.buyPropInfo);
      }
      
      protected function showPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule(this.SHOW_PANE[this.buyBtnList.indexOf(param1.target as SimpleButton)]));
      }
      
      private function getFullState(param1:ServerBuffer) : void
      {
         var buffer:ServerBuffer = param1;
         if(buffer.readDataAtPostion(34) == 0)
         {
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("BaiKuiFull"),function():void
            {
               ServerBufferManager.updateServerBuffer(ServerBufferType.BUFFER_SEAT_57,34,1);
            },true,true);
         }
      }
   }
}
