package com.taomee.seer2.app.activity.snow
{
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.taomee.utils.DisplayUtil;
   
   public class Snow extends Sprite
   {
       
      
      private var snowCount:uint;
      
      private var snowArr:Array;
      
      private var snowSp:Array;
      
      private var minY:Number = 500;
      
      public function Snow()
      {
         this.snowArr = new Array();
         this.snowSp = new Array();
         super();
         this.snowCount = 30;
         this.CreateSnows();
         addEventListener(Event.ENTER_FRAME,this.moveSnow);
      }
      
      private function CreateOneSnow() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215);
         _loc1_.graphics.drawCircle(0,0,Math.random() * 1 + 3);
         return _loc1_;
      }
      
      private function CreateSnows() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:Shape = null;
         _loc1_ = 0;
         while(_loc1_ < this.snowCount)
         {
            _loc2_ = this.CreateOneSnow();
            addChild(_loc2_);
            this.snowSp.push(_loc2_);
            _loc2_.x = 960 * Math.random() - 100;
            _loc2_.y = 560 * Math.random();
            _loc2_.name = "snow" + _loc1_;
            _loc1_++;
         }
      }
      
      private function moveSnow(param1:Event) : void
      {
         var _loc3_:Shape = null;
         var _loc2_:uint = 0;
         while(_loc2_ < this.snowCount)
         {
            _loc3_ = getChildByName("snow" + _loc2_) as Shape;
            _loc3_.x += Math.random() * 2;
            _loc3_.y += Math.random() * 3 + 1;
            _loc3_.rotation += Math.random() * 5 + 1;
            this.checkSnow(_loc3_);
            _loc2_++;
         }
      }
      
      private function checkSnow(param1:Shape) : void
      {
         if(param1.y >= this.minY - 2)
         {
            if(param1.x > 960 || param1.x < 0)
            {
               this.randomPoint(param1);
               return;
            }
            if(param1.y > 560)
            {
               this.randomPoint(param1);
               return;
            }
         }
      }
      
      private function randomPoint(param1:Shape) : void
      {
         param1.x = 960 * Math.random() - 100;
         param1.y = 0;
      }
      
      private function setSnowLand(param1:Shape) : void
      {
         var _loc2_:Shape = this.CreateOneSnow();
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         addChild(_loc2_);
         this.snowArr.push(_loc2_);
         this.minY = Math.min(_loc2_.y,this.minY);
         this.randomPoint(param1);
      }
      
      public function dispose() : void
      {
         var _loc1_:Shape = null;
         var _loc2_:Shape = null;
         for each(_loc1_ in this.snowSp)
         {
            DisplayUtil.removeForParent(_loc1_);
         }
         for each(_loc2_ in this.snowArr)
         {
            DisplayUtil.removeForParent(_loc2_);
         }
         this.snowArr = null;
         this.snowSp = null;
         removeEventListener(Event.ENTER_FRAME,this.moveSnow);
      }
   }
}
