package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.swap.SwapManager;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class MapProcessor_171 extends MapProcessor
   {
      
      private static const BUBBLE_REWARD_ITEMID:uint = 42;
      
      private static const GET_REWART_NEEDBUBBLES_NUM:uint = 3;
      
      private static const BUBBLES_NUM:uint = 5;
       
      
      private var _bubbles:MovieClip;
      
      private var _protectShelter:MovieClip;
      
      private var _lockedDragon:MovieClip;
      
      private var _bubbleTimer:Timer;
      
      private var _bubbleVec:Vector.<MovieClip>;
      
      private var _brokenAnimation:MovieClip;
      
      private var _brokenBubbleNum:uint;
      
      public function MapProcessor_171(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initActivity();
      }
      
      private function initActivity() : void
      {
         this._brokenBubbleNum = 0;
         this.processBubble();
      }
      
      private function processBubble() : void
      {
         this._protectShelter = _map.content["protectShelter"];
         closeInteractor(this._protectShelter);
         this._protectShelter.mouseChildren = false;
         this._lockedDragon = _map.content["lockedDragon"];
         closeInteractor(this._lockedDragon);
         this._lockedDragon.mouseChildren = false;
         this._brokenAnimation = _map.libManager.getMovieClip("bubbleBroken");
         this._bubbles = _map.content["waterRecaptureBubbles"];
         this._bubbles.addEventListener(Event.FRAME_CONSTRUCTED,this.onBubblesFrameConstructed);
         this._bubbles.play();
         this._bubbleTimer = new Timer(60000);
         this._bubbleTimer.addEventListener(TimerEvent.TIMER,this.onBubble);
         this._bubbleTimer.start();
      }
      
      private function onBubblesFrameConstructed(param1:Event) : void
      {
         if(this._bubbleVec == null)
         {
            this._bubbleVec = new Vector.<MovieClip>();
            this.initBubbleVec();
            this._bubbles.removeEventListener(Event.FRAME_CONSTRUCTED,this.onBubblesFrameConstructed);
         }
      }
      
      private function initBubbleVec() : void
      {
         var _loc2_:String = null;
         var _loc3_:MovieClip = null;
         var _loc1_:uint = 1;
         while(_loc1_ <= BUBBLES_NUM)
         {
            _loc2_ = "bubble" + _loc1_;
            _loc3_ = this._bubbles[_loc2_];
            _loc3_.buttonMode = true;
            _loc3_.addEventListener(MouseEvent.CLICK,this.onBubbleClick);
            this._bubbleVec.push(_loc3_);
            _loc1_++;
         }
      }
      
      private function onBubbleClick(param1:MouseEvent) : void
      {
         this.parseRewardStatus();
         var _loc2_:MovieClip = param1.currentTarget as MovieClip;
         this.playBrokenAnimation(param1.stageX,param1.stageY);
         _loc2_.visible = false;
      }
      
      private function parseRewardStatus() : void
      {
         ++this._brokenBubbleNum;
         if(this._brokenBubbleNum == GET_REWART_NEEDBUBBLES_NUM)
         {
            this._brokenBubbleNum = 0;
            if(SwapManager.isSwapNumberMax(BUBBLE_REWARD_ITEMID))
            {
               SwapManager.entrySwap(BUBBLE_REWARD_ITEMID);
            }
         }
      }
      
      private function playBrokenAnimation(param1:Number, param2:Number) : void
      {
         this._brokenAnimation.addEventListener(Event.ENTER_FRAME,this.onBrokenAnimationEnd);
         _map.content.addChild(this._brokenAnimation);
         this._brokenAnimation.x = param1;
         this._brokenAnimation.y = param2;
         this._brokenAnimation.gotoAndPlay(1);
      }
      
      private function onBrokenAnimationEnd(param1:Event) : void
      {
         if(this._brokenAnimation.currentFrame == this._brokenAnimation.totalFrames)
         {
            this._brokenAnimation.removeEventListener(Event.ENTER_FRAME,this.onBrokenAnimationEnd);
            DisplayObjectUtil.removeFromParent(this._brokenAnimation);
         }
      }
      
      private function onBubble(param1:TimerEvent) : void
      {
         this.resetBubbles();
      }
      
      private function resetBubbles() : void
      {
         var _loc1_:MovieClip = null;
         if(this._bubbleVec)
         {
            for each(_loc1_ in this._bubbleVec)
            {
               _loc1_.gotoAndPlay(1);
               _loc1_.visible = true;
            }
         }
      }
      
      private function clearBubbles() : void
      {
         var _loc1_:MovieClip = null;
         if(this._bubbleVec)
         {
            for each(_loc1_ in this._bubbleVec)
            {
               _loc1_.removeEventListener(MouseEvent.CLICK,this.onBubbleClick);
            }
         }
         this._bubbleVec = null;
      }
      
      override public function dispose() : void
      {
         this.clearBubbles();
         this._brokenAnimation.removeEventListener(Event.ENTER_FRAME,this.onBrokenAnimationEnd);
         this._brokenAnimation = null;
         this._bubbles.removeEventListener(Event.FRAME_CONSTRUCTED,this.onBubblesFrameConstructed);
         this._bubbles = null;
         this._bubbleTimer.stop();
         this._bubbleTimer.removeEventListener(TimerEvent.TIMER,this.onBubble);
         this._bubbleTimer = null;
         this._lockedDragon = null;
         this._protectShelter = null;
      }
   }
}
