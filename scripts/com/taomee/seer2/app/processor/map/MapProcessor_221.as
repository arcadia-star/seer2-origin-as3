package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.dream.DreamManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MapProcessor_221 extends DreamMapProcessor
   {
       
      
      private var _fire:MovieClip;
      
      private var _fireMC:MovieClip;
      
      private var _fireContent:MovieClip;
      
      private var _light:MovieClip;
      
      public function MapProcessor_221(param1:MapModel)
      {
         _taskId = 1;
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         this._fire = _map.content["fire"];
         this._fire.stop();
         this._fire.visible = false;
         this._fire.mouseChildren = false;
         this._fire.mouseEnabled = false;
         this._fireContent = _map.content["fireContent"];
         this._fireMC = this._fireContent["fireMC"];
         this._light = this._fireContent["light"];
         this._fireMC.buttonMode = true;
         this._fireMC.addEventListener(MouseEvent.CLICK,this.onFireClick);
      }
      
      private function onFireClick(param1:MouseEvent) : void
      {
         this._fireMC.buttonMode = false;
         this._fireMC.removeEventListener(MouseEvent.CLICK,this.onFireClick);
         this._fire.visible = true;
         this._fire.gotoAndPlay(1);
         this._light.buttonMode = true;
         this._light.addEventListener(MouseEvent.CLICK,this.onLightClick);
         this._fire.addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         this._fire.x = LayerManager.mapLayer.mouseX;
         this._fire.y = LayerManager.mapLayer.mouseY;
      }
      
      private function onLightClick(param1:MouseEvent) : void
      {
         this._light.removeEventListener(MouseEvent.CLICK,this.onLightClick);
         this._fire.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._fire.visible = false;
         DreamManager.currentTaskId = _taskId;
         this._fireContent.gotoAndStop(2);
         indicateLeaveDream();
      }
      
      override public function dispose() : void
      {
         this._fire.removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
         this._fire.stop();
         this._fire.visible = false;
         this._fire = null;
         this._fireMC.buttonMode = false;
         this._fireMC.removeEventListener(MouseEvent.CLICK,this.onFireClick);
         this._fireMC = null;
         this._light.removeEventListener(MouseEvent.CLICK,this.onLightClick);
         this._light = null;
         this._fireContent.gotoAndStop(1);
         this._fireContent = null;
         super.dispose();
      }
   }
}
