package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.config.ItemConfig;
   import com.taomee.seer2.module.login.config.definition.EquipDefinition;
   import com.taomee.seer2.module.login.data.LoginUserInfo;
   import com.taomee.seer2.module.login.util.EquipUtil;
   import flash.display.Sprite;
   
   public class EquipPreview extends Sprite
   {
       
      
      private var _previewVec:Vector.<com.taomee.seer2.module.login.view.EquipItem>;
      
      private var _info:LoginUserInfo;
      
      public function EquipPreview()
      {
         super();
         this.initPreviewDisplayer();
      }
      
      private function initPreviewDisplayer() : void
      {
         this._previewVec = new Vector.<com.taomee.seer2.module.login.view.EquipItem>();
         var _loc1_:int = 1;
         while(_loc1_ <= EquipUtil.TOTAL_SLOT_NUM)
         {
            this._previewVec.push(new com.taomee.seer2.module.login.view.EquipItem(_loc1_));
            _loc1_++;
         }
         this._previewVec.sort(this.sortBySlotDepth);
         var _loc2_:int = int(this._previewVec.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            addChildAt(this._previewVec[_loc3_],_loc3_);
            _loc3_++;
         }
      }
      
      private function sortBySlotDepth(param1:com.taomee.seer2.module.login.view.EquipItem, param2:com.taomee.seer2.module.login.view.EquipItem) : int
      {
         var _loc3_:uint = uint(EquipUtil.findDepthIndex(param1.slotIndex));
         var _loc4_:uint = uint(EquipUtil.findDepthIndex(param2.slotIndex));
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
      
      public function setData(param1:LoginUserInfo) : void
      {
         var _loc2_:int = 0;
         this._info = param1;
         for each(_loc2_ in param1.equipVec)
         {
            if(_loc2_ != 0)
            {
               this.addEquip(_loc2_);
            }
         }
      }
      
      public function addEquip(param1:uint) : void
      {
         var _loc2_:EquipDefinition = ItemConfig.getEquipDefinition(param1);
         if(_loc2_ == null)
         {
            return;
         }
         this.addEquipInternal(param1,_loc2_.slotIndex);
         if(EquipUtil.hasAccessory(_loc2_.slotIndex))
         {
            this.addEquipInternal(param1,EquipUtil.getAccessorySlotIndex(_loc2_.slotIndex));
         }
      }
      
      public function removeEquip(param1:uint) : void
      {
         var _loc2_:EquipDefinition = ItemConfig.getEquipDefinition(param1);
         var _loc3_:uint = EquipUtil.getSlotDefaultEquipReferenceId(this._info.color,_loc2_.slotIndex);
         if(param1 != _loc3_ && _loc3_ != uint.MAX_VALUE)
         {
            this.addEquip(_loc3_);
         }
         else
         {
            this.removeEquipInternal(_loc2_.slotIndex);
         }
      }
      
      private function addEquipInternal(param1:int, param2:int) : void
      {
         this.getPreviewDisplayer(param2).setEquipId(param1);
      }
      
      private function removeEquipInternal(param1:int) : void
      {
         this.getPreviewDisplayer(param1).removeEquip();
      }
      
      public function dispose() : void
      {
         var _loc1_:com.taomee.seer2.module.login.view.EquipItem = null;
         for each(_loc1_ in this._previewVec)
         {
            _loc1_.dispose();
         }
         this._previewVec = null;
      }
      
      private function getPreviewDisplayer(param1:int) : com.taomee.seer2.module.login.view.EquipItem
      {
         var _loc2_:com.taomee.seer2.module.login.view.EquipItem = null;
         var _loc3_:com.taomee.seer2.module.login.view.EquipItem = null;
         for each(_loc3_ in this._previewVec)
         {
            if(_loc3_.slotIndex == param1)
            {
               _loc2_ = _loc3_;
               break;
            }
         }
         return _loc2_;
      }
   }
}
