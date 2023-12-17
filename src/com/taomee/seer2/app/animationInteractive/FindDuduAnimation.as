package com.taomee.seer2.app.animationInteractive
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FindDuduAnimation extends BaseAniamationInteractive
   {
       
      
      private var _findNumMC:MovieClip;
      
      private var _duduVec:Vector.<MovieClip>;
      
      private var _findNum:int;
      
      public function FindDuduAnimation()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         var _loc2_:MovieClip = null;
         this._findNumMC = _animation["findNumMC"];
         this._findNumMC.gotoAndStop(1);
         this._findNum = 0;
         this._duduVec = new Vector.<MovieClip>();
         var _loc1_:int = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = _animation["dudu_" + _loc1_];
            _loc2_.buttonMode = true;
            _loc2_.gotoAndStop(1);
            _loc2_.addEventListener(MouseEvent.CLICK,this.onDuduClick);
            this._duduVec.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function onDuduClick(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         _loc2_.gotoAndStop(2);
         _loc2_.addEventListener(Event.ENTER_FRAME,this.onDuduEnter);
         _loc2_.removeEventListener(MouseEvent.CLICK,this.onDuduClick);
      }
      
      private function onDuduEnter(param1:Event) : void
      {
         var _loc2_:MovieClip = param1.currentTarget.getChildAt(0) as MovieClip;
         if(_loc2_.currentFrame == _loc2_.totalFrames)
         {
            _loc2_.stop();
            (param1.currentTarget as MovieClip).removeEventListener(Event.ENTER_FRAME,this.onDuduEnter);
            ++this._findNum;
            this._findNumMC.gotoAndStop(this._findNum + 1);
            if(this._findNum == 10)
            {
               dispatchEvent(new Event(AnimationEvent.FINDDUDU));
               this.dispose();
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         super.dispose();
         this._findNumMC = null;
         if(this._duduVec)
         {
            _loc1_ = 0;
            while(_loc1_ < this._duduVec.length)
            {
               this._duduVec[_loc1_].removeEventListener(MouseEvent.CLICK,this.onDuduClick);
               this._duduVec[_loc1_] = null;
               _loc1_++;
            }
            this._duduVec = null;
         }
      }
   }
}
