package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.processor.activity.yiteFigthPve.YiteFightPveProcessor;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.module.ModuleManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   
   public class MapProcessor_80010 extends MapProcessor
   {
       
      
      private var _yiteProcessor:YiteFightPveProcessor;
      
      private var _introduction:SimpleButton;
      
      public function MapProcessor_80010(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._yiteProcessor = new YiteFightPveProcessor();
         this._introduction = _map.content["introduction"];
         this._introduction.addEventListener(MouseEvent.CLICK,this.onIntroduction);
      }
      
      private function onIntroduction(param1:MouseEvent) : void
      {
         var _loc2_:Object = new Object();
         _loc2_.index = 100;
         ModuleManager.showModule(URLUtil.getAppModule("StartYiteFightPvePanel"),"正在打开...",_loc2_);
      }
   }
}
