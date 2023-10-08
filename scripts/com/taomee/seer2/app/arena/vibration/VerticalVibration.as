package com.taomee.seer2.app.arena.vibration
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class VerticalVibration
   {
       
      
      private var _target:DisplayObject;
      
      private var _targetRecordX:int;
      
      private var _targetRecordY:int;
      
      private var _vibrationPostionVec:Vector.<Point>;
      
      private var _vibrationIndex:int;
      
      public function VerticalVibration()
      {
         super();
         this.initialize();
      }
      
      private function initialize() : void
      {
         this._vibrationPostionVec = new Vector.<Point>();
         this._vibrationPostionVec.push(new Point(-5,-5));
         this._vibrationPostionVec.push(new Point(5,5));
         this._vibrationPostionVec.push(new Point(-4,-4));
         this._vibrationPostionVec.push(new Point(4,4));
         this._vibrationPostionVec.push(new Point(-3,-3));
         this._vibrationPostionVec.push(new Point(3,3));
         this._vibrationPostionVec.push(new Point(-2,-2));
         this._vibrationPostionVec.push(new Point(2,2));
         this._vibrationPostionVec.push(new Point(-1,-1));
         this._vibrationPostionVec.push(new Point(1,1));
      }
      
      public function vibrate(param1:DisplayObject) : void
      {
         if(this._vibrationIndex != 0)
         {
            return;
         }
         this._target = param1;
         this._vibrationIndex = 0;
         this._targetRecordX = this._target.x;
         this._targetRecordY = this._target.y;
         this._target.addEventListener(Event.ENTER_FRAME,this.onTargetEnterFrame);
      }
      
      private function onTargetEnterFrame(param1:Event) : void
      {
         if(this._vibrationIndex <= this._vibrationPostionVec.length - 1)
         {
            this._target.x = this._targetRecordX + this._vibrationPostionVec[this._vibrationIndex].x;
            this._target.y = this._targetRecordY + this._vibrationPostionVec[this._vibrationIndex].y;
            this._vibrationIndex += 1;
         }
         else
         {
            this.dispose();
         }
      }
      
      public function dispose() : void
      {
         if(this._target.hasEventListener(Event.ENTER_FRAME))
         {
            this._target.removeEventListener(Event.ENTER_FRAME,this.onTargetEnterFrame);
            this._target.x = this._targetRecordX;
            this._target.y = this._targetRecordY;
         }
         this._target = null;
         this._vibrationIndex = 0;
      }
   }
}
