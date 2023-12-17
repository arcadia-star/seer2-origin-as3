package com.taomee.seer2.app.processor.quest.handler.branch.quest10116
{
   import com.taomee.seer2.app.dialog.NpcDialog;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class FindFirePanel extends Sprite
   {
       
      
      private var closeBtn:SimpleButton;
      
      private var fireContainer:MovieClip;
      
      private var percentBar:MovieClip;
      
      private var completeFunc:Function;
      
      public function FindFirePanel(param1:MovieClip, param2:Function)
      {
         super();
         this.completeFunc = param2;
         this.closeBtn = param1["closeBtn"];
         this.fireContainer = param1["fireContainer"];
         this.percentBar = param1["percentBar"];
         this.percentBar.gotoAndStop(1);
         this.closeBtn.addEventListener(MouseEvent.CLICK,this.closeClick);
         this.fireContainer.addEventListener(MouseEvent.CLICK,this.clickFire);
         param1.x = 191.7;
         param1.y = 86;
         this.addChild(param1);
      }
      
      private function clickFire(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         _loc2_.stop();
         _loc2_.visible = false;
         this.percentBar.nextFrame();
         if(this.percentBar.currentFrame == this.percentBar.totalFrames)
         {
            this.completeFunc();
         }
      }
      
      private function closeClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         NpcDialog.show(508,"我",[[0,"我知道……火焰是唯一的线索……收集所有的火焰，也许我能回想起什么……"]],["脑海中渐渐有画面浮现出来了"],[function():void
         {
            inits();
         }]);
      }
      
      private function inits() : void
      {
         this.percentBar.gotoAndStop(1);
         var _loc1_:int = 0;
         while(_loc1_ < this.fireContainer.numChildren)
         {
            MovieClip(this.fireContainer.getChildAt(_loc1_)).play();
            this.fireContainer.getChildAt(_loc1_).visible = true;
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         DisplayObjectUtil.removeFromParent(this);
         this.closeBtn.removeEventListener(MouseEvent.CLICK,this.closeClick);
         this.fireContainer.removeEventListener(MouseEvent.CLICK,this.clickFire);
      }
   }
}
