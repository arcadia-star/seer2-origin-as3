package com.taomee.seer2.app.utils
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public class FPS extends Sprite
   {
      
      private static const maxMemory:uint = 41943000;
      
      private static const diagramWidth:uint = 60;
      
      private static const tfDelayMax:int = 10;
      
      private static var instance:FPS;
      
      private static const diagramHeight:uint = 40;
       
      
      private var currentY:int;
      
      private var diagramTimer:int;
      
      private var tfTimer:int;
      
      private var mem:TextField;
      
      private var diagram:BitmapData;
      
      private var skins:int = -1;
      
      private var fps:TextField;
      
      private var tfDelay:int = 0;
      
      private var skinsChanged:int = 0;
      
      public function FPS()
      {
         super();
         this.addEventListener(Event.ADDED_TO_STAGE,this.run);
      }
      
      private function run(param1:Event) : void
      {
         var _loc2_:Bitmap = null;
         this.fps = new TextField();
         this.mem = new TextField();
         if(instance == null)
         {
            mouseEnabled = false;
            mouseChildren = false;
            this.fps.defaultTextFormat = new TextFormat("Tahoma",10,13421772);
            this.fps.autoSize = TextFieldAutoSize.LEFT;
            this.fps.text = "FPS: " + Number(stage.frameRate).toFixed(2);
            this.fps.selectable = false;
            this.fps.x = -diagramWidth - 2;
            addChild(this.fps);
            this.mem.defaultTextFormat = new TextFormat("Tahoma",10,13421568);
            this.mem.autoSize = TextFieldAutoSize.LEFT;
            this.mem.text = "MEM: " + this.bytesToString(System.totalMemory);
            this.mem.selectable = false;
            this.mem.x = -diagramWidth - 2;
            this.mem.y = 10;
            addChild(this.mem);
            this.currentY = 20;
            this.diagram = new BitmapData(diagramWidth,diagramHeight,true,553648127);
            _loc2_ = new Bitmap(this.diagram);
            _loc2_.y = this.currentY + 4;
            _loc2_.x = -diagramWidth;
            addChildAt(_loc2_,0);
            addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
            this.stage.addEventListener(Event.RESIZE,this.onResize);
            this.onResize();
            this.diagramTimer = getTimer();
            this.tfTimer = getTimer();
         }
      }
      
      private function bytesToString(param1:uint) : String
      {
         var _loc2_:* = null;
         if(param1 < 1024)
         {
            _loc2_ = String(param1) + "b";
         }
         else if(param1 < 10240)
         {
            _loc2_ = Number(param1 / 1024).toFixed(2) + "kb";
         }
         else if(param1 < 102400)
         {
            _loc2_ = Number(param1 / 1024).toFixed(1) + "kb";
         }
         else if(param1 < 1048576)
         {
            _loc2_ = Math.round(param1 / 1024) + "kb";
         }
         else if(param1 < 10485760)
         {
            _loc2_ = Number(param1 / 1048576).toFixed(2) + "mb";
         }
         else if(param1 < 104857600)
         {
            _loc2_ = Number(param1 / 1048576).toFixed(1) + "mb";
         }
         else
         {
            _loc2_ = Math.round(param1 / 1048576) + "mb";
         }
         return _loc2_;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         ++this.tfDelay;
         if(this.tfDelay >= tfDelayMax)
         {
            this.tfDelay = 0;
            this.fps.text = "FPS: " + Number(1000 * tfDelayMax / (getTimer() - this.tfTimer)).toFixed(2);
            this.tfTimer = getTimer();
         }
         var _loc2_:* = 1000 / (getTimer() - this.diagramTimer);
         var _loc3_:* = _loc2_ > stage.frameRate ? 1 : _loc2_ / stage.frameRate;
         this.diagramTimer = getTimer();
         this.diagram.scroll(1,0);
         this.diagram.fillRect(new Rectangle(0,0,1,this.diagram.height),553648127);
         this.diagram.setPixel32(0,diagramHeight * (1 - _loc3_),4291611852);
         this.mem.text = "MEM: " + this.bytesToString(System.totalMemory);
         var _loc4_:* = this.skins == 0 ? 0 : this.skinsChanged / this.skins;
         this.diagram.setPixel32(0,diagramHeight * (1 - _loc4_),4294927872);
         var _loc5_:* = System.totalMemory / maxMemory;
         this.diagram.setPixel32(0,diagramHeight * (1 - _loc5_),4291611648);
      }
      
      private function onResize(param1:Event = null) : void
      {
         var _loc2_:* = parent.globalToLocal(new Point(stage.stageWidth - 2,-3));
         x = _loc2_.x;
         y = _loc2_.y;
      }
   }
}
