package com.taomee.seer2.app.component
{
   import com.taomee.seer2.app.actor.constant.EquipSlot;
   import com.taomee.seer2.app.actor.data.UserInfo;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.core.cache.CacheManager;
   import com.taomee.seer2.core.cache.CacheType;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import org.taomee.utils.DisplayUtil;
   
   public class EquipPreviewDisplayer extends Sprite
   {
       
      
      private var _equipItem:EquipItem;
      
      private var _icon:MovieClip;
      
      private var _slotIndex:int;
      
      private var _userInfo:UserInfo;
      
      private var _defaultIcon:MovieClip;
      
      private var _isInit:Boolean;
      
      public function EquipPreviewDisplayer(param1:int)
      {
         super();
         this.mouseEnabled = false;
         this.mouseChildren = false;
         this._slotIndex = param1;
      }
      
      public function updateUserInfo(param1:UserInfo, param2:Boolean) : void
      {
         this._userInfo = param1;
         this._isInit = param2;
      }
      
      public function setEquipPreviewUrl(param1:EquipItem, param2:Function = null) : void
      {
         this.removeEquip();
         this._equipItem = param1;
         this.loadEquip();
      }
      
      private function removeEquip() : void
      {
         if(Boolean(this._equipItem) && Boolean(this._equipItem.previewUrl))
         {
            CacheManager.cancel(this._equipItem.previewUrl,CacheType.PHASOR,this.onEquipeLoaded);
         }
         DisplayObjectUtil.removeFromParent(this._icon);
      }
      
      private function loadEquip() : void
      {
         if(this._equipItem)
         {
            if(!this._isInit)
            {
               this.addDefaultIcon();
            }
            CacheManager.getContent(this._equipItem.previewUrl,CacheType.PHASOR,this.onEquipeLoaded);
         }
      }
      
      private function addDefaultIcon() : void
      {
         switch(this._equipItem.slotIndex)
         {
            case EquipSlot.HEAD:
               this._defaultIcon = UIManager.getMovieClip("EQUIP_COMMON_HEAD");
               break;
            case EquipSlot.EYE:
               this._defaultIcon = UIManager.getMovieClip("EQUIP_COMMON_HEAD");
               break;
            case EquipSlot.HAND_LEFT:
               this._defaultIcon = UIManager.getMovieClip(this._userInfo.sex == 0 ? "EQUIP_BLUE_LEFT_HAND" : "EQUIP_RED_LEFT_HAND");
               break;
            case EquipSlot.HAND_RIGHT:
               this._defaultIcon = UIManager.getMovieClip(this._userInfo.sex == 0 ? "EQUIP_BLUE_RIGHT_HAND" : "EQUIP_RED_RIGHT_HAND");
               break;
            case EquipSlot.BODY:
               this._defaultIcon = UIManager.getMovieClip(this._userInfo.sex == 0 ? "EQUIP_BLUE_BODY" : "EQUIP_RED_BODY");
               break;
            case EquipSlot.FOOT_LEFT:
               this._defaultIcon = UIManager.getMovieClip(this._userInfo.sex == 0 ? "EQUIP_BLUE_LEFT_FOOT" : "EQUIP_RED_LEFT_FOOT");
               break;
            case EquipSlot.FOOT_RIGHT:
               this._defaultIcon = UIManager.getMovieClip(this._userInfo.sex == 0 ? "EQUIP_BLUE_RIGHT_FOOT" : "EQUIP_RED_RIGHT_FOOT");
         }
         if(this._defaultIcon)
         {
            addChild(this._defaultIcon);
         }
      }
      
      private function onEquipeLoaded(param1:ContentInfo) : void
      {
         DisplayUtil.removeForParent(this._icon);
         this._icon = param1.content;
         if(this._icon)
         {
            addChild(this._icon);
         }
         if(!this._isInit)
         {
            DisplayObjectUtil.removeFromParent(this._defaultIcon);
            this._isInit = true;
         }
      }
      
      public function get slotIndex() : int
      {
         return this._slotIndex;
      }
      
      public function dispose() : void
      {
         this.removeEquip();
         this._userInfo = null;
      }
   }
}
