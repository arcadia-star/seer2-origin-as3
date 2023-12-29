package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dream.DreamOneEntry;
   import com.taomee.seer2.app.manager.VipMonGiftPetDreamStrongManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_3840 extends MapProcessor
   {
       
      
      private var _dreamMainBtn:SimpleButton;
      
      private var _dreamEggBtn:SimpleButton;
      
      private var _dreamOneMainMC:MovieClip;
      
      private var _dreamOneEggMC:MovieClip;
      
      public function MapProcessor_3840(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._dreamMainBtn = _map.content["dreamMainBtn"];
         this._dreamEggBtn = _map.content["dreamEggBtn"];
         this._dreamMainBtn.addEventListener(MouseEvent.CLICK,this.onDreamMain);
         this._dreamEggBtn.addEventListener(MouseEvent.CLICK,this.onDreamEgg);
         this._dreamOneMainMC = _map.content["dreamOneMainMC"];
         this._dreamOneEggMC = _map.content["dreamOneEggMC"];
         DreamOneEntry.dreamOneEntry(this._dreamOneMainMC,this._dreamOneEggMC);
         //VipMonGiftPetDreamStrongManager.init();
      }
      
      private function onPetSmelt(param1:MouseEvent) : void
      {
         ModuleManager.showAppModule("PetSmeltingActPanel");
      }
      
      private function onDreamMain(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("DreamMainPanel"),"");
         DreamOneEntry.updateOneServerBuff(0);
      }
      
      private function onDreamEgg(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("DreamEggPanel"),"");
      }
      
      override public function dispose() : void
      {
         super.dispose();
         VipMonGiftPetDreamStrongManager.dispose();
      }
   }
}
