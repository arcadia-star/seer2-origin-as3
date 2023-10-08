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
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80337 extends CopyMapProcessor
   {
       
      
      private const WENZHANG_ID:uint = 203403;
      
      private const JUANZHOU_ID:uint = 206640;
      
      private const SHOW_PANE:Array = ["BuyItemPanel","SpriteQuickChangePanel"];
      
      private var _npc:MovieClip;
      
      private var _buyBtnList:Vector.<SimpleButton>;
      
      private var _buyPropInfo:BuyPropInfo;
      
      public function MapProcessor_80337(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._npc = _map.content["npc"];
         this._npc.buttonMode = true;
         this._npc.gotoAndStop(1);
         TooltipManager.addCommonTip(this._npc,"我是风姬");
         this._npc.addEventListener(MouseEvent.CLICK,this.onNpc);
         this._buyPropInfo = new BuyPropInfo();
         this._buyBtnList = new Vector.<SimpleButton>();
         this._buyBtnList.push(_map.content["buyBtn0"]);
         this._buyBtnList.push(_map.content["buyBtn1"]);
         this._buyBtnList.push(_map.content["buyBtn2"]);
         this._buyBtnList.push(_map.content["buyBtn3"]);
         ServerBufferManager.getServerBuffer(ServerBufferType.KAZEHIME_FIRST,this.getFullState);
         this.initEvent();
      }
      
      private function onNpc(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("NinjaPetKazeHimePanel");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._buyBtnList[0].removeEventListener(MouseEvent.CLICK,this.showPanel);
         this._buyBtnList[1].removeEventListener(MouseEvent.CLICK,this.showPanel);
         this._buyBtnList[2].removeEventListener(MouseEvent.CLICK,this.toBuyItem);
         this._buyBtnList[3].removeEventListener(MouseEvent.CLICK,this.toBuyItem);
      }
      
      private function initEvent() : void
      {
         this._buyBtnList[0].addEventListener(MouseEvent.CLICK,this.showPanel);
         this._buyBtnList[1].addEventListener(MouseEvent.CLICK,this.showPanel);
         this._buyBtnList[2].addEventListener(MouseEvent.CLICK,this.toBuyItem);
         this._buyBtnList[3].addEventListener(MouseEvent.CLICK,this.toBuyItem);
      }
      
      protected function toBuyItem(param1:MouseEvent) : void
      {
         if(param1.target == this._buyBtnList[2])
         {
            this._buyPropInfo.itemId = this.WENZHANG_ID;
         }
         else
         {
            this._buyPropInfo.itemId = this.JUANZHOU_ID;
         }
         ShopManager.buyBagItem(this._buyPropInfo);
      }
      
      protected function showPanel(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule(this.SHOW_PANE[this._buyBtnList.indexOf(param1.target)]));
      }
      
      private function getFullState(param1:ServerBuffer) : void
      {
         var buffer:ServerBuffer = param1;
         if(buffer.readDataAtPostion(1) == 0)
         {
            this._npc.gotoAndStop(1);
            MovieClipUtil.playFullScreen(URLUtil.getActivityFullScreen("ninjaPetKazeHimePanel/NinjaPetKazeHimeFull"),function():void
            {
               _npc.play();
               ServerBufferManager.updateServerBuffer(ServerBufferType.KAZEHIME_FIRST,1,1);
            },true,true);
         }
         else
         {
            this._npc.gotoAndPlay(1);
         }
      }
   }
}
