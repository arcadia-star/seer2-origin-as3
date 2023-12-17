package com.taomee.seer2.app.component
{
   import com.taomee.seer2.core.ui.UINumberGenerator;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class ItemIcon extends Sprite
   {
       
      
      private var _icon:IconDisplayer;
      
      private var _numContainer:Sprite;
      
      private var _itemUrl:String;
      
      private var _num:int;
      
      private var _maxWidth:Number;
      
      private var _maxHeight:Number;
      
      public function ItemIcon(param1:Number, param2:Number)
      {
         super();
         this._maxWidth = param1;
         this._maxHeight = param2;
         this._icon = new IconDisplayer();
         this._icon.setBoundary(this._maxWidth,this._maxHeight);
      }
      
      public function update(param1:String, param2:int) : void
      {
         var _loc3_:Sprite = null;
         var _loc4_:Rectangle = null;
         this.clear();
         this._numContainer = new Sprite();
         if(param1 != "")
         {
            this._itemUrl = param1;
            this._num = param2;
            this._icon.setIconUrl(param1);
            addChild(this._icon);
            if(this._num >= 1)
            {
               _loc3_ = UINumberGenerator.generateItemNumber(this._num);
               this._numContainer.addChild(_loc3_);
               addChild(this._numContainer);
               _loc4_ = this._numContainer.getBounds(this._numContainer);
               this._numContainer.x = this._maxWidth - _loc4_.width + 2;
               this._numContainer.y = this._maxHeight - _loc4_.height + 3;
            }
         }
      }
      
      private function clear() : void
      {
         DisplayObjectUtil.removeFromParent(this._icon);
         DisplayObjectUtil.removeFromParent(this._numContainer);
      }
      
      public function dispose() : void
      {
         this._icon.dispose();
      }
   }
}
