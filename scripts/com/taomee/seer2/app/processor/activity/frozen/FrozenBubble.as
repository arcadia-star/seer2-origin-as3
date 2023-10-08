package com.taomee.seer2.app.processor.activity.frozen
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import org.taomee.utils.DisplayUtil;
   
   public class FrozenBubble
   {
      
      private static const LANGUAGE:Array = [[22,23,24,25],[2,3,4,5,6],[7,8,9,10,11],[12,13,14,15,16],[17,18,19,20,21]];
      
      private static var _bubble:MovieClip;
      
      private static var _timer:Timer;
      
      private static var _index:int;
       
      
      public function FrozenBubble()
      {
         super();
      }
      
      public static function setupBubble() : void
      {
         if(_bubble == null)
         {
            FrozenStatus.getSwfContent(function():void
            {
               _bubble = FrozenStatus.getBubble();
               LayerManager.uiLayer.addChild(_bubble);
            });
            return;
         }
         LayerManager.uiLayer.addChild(_bubble);
      }
      
      public static function setTimerBubble(param1:uint) : void
      {
         removeTimer();
         if(param1 < 3)
         {
            _timer = new Timer(5000);
            _index = 0;
            if(param1 == 1)
            {
               _index = 4;
            }
         }
         if(param1 >= 3)
         {
            _index = param1 - 2;
            _timer = new Timer(7000);
         }
         _timer.addEventListener(TimerEvent.TIMER,onTimer);
         _timer.start();
      }
      
      private static function onTimer(param1:TimerEvent) : void
      {
         var _loc2_:Array = LANGUAGE[_index];
         var _loc3_:int = int(Math.random() * _loc2_.length);
         setBubble(_loc2_[_loc3_]);
      }
      
      private static function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener(TimerEvent.TIMER,onTimer);
            _timer = null;
         }
      }
      
      public static function enterBubble(param1:int) : void
      {
         switch(param1)
         {
            case 1:
               setBubble(26);
               break;
            case 2:
               setBubble(27);
               break;
            case 3:
               setBubble(28);
               break;
            case 4:
               setBubble(29);
               break;
            case 5:
               setBubble(30);
         }
      }
      
      private static function setBubble(param1:int) : void
      {
         if(param1 <= 0)
         {
            return;
         }
         if(_bubble == null)
         {
            return;
         }
         _bubble["bubbles"].gotoAndStop(param1);
      }
      
      public static function remove() : void
      {
         if(_timer)
         {
            removeTimer();
         }
         DisplayUtil.removeForParent(_bubble);
         _bubble = null;
      }
   }
}
