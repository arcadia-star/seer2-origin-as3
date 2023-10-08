package com.taomee.seer2.app.processor.quest.handler.branch.quest10115
{
   import com.greensock.TweenMax;
   import com.taomee.seer2.app.processor.quest.QuestProcessor;
   import com.taomee.seer2.app.processor.quest.handler.QuestMapHandler;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class QuestMapHandlerDream extends QuestMapHandler
   {
       
      
      private var myTween:TweenMax;
      
      protected var stoneMc:MovieClip;
      
      protected var _questID:int;
      
      public function QuestMapHandlerDream(param1:QuestProcessor)
      {
         super(param1);
      }
      
      protected function showStone() : void
      {
         this.stoneMc = _processor.resLib.getMovieClip("stoneMc");
         this.stoneMc.buttonMode = true;
         _map.front.addChild(this.stoneMc);
         MovieClipUtil.playMc(this.stoneMc,1,this.stoneMc.totalFrames,function():void
         {
            stoneMc.gotoAndStop(stoneMc.totalFrames);
            stoneMc.addEventListener(MouseEvent.CLICK,clickStone);
         },true);
      }
      
      protected function clickStone(param1:MouseEvent) : void
      {
      }
   }
}
