package com.taomee.seer2.app.controls.petAvatarPanel
{
   import com.taomee.seer2.app.component.IconDisplayer;
   import com.taomee.seer2.app.pet.data.PetInfo;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   
   public class PetItem extends Sprite
   {
       
      
      private var _mainUI:MovieClip;
      
      private var _petIcon:IconDisplayer;
      
      private var _cell:MovieClip;
      
      private var _petName:TextField;
      
      private var _petLevel:TextField;
      
      private var _hpTxt:TextField;
      
      private var _hpBar:MovieClip;
      
      private var _lvLink:SimpleButton;
      
      private var _info:PetInfo;
      
      public function PetItem()
      {
         super();
         this._info = this.info;
         this.initSet();
         this.initEvent();
      }
      
      private function initSet() : void
      {
         this._mainUI = UIManager.getMovieClip("PetAvstarPetItem");
         addChild(this._mainUI);
         this._cell = this._mainUI["petIcon"]["cell"] as MovieClip;
         this._hpTxt = this._mainUI["hpTxt"];
         this._hpBar = this._mainUI["hpBar"];
         this._petName = this._mainUI["petName"];
         this._petLevel = this._mainUI["petLevel"];
         this._hpTxt.mouseEnabled = this._petName.mouseEnabled = this._petLevel.mouseEnabled = false;
         this._petIcon = new IconDisplayer();
         this._petIcon.scaleX = this._petIcon.scaleY = 0.8;
         this._petIcon.x = -2;
         this._petIcon.y = -5;
         this._cell.addChild(this._petIcon);
         this._lvLink = this._mainUI["lvLink"];
      }
      
      public function get lvLink() : SimpleButton
      {
         return this._lvLink;
      }
      
      public function getPetIconMC() : MovieClip
      {
         return this._mainUI["petIcon"];
      }
      
      private function initEvent() : void
      {
         this._lvLink.addEventListener(MouseEvent.CLICK,this.onLvLink);
      }
      
      private function onLvLink(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("OffLineExpPanel");
      }
      
      public function set info(param1:PetInfo) : void
      {
         this._info = param1;
         this.update();
      }
      
      public function get info() : PetInfo
      {
         return this._info;
      }
      
      public function update() : void
      {
         this._petName.text = this._info.name;
         this._petLevel.text = this._info.level.toString();
         this._hpTxt.text = this._info.hp + "/" + this._info.maxHp;
         var _loc1_:Number = this._info.hp / this._info.maxHp > 1 ? 1 : this._info.hp / this._info.maxHp;
         this._hpBar.scaleX = _loc1_;
         this._petIcon.setIconUrl(URLUtil.getPetIcon(this._info.resourceId));
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeFromParent(this);
         this._mainUI = null;
         this._petIcon.dispose();
         this._petIcon = null;
         this._cell = null;
         this._petName = null;
         this._petLevel = null;
         this._hpTxt = null;
         this._hpBar = null;
         this._info = null;
      }
   }
}
