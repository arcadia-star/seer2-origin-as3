package com.taomee.seer2.app.arena.newUI.toolbar
{
   import com.taomee.seer2.app.arena.ArenaScene;
   import com.taomee.seer2.app.arena.Fighter;
   import com.taomee.seer2.app.arena.events.OperateEvent;
   import com.taomee.seer2.app.arena.newUI.toolbar.sub.NewItemDisplay;
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.arena.ui.toolbar.sub.ItemTip;
   import com.taomee.seer2.app.arena.util.FightMode;
   import com.taomee.seer2.app.config.FitConfig;
   import com.taomee.seer2.app.firstTeach.guide.controller.GudieFightTipContent;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.constant.PetItemType;
   import com.taomee.seer2.app.inventory.item.PetItem;
   import com.taomee.seer2.app.popup.ServerMessager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   internal class NewItemPanel extends Sprite
   {
      
      private static const MEDICINE_ITEM_TYPE_VECTOR:Vector.<int> = Vector.<int>([PetItemType.PHYSICAL_MEDICINE,PetItemType.ANGER_MEDICINE,PetItemType.FIGHT_MEDICINE,PetItemType.PROPERTY_MEDICINE,PetItemType.AID_MEDICINE,PetItemType.RESURRECTION]);
      
      private static const ITEM_NUM_PATGE:int = 9;
       
      
      private var _pageIndex:int;
      
      private var _maxPageIndex:int;
      
      private var _petItemVec:Vector.<PetItem>;
      
      private var _itemDisplayVec:Vector.<NewItemDisplay>;
      
      private var _nextBtn:SimpleButton;
      
      private var _prevBtn:SimpleButton;
      
      private var _tip:ItemTip;
      
      private var _filterType:int;
      
      private var _fighter:Fighter;
      
      private var _oppositeFighter:Fighter;
      
      private var _usedItemReferenceId:uint;
      
      public function NewItemPanel(param1:int)
      {
         var offsetX:int;
         var offsetY:int;
         var itemWidth:int;
         var i:int = 0;
         var onOver:Function = null;
         var onOut:Function = null;
         var onNextPage:Function = null;
         var onPrevPage:Function = null;
         var itemDisplay:NewItemDisplay = null;
         var filterType:int = param1;
         super();
         onOver = function(param1:MouseEvent):void
         {
            var _loc2_:NewItemDisplay = param1.currentTarget as NewItemDisplay;
            _tip.setItemInfo(_loc2_.getItemInfo());
            _tip.x = _loc2_.x + 15;
            _tip.y = _loc2_.y;
            addChild(_tip);
         };
         onOut = function(param1:MouseEvent):void
         {
            if(Boolean(_tip) && contains(_tip))
            {
               removeChild(_tip);
            }
         };
         onNextPage = function(param1:MouseEvent):void
         {
            ++_pageIndex;
            showPage(_pageIndex);
         };
         onPrevPage = function(param1:MouseEvent):void
         {
            --_pageIndex;
            showPage(_pageIndex);
         };
         this._filterType = filterType;
         this.mouseEnabled = false;
         offsetX = 72;
         offsetY = 4;
         itemWidth = 73;
         this._itemDisplayVec = new Vector.<NewItemDisplay>();
         i = 0;
         while(i < ITEM_NUM_PATGE)
         {
            itemDisplay = new NewItemDisplay();
            itemDisplay.x = offsetX + i * itemWidth;
            itemDisplay.y = offsetY + i % 2 * 20;
            itemDisplay.addEventListener(MouseEvent.CLICK,this.onClick);
            itemDisplay.addEventListener(MouseEvent.MOUSE_OVER,onOver);
            itemDisplay.addEventListener(MouseEvent.MOUSE_OUT,onOut);
            this._itemDisplayVec.push(itemDisplay);
            addChild(itemDisplay);
            i++;
         }
         this._prevBtn = FightUIManager.getButton("New_UI_FightPage");
         this._prevBtn.x = 35;
         this._prevBtn.y = 46;
         addChild(this._prevBtn);
         this._nextBtn = FightUIManager.getButton("New_UI_FightPage");
         this._nextBtn.x = 760;
         this._nextBtn.y = 46;
         this._nextBtn.scaleX = -1;
         addChild(this._nextBtn);
         this.disableBtn(this._prevBtn);
         this.disableBtn(this._nextBtn);
         this._tip = new ItemTip();
         this._nextBtn.addEventListener(MouseEvent.CLICK,onNextPage);
         this._prevBtn.addEventListener(MouseEvent.CLICK,onPrevPage);
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA)
         {
            this.addGudie();
         }
         else if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA)
         {
            this.addGudie();
         }
         else if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA5)
         {
            this.addGudie5();
         }
      }
      
      private function addGudie5() : void
      {
         if(this._filterType == PetItemType.CAPSULE)
         {
            GudieFightTipContent.pushTar(this._itemDisplayVec[0],7);
         }
      }
      
      private function addGudie() : void
      {
         if(this._filterType == PetItemType.PHYSICAL_MEDICINE)
         {
            GudieFightTipContent.pushTar(this._itemDisplayVec[0],2);
         }
         else if(this._filterType == PetItemType.CAPSULE)
         {
            GudieFightTipContent.pushTar(this._itemDisplayVec[0],4);
         }
      }
      
      public function setControlledFighter(param1:Fighter) : void
      {
         this._fighter = param1;
      }
      
      public function setOppositeFighter(param1:Fighter) : void
      {
         this._oppositeFighter = param1;
      }
      
      public function reset() : void
      {
         var _loc1_:PetItem = null;
         if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA && this._filterType == PetItemType.PHYSICAL_MEDICINE)
         {
            _loc1_ = new PetItem(200011,1,0);
            this._petItemVec = new Vector.<PetItem>();
            this._petItemVec.push(_loc1_);
            this._pageIndex = 0;
            this._maxPageIndex = Math.max(0,Math.floor((this._petItemVec.length - 1) / ITEM_NUM_PATGE));
            this.showPage(this._pageIndex);
         }
         else if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA && this._filterType == PetItemType.CAPSULE)
         {
            _loc1_ = new PetItem(200001,1,0);
            this._petItemVec = new Vector.<PetItem>();
            this._petItemVec.push(_loc1_);
            this._pageIndex = 0;
            this._maxPageIndex = Math.max(0,Math.floor((this._petItemVec.length - 1) / ITEM_NUM_PATGE));
            this.showPage(this._pageIndex);
         }
         else
         {
            ItemManager.requestItemList(this.resetData);
         }
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         var _loc4_:OperateEvent = null;
         var _loc2_:NewItemDisplay = param1.currentTarget as NewItemDisplay;
         var _loc3_:PetItem = _loc2_.getItemInfo();
         SoundEffects.playSoundMouseClick(0.35);
         if(_loc3_.type == PetItemType.PHYSICAL_MEDICINE)
         {
            if(this._fighter.fighterInfo.hp >= this._fighter.fighterInfo.maxHp)
            {
               ServerMessager.addMessage("这只精灵处于满血状态");
               dispatchEvent(new OperateEvent(0,0,OperateEvent.ERROR));
               return;
            }
            this.useMedicineItem(_loc3_);
            (_loc4_ = new OperateEvent(OperateEvent.OPERATE_ITEM_USE_MEDICINE,this._usedItemReferenceId,OperateEvent.OPERATE_END)).fighterId = this._fighter.id;
         }
         else if(_loc3_.type == PetItemType.ANGER_MEDICINE)
         {
            if(SceneManager.currentSceneType == SceneType.GUDIE_ARENA2 || SceneManager.currentSceneType == SceneType.GUIDE_NEW_ARENA3)
            {
               this.useMedicineItem(_loc3_);
               (_loc4_ = new OperateEvent(OperateEvent.OPERATE_ITEM_USE_MEDICINE,this._usedItemReferenceId,OperateEvent.OPERATE_END)).fighterId = this._fighter.id;
            }
            else
            {
               if(this._fighter.fighterInfo.fightAnger >= 100)
               {
                  ServerMessager.addMessage("这只精灵处于满怒气状态");
                  dispatchEvent(new OperateEvent(0,0,OperateEvent.ERROR));
                  return;
               }
               this.useMedicineItem(_loc3_);
               (_loc4_ = new OperateEvent(OperateEvent.OPERATE_ITEM_USE_MEDICINE,this._usedItemReferenceId,OperateEvent.OPERATE_END)).fighterId = this._fighter.id;
            }
         }
         else if(_loc3_.type == PetItemType.CAPSULE)
         {
            if(_loc3_.minLevel < this._oppositeFighter.fighterInfo.level)
            {
               ServerMessager.addMessage("只能捕捉" + _loc3_.minLevel + "级以下的精灵");
               return;
            }
            this.useCapsuleItem(_loc3_);
            _loc4_ = new OperateEvent(OperateEvent.OPERATE_ITEM_CATCH_PET,this._usedItemReferenceId,OperateEvent.OPERATE_END);
         }
         else if(_loc3_.type == PetItemType.RESURRECTION)
         {
            this.useCapsuleItem(_loc3_);
            _loc4_ = new OperateEvent(OperateEvent.OPERATE_RESURRECTION,this._usedItemReferenceId,OperateEvent.FIGHT_SELECT_ITEM);
         }
         if(_loc4_ == null)
         {
            _loc4_ = new OperateEvent(0,0,OperateEvent.OPERATE_END);
         }
         dispatchEvent(_loc4_);
      }
      
      private function useCapsuleItem(param1:PetItem) : void
      {
         this._usedItemReferenceId = param1.referenceId;
      }
      
      private function useMedicineItem(param1:PetItem) : void
      {
         this._usedItemReferenceId = param1.referenceId;
      }
      
      public function resetData() : void
      {
         var filterByPetItemType:Function = null;
         filterByPetItemType = function(param1:PetItem, param2:int, param3:Vector.<PetItem>):Boolean
         {
            var _loc4_:ArenaScene = null;
            var _loc5_:Boolean = false;
            var _loc6_:Fighter = null;
            if(_filterType == PetItemType.CAPSULE)
            {
               return param1.type == PetItemType.CAPSULE;
            }
            if(_filterType == PetItemType.PHYSICAL_MEDICINE)
            {
               _loc4_ = SceneManager.active as ArenaScene;
               if(param1.type == PetItemType.RESURRECTION)
               {
                  _loc5_ = false;
                  for each(_loc6_ in _loc4_.arenaData.leftTeam.fighterVec)
                  {
                     if(FitConfig.isPetFit(_loc6_.fighterInfo.bunchId))
                     {
                        _loc5_ = true;
                     }
                  }
                  if(FightMode.isPVPMode(_loc4_.arenaData.fightMode) == false && _loc4_.arenaData.isDoubleMode == false && _loc5_ == false)
                  {
                     return true;
                  }
               }
               else
               {
                  if(param1.referenceId == 200018 || param1.referenceId == 200019)
                  {
                     if(FightMode.isPVPMode(_loc4_.arenaData.fightMode))
                     {
                        return false;
                     }
                     return true;
                  }
                  if(param1.referenceId == 201026 || param1.referenceId == 200233 || param1.referenceId == 201014 || param1.referenceId == 400132)
                  {
                     return false;
                  }
                  if(MEDICINE_ITEM_TYPE_VECTOR.indexOf(param1.type) != -1)
                  {
                     if(param1.type == PetItemType.ANGER_MEDICINE)
                     {
                        if(FightMode.isPVPMode(_loc4_.arenaData.fightMode))
                        {
                           return false;
                        }
                        return true;
                     }
                     return true;
                  }
               }
            }
            return false;
         };
         this._petItemVec = ItemManager.getPetRelateVec();
         this._petItemVec = this._petItemVec.filter(filterByPetItemType);
         this._pageIndex = 0;
         this._maxPageIndex = Math.max(0,Math.floor((this._petItemVec.length - 1) / ITEM_NUM_PATGE));
         this.showPage(this._pageIndex);
      }
      
      private function showPage(param1:int) : void
      {
         var _loc2_:NewItemDisplay = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         for each(_loc2_ in this._itemDisplayVec)
         {
            _loc2_.clear();
         }
         _loc3_ = this._pageIndex * ITEM_NUM_PATGE;
         _loc4_ = (this._pageIndex + 1) * ITEM_NUM_PATGE;
         _loc5_ = int(this._petItemVec.length);
         _loc4_ = Math.min(_loc4_,_loc5_);
         _loc6_ = _loc3_;
         while(_loc6_ < _loc4_)
         {
            this._itemDisplayVec[_loc6_ - _loc3_].setItemInfo(this._petItemVec[_loc6_]);
            _loc6_++;
         }
         this.disableBtn(this._nextBtn);
         this.disableBtn(this._prevBtn);
         if(this._pageIndex > 0)
         {
            this.enableBtn(this._prevBtn);
         }
         if(this._pageIndex < this._maxPageIndex)
         {
            this.enableBtn(this._nextBtn);
         }
      }
      
      private function enableBtn(param1:SimpleButton) : void
      {
         param1.enabled = true;
         param1.mouseEnabled = true;
      }
      
      private function disableBtn(param1:SimpleButton) : void
      {
         param1.enabled = false;
         param1.mouseEnabled = false;
      }
      
      public function dispose() : void
      {
         var _loc1_:NewItemDisplay = null;
         DisplayObjectUtil.removeAllChildren(this);
         for each(_loc1_ in this._itemDisplayVec)
         {
            _loc1_.dispose();
         }
         this._itemDisplayVec = null;
         this._tip = null;
         this._oppositeFighter = null;
         this._fighter = null;
      }
      
      public function active() : void
      {
         this.mouseEnabled = true;
         this.mouseChildren = true;
      }
      
      public function deactive() : void
      {
         this.mouseEnabled = false;
         this.mouseChildren = false;
      }
   }
}
