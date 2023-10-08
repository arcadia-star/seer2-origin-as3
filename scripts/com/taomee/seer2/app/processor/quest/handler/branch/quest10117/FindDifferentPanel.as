package com.taomee.seer2.app.processor.quest.handler.branch.quest10117
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import org.taomee.utils.DisplayUtil;
   
   public class FindDifferentPanel extends Sprite
   {
       
      
      private var differentContainer:Sprite;
      
      private var func:Function;
      
      private var findNum:int = 0;
      
      private var clickTargetArr:Array;
      
      public function FindDifferentPanel(param1:MovieClip, param2:Function)
      {
         this.clickTargetArr = [];
         super();
         this.func = param2;
         this.differentContainer = param1["differentContainer"];
         param1.x = 177;
         param1.y = 81;
         this.addChild(param1);
         this.init();
      }
      
      public function init() : void
      {
         this.differentContainer.addEventListener(MouseEvent.CLICK,this.clickContainer);
         var _loc1_:int = 0;
         while(_loc1_ < this.differentContainer.numChildren)
         {
            this.differentContainer.getChildAt(_loc1_).alpha = 0;
            _loc1_++;
         }
      }
      
      public function dispose() : void
      {
         this.differentContainer.removeEventListener(MouseEvent.CLICK,this.clickContainer);
         DisplayUtil.removeForParent(this);
      }
      
      private function clickContainer(param1:MouseEvent) : void
      {
         var _loc2_:Sprite = param1.target as Sprite;
         if(_loc2_ == this.differentContainer)
         {
            return;
         }
         if(this.clickTargetArr.indexOf(_loc2_) != -1)
         {
            return;
         }
         this.clickTargetArr.push(_loc2_);
         _loc2_.alpha = 1;
         ++this.findNum;
         if(this.findNum == 5)
         {
            this.dispose();
            this.func();
         }
      }
   }
}
