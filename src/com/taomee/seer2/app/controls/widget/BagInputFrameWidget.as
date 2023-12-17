package com.taomee.seer2.app.controls.widget
{
   import com.taomee.seer2.app.controls.ToolbarEvent;
   import com.taomee.seer2.app.controls.ToolbarEventDispatcher;
   import com.taomee.seer2.app.controls.widget.core.IWidgetable;
   import com.taomee.seer2.app.init.LoginInfo;
   import com.taomee.seer2.app.inventory.ItemManager;
   import com.taomee.seer2.app.inventory.item.EquipItem;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.core.effects.SoundEffects;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.toolTip.TooltipManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class BagInputFrameWidget extends Sprite implements IWidgetable
   {
      
      public static const BAG_INPUT:String = "BagInput";
       
      
      private var _mainUI:MovieClip;
      
      private var _btn:SimpleButton;
      
      private var _page:MovieClip;
      
      private var _petBag:SimpleButton;
      
      private var _itemBag:SimpleButton;
      
      private var _isShow:Boolean;
      
      private var _bagIsShow:Boolean;
      
      public function BagInputFrameWidget(param1:MovieClip)
      {
         super();
         this._mainUI = param1;
         addChild(this._mainUI);
         this.initMC();
         this.initEventListener();
      }
      
      private function initMC() : void
      {
         this._btn = this._mainUI["btn"];
         this._page = this._mainUI["page"];
         this._petBag = this._page["petBtn"];
         this._itemBag = this._page["itemBtn"];
         this._isShow = false;
         this.updateTooltip();
         this.updateNonoPage();
      }
      
      private function updateTooltip() : void
      {
         TooltipManager.addCommonTip(this._btn,"背包");
      }
      
      private function initEventListener() : void
      {
         this._petBag.addEventListener(MouseEvent.CLICK,this.onPet);
         this._itemBag.addEventListener(MouseEvent.CLICK,this.onItem);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.PAGE_CHANGE,this.onChange);
         ToolbarEventDispatcher.addEventListener(ToolbarEvent.TOOLBAR_HIDE,this.onHide);
         this._btn.addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         this._mainUI.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         this._isShow = !this._isShow;
         ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,this._isShow,BAG_INPUT));
         this.updateNonoPage();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_306);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         this.onHide(null);
      }
      
      private function onChange(param1:ToolbarEvent) : void
      {
         if(param1.typeStr != BAG_INPUT && param1.status)
         {
            this._isShow = false;
            this.updateNonoPage();
         }
      }
      
      private function onHide(param1:ToolbarEvent) : void
      {
         this._isShow = false;
         this.updateNonoPage();
      }
      
      private function updateNonoPage() : void
      {
         this._page.visible = this._isShow;
      }
      
      private function onNono(param1:MouseEvent) : void
      {
         this._isShow = !this._isShow;
         ToolbarEventDispatcher.dispatchEvent(new ToolbarEvent(ToolbarEvent.PAGE_CHANGE,this._isShow,BAG_INPUT));
         this.updateNonoPage();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_306);
      }
      
      private function onPet(param1:MouseEvent) : void
      {
         ModuleManager.toggleModule(URLUtil.getAppModule("PetBagPanel"),"正在打开" + "精灵背包" + "...");
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_325);
         SoundEffects.playSoundMouseClick();
      }
      
      private function onItem(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_12);
         ModuleManager.toggleModule(URLUtil.getAppModule("ItemBagPanel"),"正在打开物品背包...");
         if(!this._bagIsShow)
         {
            if(LoginInfo.expiredEquipList.length > 0)
            {
               this._bagIsShow = true;
               ModuleManager.toggleModule(URLUtil.getAppModule("EquipExpiredPanel"),"正在打开物品过期提醒...",{"param":2});
            }
            else
            {
               ItemManager.requestEquipList(function():void
               {
                  var _loc2_:EquipItem = null;
                  _bagIsShow = true;
                  var _loc1_:Array = [];
                  for each(_loc2_ in ItemManager.getEquipVec())
                  {
                     if(_loc2_.isExpired())
                     {
                        _loc1_.push(_loc2_);
                     }
                  }
                  if(_loc1_.length > 0)
                  {
                     ModuleManager.toggleModule(URLUtil.getAppModule("EquipExpiredPanel"),"正在打开物品过期提醒...",{
                        "param":1,
                        "vec":_loc1_
                     });
                  }
               });
            }
         }
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_326);
         SoundEffects.playSoundMouseClick();
      }
   }
}
