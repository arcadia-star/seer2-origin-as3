package com.greensock.motionPaths
{
   import flash.display.Graphics;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public class LinePath2D extends MotionPath
   {
       
      
      protected var _points:Array;
      
      protected var _totalLength:Number;
      
      public var autoUpdatePoints:Boolean;
      
      protected var _hasAutoRotate:Boolean;
      
      protected var _first:PathPoint;
      
      protected var _prevMatrix:Matrix;
      
      public function LinePath2D(param1:Array = null, param2:Number = 0, param3:Number = 0, param4:Boolean = false)
      {
         super();
         _points = [];
         _totalLength = 0;
         this.autoUpdatePoints = param4;
         if(param1 != null)
         {
            insertMultiplePoints(param1,0);
         }
         super.x = param2;
         super.y = param3;
      }
      
      protected function _organize() : void
      {
         var _loc2_:PathPoint = null;
         _totalLength = 0;
         _hasAutoRotate = false;
         var _loc1_:int = int(_points.length - 1);
         if(_loc1_ == -1)
         {
            _first = null;
         }
         else if(_loc1_ == 0)
         {
            _first = _points[0];
            _first.progress = _first.xChange = _first.yChange = _first.length = 0;
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ <= _loc1_)
         {
            if(_points[_loc3_] != null)
            {
               _loc2_ = _points[_loc3_];
               _loc2_.x = _loc2_.point.x;
               _loc2_.y = _loc2_.point.y;
               if(_loc3_ == _loc1_)
               {
                  _loc2_.length = 0;
                  _loc2_.next = null;
               }
               else
               {
                  _loc2_.next = _points[_loc3_ + 1];
                  _loc2_.xChange = _loc2_.next.x - _loc2_.x;
                  _loc2_.yChange = _loc2_.next.y - _loc2_.y;
                  _loc2_.length = Math.sqrt(_loc2_.xChange * _loc2_.xChange + _loc2_.yChange * _loc2_.yChange);
                  _totalLength += _loc2_.length;
               }
            }
            _loc3_++;
         }
         _first = _loc2_ = _points[0];
         var _loc4_:Number = 0;
         while(_loc2_)
         {
            _loc2_.progress = _loc4_ / _totalLength;
            _loc4_ += _loc2_.length;
            _loc2_ = _loc2_.next;
         }
         _updateAngles();
      }
      
      public function set points(param1:Array) : void
      {
         _points = [];
         insertMultiplePoints(param1,0);
         _redrawLine = true;
         update(null);
      }
      
      protected function _updateAngles() : void
      {
         var _loc1_:Matrix = this.transform.matrix;
         var _loc2_:PathPoint = _first;
         while(_loc2_)
         {
            _loc2_.angle = Math.atan2(_loc2_.xChange * _loc1_.b + _loc2_.yChange * _loc1_.d,_loc2_.xChange * _loc1_.a + _loc2_.yChange * _loc1_.c) * _RAD2DEG;
            _loc2_ = _loc2_.next;
         }
         _prevMatrix = _loc1_;
      }
      
      public function getSegmentProgress(param1:uint, param2:Number) : Number
      {
         if(_first == null)
         {
            return 0;
         }
         if(_points.length <= param1)
         {
            param1 = _points.length;
         }
         var _loc3_:PathPoint = _points[param1 - 1];
         return _loc3_.progress + param2 * _loc3_.length / _totalLength;
      }
      
      public function appendMultiplePoints(param1:Array) : void
      {
         insertMultiplePoints(param1,_points.length);
      }
      
      override public function renderObjectAt(param1:Object, param2:Number, param3:Boolean = false, param4:Number = 0) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Matrix = null;
         if(param2 > 1)
         {
            param2 -= int(param2);
         }
         else if(param2 < 0)
         {
            param2 -= int(param2) - 1;
         }
         if(_first == null)
         {
            return;
         }
         var _loc5_:PathPoint = _first;
         while(_loc5_.next != null && _loc5_.next.progress < param2)
         {
            _loc5_ = _loc5_.next;
         }
         if(_loc5_ != null)
         {
            _loc6_ = (param2 - _loc5_.progress) / (_loc5_.length / _totalLength);
            _loc7_ = _loc5_.x + _loc6_ * _loc5_.xChange;
            _loc8_ = _loc5_.y + _loc6_ * _loc5_.yChange;
            _loc9_ = this.transform.matrix;
            param1.x = _loc7_ * _loc9_.a + _loc8_ * _loc9_.c + _loc9_.tx;
            param1.y = _loc7_ * _loc9_.b + _loc8_ * _loc9_.d + _loc9_.ty;
            if(param3)
            {
               if(_prevMatrix.a != _loc9_.a || _prevMatrix.b != _loc9_.b || _prevMatrix.c != _loc9_.c || _prevMatrix.d != _loc9_.d)
               {
                  _updateAngles();
               }
               param1.rotation = _loc5_.angle + param4;
            }
         }
      }
      
      override public function update(param1:Event = null) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:PathPoint = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc16_:Graphics = null;
         if(_first == null || _points.length <= 1)
         {
            return;
         }
         var _loc2_:Boolean = false;
         var _loc8_:Matrix;
         var _loc9_:Number = (_loc8_ = this.transform.matrix).a;
         var _loc10_:Number = _loc8_.b;
         var _loc11_:Number = _loc8_.c;
         var _loc12_:Number = _loc8_.d;
         var _loc13_:Number = _loc8_.tx;
         var _loc14_:Number = _loc8_.ty;
         var _loc15_:PathFollower = _rootFollower;
         if(autoUpdatePoints)
         {
            _loc5_ = _first;
            while(_loc5_)
            {
               if(_loc5_.point.x != _loc5_.x || _loc5_.point.y != _loc5_.y)
               {
                  _organize();
                  _redrawLine = true;
                  update();
                  return;
               }
               _loc5_ = _loc5_.next;
            }
         }
         while(_loc15_)
         {
            _loc6_ = _loc15_.cachedProgress;
            _loc5_ = _first;
            while(_loc5_ != null && _loc5_.next.progress < _loc6_)
            {
               _loc5_ = _loc5_.next;
            }
            if(_loc5_ != null)
            {
               _loc7_ = (_loc6_ - _loc5_.progress) / (_loc5_.length / _totalLength);
               _loc3_ = _loc5_.x + _loc7_ * _loc5_.xChange;
               _loc4_ = _loc5_.y + _loc7_ * _loc5_.yChange;
               _loc15_.target.x = _loc3_ * _loc9_ + _loc4_ * _loc11_ + _loc13_;
               _loc15_.target.y = _loc3_ * _loc10_ + _loc4_ * _loc12_ + _loc14_;
               if(_loc15_.autoRotate)
               {
                  if(!_loc2_ && (_prevMatrix.a != _loc9_ || _prevMatrix.b != _loc10_ || _prevMatrix.c != _loc11_ || _prevMatrix.d != _loc12_))
                  {
                     _updateAngles();
                     _loc2_ = true;
                  }
                  _loc15_.target.rotation = _loc5_.angle + _loc15_.rotationOffset;
               }
            }
            _loc15_ = _loc15_.cachedNext;
         }
         if(_redrawLine)
         {
            (_loc16_ = this.graphics).clear();
            _loc16_.lineStyle(_thickness,_color,_lineAlpha,_pixelHinting,_scaleMode,_caps,_joints,_miterLimit);
            _loc5_ = _first;
            _loc16_.moveTo(_loc5_.x,_loc5_.y);
            while(_loc5_)
            {
               _loc16_.lineTo(_loc5_.x,_loc5_.y);
               _loc5_ = _loc5_.next;
            }
            _redrawLine = false;
         }
      }
      
      public function appendPoint(param1:Point) : void
      {
         _insertPoint(param1,_points.length,false);
      }
      
      public function insertPoint(param1:Point, param2:uint = 0) : void
      {
         _insertPoint(param1,param2,false);
      }
      
      protected function _insertPoint(param1:Point, param2:uint, param3:Boolean) : void
      {
         _points.splice(param2,0,new PathPoint(param1));
         if(!param3)
         {
            _organize();
         }
      }
      
      public function snap(param1:Object, param2:Boolean = false, param3:Number = 0) : PathFollower
      {
         return this.addFollower(param1,getClosestProgress(param1),param2,param3);
      }
      
      public function get points() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:int = int(_points.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_[_loc3_] = _points[_loc3_].point;
            _loc3_++;
         }
         return _loc1_;
      }
      
      public function insertMultiplePoints(param1:Array, param2:uint = 0) : void
      {
         var _loc3_:int = int(param1.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _insertPoint(param1[_loc4_],param2 + _loc4_,true);
            _loc4_++;
         }
         _organize();
      }
      
      public function removePointByIndex(param1:uint) : void
      {
         _points.splice(param1,1);
         _organize();
      }
      
      public function getClosestProgress(param1:Object) : Number
      {
         var _loc2_:PathPoint = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:PathPoint = null;
         var _loc16_:Number = NaN;
         if(_first == null || _points.length == 1)
         {
            return 0;
         }
         var _loc3_:Number = 9999999999;
         var _loc4_:Number = 0;
         var _loc5_:Number = Math.PI / 2;
         var _loc6_:Number = Number(param1.x);
         var _loc7_:Number = Number(param1.y);
         var _loc8_:PathPoint = _first;
         while(_loc8_)
         {
            _loc9_ = _loc6_ - _loc8_.x;
            _loc10_ = _loc7_ - _loc8_.y;
            _loc11_ = (_loc15_ = _loc8_.next != null ? _loc8_.next : _loc8_).x - _loc8_.x;
            _loc12_ = _loc15_.y - _loc8_.y;
            _loc13_ = Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_);
            if((_loc14_ = Math.atan2(_loc10_,_loc9_) - Math.atan2(_loc12_,_loc11_)) < 0)
            {
               _loc14_ = -_loc14_;
            }
            if(_loc14_ > _loc5_)
            {
               if(_loc13_ < _loc3_)
               {
                  _loc3_ = _loc13_;
                  _loc2_ = _loc8_;
                  _loc4_ = 0;
               }
            }
            else
            {
               if((_loc16_ = Math.cos(_loc14_) * _loc13_) < 0)
               {
                  _loc16_ = -_loc16_;
               }
               if(_loc16_ > _loc8_.length)
               {
                  _loc11_ = _loc6_ - _loc15_.x;
                  _loc12_ = _loc7_ - _loc15_.y;
                  if((_loc16_ = Math.sqrt(_loc11_ * _loc11_ + _loc12_ * _loc12_)) < _loc3_)
                  {
                     _loc3_ = _loc16_;
                     _loc2_ = _loc8_;
                     _loc4_ = _loc8_.length;
                  }
               }
               else if((_loc16_ = Math.sin(_loc14_) * _loc13_) < _loc3_)
               {
                  _loc3_ = _loc16_;
                  _loc2_ = _loc8_;
                  _loc4_ = Math.cos(_loc14_) * _loc13_;
               }
            }
            _loc8_ = _loc8_.next;
         }
         return _loc2_.progress + _loc4_ / _totalLength;
      }
      
      public function get totalLength() : Number
      {
         return _totalLength;
      }
      
      public function removePoint(param1:Point) : void
      {
         var _loc2_:int = int(_points.length);
         while(--_loc2_ > -1)
         {
            if(_points[_loc2_].point == param1)
            {
               _points.splice(_loc2_,1);
            }
         }
         _organize();
      }
   }
}

import flash.geom.Point;

class PathPoint
{
    
   
   public var next:PathPoint;
   
   public var length:Number;
   
   public var y:Number;
   
   public var yChange:Number;
   
   public var progress:Number;
   
   public var xChange:Number;
   
   public var angle:Number;
   
   public var point:Point;
   
   public var x:Number;
   
   public function PathPoint(param1:Point)
   {
      super();
      this.x = param1.x;
      this.y = param1.y;
      this.point = param1;
   }
}
