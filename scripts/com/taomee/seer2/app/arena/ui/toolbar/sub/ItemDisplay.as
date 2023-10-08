package com.taomee.seer2.app.arena.ui.toolbar.sub
{
   import com.taomee.seer2.app.arena.resource.FightUIManager;
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.inventory.item.PetItem;
   import com.taomee.seer2.core.ui.UINumberGenerator;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   
   public class ItemDisplay extends Sprite
   {
       
      
      private var _info:PetItem;
      
      private var _backBtn:SimpleButton;
      
      private var _iconDisplay:IconDisplayer;
      
      private var _numSprite:Sprite;
      
      private var _enabled:Boolean;
      
      public function ItemDisplay()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this.enabled = false;
         this.mouseChildren = false;
         this.buttonMode = true;
         this.createChildren();
      }
      
      private function createChildren() : void
      {
         this.createBack();
      }
      
      private function createBack() : void
      {
         this._backBtn = FightUIManager.getButton("UI_FightItemBtn");
         addChild(this._backBtn);
         this._iconDisplay = new IconDisplayer();
         DisplayObjectUtil.disableSprite(this._iconDisplay);
         addChild(this._iconDisplay);
      }
      
      public function setItemInfo(param1:PetItem) : void
      {
         this.clear();
         this.enabled = true;
         this._info = param1;
         this.update();
      }
      
      public function getItemInfo() : PetItem
      {
         return this._info;
      }
      
      private function update() : void
      {
         this.updateIcon();
         this.updateNumber();
      }
      
      private function updateNumber() : void
      {
         if(this._info.quantity > 1)
         {
            this._numSprite = UINumberGenerator.generateItemNumber(this._info.quantity);
            this._numSprite.x = 63 - this._numSprite.width;
            this._numSprite.y = 44;
            this._numSprite.mouseChildren = false;
            this._numSprite.mouseEnabled = false;
            addChild(this._numSprite);
         }
      }
      
      private function updateIcon() : void
      {
         this._iconDisplay.setIconUrl(this._info.iconUrl);
      }
      
      public function clear() : void
      {
         this.enabled = false;
         this._iconDisplay.removeIcon();
         DisplayObjectUtil.removeFromParent(this._numSprite);
         this._info = null;
      }
      
      private function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      private function set enabled(param1:Boolean) : void
      {
         this._enabled = param1;
         if(this._enabled == false)
         {
            DisplayObjectUtil.disableSprite(this);
         }
         else
         {
            DisplayObjectUtil.enableSprite(this);
         }
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeAllChildren(this);
         this._info = null;
         this._iconDisplay.dispose();
         this._iconDisplay = null;
         this._numSprite = null;
      }
   }
}
