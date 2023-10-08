package com.greensock.motionPaths
{
   import flash.display.Shape;
   import flash.events.Event;
   
   public class MotionPath extends Shape
   {
      
      protected static const _RAD2DEG:Number = 180 / Math.PI;
      
      protected static const _DEG2RAD:Number = Math.PI / 180;
       
      
      protected var _progress:Number;
      
      protected var _scaleMode:String;
      
      protected var _redrawLine:Boolean;
      
      protected var _rawProgress:Number;
      
      protected var _caps:String;
      
      protected var _lineAlpha:Number;
      
      protected var _joints:String;
      
      protected var _miterLimit:Number;
      
      protected var _color:uint;
      
      protected var _pixelHinting:Boolean;
      
      protected var _thickness:Number;
      
      protected var _rootFollower:com.greensock.motionPaths.PathFollower;
      
      public function MotionPath()
      {
         super();
         _progress = _rawProgress = 0;
         lineStyle(1,6710886,1,false,"none",null,null,3,true);
         this.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,0,true);
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         update();
      }
      
      public function get targets() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         var _loc3_:com.greensock.motionPaths.PathFollower = _rootFollower;
         while(_loc3_)
         {
            var _loc4_:*;
            _loc1_[_loc4_ = _loc2_++] = _loc3_.target;
            _loc3_ = _loc3_.cachedNext;
         }
         return _loc1_;
      }
      
      public function get rawProgress() : Number
      {
         return _rawProgress;
      }
      
      public function renderObjectAt(param1:Object, param2:Number, param3:Boolean = false, param4:Number = 0) : void
      {
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         update();
      }
      
      public function getFollower(param1:Object) : com.greensock.motionPaths.PathFollower
      {
         if(param1 is com.greensock.motionPaths.PathFollower)
         {
            return param1 as com.greensock.motionPaths.PathFollower;
         }
         var _loc2_:com.greensock.motionPaths.PathFollower = _rootFollower;
         while(_loc2_)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
            _loc2_ = _loc2_.cachedNext;
         }
         return null;
      }
      
      protected function _normalize(param1:Number) : Number
      {
         if(param1 > 1)
         {
            param1 -= int(param1);
         }
         else if(param1 < 0)
         {
            param1 -= int(param1) - 1;
         }
         return param1;
      }
      
      public function lineStyle(param1:Number = 1, param2:uint = 6710886, param3:Number = 1, param4:Boolean = false, param5:String = "none", param6:String = null, param7:String = null, param8:Number = 3, param9:Boolean = false) : void
      {
         _thickness = param1;
         _color = param2;
         _lineAlpha = param3;
         _pixelHinting = param4;
         _scaleMode = param5;
         _caps = param6;
         _joints = param7;
         _miterLimit = param8;
         _redrawLine = true;
         if(!param9)
         {
            update();
         }
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         update();
      }
      
      public function removeAllFollowers() : void
      {
         var _loc2_:com.greensock.motionPaths.PathFollower = null;
         var _loc1_:com.greensock.motionPaths.PathFollower = _rootFollower;
         while(_loc1_)
         {
            _loc2_ = _loc1_.cachedNext;
            _loc1_.cachedNext = _loc1_.cachedPrev = null;
            _loc1_.path = null;
            _loc1_ = _loc2_;
         }
         _rootFollower = null;
      }
      
      protected function onAddedToStage(param1:Event) : void
      {
         update();
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         update();
      }
      
      public function get followers() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         var _loc3_:com.greensock.motionPaths.PathFollower = _rootFollower;
         while(_loc3_)
         {
            var _loc4_:*;
            _loc1_[_loc4_ = _loc2_++] = _loc3_;
            _loc3_ = _loc3_.cachedNext;
         }
         return _loc1_;
      }
      
      override public function get height() : Number
      {
         return super.height;
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
      
      public function removeFollower(param1:*) : void
      {
         var _loc2_:com.greensock.motionPaths.PathFollower = getFollower(param1);
         if(_loc2_ == null)
         {
            return;
         }
         if(_loc2_.cachedNext)
         {
            _loc2_.cachedNext.cachedPrev = _loc2_.cachedPrev;
         }
         if(_loc2_.cachedPrev)
         {
            _loc2_.cachedPrev.cachedNext = _loc2_.cachedNext;
         }
         else if(_rootFollower == _loc2_)
         {
            _rootFollower = null;
         }
         _loc2_.cachedNext = _loc2_.cachedPrev = null;
         _loc2_.path = null;
      }
      
      override public function get width() : Number
      {
         return super.width;
      }
      
      public function update(param1:Event = null) : void
      {
      }
      
      override public function get scaleX() : Number
      {
         return super.scaleX;
      }
      
      override public function get scaleY() : Number
      {
         return super.scaleY;
      }
      
      public function set progress(param1:Number) : void
      {
         if(param1 > 1)
         {
            _rawProgress = param1;
            param1 -= int(param1);
            if(param1 == 0)
            {
               param1 = 1;
            }
         }
         else if(param1 < 0)
         {
            _rawProgress = param1;
            param1 -= int(param1) - 1;
         }
         else
         {
            _rawProgress = int(_rawProgress) + param1;
         }
         var _loc2_:Number = param1 - _progress;
         var _loc3_:com.greensock.motionPaths.PathFollower = _rootFollower;
         while(_loc3_)
         {
            _loc3_.cachedProgress += _loc2_;
            _loc3_.cachedRawProgress += _loc2_;
            if(_loc3_.cachedProgress > 1)
            {
               _loc3_.cachedProgress -= int(_loc3_.cachedProgress);
               if(_loc3_.cachedProgress == 0)
               {
                  _loc3_.cachedProgress = 1;
               }
            }
            else if(_loc3_.cachedProgress < 0)
            {
               _loc3_.cachedProgress -= int(_loc3_.cachedProgress) - 1;
            }
            _loc3_ = _loc3_.cachedNext;
         }
         _progress = param1;
         update();
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         update();
      }
      
      public function addFollower(param1:*, param2:Number = 0, param3:Boolean = false, param4:Number = 0) : com.greensock.motionPaths.PathFollower
      {
         var _loc5_:com.greensock.motionPaths.PathFollower;
         if((_loc5_ = getFollower(param1)) == null)
         {
            _loc5_ = new com.greensock.motionPaths.PathFollower(param1);
         }
         _loc5_.autoRotate = param3;
         _loc5_.rotationOffset = param4;
         if(_loc5_.path != this)
         {
            if(_rootFollower)
            {
               _rootFollower.cachedPrev = _loc5_;
            }
            _loc5_.cachedNext = _rootFollower;
            _rootFollower = _loc5_;
            _loc5_.path = this;
            _loc5_.progress = param2;
         }
         return _loc5_;
      }
      
      public function distribute(param1:Array = null, param2:Number = 0, param3:Number = 1, param4:Boolean = false, param5:Number = 0) : void
      {
         var _loc6_:com.greensock.motionPaths.PathFollower = null;
         if(param1 == null)
         {
            param1 = this.followers;
         }
         param2 = _normalize(param2);
         param3 = _normalize(param3);
         var _loc7_:int;
         var _loc8_:Number = (_loc7_ = int(param1.length)) > 1 ? (param3 - param2) / (_loc7_ - 1) : 1;
         while(--_loc7_ > -1)
         {
            if((_loc6_ = getFollower(param1[_loc7_])) == null)
            {
               _loc6_ = this.addFollower(param1[_loc7_],0,param4,param5);
            }
            _loc6_.cachedProgress = _loc6_.cachedRawProgress = param2 + _loc8_ * _loc7_;
            this.renderObjectAt(_loc6_.target,_loc6_.cachedProgress,param4,param5);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         _redrawLine = true;
         update();
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         update();
      }
      
      public function set rawProgress(param1:Number) : void
      {
         this.progress = param1;
      }
      
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function get x() : Number
      {
         return super.x;
      }
      
      override public function get y() : Number
      {
         return super.y;
      }
      
      override public function set rotation(param1:Number) : void
      {
         super.rotation = param1;
         update();
      }
      
      override public function get rotation() : Number
      {
         return super.rotation;
      }
   }
}
