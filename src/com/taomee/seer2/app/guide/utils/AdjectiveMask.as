package com.taomee.seer2.app.guide.utils
{
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class AdjectiveMask
   {
      
      private static var _instance:AdjectiveMask = null;
       
      
      private var _MainMask:Sprite;
      
      private var _view:Sprite;
      
      private var _target:* = null;
      
      private var _parent:* = null;
      
      public function AdjectiveMask(param1:SingletonClass)
      {
         this._MainMask = new Sprite();
         this._view = new Sprite();
         super();
      }
      
      public static function get instance() : AdjectiveMask
      {
         if(_instance == null)
         {
            _instance = new AdjectiveMask(new SingletonClass());
         }
         return _instance;
      }
      
      public function showMask(param1:*, param2:*) : void
      {
      }
      
      public function closeMask(param1:*) : void
      {
      }
      
      public function makeMask(param1:Vector.<Rectangle>, param2:int = 0, param3:int = 0, param4:int = 760, param5:int = 600, param6:Number = 0.4, param7:uint = 0) : Sprite
      {
         this._MainMask.graphics.clear();
         this._MainMask.alpha = param6;
         this._MainMask.graphics.lineStyle(0);
         this._MainMask.graphics.beginFill(param7);
         this._MainMask.graphics.drawRect(param2,param3,param4,param5);
         var _loc8_:int = int(param1.length);
         this._MainMask.graphics.lineStyle(5,16763904);
         var _loc9_:int = 0;
         while(_loc9_ < _loc8_)
         {
            this._MainMask.graphics.drawRect(param1[_loc9_].x,param1[_loc9_].y,param1[_loc9_].width,param1[_loc9_].height);
            _loc9_++;
         }
         this._MainMask.graphics.endFill();
         return this._MainMask;
      }
      
      private function drawTargBorder(param1:int, param2:int, param3:int, param4:int, param5:uint = 1044480, param6:Number = 2) : void
      {
         this._MainMask.graphics.lineStyle(param6,param5);
         this._MainMask.graphics.moveTo(param1,param2);
         this._MainMask.graphics.lineTo(param1 + param3,param2);
         this._MainMask.graphics.lineTo(param1 + param3,param2 + param4);
         this._MainMask.graphics.lineTo(param1,param2 + param4);
         this._MainMask.graphics.lineTo(param1,param2);
         this._MainMask.graphics.endFill();
      }
      
      public function makeView(param1:int = 0, param2:int = 0, param3:int = 100, param4:int = 100) : void
      {
         this._view.graphics.clear();
         this._view.alpha = 0.5;
         this._view.graphics.lineStyle(5,16711680);
         this._view.graphics.beginFill(16777215);
         this._view.graphics.drawRect(param1,param2,param3,param4);
      }
      
      public function moveView(param1:int = 0, param2:int = 0, param3:int = 100, param4:int = 100) : void
      {
         this._view.x = param1 - (this._view.width / 2 - param3 / 2);
         this._view.y = param2 - (this._view.height / 2 - param4 / 2);
      }
      
      public function clearMask() : void
      {
      }
      
      public function additionalItem() : void
      {
      }
      
      public function close() : void
      {
      }
   }
}

class SingletonClass
{
    
   
   public function SingletonClass()
   {
      super();
   }
}
