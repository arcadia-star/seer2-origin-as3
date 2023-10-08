package com.greensock.loading.display
{
   import com.greensock.loading.core.LoaderItem;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ContentDisplay extends Sprite
   {
      
      protected static var _transformProps:Object = {
         "x":1,
         "y":1,
         "scaleX":1,
         "scaleY":1,
         "rotation":1,
         "alpha":1,
         "visible":true,
         "blendMode":"normal",
         "centerRegistration":false,
         "crop":false,
         "scaleMode":"stretch",
         "hAlign":"center",
         "vAlign":"center"
      };
       
      
      protected var _scaleMode:String = "stretch";
      
      protected var _fitWidth:Number;
      
      protected var _fitHeight:Number;
      
      protected var _hAlign:String = "center";
      
      public var data;
      
      protected var _loader:LoaderItem;
      
      protected var _centerRegistration:Boolean;
      
      protected var _vAlign:String = "center";
      
      protected var _rawContent:DisplayObject;
      
      protected var _cropContainer:Sprite;
      
      public var gcProtect;
      
      protected var _bgAlpha:Number = 0;
      
      protected var _bgColor:uint;
      
      protected var _crop:Boolean;
      
      public function ContentDisplay(param1:LoaderItem)
      {
         super();
         this.loader = param1;
      }
      
      public function get scaleMode() : String
      {
         return _scaleMode;
      }
      
      public function get crop() : Boolean
      {
         return _crop;
      }
      
      public function get loader() : LoaderItem
      {
         return _loader;
      }
      
      public function get fitHeight() : Number
      {
         return _fitHeight;
      }
      
      public function get bgColor() : uint
      {
         return _bgColor;
      }
      
      public function dispose(param1:Boolean = true, param2:Boolean = true) : void
      {
         this.rawContent = null;
         if(this.parent != null)
         {
            this.parent.removeChild(this);
         }
         this.gcProtect = null;
         if(_loader != null)
         {
            if(param1)
            {
               _loader.unload();
            }
            if(param2)
            {
               _loader.dispose(false);
               _loader = null;
            }
         }
      }
      
      public function set scaleMode(param1:String) : void
      {
         if(param1 == "none" && _rawContent != null)
         {
            _rawContent.scaleX = _rawContent.scaleY = 1;
         }
         _scaleMode = param1;
         _update();
      }
      
      public function set crop(param1:Boolean) : void
      {
         _crop = param1;
         _update();
      }
      
      public function set loader(param1:LoaderItem) : void
      {
         var _loc2_:* = null;
         var _loc3_:String = null;
         _loader = param1;
         if(_loader == null)
         {
            return;
         }
         if(!_loader.hasOwnProperty("setContentDisplay"))
         {
            throw new Error("Incompatible loader used for a ContentDisplay");
         }
         this.name = _loader.name;
         for(_loc3_ in _transformProps)
         {
            if(_loc3_ in _loader.vars)
            {
               _loc2_ = typeof _transformProps[_loc3_];
               this[_loc3_] = _loc2_ == "number" ? Number(_loader.vars[_loc3_]) : (_loc2_ == "string" ? String(_loader.vars[_loc3_]) : Boolean(_loader.vars[_loc3_]));
            }
         }
         _bgColor = uint(_loader.vars.bgColor);
         _bgAlpha = "bgAlpha" in _loader.vars ? Number(_loader.vars.bgAlpha) : ("bgColor" in _loader.vars ? 1 : 0);
         _fitWidth = "fitWidth" in _loader.vars ? Number(_loader.vars.fitWidth) : Number(_loader.vars.width);
         _fitHeight = "fitHeight" in _loader.vars ? Number(_loader.vars.fitHeight) : Number(_loader.vars.height);
         _update();
         if(_loader.vars.container is DisplayObjectContainer)
         {
            (_loader.vars.container as DisplayObjectContainer).addChild(this);
         }
         if(_loader.content != this)
         {
            (_loader as Object).setContentDisplay(this);
         }
         this.rawContent = (_loader as Object).rawContent;
      }
      
      public function get centerRegistration() : Boolean
      {
         return _centerRegistration;
      }
      
      public function get vAlign() : String
      {
         return _vAlign;
      }
      
      public function set fitHeight(param1:Number) : void
      {
         _fitHeight = param1;
         _update();
      }
      
      public function get rawContent() : *
      {
         return _rawContent;
      }
      
      public function set bgAlpha(param1:Number) : void
      {
         _bgAlpha = param1;
         _update();
      }
      
      public function get fitWidth() : Number
      {
         return _fitWidth;
      }
      
      public function get bgAlpha() : Number
      {
         return _bgAlpha;
      }
      
      public function set bgColor(param1:uint) : void
      {
         _bgColor = param1;
         _update();
      }
      
      public function set centerRegistration(param1:Boolean) : void
      {
         _centerRegistration = param1;
         _update();
      }
      
      public function set rawContent(param1:*) : void
      {
         if(_rawContent != null && _rawContent != param1)
         {
            if(_rawContent.parent == this)
            {
               removeChild(_rawContent);
            }
            else if(_cropContainer != null && _rawContent.parent == _cropContainer)
            {
               _cropContainer.removeChild(_rawContent);
               removeChild(_cropContainer);
               _cropContainer = null;
            }
         }
         _rawContent = param1 as DisplayObject;
         if(_rawContent == null)
         {
            return;
         }
         addChildAt(_rawContent as DisplayObject,0);
         _update();
      }
      
      public function set vAlign(param1:String) : void
      {
         _vAlign = param1;
         _update();
      }
      
      protected function _update() : void
      {
         var _loc6_:Matrix = null;
         var _loc7_:LoaderInfo = null;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc1_:Number = _centerRegistration && _fitWidth > 0 ? _fitWidth / -2 : 0;
         var _loc2_:Number = _centerRegistration && _fitHeight > 0 ? _fitHeight / -2 : 0;
         graphics.clear();
         if(_fitWidth > 0 && _fitHeight > 0)
         {
            graphics.beginFill(_bgColor,_bgAlpha);
            graphics.drawRect(_loc1_,_loc2_,_fitWidth,_fitHeight);
            graphics.endFill();
         }
         if(_rawContent == null)
         {
            return;
         }
         var _loc3_:DisplayObject = _rawContent;
         var _loc4_:Number = _loc3_.width;
         var _loc5_:Number = _loc3_.height;
         if(_loader.hasOwnProperty("getClass"))
         {
            _loc6_ = _loc3_.transform.matrix;
            _loc4_ = (_loc7_ = _loc3_ is Loader ? Object(_loc3_).contentLoaderInfo : _loc3_.loaderInfo).width * Math.abs(_loc6_.a) + _loc7_.height * Math.abs(_loc6_.b);
            _loc5_ = _loc7_.width * Math.abs(_loc6_.c) + _loc7_.height * Math.abs(_loc6_.d);
         }
         if(_fitWidth > 0 && _fitHeight > 0)
         {
            _loc8_ = _fitWidth;
            _loc9_ = _fitHeight;
            _loc10_ = _loc8_ - _loc4_;
            _loc11_ = _loc9_ - _loc5_;
            if(_scaleMode != "none")
            {
               _loc12_ = _loc8_ / _loc9_;
               if((_loc13_ = _loc4_ / _loc5_) < _loc12_ && _scaleMode == "proportionalInside" || _loc13_ > _loc12_ && _scaleMode == "proportionalOutside")
               {
                  _loc8_ = _loc9_ * _loc13_;
               }
               if(_loc13_ > _loc12_ && _scaleMode == "proportionalInside" || _loc13_ < _loc12_ && _scaleMode == "proportionalOutside")
               {
                  _loc9_ = _loc8_ / _loc13_;
               }
               if(_scaleMode != "heightOnly")
               {
                  _loc3_.width *= _loc8_ / _loc4_;
                  _loc10_ = _fitWidth - _loc8_;
               }
               if(_scaleMode != "widthOnly")
               {
                  _loc3_.height *= _loc9_ / _loc5_;
                  _loc11_ = _fitHeight - _loc9_;
               }
            }
            if(_hAlign == "left")
            {
               _loc10_ = 0;
            }
            else if(_hAlign != "right")
            {
               _loc10_ /= 2;
            }
            if(_vAlign == "top")
            {
               _loc11_ = 0;
            }
            else if(_vAlign != "bottom")
            {
               _loc11_ /= 2;
            }
            if(_crop)
            {
               if(_cropContainer == null || _loc3_.parent != _cropContainer)
               {
                  _cropContainer = new Sprite();
                  this.addChildAt(_cropContainer,this.getChildIndex(_loc3_));
                  _cropContainer.addChild(_loc3_);
               }
               _cropContainer.x = _loc1_;
               _cropContainer.y = _loc2_;
               _cropContainer.scrollRect = new Rectangle(0,0,_fitWidth,_fitHeight);
               _loc3_.x = _loc10_;
               _loc3_.y = _loc11_;
            }
            else
            {
               if(_cropContainer != null)
               {
                  this.addChildAt(_loc3_,this.getChildIndex(_cropContainer));
                  _cropContainer = null;
               }
               _loc3_.x = _loc1_ + _loc10_;
               _loc3_.y = _loc2_ + _loc11_;
            }
         }
         else
         {
            _loc3_.x = _centerRegistration ? _loc4_ / -2 : 0;
            _loc3_.y = _centerRegistration ? _loc5_ / -2 : 0;
         }
      }
      
      public function set fitWidth(param1:Number) : void
      {
         _fitWidth = param1;
         _update();
      }
      
      public function set hAlign(param1:String) : void
      {
         _hAlign = param1;
         _update();
      }
      
      public function get hAlign() : String
      {
         return _hAlign;
      }
   }
}
