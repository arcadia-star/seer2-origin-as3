package com.taomee.seer2.module.login.util
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class DisplayObjectUtil
   {
       
      
      public function DisplayObjectUtil()
      {
         super();
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
         param1.alpha = 0.4;
         param1.mouseEnabled = false;
      }
      
      public static function enableButton(param1:SimpleButton) : void
      {
         param1.alpha = 1;
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
      
      public static function removeFromParent(param1:DisplayObject) : void
      {
         if(Boolean(param1) && param1.parent != null)
         {
            param1.parent.removeChild(param1);
         }
      }
      
      public static function align(param1:DisplayObject, param2:int = 4, param3:Rectangle = null, param4:Point = null) : void
      {
         var _loc5_:Rectangle = null;
         if(param3 == null)
         {
            if(!param1.stage)
            {
               param1.addEventListener(Event.ADDED_TO_STAGE,createFun(onAddStage,param2,param4),false,0,true);
               return;
            }
            _loc5_ = new Rectangle(0,0,param1.stage.stageWidth,param1.stage.stageHeight);
         }
         else
         {
            _loc5_ = param3.clone();
         }
         align2(param1,_loc5_,param2,param4);
      }
      
      private static function onAddStage(param1:Event, param2:int, param3:Point) : void
      {
         var _loc5_:DisplayObject;
         (_loc5_ = param1.currentTarget as DisplayObject).removeEventListener(Event.ADDED_TO_STAGE,arguments.callee);
         align2(_loc5_,new Rectangle(0,0,_loc5_.stage.stageWidth,_loc5_.stage.stageHeight),param2,param3);
      }
      
      private static function align2(param1:DisplayObject, param2:Rectangle, param3:int, param4:Point) : void
      {
         if(param4)
         {
            param2.offsetPoint(param4);
         }
         var _loc5_:Rectangle = param1.getRect(param1);
         var _loc6_:Number = param2.width - param1.width;
         var _loc7_:Number = param2.height - param1.height;
         switch(param3)
         {
            case AlignType.TOP_LEFT:
               param1.x = param2.x;
               param1.y = param2.y;
               break;
            case AlignType.TOP_CENTER:
               param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
               param1.y = param2.y;
               break;
            case AlignType.TOP_RIGHT:
               param1.x = param2.x + _loc6_ - _loc5_.x;
               param1.y = param2.y;
               break;
            case AlignType.MIDDLE_LEFT:
               param1.x = param2.x;
               param1.y = param2.y + _loc7_ / 2 - _loc5_.x;
               break;
            case AlignType.MIDDLE_CENTER:
               param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
               param1.y = param2.y + _loc7_ / 2 - _loc5_.y;
               break;
            case AlignType.MIDDLE_RIGHT:
               param1.x = param2.x + _loc6_ - _loc5_.x;
               param1.y = param2.y + _loc7_ / 2 - _loc5_.y;
               break;
            case AlignType.BOTTOM_LEFT:
               param1.x = param2.x;
               param1.y = param2.y + _loc7_ - _loc5_.y;
               break;
            case AlignType.BOTTOM_CENTER:
               param1.x = param2.x + _loc6_ / 2 - _loc5_.x;
               param1.y = param2.y + _loc7_ - _loc5_.y;
               break;
            case AlignType.BOTTOM_RIGHT:
               param1.x = param2.x + _loc6_ - _loc5_.x;
               param1.y = param2.y + _loc7_ - _loc5_.y;
         }
      }
      
      private static function createFun(param1:Function, ... rest) : Function
      {
         var func:Function = param1;
         var args:Array = rest;
         var f:Function = function():*
         {
            var _loc2_:Function = arguments.callee.func;
            var _loc3_:Array = arguments.concat(args);
            return _loc2_.apply(null,_loc3_);
         };
         f["func"] = func;
         return f;
      }
   }
}
