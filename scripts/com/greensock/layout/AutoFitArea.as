package com.greensock.layout
{
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class AutoFitArea extends Shape
   {
      
      private static var _bd:BitmapData;
      
      private static var _rect:Rectangle = new Rectangle(0,0,2800,2800);
      
      private static var _matrix:Matrix = new Matrix();
      
      public static const version:Number = 2.53;
       
      
      protected var _height:Number;
      
      protected var _width:Number;
      
      protected var _preview:Boolean;
      
      protected var _parent:DisplayObjectContainer;
      
      protected var _previewColor:uint;
      
      protected var _tweenMode:Boolean;
      
      protected var _hasListener:Boolean;
      
      protected var _rootItem:AutoFitItem;
      
      public function AutoFitArea(param1:DisplayObjectContainer, param2:Number = 0, param3:Number = 0, param4:Number = 100, param5:Number = 100, param6:uint = 16711680)
      {
         super();
         super.x = param2;
         super.y = param3;
         if(param1 == null)
         {
            throw new Error("AutoFitArea parent cannot be null");
         }
         _parent = param1;
         _width = param4;
         _height = param5;
         _redraw(param6);
      }
      
      public static function createAround(param1:DisplayObject, param2:Object = null, ... rest) : AutoFitArea
      {
         if(param2 == null || typeof param2 == "string")
         {
            param2 = {
               "scaleMode":param2 || "proportionalInside",
               "hAlign":rest[0] || "center",
               "vAlign":rest[1] || "center",
               "crop":Boolean(rest[2]),
               "minWidth":rest[3] || 0,
               "maxWidth":(isNaN(rest[4]) ? 999999999 : rest[4]),
               "minHeight":rest[5] || 0,
               "maxHeight":(isNaN(rest[6]) ? 999999999 : rest[6]),
               "calculateVisible":Boolean(rest[8])
            };
         }
         var _loc4_:DisplayObject = param2.customBoundsTarget is DisplayObject ? param2.customBoundsTarget : param1;
         var _loc5_:uint = isNaN(rest[7]) ? ("previewColor" in param2 ? uint(param2.previewColor) : 16711680) : uint(rest[7]);
         var _loc6_:Rectangle = param2.calculateVisible == true ? getVisibleBounds(_loc4_,param1.parent) : _loc4_.getBounds(param1.parent);
         var _loc7_:AutoFitArea;
         (_loc7_ = new AutoFitArea(param1.parent,_loc6_.x,_loc6_.y,_loc6_.width,_loc6_.height,_loc5_)).attach(param1,param2);
         return _loc7_;
      }
      
      protected static function getVisibleBounds(param1:DisplayObject, param2:DisplayObject) : Rectangle
      {
         if(_bd == null)
         {
            _bd = new BitmapData(2800,2800,true,16777215);
         }
         var _loc3_:DisplayObject = param1.mask;
         param1.mask = null;
         _bd.fillRect(_rect,16777215);
         _matrix.tx = _matrix.ty = 0;
         var _loc4_:Rectangle = param1.getBounds(param2);
         var _loc5_:Matrix = param2 == param1 ? _matrix : param1.transform.matrix;
         _loc5_.tx -= _loc4_.x;
         _loc5_.ty -= _loc4_.y;
         _bd.draw(param1,_loc5_,null,"normal",_rect,false);
         var _loc6_:Rectangle = _bd.getColorBoundsRect(4278190080,0,false);
         _loc6_.x += _loc4_.x;
         _loc6_.y += _loc4_.y;
         param1.mask = _loc3_;
         return _loc6_;
      }
      
      public function get previewColor() : uint
      {
         return _previewColor;
      }
      
      public function attach(param1:DisplayObject, param2:Object = null, ... rest) : void
      {
         var _loc4_:Shape = null;
         var _loc5_:Rectangle = null;
         if(param1.parent != _parent)
         {
            throw new Error("The parent of the DisplayObject " + param1.name + " added to AutoFitArea " + this.name + " doesn\'t share the same parent.");
         }
         if(param2 == null || typeof param2 == "string")
         {
            param2 = {
               "scaleMode":param2 || "proportionalInside",
               "hAlign":rest[0] || "center",
               "vAlign":rest[1] || "center",
               "crop":Boolean(rest[2]),
               "minWidth":rest[3] || 0,
               "maxWidth":(isNaN(rest[4]) ? 999999999 : rest[4]),
               "minHeight":rest[5] || 0,
               "maxHeight":(isNaN(rest[6]) ? 999999999 : rest[6]),
               "calculateVisible":Boolean(rest[7]),
               "customAspectRatio":Number(rest[8]),
               "roundPosition":Boolean(rest[9])
            };
         }
         release(param1);
         _rootItem = new AutoFitItem(param1,param2,_rootItem);
         if(param2 != null && param2.crop == true)
         {
            _loc4_ = new Shape();
            _loc5_ = this.getBounds(this);
            _loc4_.graphics.beginFill(_previewColor,1);
            _loc4_.graphics.drawRect(_loc5_.x,_loc5_.y,_loc5_.width,_loc5_.height);
            _loc4_.graphics.endFill();
            _loc4_.visible = false;
            _parent.addChild(_loc4_);
            _rootItem.mask = _loc4_;
            param1.mask = _loc4_;
         }
         if(_preview)
         {
            this.preview = true;
         }
         update(null);
      }
      
      public function get preview() : Boolean
      {
         return _preview;
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         _hasListener = true;
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function update(param1:Event = null) : void
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:DisplayObject = null;
         var _loc13_:Rectangle = null;
         var _loc14_:Rectangle = null;
         var _loc15_:Number = NaN;
         var _loc16_:String = null;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Matrix = null;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Matrix = null;
         var _loc2_:Number = this.width;
         var _loc3_:Number = this.height;
         var _loc4_:Number = this.x;
         var _loc5_:Number = this.y;
         var _loc6_:Matrix = this.transform.matrix;
         var _loc7_:AutoFitItem = _rootItem;
         while(_loc7_)
         {
            _loc12_ = _loc7_.target;
            if((_loc16_ = _loc7_.scaleMode) != ScaleMode.NONE)
            {
               if(_loc16_ != ScaleMode.HEIGHT_ONLY && _loc12_.width == 0)
               {
                  _loc12_.width = 1;
               }
               if(_loc16_ != ScaleMode.WIDTH_ONLY && _loc12_.height == 0)
               {
                  _loc12_.height = 1;
               }
               if(_loc7_.calculateVisible)
               {
                  _loc13_ = _loc7_.bounds = getVisibleBounds(_loc7_.boundsTarget,_loc12_);
                  _loc14_ = getVisibleBounds(_loc7_.boundsTarget,_parent);
               }
               else
               {
                  _loc13_ = _loc7_.boundsTarget.getBounds(_loc12_);
                  _loc14_ = _loc7_.boundsTarget.getBounds(_parent);
               }
               _loc15_ = _loc7_.hasCustomRatio ? _loc7_.aspectRatio : _loc13_.width / _loc13_.height;
               if((_loc21_ = _loc12_.transform.matrix).b != 0 || _loc21_.a == 0 || _loc21_.d == 0)
               {
                  if(_loc21_.a == 0 || _loc21_.d == 0)
                  {
                     _loc21_ = _loc12_.transform.matrix = _loc7_.matrix;
                  }
                  else
                  {
                     (_loc24_ = _loc7_.matrix).a = _loc21_.a;
                     _loc24_.b = _loc21_.b;
                     _loc24_.c = _loc21_.c;
                     _loc24_.d = _loc21_.d;
                     _loc24_.tx = _loc21_.tx;
                     _loc24_.ty = _loc21_.ty;
                  }
                  _loc18_ = Math.atan2(_loc21_.b,_loc21_.a);
                  if(_loc21_.a < 0 && _loc21_.d >= 0)
                  {
                     if(_loc18_ <= 0)
                     {
                        _loc18_ += Math.PI;
                     }
                     else
                     {
                        _loc18_ -= Math.PI;
                     }
                  }
                  if((_loc19_ = Math.sin(_loc18_)) < 0)
                  {
                     _loc19_ = -_loc19_;
                  }
                  if((_loc20_ = Math.cos(_loc18_)) < 0)
                  {
                     _loc20_ = -_loc20_;
                  }
                  _loc15_ = (_loc15_ * _loc20_ + _loc19_) / (_loc15_ * _loc19_ + _loc20_);
               }
               _loc8_ = _loc2_ > _loc7_.maxWidth ? _loc7_.maxWidth : (_loc2_ < _loc7_.minWidth ? _loc7_.minWidth : _loc2_);
               _loc9_ = _loc3_ > _loc7_.maxHeight ? _loc7_.maxHeight : (_loc3_ < _loc7_.minHeight ? _loc7_.minHeight : _loc3_);
               _loc17_ = _loc8_ / _loc9_;
               if(_loc15_ < _loc17_ && _loc16_ == ScaleMode.PROPORTIONAL_INSIDE || _loc15_ > _loc17_ && _loc16_ == ScaleMode.PROPORTIONAL_OUTSIDE)
               {
                  if((_loc8_ = _loc9_ * _loc15_) == 0)
                  {
                     _loc9_ = 0;
                  }
                  else if(_loc8_ > _loc7_.maxWidth)
                  {
                     _loc9_ = (_loc8_ = _loc7_.maxWidth) / _loc15_;
                  }
                  else if(_loc8_ < _loc7_.minWidth)
                  {
                     _loc9_ = (_loc8_ = _loc7_.minWidth) / _loc15_;
                  }
               }
               if(_loc15_ > _loc17_ && _loc16_ == ScaleMode.PROPORTIONAL_INSIDE || _loc15_ < _loc17_ && _loc16_ == ScaleMode.PROPORTIONAL_OUTSIDE)
               {
                  if((_loc9_ = _loc8_ / _loc15_) > _loc7_.maxHeight)
                  {
                     _loc8_ = (_loc9_ = _loc7_.maxHeight) * _loc15_;
                  }
                  else if(_loc9_ < _loc7_.minHeight)
                  {
                     _loc8_ = (_loc9_ = _loc7_.minHeight) * _loc15_;
                  }
               }
               if(_loc8_ != 0 && _loc9_ != 0)
               {
                  _loc22_ = _loc8_ / _loc14_.width;
                  _loc23_ = _loc9_ / _loc14_.height;
               }
               else
               {
                  _loc22_ = _loc23_ = 0;
               }
               if(_loc16_ != ScaleMode.HEIGHT_ONLY)
               {
                  if(_loc7_.calculateVisible)
                  {
                     _loc7_.scaleVisibleWidth(_loc22_);
                  }
                  else if(_loc21_.b != 0)
                  {
                     _loc21_.a *= _loc22_;
                     _loc21_.c *= _loc22_;
                     _loc12_.transform.matrix = _loc21_;
                  }
                  else
                  {
                     _loc12_.width *= _loc22_;
                  }
               }
               if(_loc16_ != ScaleMode.WIDTH_ONLY)
               {
                  if(_loc7_.calculateVisible)
                  {
                     _loc7_.scaleVisibleHeight(_loc23_);
                  }
                  else if(_loc21_.b != 0)
                  {
                     _loc21_.d *= _loc23_;
                     _loc21_.b *= _loc23_;
                     _loc12_.transform.matrix = _loc21_;
                  }
                  else
                  {
                     _loc12_.height *= _loc23_;
                  }
               }
            }
            if(_loc7_.hasDrawNow)
            {
               Object(_loc12_).drawNow();
            }
            if(_loc16_ != ScaleMode.NONE && _loc13_.x == 0 && _loc13_.y == 0)
            {
               if(_loc16_ != ScaleMode.HEIGHT_ONLY)
               {
                  _loc14_.width = _loc8_;
               }
               if(_loc16_ != ScaleMode.WIDTH_ONLY)
               {
                  _loc14_.height = _loc9_;
               }
            }
            else
            {
               _loc14_ = _loc7_.calculateVisible ? getVisibleBounds(_loc7_.boundsTarget,_parent) : _loc7_.boundsTarget.getBounds(_parent);
            }
            _loc10_ = _loc12_.x;
            _loc11_ = _loc12_.y;
            if(_loc7_.hAlign == AlignMode.LEFT)
            {
               _loc10_ += _loc4_ - _loc14_.x;
            }
            else if(_loc7_.hAlign == AlignMode.CENTER)
            {
               _loc10_ += _loc4_ - _loc14_.x + (_loc2_ - _loc14_.width) * 0.5;
            }
            else
            {
               _loc10_ += _loc4_ - _loc14_.x + (_loc2_ - _loc14_.width);
            }
            if(_loc7_.vAlign == AlignMode.TOP)
            {
               _loc11_ += _loc5_ - _loc14_.y;
            }
            else if(_loc7_.vAlign == AlignMode.CENTER)
            {
               _loc11_ += _loc5_ - _loc14_.y + (_loc3_ - _loc14_.height) * 0.5;
            }
            else
            {
               _loc11_ += _loc5_ - _loc14_.y + (_loc3_ - _loc14_.height);
            }
            if(_loc7_.roundPosition)
            {
               _loc10_ = _loc10_ + 0.5 >> 0;
               _loc11_ = _loc11_ + 0.5 >> 0;
            }
            _loc12_.x = _loc10_;
            _loc12_.y = _loc11_;
            if(_loc7_.mask)
            {
               _loc7_.mask.transform.matrix = _loc6_;
            }
            _loc7_ = _loc7_.next;
         }
         if(_hasListener)
         {
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(!_tweenMode)
         {
            update();
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(!_tweenMode)
         {
            update();
         }
      }
      
      public function release(param1:DisplayObject) : Boolean
      {
         var _loc2_:AutoFitItem = getItem(param1);
         if(_loc2_ == null)
         {
            return false;
         }
         if(_loc2_.mask != null)
         {
            if(_loc2_.mask.parent)
            {
               _loc2_.mask.parent.removeChild(_loc2_.mask);
            }
            param1.mask = null;
            _loc2_.mask = null;
         }
         if(_loc2_.next)
         {
            _loc2_.next.prev = _loc2_.prev;
         }
         if(_loc2_.prev)
         {
            _loc2_.prev.next = _loc2_.next;
         }
         else if(_loc2_ == _rootItem)
         {
            _rootItem = _loc2_.next;
         }
         _loc2_.next = _loc2_.prev = null;
         _loc2_.boundsTarget = null;
         _loc2_.target = null;
         return true;
      }
      
      public function set preview(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:AutoFitItem = null;
         _preview = param1;
         if(this.parent == _parent)
         {
            _parent.removeChild(this);
         }
         if(param1)
         {
            _loc2_ = _rootItem == null ? 0 : 999999999;
            _loc4_ = _rootItem;
            while(_loc4_)
            {
               if(_loc4_.target.parent == _parent)
               {
                  _loc3_ = uint(_parent.getChildIndex(_loc4_.target));
                  if(_loc3_ < _loc2_)
                  {
                     _loc2_ = _loc3_;
                  }
               }
               _loc4_ = _loc4_.next;
            }
            _parent.addChildAt(this,_loc2_);
            this.visible = true;
         }
      }
      
      public function getAttachedObjects() : Array
      {
         var _loc1_:Array = [];
         var _loc2_:uint = 0;
         var _loc3_:AutoFitItem = _rootItem;
         while(_loc3_)
         {
            var _loc4_:*;
            _loc1_[_loc4_ = _loc2_++] = _loc3_.target;
            _loc3_ = _loc3_.next;
         }
         return _loc1_;
      }
      
      override public function set scaleX(param1:Number) : void
      {
         super.scaleX = param1;
         update();
      }
      
      protected function _redraw(param1:uint) : void
      {
         _previewColor = param1;
         var _loc2_:Graphics = this.graphics;
         _loc2_.clear();
         _loc2_.beginFill(_previewColor,1);
         _loc2_.drawRect(0,0,_width,_height);
         _loc2_.endFill();
      }
      
      protected function getItem(param1:DisplayObject) : AutoFitItem
      {
         var _loc2_:AutoFitItem = _rootItem;
         while(_loc2_)
         {
            if(_loc2_.target == param1)
            {
               return _loc2_;
            }
            _loc2_ = _loc2_.next;
         }
         return null;
      }
      
      public function disableTweenMode() : void
      {
         _tweenMode = false;
      }
      
      public function enableTweenMode() : void
      {
         _tweenMode = true;
      }
      
      override public function set scaleY(param1:Number) : void
      {
         super.scaleY = param1;
         update();
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         if(!_tweenMode)
         {
            update();
         }
      }
      
      override public function set y(param1:Number) : void
      {
         super.y = param1;
         if(!_tweenMode)
         {
            update();
         }
      }
      
      public function destroy() : void
      {
         var _loc1_:AutoFitItem = null;
         if(_preview)
         {
            this.preview = false;
         }
         var _loc2_:AutoFitItem = _rootItem;
         while(_loc2_)
         {
            _loc1_ = _loc2_.next;
            release(_loc2_.target);
            _loc2_ = _loc1_;
         }
         if(_bd != null)
         {
            _bd.dispose();
            _bd = null;
         }
         _parent = null;
      }
      
      override public function set rotation(param1:Number) : void
      {
         trace("Warning: AutoFitArea instances should not be rotated.");
      }
      
      public function set previewColor(param1:uint) : void
      {
         _redraw(param1);
      }
   }
}

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.Matrix;
import flash.geom.Rectangle;

class AutoFitItem
{
    
   
   public var matrix:Matrix;
   
   public var maxWidth:Number;
   
   public var prev:AutoFitItem;
   
   public var scaleMode:String;
   
   public var target:DisplayObject;
   
   public var aspectRatio:Number;
   
   public var minWidth:Number;
   
   public var roundPosition:Boolean;
   
   public var minHeight:Number;
   
   public var hasCustomRatio:Boolean;
   
   public var maxHeight:Number;
   
   public var mask:Shape;
   
   public var vAlign:String;
   
   public var next:AutoFitItem;
   
   public var hasDrawNow:Boolean;
   
   public var calculateVisible:Boolean;
   
   public var bounds:Rectangle;
   
   public var hAlign:String;
   
   public var boundsTarget:DisplayObject;
   
   public function AutoFitItem(param1:DisplayObject, param2:Object, param3:AutoFitItem)
   {
      super();
      this.target = param1;
      if(param2 == null)
      {
         param2 = {};
      }
      this.scaleMode = String(param2.scaleMode) || "proportionalInside";
      this.hAlign = String(param2.hAlign) || "center";
      this.vAlign = String(param2.vAlign) || "center";
      this.minWidth = Number(param2.minWidth) || 0;
      this.maxWidth = isNaN(param2.maxWidth) ? 999999999 : Number(param2.maxWidth);
      this.minHeight = Number(param2.minHeight) || 0;
      this.maxHeight = isNaN(param2.maxHeight) ? 999999999 : Number(param2.maxHeight);
      this.roundPosition = Boolean(param2.roundPosition);
      this.boundsTarget = param2.customBoundsTarget is DisplayObject ? param2.customBoundsTarget : this.target;
      this.matrix = param1.transform.matrix;
      this.calculateVisible = Boolean(param2.calculateVisible);
      this.hasDrawNow = this.target.hasOwnProperty("drawNow");
      if(this.hasDrawNow)
      {
         Object(this.target).drawNow();
      }
      if(!isNaN(param2.customAspectRatio))
      {
         this.aspectRatio = param2.customAspectRatio;
         this.hasCustomRatio = true;
      }
      if(param3)
      {
         param3.prev = this;
         this.next = param3;
      }
   }
   
   public function scaleVisibleHeight(param1:Number) : void
   {
      var _loc2_:Matrix = this.target.transform.matrix;
      _loc2_.b *= param1;
      _loc2_.d *= param1;
      this.target.transform.matrix = _loc2_;
      if(param1 != 0)
      {
         this.matrix = _loc2_;
      }
   }
   
   public function scaleVisibleWidth(param1:Number) : void
   {
      var _loc2_:Matrix = this.target.transform.matrix;
      _loc2_.a *= param1;
      _loc2_.c *= param1;
      this.target.transform.matrix = _loc2_;
      if(param1 != 0)
      {
         this.matrix = _loc2_;
      }
   }
   
   public function setVisibleWidth(param1:Number) : void
   {
      var _loc4_:Number = NaN;
      var _loc2_:Matrix = this.target.transform.matrix;
      if(_loc2_.a == 0 && _loc2_.c == 0 || _loc2_.d == 0 && _loc2_.b == 0)
      {
         _loc2_.a = this.matrix.a;
         _loc2_.c = this.matrix.c;
      }
      var _loc3_:Number = _loc2_.a < 0 ? -_loc2_.a * this.bounds.width : _loc2_.a * this.bounds.width;
      _loc3_ += _loc2_.c < 0 ? -_loc2_.c * this.bounds.height : _loc2_.c * this.bounds.height;
      if(_loc3_ != 0)
      {
         _loc4_ = param1 / _loc3_;
         _loc2_.a *= _loc4_;
         _loc2_.c *= _loc4_;
         this.target.transform.matrix = _loc2_;
         if(param1 != 0)
         {
            this.matrix = _loc2_;
         }
      }
   }
   
   public function setVisibleHeight(param1:Number) : void
   {
      var _loc4_:Number = NaN;
      var _loc2_:Matrix = this.target.transform.matrix;
      if(_loc2_.a == 0 && _loc2_.c == 0 || _loc2_.d == 0 && _loc2_.b == 0)
      {
         _loc2_.b = this.matrix.b;
         _loc2_.d = this.matrix.d;
      }
      var _loc3_:Number = _loc2_.b < 0 ? -_loc2_.b * this.bounds.width : _loc2_.b * this.bounds.width;
      _loc3_ += _loc2_.d < 0 ? -_loc2_.d * this.bounds.height : _loc2_.d * this.bounds.height;
      if(_loc3_ != 0)
      {
         _loc4_ = param1 / _loc3_;
         _loc2_.b *= _loc4_;
         _loc2_.d *= _loc4_;
         this.target.transform.matrix = _loc2_;
         if(param1 != 0)
         {
            this.matrix = _loc2_;
         }
      }
   }
}
