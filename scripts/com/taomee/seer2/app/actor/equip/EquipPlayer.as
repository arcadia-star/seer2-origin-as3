package com.taomee.seer2.app.actor.equip
{
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.core.animation.FramePlayer;
   import com.taomee.seer2.core.animation.frame.FrameSequence;
   import com.taomee.seer2.core.animation.frame.FrameSequenceManager;
   import com.taomee.seer2.core.cache.CacheType;
   import com.taomee.seer2.core.ui.UIManager;
   import flash.utils.ByteArray;
   
   public class EquipPlayer extends FramePlayer
   {
       
      
      private var _equipItem:EquipItem;
      
      private var _newFrameSequence:FrameSequence;
      
      private var _actorInfo:UserInfo;
      
      public function EquipPlayer(param1:EquipItem, param2:UserInfo)
      {
         this._actorInfo = param2;
         this._equipItem = param1;
         super(param1.swfUrl);
      }
      
      override protected function initFrameSequence() : void
      {
         var _loc1_:ByteArray = null;
         var _loc2_:FrameSequence = null;
         switch(this._equipItem.slotIndex)
         {
            case EquipSlot.HEAD:
               _loc1_ = UIManager.getByteArray("UI_DEFAULT_HEAD");
               break;
            case EquipSlot.EYE:
               _loc1_ = UIManager.getByteArray("UI_DEFAULT_EYE");
               break;
            case EquipSlot.HAND_LEFT:
               _loc1_ = UIManager.getByteArray(this._actorInfo.sex == 0 ? "UI_BLUE_LEFT_HAND" : "UI_RED_LEFT_HAND");
               break;
            case EquipSlot.HAND_RIGHT:
               _loc1_ = UIManager.getByteArray(this._actorInfo.sex == 0 ? "UI_BLUE_RGIHT_HAND" : "UI_RED_RGIHT_HAND");
               break;
            case EquipSlot.BODY:
               _loc1_ = UIManager.getByteArray(this._actorInfo.sex == 0 ? "UI_BLUE_BODY" : "UI_RED_BODY");
               break;
            case EquipSlot.FOOT_LEFT:
               _loc1_ = UIManager.getByteArray(this._actorInfo.sex == 0 ? "UI_BLUE_LEFT_FOOT" : "UI_RED_LEFT_FOOT");
               break;
            case EquipSlot.FOOT_RIGHT:
               _loc1_ = UIManager.getByteArray(this._actorInfo.sex == 0 ? "UI_BLUE_RGIHT_FOOT" : "UI_RED_RGIHT_FOOT");
         }
         if(_loc1_)
         {
            _loc2_ = new FrameSequence();
            _loc2_.isFromPool = false;
            _loc2_.setData(_loc1_);
            this.frameSequence = _loc2_;
            this._newFrameSequence = FrameSequenceManager.getFrameSequence(this.resourceUrl,CacheType.EQUIP);
         }
         else
         {
            this.frameSequence = FrameSequenceManager.getFrameSequence(this._equipItem.swfUrl,CacheType.EQUIP);
         }
      }
      
      public function updateEquip(param1:EquipItem) : void
      {
         this._equipItem = param1;
         this._newFrameSequence = FrameSequenceManager.getFrameSequence(this._equipItem.swfUrl,CacheType.EQUIP);
      }
      
      override public function update() : void
      {
         super.update();
         if(Boolean(this._newFrameSequence) && Boolean(this._newFrameSequence.isReady))
         {
            this.applyNewFrameSequence();
         }
      }
      
      private function applyNewFrameSequence() : void
      {
         releaseFrameSequence();
         this.frameSequence = this._newFrameSequence;
         this._newFrameSequence = null;
      }
      
      public function get slotIndex() : uint
      {
         return this._equipItem.slotIndex;
      }
      
      public function clear() : void
      {
         releaseFrameSequence();
      }
   }
}
