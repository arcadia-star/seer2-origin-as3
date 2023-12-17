package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80420 extends MapProcessor
   {
       
      
      private var _mc:MovieClip;
      
      public function MapProcessor_80420(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._mc = _map.front["mc"];
         this._mc.buttonMode = true;
         this._mc.addEventListener(MouseEvent.ROLL_OVER,this.onOver);
         this._mc.addEventListener(MouseEvent.ROLL_OUT,this.onOut);
         this._mc.addEventListener(MouseEvent.CLICK,this.onMC);
      }
      
      private function onOver(param1:MouseEvent) : void
      {
         this._mc.gotoAndStop(2);
      }
      
      private function onOut(param1:MouseEvent) : void
      {
         this._mc.gotoAndStop(1);
      }
      
      private function onMC(param1:MouseEvent) : void
      {
         ModuleManager.showModule(URLUtil.getAppModule("PlutoSealPanel"),"");
      }
   }
}
