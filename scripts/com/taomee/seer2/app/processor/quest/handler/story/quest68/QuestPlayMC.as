package com.taomee.seer2.app.processor.quest.handler.story.quest68
{
   import com.taomee.seer2.core.scene.LayerManager;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class QuestPlayMC
   {
      
      private static var _prevMC:MovieClip;
      
      private static var _mc:MovieClip;
      
      private static var _btn:SimpleButton;
      
      private static var _total:int;
      
      private static var _fun:Function;
       
      
      public function QuestPlayMC()
      {
         super();
      }
      
      public static function playMC(param1:MovieClip, param2:Function) : void
      {
         _prevMC = param1;
         _mc = param1["mc"];
         _btn = param1["btn"];
         _total = _mc.totalFrames;
         _fun = param2;
         LayerManager.focusOnTopLayer();
         _btn.addEventListener(MouseEvent.CLICK,onClick);
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         if(_mc.currentFrame < _mc.totalFrames)
         {
            _mc.nextFrame();
         }
         else
         {
            DisplayUtil.removeForParent(_prevMC);
            _btn.removeEventListener(MouseEvent.CLICK,onClick);
            LayerManager.resetOperation();
            _fun();
            _fun = null;
            _mc = null;
            _btn = null;
         }
      }
   }
}
