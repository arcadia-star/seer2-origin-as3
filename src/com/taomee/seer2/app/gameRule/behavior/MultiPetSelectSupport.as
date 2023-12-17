package com.taomee.seer2.app.gameRule.behavior
{
   import com.taomee.seer2.app.gameRule.data.FighterSelectPanelVO;
   import com.taomee.seer2.app.gameRule.data.PetCanvas;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.app.popup.AlertManager;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import org.taomee.filter.ColorFilter;
   
   public class MultiPetSelectSupport
   {
       
      
      private var _mainUI:MovieClip;
      
      private var _confirmBtn:SimpleButton;
      
      private var _petCounter:TextField;
      
      private var _actorName:TextField;
      
      private var _timeTxt:TextField;
      
      private var _actorCounter:MovieClip;
      
      private var _petCavasList:Vector.<PetCanvas>;
      
      private var _tagList:Vector.<InteractiveObject>;
      
      private var _initData:FighterSelectPanelVO;
      
      private var _minSelectedPetCount:int;
      
      private var _maxSelectedPetCount:int;
      
      private var _selectable:Boolean;
      
      private var _timeDown:int = 0;
      
      private var _selectedPetList:Vector.<PetCanvas>;
      
      private var _completeFun:Function;
      
      private var _confirmFightFlag:Boolean = false;
      
      private var intervalIndex:uint = 0;
      
      public function MultiPetSelectSupport(param1:Function = null)
      {
         super();
         this._completeFun = param1;
      }
      
      public function setUpMainUI(param1:MovieClip) : void
      {
         this._mainUI = param1;
         this._confirmBtn = this._mainUI["confirmBtn"];
         this._petCounter = this._mainUI["petCounter"];
         this._actorName = this._mainUI["actorName"];
         this._actorCounter = this._mainUI["actorCounter"];
         this._timeTxt = this._mainUI["timeTxt"];
         this._tagList = new Vector.<InteractiveObject>();
         this._tagList.push(this._mainUI["selected_1_pet"]);
         this._tagList.push(this._mainUI["selected_2_pet"]);
         this._tagList.push(this._mainUI["selected_3_pet"]);
         this._tagList.push(this._mainUI["selected_4_pet"]);
         this._tagList.push(this._mainUI["selected_5_pet"]);
         this._tagList.push(this._mainUI["selected_6_pet"]);
         this.hideTags();
         this._petCavasList = new Vector.<PetCanvas>();
         this._petCavasList.push(new PetCanvas(this._mainUI["play_0"]));
         this._petCavasList.push(new PetCanvas(this._mainUI["play_1"]));
         this._petCavasList.push(new PetCanvas(this._mainUI["play_2"]));
         this._petCavasList.push(new PetCanvas(this._mainUI["play_3"]));
         this._petCavasList.push(new PetCanvas(this._mainUI["play_4"]));
         this._petCavasList.push(new PetCanvas(this._mainUI["play_5"]));
         this._selectedPetList = new Vector.<PetCanvas>();
         if(this._confirmBtn != null)
         {
            this._confirmBtn.addEventListener(MouseEvent.CLICK,this.onConfirm);
         }
      }
      
      public function init(param1:FighterSelectPanelVO) : void
      {
         var _loc2_:String = null;
         this._initData = param1;
         this._minSelectedPetCount = this._initData.minSelectedPetCount;
         this._maxSelectedPetCount = this._initData.maxSelectedPetCount;
         if(this._minSelectedPetCount == this._maxSelectedPetCount)
         {
            _loc2_ = String(this._minSelectedPetCount);
         }
         else
         {
            _loc2_ = this._minSelectedPetCount + "-" + this._maxSelectedPetCount;
         }
         this._petCounter.text = _loc2_;
         this._selectable = this._initData.selectable;
         var _loc3_:Vector.<PetInfo> = this.sortSelftIDs(this._initData.pets);
         this._actorCounter.gotoAndStop(_loc3_.length);
         this.initPetCanvas(_loc3_);
         this.setDefalutPets(this._initData.defaultPets);
         this._timeDown = this._initData.timeDown;
         if(this._timeDown == 0)
         {
            this._timeTxt.visible = false;
         }
         else
         {
            this._timeTxt.visible = true;
            this.startCountDown();
         }
         if(this._actorName != null)
         {
            this._actorName.text = this._initData.actorName;
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:PetCanvas = null;
         if(this._confirmBtn != null)
         {
            this._confirmBtn.removeEventListener(MouseEvent.CLICK,this.onConfirm);
            this._confirmBtn = null;
         }
         this._petCounter = null;
         this._actorName = null;
         this._actorCounter = null;
         this._timeTxt = null;
         this._tagList = null;
         for each(_loc1_ in this._petCavasList)
         {
            _loc1_.reset();
            _loc1_.dispose();
         }
         this._petCavasList = null;
      }
      
      private function onConfirm(param1:MouseEvent) : void
      {
         var _loc3_:Vector.<uint> = null;
         var _loc4_:PetCanvas = null;
         var _loc2_:Boolean = this.checkFightPet();
         if(_loc2_)
         {
            if(this._confirmFightFlag == false)
            {
               this.stopCountDown();
               this._confirmFightFlag = true;
               if(this._confirmBtn != null)
               {
                  this._confirmBtn.visible = false;
               }
               if(this._initData.onComplete != null)
               {
                  _loc3_ = new Vector.<uint>();
                  for each(_loc4_ in this._selectedPetList)
                  {
                     _loc3_.push(_loc4_.petInfo.catchTime);
                  }
                  this._initData.onComplete(_loc3_);
                  if(this._completeFun != null)
                  {
                     this._completeFun();
                  }
               }
            }
         }
      }
      
      private function checkFightPet() : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc4_:PetInfo = null;
         var _loc5_:uint = 0;
         var _loc1_:Boolean = false;
         var _loc2_:* = this._selectedPetList.length >= this._minSelectedPetCount;
         if(_loc2_)
         {
            _loc3_ = true;
            _loc5_ = 0;
            while(_loc5_ < this._minSelectedPetCount)
            {
               if((_loc4_ = this._selectedPetList[_loc5_].petInfo).hp <= 0)
               {
                  _loc3_ = false;
                  AlertManager.showAlert("你选择出战的精灵需要恢复体力");
                  break;
               }
               _loc5_++;
            }
            if(_loc3_)
            {
               _loc1_ = true;
            }
         }
         else
         {
            AlertManager.showAlert("请选择至少 " + this._minSelectedPetCount + " 个出战精灵");
         }
         return _loc1_;
      }
      
      private function initPetCanvas(param1:Vector.<PetInfo>) : void
      {
         var _loc3_:PetCanvas = null;
         var _loc4_:PetInfo = null;
         var _loc2_:uint = this._petCavasList.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = this._petCavasList[_loc5_];
            _loc3_.highLight.visible = false;
            _loc3_.ui.buttonMode = true;
            if(param1.length > 0)
            {
               _loc3_.ui.filters = [];
               _loc3_.petInfo = param1.shift();
               _loc3_.updatePetInfo();
               if((_loc4_ = _loc3_.petInfo).hp != _loc4_.maxHp)
               {
                  _loc3_.cureBtn.visible = true;
               }
               else
               {
                  _loc3_.cureBtn.visible = false;
               }
               _loc3_.ui.addEventListener(MouseEvent.CLICK,this.onClickHandler);
               _loc3_.addCureListener();
            }
            else
            {
               _loc3_.reset();
               ColorFilter.setGrayscale(_loc3_.ui);
            }
            _loc5_++;
         }
      }
      
      private function setDefalutPets(param1:Vector.<PetInfo>) : void
      {
         var _loc2_:PetCanvas = null;
         var _loc3_:PetInfo = null;
         var _loc4_:Boolean = false;
         if(param1 != null)
         {
            for each(_loc3_ in param1)
            {
               _loc2_ = this.getPetCanvasById(_loc3_.catchTime);
               if(_loc2_ != null)
               {
                  _loc4_ = true;
                  if(this._initData.onSelectCheck != null && this._initData.onSelectCheck(_loc3_) == false)
                  {
                     _loc4_ = false;
                  }
                  if(_loc4_)
                  {
                     this._selectedPetList.push(_loc2_);
                     _loc2_.highLight.visible = true;
                  }
               }
            }
            this.updateTags();
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = null;
         var _loc3_:PetCanvas = null;
         if(this._confirmFightFlag == false)
         {
            _loc2_ = param1.currentTarget as MovieClip;
            _loc3_ = this.getPlayerPetCanvas(_loc2_);
            if(_loc3_.petInfo != null)
            {
               if(this._selectable)
               {
                  this.setSlectedPet(_loc3_);
               }
               else
               {
                  this.adjustSelectedPet(_loc3_);
               }
            }
         }
      }
      
      private function adjustSelectedPet(param1:PetCanvas) : void
      {
         var _loc2_:int = this._selectedPetList.indexOf(param1);
         if(_loc2_ != -1)
         {
            this._selectedPetList.unshift(this._selectedPetList.splice(_loc2_,1)[0]);
         }
         this.updateTags();
      }
      
      private function setSlectedPet(param1:PetCanvas) : void
      {
         var _loc4_:int = 0;
         var _loc2_:PetInfo = param1.petInfo;
         var _loc3_:Boolean = true;
         if(this._initData.onSelectCheck != null && this._initData.onSelectCheck(_loc2_) == false)
         {
            _loc3_ = false;
         }
         if(_loc3_)
         {
            if((_loc4_ = this._selectedPetList.indexOf(param1)) == -1)
            {
               if(this._selectedPetList.length > this._maxSelectedPetCount - 1)
               {
                  this._selectedPetList.shift().highLight.visible = false;
               }
               this._selectedPetList.push(param1);
               param1.highLight.visible = true;
            }
            else
            {
               this._selectedPetList.splice(_loc4_,1);
               param1.highLight.visible = false;
            }
            this.updateTags();
         }
      }
      
      private function getPetCanvasById(param1:uint) : PetCanvas
      {
         var _loc2_:PetCanvas = null;
         var _loc3_:PetInfo = null;
         for each(_loc2_ in this._petCavasList)
         {
            _loc3_ = _loc2_.petInfo;
            if(_loc3_ != null && param1 == _loc3_.catchTime)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function getPlayerPetCanvas(param1:MovieClip) : PetCanvas
      {
         var _loc2_:PetCanvas = null;
         for each(_loc2_ in this._petCavasList)
         {
            if(_loc2_.ui != null && _loc2_.ui == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function sortSelftIDs(param1:Vector.<PetInfo>) : Vector.<PetInfo>
      {
         var compareFunction:Function = null;
         var petList:Vector.<PetInfo> = param1;
         compareFunction = function(param1:PetInfo, param2:PetInfo):int
         {
            var _loc3_:uint = param1.catchTime;
            var _loc4_:uint = param2.catchTime;
            if(_loc3_ > _loc4_)
            {
               return 1;
            }
            return -1;
         };
         petList = petList.sort(compareFunction);
         return petList;
      }
      
      public function startCountDown() : void
      {
         var intervalHandler:Function = null;
         intervalHandler = function():void
         {
            --_timeDown;
            _timeTxt.text = "剩余选择时间:" + _timeDown;
            if(_timeDown <= 0)
            {
               stopCountDown();
               timeOutHandler();
            }
         };
         this.intervalIndex = setInterval(intervalHandler,1000);
      }
      
      public function stopCountDown() : void
      {
         if(this.intervalIndex != 0)
         {
            clearInterval(this.intervalIndex);
         }
      }
      
      private function timeOutHandler() : void
      {
         var _loc3_:PetInfo = null;
         var _loc4_:PetCanvas = null;
         var _loc6_:Boolean = false;
         var _loc1_:Vector.<PetInfo> = this._initData.pets;
         var _loc2_:uint = _loc1_.length;
         var _loc5_:uint = 0;
         while(_loc5_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc5_];
            if((_loc4_ = this.getPetCanvasById(_loc3_.catchTime)) != null)
            {
               _loc6_ = true;
               if(this._initData.onSelectCheck != null && this._initData.onSelectCheck(_loc3_) == false)
               {
                  _loc6_ = false;
               }
               if(_loc6_)
               {
                  this._selectedPetList.push(_loc4_);
                  _loc4_.highLight.visible = true;
               }
            }
            if(this._selectedPetList.length >= this._maxSelectedPetCount)
            {
               break;
            }
            _loc5_++;
         }
         this.updateTags();
         this.onConfirm(null);
      }
      
      private function hideTags() : void
      {
         var _loc1_:InteractiveObject = null;
         for each(_loc1_ in this._tagList)
         {
            _loc1_.visible = false;
            _loc1_.mouseEnabled = false;
         }
      }
      
      private function updateTags() : void
      {
         var _loc2_:PetCanvas = null;
         var _loc4_:uint = 0;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         this.hideTags();
         var _loc1_:uint = this._selectedPetList.length;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._selectedPetList[_loc3_];
            _loc4_ = _loc3_;
            _loc5_ = _loc2_.ui.x;
            _loc6_ = _loc2_.ui.y;
            if(_loc4_ + 1 <= this._tagList.length)
            {
               if(this._initData.isShowSelected)
               {
                  this._tagList[_loc3_].visible = true;
               }
               this._tagList[_loc3_].x = _loc5_ - 40;
               this._tagList[_loc3_].y = _loc6_ - 40;
            }
            _loc3_++;
         }
      }
   }
}
