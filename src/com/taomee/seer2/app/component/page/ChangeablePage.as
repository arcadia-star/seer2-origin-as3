package com.taomee.seer2.app.component.page
{
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class ChangeablePage extends Page
   {
       
      
      private var _preBtn:SimpleButton;
      
      private var _nextBtn:SimpleButton;
      
      private var _pageTxt:TextField;
      
      private var _pageIndex:int;
      
      private var _pageTotal:int;
      
      public function ChangeablePage(param1:MovieClip, param2:Class, param3:PageLayoutInfo, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
         this.extractAssets();
         this.initEventListener();
      }
      
      private function extractAssets() : void
      {
         this._preBtn = _mainUI["preBtn"];
         this._nextBtn = _mainUI["nextBtn"];
         this._pageTxt = _mainUI["pageTxt"];
      }
      
      private function initEventListener() : void
      {
         this._preBtn.addEventListener(MouseEvent.CLICK,this.onPreBtnClick);
         this._nextBtn.addEventListener(MouseEvent.CLICK,this.onNextBtnClick);
      }
      
      private function onPreBtnClick(param1:MouseEvent) : void
      {
         this.pageIndex = this._pageIndex - 1;
         this.updateDisplay();
      }
      
      private function onNextBtnClick(param1:MouseEvent) : void
      {
         this.pageIndex = this._pageIndex + 1;
         this.updateDisplay();
      }
      
      public function refresh(param1:*) : void
      {
         _dataArr = param1;
         _selectedIndex = -1;
         this.updateData(true);
         this.updateDisplay();
      }
      
      override public function update(param1:*) : void
      {
         _dataArr = param1;
         _selectedIndex = -1;
         this.updateData(false);
         this.updateDisplay();
      }
      
      private function updateData(param1:Boolean) : void
      {
         this._pageTotal = Math.ceil(_dataArr.length / _pageCount);
         if(this._pageTotal == 0)
         {
            this._pageTotal = 1;
         }
         if(!param1)
         {
            this.pageIndex = 0;
         }
         if(this._pageIndex > this._pageTotal - 1)
         {
            this._pageIndex = this._pageTotal - 1;
         }
      }
      
      override protected function updateDisplay() : void
      {
         super.updateDisplay();
         this.updateStatus();
      }
      
      override public function get offset() : int
      {
         return this._pageIndex * _pageCount;
      }
      
      protected function updateStatus() : void
      {
         DisplayObjectUtil.enableButton(this._preBtn);
         DisplayObjectUtil.enableButton(this._nextBtn);
         if(this._pageIndex == 0)
         {
            DisplayObjectUtil.disableButton(this._preBtn);
         }
         if(this._pageIndex == this._pageTotal - 1)
         {
            DisplayObjectUtil.disableButton(this._nextBtn);
         }
         if(this._pageTxt)
         {
            this._pageTxt.text = this._pageIndex + 1 + "/" + this._pageTotal;
         }
      }
      
      protected function set pageIndex(param1:int) : void
      {
         this._pageIndex = param1;
         dispatchEvent(new Event(PAGE_INDEX_CHANGE));
      }
   }
}
