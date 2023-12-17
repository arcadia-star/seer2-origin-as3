package com.taomee.seer2.app.home.panel.buddy
{
   import com.taomee.seer2.app.home.panel.data.HomeBuddyDataService;
   import com.taomee.seer2.app.home.panel.data.HomeBuddyDataUnit;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.ui.WaitIndicator;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   
   public class HomeBuddyList extends Sprite
   {
      
      private static const MAX_NUM:int = 5;
       
      
      private var _container:MovieClip;
      
      private var _prePageBtn:SimpleButton;
      
      private var _nextPageBtn:SimpleButton;
      
      private var _refreshBtn:SimpleButton;
      
      private var _buddyNumber:HomeNumber;
      
      private var _itemVec:Vector.<HomeBuddyItem>;
      
      private var _waitIndicator:WaitIndicator;
      
      private var _dataService:HomeBuddyDataService;
      
      private var _dataUnitVec:Vector.<HomeBuddyDataUnit>;
      
      private var _currentDataUnit:HomeBuddyDataUnit;
      
      private var _dataUnitIndex:int;
      
      private var _emptyDataUnit:HomeBuddyDataUnit;
      
      private var _hasOrder:Boolean;
      
      private var _isIncreaseOrder:Boolean;
      
      public function HomeBuddyList()
      {
         super();
         this.createChildren();
         this.createDataService();
         this.initEventListener();
         this._hasOrder = false;
      }
      
      private function createChildren() : void
      {
         this.x = 214;
         this.y = 13;
         this._container = UIManager.getMovieClip("UI_HomeBuddyList");
         addChild(this._container);
         this._buddyNumber = new HomeNumber(this._container["buddyNumber"],AlignType.MIDDLE_CENTER);
         addChild(this._buddyNumber);
         this._prePageBtn = this._container["prePage"];
         this._nextPageBtn = this._container["nextPage"];
         this._refreshBtn = this._container["refresh"];
         this.addToolTips();
         this.createItemVec();
         this._waitIndicator = new WaitIndicator();
         this._waitIndicator.x = 300;
         this._waitIndicator.y = 30;
      }
      
      private function createItemVec() : void
      {
         var _loc2_:int = 0;
         var _loc5_:HomeBuddyItem = null;
         this._itemVec = new Vector.<HomeBuddyItem>();
         var _loc1_:int = -2;
         _loc2_ = 28;
         var _loc3_:int = 130;
         var _loc4_:int = 0;
         while(_loc4_ < MAX_NUM)
         {
            (_loc5_ = new HomeBuddyItem()).y = _loc1_;
            _loc5_.x = _loc2_ + _loc3_ * _loc4_;
            addChild(_loc5_);
            this._itemVec.push(_loc5_);
            _loc4_++;
         }
      }
      
      private function createDataService() : void
      {
         this._dataService = new HomeBuddyDataService();
         this._dataUnitVec = this._dataService.dataUnitVec;
         this._emptyDataUnit = new HomeBuddyDataUnit();
         this._emptyDataUnit.status = HomeBuddyDataUnit.EMPEY;
         this._dataUnitIndex = 0;
      }
      
      private function initEventListener() : void
      {
         this._prePageBtn.addEventListener(MouseEvent.CLICK,this.onPreAllBtnClick);
         this._nextPageBtn.addEventListener(MouseEvent.CLICK,this.onNextAllBtnClick);
         this._refreshBtn.addEventListener(MouseEvent.CLICK,this.onRefreshBtnClick);
         this._dataService.addEventListener(HomeBuddyDataService.BUDDY_DATA_CHANGE,this.onBuddyDataChange);
      }
      
      private function disposeEventListener() : void
      {
         this._prePageBtn.removeEventListener(MouseEvent.CLICK,this.onPreAllBtnClick);
         this._nextPageBtn.removeEventListener(MouseEvent.CLICK,this.onNextAllBtnClick);
         this._refreshBtn.removeEventListener(MouseEvent.CLICK,this.onRefreshBtnClick);
         this._dataService.removeEventListener(HomeBuddyDataService.BUDDY_DATA_CHANGE,this.onBuddyDataChange);
      }
      
      private function onPreAllBtnClick(param1:MouseEvent) : void
      {
         DisplayObjectUtil.disableButton(this._prePageBtn);
         this.updateBuddyItem(-MAX_NUM);
      }
      
      private function onNextAllBtnClick(param1:MouseEvent) : void
      {
         DisplayObjectUtil.disableButton(this._nextPageBtn);
         this.updateBuddyItem(MAX_NUM);
      }
      
      private function onBuddyDataChange(param1:Event) : void
      {
         this._dataUnitVec = this._dataService.dataUnitVec;
         if(this._hasOrder)
         {
            this.sortAllDataUnit();
         }
         this.updateDisplay();
      }
      
      private function onRefreshBtnClick(param1:MouseEvent) : void
      {
         if(this._hasOrder == true)
         {
            this._isIncreaseOrder = !this._isIncreaseOrder;
         }
         else
         {
            this._isIncreaseOrder = false;
         }
         TooltipManager.remove(this._refreshBtn);
         var _loc2_:String = this._isIncreaseOrder ? "按训练师等级降序排序" : "按训练师等级升序排序";
         TooltipManager.addCommonTip(this._refreshBtn,_loc2_);
         DisplayObjectUtil.disableButton(this._refreshBtn);
         this.disableBuddyList();
         this.setAllDataUnitBusy();
         this.updateAllDataUnit();
      }
      
      private function updateBuddyItem(param1:int) : void
      {
         this.updateDataUnitIndex(param1);
         this.updateDisplay();
      }
      
      private function updateDataUnitIndex(param1:int) : void
      {
         this._dataUnitIndex += param1;
         if(this._dataUnitIndex < 0)
         {
            this._dataUnitIndex = 0;
         }
         if(this._dataUnitIndex + MAX_NUM > this._dataUnitVec.length)
         {
            this._dataUnitIndex = this._dataUnitVec.length - MAX_NUM;
         }
      }
      
      private function updateDisplay() : void
      {
         var _loc3_:int = 0;
         var _loc1_:int = int(this._dataUnitVec.length);
         var _loc2_:int = 0;
         while(_loc2_ < MAX_NUM)
         {
            _loc3_ = this._dataUnitIndex + _loc2_;
            if(_loc3_ < _loc1_)
            {
               this._itemVec[_loc2_].setData(this._dataUnitVec[_loc3_]);
            }
            else
            {
               this._itemVec[_loc2_].setData(this._emptyDataUnit);
            }
            _loc2_++;
         }
         this._buddyNumber.setNumber(this._dataUnitVec.length);
         this.updateBtnStatus();
         this.updateDataUnit();
      }
      
      private function updateBtnStatus() : void
      {
         this.enableBuddyList();
         if(this._dataUnitIndex == 0)
         {
            DisplayObjectUtil.disableButton(this._prePageBtn);
         }
         if(this._dataUnitIndex + MAX_NUM >= this._dataUnitVec.length)
         {
            DisplayObjectUtil.disableButton(this._nextPageBtn);
         }
      }
      
      private function updateDataUnit() : void
      {
         var _loc3_:int = 0;
         var _loc4_:HomeBuddyDataUnit = null;
         var _loc1_:int = int(this._dataUnitVec.length);
         var _loc2_:int = 0;
         while(_loc2_ < MAX_NUM)
         {
            _loc3_ = this._dataUnitIndex + _loc2_;
            if(_loc3_ < _loc1_)
            {
               if((_loc4_ = this._dataUnitVec[_loc3_]).status == HomeBuddyDataUnit.BUSY)
               {
                  this.currentDataUnit = _loc4_;
                  this._currentDataUnit.addEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdate);
                  this._currentDataUnit.update();
                  break;
               }
            }
            _loc2_++;
         }
      }
      
      private function onDataUnitUpdate(param1:Event) : void
      {
         this._currentDataUnit.removeEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdate);
         this._currentDataUnit = null;
         this.updateDisplay();
      }
      
      private function setAllDataUnitBusy() : void
      {
         var _loc1_:HomeBuddyDataUnit = null;
         for each(_loc1_ in this._dataUnitVec)
         {
            _loc1_.status = HomeBuddyDataUnit.BUSY;
         }
         addChild(this._waitIndicator);
      }
      
      private function updateAllDataUnit() : void
      {
         var _loc4_:HomeBuddyDataUnit = null;
         var _loc1_:Boolean = false;
         var _loc2_:int = int(this._dataUnitVec.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if((_loc4_ = this._dataUnitVec[_loc3_]).status == HomeBuddyDataUnit.BUSY)
            {
               this.currentDataUnit = _loc4_;
               this._currentDataUnit.addEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdateFinished);
               this._currentDataUnit.update();
               _loc1_ = true;
               break;
            }
            _loc3_++;
         }
         if(_loc1_ == false)
         {
            DisplayUtil.removeForParent(this._waitIndicator);
            this.sortAllDataUnit();
            this.enableBuddyList();
            DisplayObjectUtil.enableButton(this._prePageBtn);
            this._dataUnitIndex = 0;
            this.updateDisplay();
            this._hasOrder = true;
         }
      }
      
      private function sortAllDataUnit() : void
      {
         if(this._isIncreaseOrder == true)
         {
            this._dataUnitVec.sort(this.increaseByTrainerLevel);
         }
         else
         {
            this._dataUnitVec.sort(this.decreaseByTrainerLevel);
         }
         var _loc1_:int = int(this._dataUnitVec.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            this._dataUnitVec[_loc2_].order = _loc2_ + 1;
            _loc2_++;
         }
      }
      
      private function decreaseByTrainerLevel(param1:HomeBuddyDataUnit, param2:HomeBuddyDataUnit) : int
      {
         var _loc3_:int = param1.userInfo.trainerLevel;
         var _loc4_:int = param2.userInfo.trainerLevel;
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      private function increaseByTrainerLevel(param1:HomeBuddyDataUnit, param2:HomeBuddyDataUnit) : int
      {
         var _loc3_:int = param1.userInfo.trainerLevel;
         var _loc4_:int = param2.userInfo.trainerLevel;
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      private function onDataUnitUpdateFinished(param1:Event) : void
      {
         this._currentDataUnit.removeEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdateFinished);
         this._currentDataUnit = null;
         this.updateAllDataUnit();
      }
      
      private function set currentDataUnit(param1:HomeBuddyDataUnit) : void
      {
         if(this._currentDataUnit != null)
         {
            this._currentDataUnit.removeEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdate);
            this._currentDataUnit.removeEventListener(HomeBuddyDataUnit.UPDATE,this.onDataUnitUpdateFinished);
         }
         this._currentDataUnit = param1;
      }
      
      private function addToolTips() : void
      {
         TooltipManager.addCommonTip(this._prePageBtn,"上五个");
         TooltipManager.addCommonTip(this._nextPageBtn,"下五个");
         TooltipManager.addCommonTip(this._refreshBtn,"按训练师等级排序");
      }
      
      private function removeToolTips() : void
      {
         TooltipManager.remove(this._prePageBtn);
         TooltipManager.remove(this._nextPageBtn);
         TooltipManager.remove(this._refreshBtn);
      }
      
      private function disableBuddyList() : void
      {
         DisplayObjectUtil.disableButton(this._refreshBtn);
         DisplayObjectUtil.disableButton(this._prePageBtn);
         DisplayObjectUtil.disableButton(this._nextPageBtn);
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
      
      private function enableBuddyList() : void
      {
         DisplayObjectUtil.enableButton(this._refreshBtn);
         DisplayObjectUtil.enableButton(this._prePageBtn);
         DisplayObjectUtil.enableButton(this._nextPageBtn);
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      public function setData() : void
      {
         this.updateDisplay();
      }
      
      public function dispose() : void
      {
         var _loc1_:HomeBuddyItem = null;
         this.removeToolTips();
         this._waitIndicator.dispose();
         for each(_loc1_ in this._itemVec)
         {
            _loc1_.dispose();
         }
         this._dataService.dispose();
         this.disposeEventListener();
         this.currentDataUnit = null;
      }
   }
}
