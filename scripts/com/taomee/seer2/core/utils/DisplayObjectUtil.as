package com.taomee.seer2.core.utils
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.taomee.filter.ColorFilter;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   
   public class DisplayObjectUtil
   {
       
      
      public function DisplayObjectUtil()
      {
         super();
      }
      
      public static function bringToTop(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = param1.parent;
         if(_loc2_ != null)
         {
            _loc2_.setChildIndex(param1,_loc2_.numChildren - 1);
         }
      }
      
      public static function removeAllChildren(param1:DisplayObjectContainer) : void
      {
         while(param1.numChildren > 0)
         {
            param1.removeChildAt(0);
         }
      }
      
      public static function disableButton(param1:SimpleButton) : void
      {
         param1.mouseEnabled = false;
         ColorFilter.setGrayscale(param1);
      }
      
      public static function enableButton(param1:SimpleButton) : void
      {
         param1.filters = [];
         param1.mouseEnabled = true;
      }
      
      public static function disableSprite(param1:Sprite) : void
      {
         if(param1)
         {
            param1.mouseChildren = false;
            param1.mouseEnabled = false;
         }
      }
      
      public static function enableSprite(param1:Sprite) : void
      {
         if(param1)
         {
            param1.mouseChildren = true;
            param1.mouseEnabled = true;
         }
      }
      
      public static function disableMovieClip(param1:MovieClip) : void
      {
         if(param1)
         {
            param1.mouseChildren = false;
            param1.mouseEnabled = false;
            ColorFilter.setGrayscale(param1);
         }
      }
      
      public static function enableMovieClip(param1:MovieClip) : void
      {
         if(param1)
         {
            param1.mouseChildren = true;
            param1.mouseEnabled = true;
            param1.filters = [];
         }
      }
      
      public static function disableButtonMode(param1:Sprite) : void
      {
         param1.buttonMode = false;
         disableSprite(param1);
      }
      
      public static function enableButtonMode(param1:Sprite) : void
      {
         param1.buttonMode = true;
         enableSprite(param1);
      }
      
      public static function recoverDisplayObject(param1:DisplayObject) : void
      {
         param1.filters = [];
      }
      
      public static function darkenDisplayObject(param1:DisplayObject) : void
      {
         param1.filters = [];
         ColorFilter.setBrightness(param1,-50);
      }
      
      public static function fightCapsuleBrightness(param1:DisplayObject) : void
      {
         param1.filters = [];
         ColorFilter.setBrightness(param1,-80);
      }
      
      public static function grayDisplayObject(param1:DisplayObject) : void
      {
         param1.filters = [];
         ColorFilter.setGrayscale(param1);
      }
      
      public static function changeColor(param1:DisplayObject, param2:uint) : void
      {
         var _loc3_:uint = uint(param2 >> 16 & 255);
         var _loc4_:uint = uint(param2 >> 8 & 255);
         var _loc5_:uint = uint(param2 & 255);
         var _loc6_:ColorTransform = new ColorTransform(0,0,0,1,_loc3_,_loc4_,_loc5_,0);
         param1.transform.colorTransform = _loc6_;
      }
      
      public static function removeFromParent(param1:DisplayObject) : void
      {
         if(Boolean(param1) && param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function setBoundary(param1:DisplayObject, param2:Rectangle) : void
      {
         setSize(param1,param2.width,param2.height);
         DisplayUtil.align(param1,AlignType.MIDDLE_CENTER,param2);
      }
      
      public static function setSize(param1:DisplayObject, param2:Number, param3:Number) : void
      {
         var _loc6_:Number = NaN;
         if(isNaN(param2) || isNaN(param3))
         {
            return;
         }
         var _loc4_:Number = param2 / param1.width;
         var _loc5_:Number = param3 / param1.height;
         if(_loc4_ > _loc5_)
         {
            _loc6_ = _loc5_;
         }
         else
         {
            _loc6_ = _loc4_;
         }
         param1.scaleX = param1.scaleY = _loc6_;
      }
      
      public static function ajustCoordinate(param1:DisplayObject) : void
      {
         var _loc2_:DisplayObjectContainer = param1.parent;
         if(_loc2_ == null)
         {
            return;
         }
         var _loc3_:Rectangle = param1.getBounds(_loc2_);
         param1.x = -_loc3_.left - _loc3_.width / 2;
         param1.y = -_loc3_.top - _loc3_.height;
      }
      
      public static function getAlignPostion(param1:DisplayObject, param2:DisplayObjectContainer = null, param3:int = 4, param4:Point = null) : Point
      {
         if(param2 == null)
         {
            param2 = LayerManager.stage;
         }
         if(param4 == null)
         {
            param4 = new Point();
         }
         var _loc5_:Rectangle = param1.getBounds(param2);
         var _loc6_:Point = new Point();
         switch(param3)
         {
            case AlignType.TOP_LEFT:
               _loc6_.x = _loc5_.x;
               _loc6_.y = _loc5_.y;
               break;
            case AlignType.TOP_CENTER:
               _loc6_.x = _loc5_.x + _loc5_.width / 2;
               _loc6_.y = _loc5_.y;
               break;
            case AlignType.TOP_RIGHT:
               _loc6_.x = _loc5_.x + _loc5_.width;
               _loc6_.y = _loc5_.y;
               break;
            case AlignType.MIDDLE_LEFT:
               _loc6_.x = _loc5_.x;
               _loc6_.y = _loc5_.y + _loc5_.height / 2;
               break;
            case AlignType.MIDDLE_CENTER:
               _loc6_.x = _loc5_.x + _loc5_.width / 2;
               _loc6_.y = _loc5_.y + _loc5_.height / 2;
               break;
            case AlignType.MIDDLE_RIGHT:
               _loc6_.x = _loc5_.x + _loc5_.width;
               _loc6_.y = _loc5_.y + _loc5_.height / 2;
               break;
            case AlignType.BOTTOM_LEFT:
               _loc6_.x = _loc5_.x;
               _loc6_.y = _loc5_.y + _loc5_.height;
               break;
            case AlignType.BOTTOM_CENTER:
               _loc6_.x = _loc5_.x + _loc5_.width / 2;
               _loc6_.y = _loc5_.y + _loc5_.height;
               break;
            case AlignType.BOTTOM_RIGHT:
               _loc6_.x = _loc5_.x + _loc5_.width;
               _loc6_.y = _loc5_.y + _loc5_.height;
         }
         return _loc6_.add(param4);
      }
      
      public static function createHotArea(param1:int, param2:int) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         _loc3_.graphics.beginFill(16777215,0);
         _loc3_.graphics.drawRect(0,0,param1,param2);
         _loc3_.graphics.endFill();
         return _loc3_;
      }
      
      public static function showScore(param1:MovieClip, param2:uint, param3:uint = 0, param4:Boolean = false, param5:Boolean = false) : void
      {
         var _loc10_:uint = 0;
         var _loc11_:uint = 0;
         var _loc12_:Number = NaN;
         if(param1 == null)
         {
            return;
         }
         var _loc6_:uint = 0;
         var _loc7_:uint = param3 * 10;
         var _loc8_:Array;
         var _loc9_:uint = (_loc8_ = param2.toString().split("").reverse()).length;
         _loc6_ = 0;
         while(param1["num_" + _loc6_] != null)
         {
            param1["num_" + _loc6_].gotoAndStop(1 + _loc7_);
            param1["num_" + _loc6_].visible = param4;
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc9_)
         {
            if(_loc8_[_loc6_] != undefined)
            {
               if(param1["num_" + _loc6_])
               {
                  param1["num_" + _loc6_].visible = true;
                  param1["num_" + _loc6_].gotoAndStop(uint(_loc8_[_loc6_]) + 1 + _loc7_);
               }
            }
            _loc6_++;
         }
         if(!param4 && param5)
         {
            _loc12_ = ((_loc11_ = (_loc10_ = Math.ceil((param1.getChildAt(0) as MovieClip).width)) * param1.numChildren) - _loc9_ * _loc10_) / 2;
            _loc6_ = 0;
            while(_loc6_ < _loc9_)
            {
               if(_loc8_[_loc6_] != undefined)
               {
                  if(param1["num_" + _loc6_])
                  {
                     (param1["num_" + _loc6_] as MovieClip).x = _loc12_ + (_loc9_ - _loc6_ - 1) * (_loc10_ + 2);
                  }
               }
               _loc6_++;
            }
         }
      }
   }
}
