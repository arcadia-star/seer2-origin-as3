package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.entity.Teleport;
   import com.taomee.seer2.app.manager.StatisticsManager;
   import com.taomee.seer2.app.processor.activity.GrabXiaoYueSeAct.GrabXiaoYueSeAct;
   import com.taomee.seer2.core.entity.AnimateElementManager;
   import com.taomee.seer2.core.map.MapModel;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_170 extends TitleMapProcessor
   {
       
      
      private var _octopusCrawl:MovieClip;
      
      private var _octopusCrawlTrigger:MovieClip;
      
      private var _openSkill:MovieClip;
      
      private var _storeTrigger:MovieClip;
      
      private var _pieceTrigger:MovieClip;
      
      private var _teleport:Teleport;
      
      public function MapProcessor_170(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         GrabXiaoYueSeAct.getInstance().setup(_map);
         this.initOctopus();
         this.initOpen();
         this.initTeleport();
         StatisticsManager.sendNovice(StatisticsManager.ui_interact_142);
      }
      
      private function initOpen() : void
      {
         this._openSkill = _map.content["openSkill"];
         this._storeTrigger = _map.content["storeTrigger"];
         this._pieceTrigger = _map.content["pieceTrigger"];
         initInteractor(this._storeTrigger);
         closeInteractor(this._openSkill);
         this._pieceTrigger.visible = false;
         this._storeTrigger.addEventListener(MouseEvent.CLICK,this.onStoreClick);
      }
      
      private function initTeleport() : void
      {
         this._teleport = AnimateElementManager.getElement(1) as Teleport;
         this._teleport.visible = false;
      }
      
      private function onStoreClick(param1:Event) : void
      {
         this._pieceTrigger.visible = true;
         initInteractor(this._pieceTrigger);
         this._pieceTrigger.addEventListener(MouseEvent.CLICK,this.onPieceClick);
         closeInteractor(this._storeTrigger);
         this._openSkill.gotoAndPlay("点击");
         this._storeTrigger.removeEventListener(MouseEvent.CLICK,this.onStoreClick);
      }
      
      private function onPieceClick(param1:MouseEvent) : void
      {
         closeInteractor(this._pieceTrigger);
         this._pieceTrigger.removeEventListener(MouseEvent.CLICK,this.onPieceClick);
         this._openSkill.gotoAndPlay("点击1");
      }
      
      private function showTeleport(param1:Teleport) : void
      {
         param1.visible = true;
      }
      
      private function initOctopus() : void
      {
         this._octopusCrawl = _map.content["octopusCrawl"];
         this._octopusCrawlTrigger = _map.content["octopusCrawlTrigger"];
         initInteractor(this._octopusCrawlTrigger);
         closeInteractor(this._octopusCrawl);
         this._octopusCrawlTrigger.addEventListener(MouseEvent.CLICK,this.onOctopusClick);
         this._octopusCrawl.addEventListener(Event.ENTER_FRAME,this.resetOctopus);
      }
      
      private function resetOctopus(param1:Event) : void
      {
         if(this._octopusCrawl.currentFrame == this._octopusCrawl.totalFrames)
         {
            this._octopusCrawl.stop();
            this.showTeleport(this._teleport);
         }
      }
      
      private function onOctopusClick(param1:MouseEvent) : void
      {
         closeInteractor(this._octopusCrawlTrigger);
         this._octopusCrawlTrigger.removeEventListener(MouseEvent.CLICK,this.onOctopusClick);
         this._octopusCrawl.gotoAndPlay("跑掉了");
      }
      
      override public function dispose() : void
      {
         this._octopusCrawl.removeEventListener(Event.ENTER_FRAME,this.resetOctopus);
         this._octopusCrawl = null;
         this._octopusCrawlTrigger = null;
         this._openSkill = null;
         this._storeTrigger = null;
         this._pieceTrigger = null;
         this._teleport = null;
         GrabXiaoYueSeAct.getInstance().dispose();
         super.dispose();
      }
   }
}
