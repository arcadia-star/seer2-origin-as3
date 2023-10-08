package com.taomee.seer2.app.component.page
{
   import com.taomee.seer2.app.component.Scroller;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class ScrollablePage extends Page
   {
       
      
      private var _scroller:Scroller;
      
      public function ScrollablePage(param1:MovieClip, param2:Class, param3:PageLayoutInfo, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
         var _loc5_:MovieClip = param1["scroller"];
         this._scroller = new Scroller(_loc5_);
         this._scroller.addEventListener(Scroller.MOVE,this.onScrollerMove);
         this._scroller.x = _loc5_.x;
         this._scroller.y = _loc5_.y;
         param1.addChild(this._scroller);
      }
      
      private function onScrollerMove(param1:Event) : void
      {
         updateDisplay();
      }
      
      override public function update(param1:*) : void
      {
         super.update(param1);
         this._scroller.scrollPosition = 0;
         this._scroller.pageSize = _pageCount;
         this._scroller.maxScrollPosition = _dataArr.length;
      }
      
      override public function get offset() : int
      {
         return this._scroller.scrollPosition;
      }
      
      override public function dispose() : void
      {
         this._scroller.removeEventListener(Scroller.MOVE,this.onScrollerMove);
         super.dispose();
      }
   }
}
