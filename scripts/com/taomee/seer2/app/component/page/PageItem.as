package com.taomee.seer2.app.component.page
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class PageItem extends Sprite
   {
       
      
      protected var _bgMc:MovieClip;
      
      protected var _selectable:Boolean;
      
      public function PageItem(param1:Boolean)
      {
         super();
         this._selectable = param1;
         this.mouseChildren = false;
      }
      
      public function update(param1:*) : void
      {
         this.clear();
         if(param1 !== null && this._selectable)
         {
            this.buttonMode = true;
            this.mouseEnabled = true;
         }
         else
         {
            this.buttonMode = false;
            this.mouseEnabled = false;
         }
      }
      
      public function clear() : void
      {
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._bgMc)
         {
            this._bgMc.gotoAndStop(param1 ? 2 : 1);
         }
      }
      
      public function dispose() : void
      {
      }
   }
}
