package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class Interactive_16 extends BaseAniamationInteractive
   {
       
      
      private var _thisMCVec:Vector.<MovieClip>;
      
      private var _mcVec:Vector.<MovieClip>;
      
      private var _playMC:MovieClip;
      
      private var _selectMC:MovieClip;
      
      private var _thisPoint:Point;
      
      public function Interactive_16()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         var _loc2_:MovieClip = null;
         this._thisMCVec = Vector.<MovieClip>([]);
         this._mcVec = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 5)
         {
            this._thisMCVec.push(_animation["thisMC" + _loc1_]);
            this._mcVec.push(_animation["mc" + _loc1_]);
            _loc1_++;
         }
         for each(_loc2_ in this._mcVec)
         {
            _loc2_.mouseChildren = false;
            _loc2_.mouseEnabled = false;
         }
         this._playMC = _animation["playMC"];
         this._playMC.visible = false;
         this.initEventListener();
      }
      
      private function initEventListener() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._thisMCVec)
         {
            _loc1_.buttonMode = true;
            _loc1_.mouseChildren = true;
            _loc1_.mouseEnabled = true;
            _loc1_.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _loc1_.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }
      
      private function disposeEventListener() : void
      {
         var _loc1_:MovieClip = null;
         for each(_loc1_ in this._thisMCVec)
         {
            _loc1_.buttonMode = false;
            _loc1_.mouseChildren = false;
            _loc1_.mouseEnabled = false;
            _loc1_.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
            _loc1_.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         }
      }
      
      private function onMouseDown(param1:MouseEvent) : void
      {
         this._selectMC = param1.currentTarget as MovieClip;
         this._thisPoint = new Point(this._selectMC.x,this._selectMC.y);
         this._selectMC.startDrag(true);
      }
      
      private function onMouseUp(param1:MouseEvent) : void
      {
         this._selectMC.stopDrag();
         this._selectMC.mouseChildren = false;
         this._selectMC.mouseEnabled = false;
         this.cheakTestObj();
      }
      
      private function cheakTestObj() : void
      {
         var selectIndex:int = 0;
         selectIndex = this._thisMCVec.indexOf(this._selectMC);
         var mc:MovieClip = this._mcVec[selectIndex];
         if(mc.hitTestPoint(LayerManager.stage.mouseX,LayerManager.stage.mouseY))
         {
            this._selectMC.x = mc.x + this._selectMC.width / 2;
            this._selectMC.y = mc.y + this._selectMC.height / 2;
            this._selectMC.gotoAndStop(2);
            this.disposeEventListener();
            this._thisMCVec.splice(selectIndex,1);
            this._mcVec.splice(selectIndex,1);
            this.initEventListener();
         }
         else
         {
            this._selectMC.x = this._thisPoint.x;
            this._selectMC.y = this._thisPoint.y;
            this._thisPoint = null;
            this._selectMC = null;
            this.disposeEventListener();
            this.initEventListener();
         }
         if(this._thisMCVec.length <= 0)
         {
            _animation.gotoAndStop(2);
            this._playMC.visible = true;
            MovieClipUtil.playMc(this._playMC,2,this._playMC.totalFrames,function():void
            {
               _isSuccess = true;
               dispose();
            },true);
         }
      }
      
      override public function dispose() : void
      {
         this.disposeEventListener();
         this._thisPoint = null;
         this._selectMC = null;
         this._playMC = null;
         this._thisMCVec = null;
         this._mcVec = null;
         super.dispose();
      }
   }
}
