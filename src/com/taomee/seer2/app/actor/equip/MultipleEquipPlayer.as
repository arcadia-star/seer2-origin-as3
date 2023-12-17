package com.taomee.seer2.app.actor.equip
{
   import com.taomee.seer2.app.actor.Actor;
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.constant.EquipSlotDepth;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.core.animation.IAnimation;
   import flash.display.Sprite;
   import org.taomee.ds.HashMap;
   
   public class MultipleEquipPlayer extends Sprite implements IAnimation
   {
       
      
      private var _bodyEquipPlayer:EquipPlayer;
      
      private var _currentLabel:String;
      
      private var _playerVec:Vector.<EquipPlayer>;
      
      private var _playerMap:HashMap;
      
      private var _actor:Actor;
      
      public function MultipleEquipPlayer(param1:Actor)
      {
         super();
         this._actor = param1;
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._playerVec = new Vector.<EquipPlayer>();
         this._playerMap = new HashMap();
      }
      
      public function addEquip(param1:EquipItem) : void
      {
         if(param1.suitId == 0 && param1.slotIndex == 9)
         {
            return;
         }
         if(this.isSlotOccupied(param1.slotIndex) == false)
         {
            this.addEquipPlayer(param1);
         }
         else
         {
            this.updateEquipPlayer(param1);
         }
         this.arrangeSoltDepth();
      }
      
      public function hideHandAndFootEquipPlayer() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            if(_loc1_.slotIndex == EquipSlot.HAND_LEFT || _loc1_.slotIndex == EquipSlot.HAND_RIGHT || _loc1_.slotIndex == EquipSlot.FOOT_LEFT || _loc1_.slotIndex == EquipSlot.FOOT_RIGHT)
            {
               _loc1_.visible = false;
            }
         }
      }
      
      public function showHandAndFootEquipPlayer() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            if(_loc1_.slotIndex == EquipSlot.HAND_LEFT || _loc1_.slotIndex == EquipSlot.HAND_RIGHT || _loc1_.slotIndex == EquipSlot.FOOT_LEFT || _loc1_.slotIndex == EquipSlot.FOOT_RIGHT)
            {
               _loc1_.visible = true;
            }
         }
      }
      
      private function addEquipPlayer(param1:EquipItem) : void
      {
         var _loc2_:EquipPlayer = new EquipPlayer(param1,this._actor.getInfo());
         _loc2_.play();
         _loc2_.gotoLabel(this._currentLabel);
         addChild(_loc2_);
         this._playerMap.add(_loc2_.slotIndex,_loc2_);
         this.updatePlayerVec();
         if(param1.slotIndex == EquipSlot.BODY)
         {
            this._bodyEquipPlayer = _loc2_;
         }
      }
      
      private function updateEquipPlayer(param1:EquipItem) : void
      {
         var _loc2_:EquipPlayer = this._playerMap.getValue(param1.slotIndex) as EquipPlayer;
         _loc2_.updateEquip(param1);
      }
      
      public function removeEquip(param1:EquipItem) : void
      {
         var _loc2_:EquipPlayer = this._playerMap.getValue(param1.slotIndex) as EquipPlayer;
         if(_loc2_)
         {
            _loc2_.clear();
         }
      }
      
      private function isSlotOccupied(param1:uint) : Boolean
      {
         return this._playerMap.containsKey(param1);
      }
      
      private function updatePlayerVec() : void
      {
         this._playerVec = Vector.<EquipPlayer>(this._playerMap.getValues());
      }
      
      public function get totalFrameNum() : uint
      {
         return 1;
      }
      
      public function get currentFrameIndex() : uint
      {
         return 1;
      }
      
      public function get currentFrameLabel() : String
      {
         return this._currentLabel;
      }
      
      public function play() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            _loc1_.play();
         }
      }
      
      public function stop() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            _loc1_.stop();
         }
      }
      
      public function gotoAndPlay(param1:uint) : void
      {
         var _loc2_:EquipPlayer = null;
         for each(_loc2_ in this._playerVec)
         {
            _loc2_.gotoAndPlay(param1);
         }
      }
      
      public function gotoAndStop(param1:uint) : void
      {
         var _loc2_:EquipPlayer = null;
         for each(_loc2_ in this._playerVec)
         {
            _loc2_.gotoAndStop(param1);
         }
      }
      
      public function hasLabel(param1:String) : Boolean
      {
         var _loc2_:EquipPlayer = null;
         for each(_loc2_ in this._playerVec)
         {
            if(_loc2_.hasLabel(param1))
            {
               return true;
            }
         }
         return false;
      }
      
      public function isStopAll(param1:Boolean) : void
      {
         var _loc2_:EquipPlayer = null;
         for each(_loc2_ in this._playerVec)
         {
            _loc2_.isStopAllAnimation(param1);
         }
      }
      
      public function gotoLabel(param1:String) : void
      {
         var _loc2_:EquipPlayer = null;
         this._currentLabel = param1;
         for each(_loc2_ in this._playerVec)
         {
            _loc2_.gotoLabel(this._currentLabel);
         }
         this.arrangeSoltDepth();
      }
      
      public function isStopAllAnimation(param1:Boolean) : void
      {
      }
      
      private function arrangeSoltDepth() : void
      {
         var _loc3_:EquipPlayer = null;
         this._playerVec.sort(this.sortBySlotDepth);
         var _loc1_:int = int(this._playerVec.length);
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._playerVec[_loc2_];
            if(getChildAt(_loc2_) != _loc3_)
            {
               addChildAt(_loc3_,_loc2_);
            }
            _loc2_++;
         }
      }
      
      private function sortBySlotDepth(param1:EquipPlayer, param2:EquipPlayer) : int
      {
         var _loc3_:uint = uint(EquipSlotDepth.getDepthByDirection(param1.slotIndex,this._actor.direction));
         var _loc4_:uint = uint(EquipSlotDepth.getDepthByDirection(param2.slotIndex,this._actor.direction));
         if(_loc3_ > _loc4_)
         {
            return 1;
         }
         if(_loc3_ < _loc4_)
         {
            return -1;
         }
         return 0;
      }
      
      public function update() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            _loc1_.update();
            _loc1_.gotoAndPlay(this._bodyEquipPlayer.currentFrameIndex);
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:EquipPlayer = null;
         for each(_loc1_ in this._playerVec)
         {
            _loc1_.dispose();
         }
         this._playerMap = null;
         this._playerVec = null;
      }
   }
}
