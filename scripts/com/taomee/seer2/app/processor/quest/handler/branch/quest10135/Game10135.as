package com.taomee.seer2.app.processor.quest.handler.branch.quest10135
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.utils.DisplayUtil;
   
   public class Game10135
   {
       
      
      private var _mc:MovieClip;
      
      private var _closeBtn:SimpleButton;
      
      private var _currMC:MovieClip;
      
      private var _mcList:Vector.<MovieClip>;
      
      private var _fun:Function;
      
      private var _pointList:Vector.<MovieClip>;
      
      private var _coinsList:Vector.<MovieClip>;
      
      private var _sp:Sprite;
      
      private var _isDown:Boolean;
      
      private var _startPoint:Point;
      
      private var _pi:MovieClip;
      
      private var _long:MovieClip;
      
      private var _okBtn:SimpleButton;
      
      private var _container:Sprite;
      
      public function Game10135(param1:MovieClip, param2:int, param3:Function)
      {
         super();
         this._mc = param1;
         this._closeBtn = this._mc["closeBtn"];
         this._closeBtn.addEventListener(MouseEvent.CLICK,this.dispose);
         this._fun = param3;
         LayerManager.topLayer.addChild(this._mc);
         DisplayUtil.align(this._mc,4,LayerManager.rootRect);
         this._mcList = Vector.<MovieClip>([]);
         var _loc4_:int = 0;
         while(_loc4_ < 2)
         {
            this._mcList.push(this._mc["mc" + _loc4_]);
            this._mcList[_loc4_].visible = false;
            _loc4_++;
         }
         this._currMC = this._mcList[param2];
         this._currMC.visible = true;
         switch(param2)
         {
            case 0:
               this.initMC0();
               break;
            case 1:
               this.initMC1();
         }
      }
      
      private function initMC0() : void
      {
         this._pointList = Vector.<MovieClip>([]);
         this._pi = this._currMC["pi"];
         this._long = this._currMC["long"];
         this._okBtn = this._currMC["okBtn"];
         var _loc1_:Rectangle = new Rectangle(-230,-150,500,300);
         this._pi.startDrag(true,_loc1_);
         this._pi.mouseChildren = false;
         this._pi.mouseEnabled = false;
         this._long.addEventListener(MouseEvent.MOUSE_DOWN,this.onDeleteHandler);
         this._okBtn.addEventListener(MouseEvent.MOUSE_DOWN,this.onOkHandler);
         var _loc2_:int = 0;
         while(_loc2_ < 5)
         {
            this._pointList.push(this._currMC["po" + _loc2_]);
            _loc2_++;
         }
      }
      
      private function onDeleteHandler(param1:MouseEvent) : void
      {
         this._container = new Sprite();
         this._long.addChild(this._container);
         this._pi.addEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._container.graphics.moveTo(this._container.mouseX,this._container.mouseY);
         this._container.graphics.lineStyle(30,16777215);
      }
      
      private function enterFrameHandler(param1:Event) : void
      {
         this._container.graphics.lineTo(this._container.mouseX,this._container.mouseY);
         this._long.addEventListener(MouseEvent.MOUSE_UP,this.onDeleteOverHandler);
      }
      
      private function onDeleteOverHandler(param1:MouseEvent) : void
      {
         this._pi.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
      }
      
      private function onOkHandler(param1:MouseEvent) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            if(this._pointList[_loc3_].hitTestObject(this._container))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ >= 5)
         {
            this.win();
         }
         DisplayUtil.removeForParent(this._container);
      }
      
      private function win() : void
      {
         this._pi.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._long.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDeleteHandler);
         this._long.removeEventListener(MouseEvent.MOUSE_UP,this.onDeleteOverHandler);
         this._okBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.onOkHandler);
         DisplayUtil.removeForParent(this._mc);
         this._fun();
      }
      
      private function initMC1() : void
      {
         var _loc2_:MovieClip = null;
         this._coinsList = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = this._currMC["d" + _loc1_];
            this._coinsList.push(_loc2_);
            _loc1_++;
         }
         LayerManager.topLayer.addEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.addEventListener(MouseEvent.MOUSE_UP,this.onUp);
      }
      
      private function onDown(param1:MouseEvent) : void
      {
         LayerManager.topLayer.addEventListener(Event.ENTER_FRAME,this.onMove);
         this._isDown = true;
         this._sp = new Sprite();
         this._currMC.addChild(this._sp);
         this._sp.graphics.lineStyle(3,52224);
         this._sp.graphics.moveTo(this._sp.mouseX,this._sp.mouseY);
      }
      
      private function onUp(param1:MouseEvent) : void
      {
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         this._isDown = false;
         this._sp.graphics.endFill();
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         while(_loc3_ < 5)
         {
            if(this._coinsList[_loc3_].hitTestObject(this._sp))
            {
               _loc2_++;
            }
            _loc3_++;
         }
         if(_loc2_ >= 5)
         {
            this.win0();
         }
         DisplayUtil.removeForParent(this._sp);
      }
      
      private function onMove(param1:Event) : void
      {
         if(this._isDown)
         {
            this._sp.graphics.lineTo(this._sp.mouseX,this._sp.mouseY);
         }
      }
      
      private function win0() : void
      {
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         DisplayUtil.removeForParent(this._mc);
         this._fun();
      }
      
      public function dispose(param1:MouseEvent) : void
      {
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDown);
         LayerManager.topLayer.removeEventListener(MouseEvent.MOUSE_UP,this.onUp);
         LayerManager.topLayer.removeEventListener(Event.ENTER_FRAME,this.onMove);
         this._pi.removeEventListener(Event.ENTER_FRAME,this.enterFrameHandler);
         this._long.removeEventListener(MouseEvent.MOUSE_DOWN,this.onDeleteHandler);
         this._long.removeEventListener(MouseEvent.MOUSE_UP,this.onDeleteOverHandler);
         this._okBtn.removeEventListener(MouseEvent.MOUSE_DOWN,this.onOkHandler);
         DisplayUtil.removeForParent(this._mc);
      }
   }
}
