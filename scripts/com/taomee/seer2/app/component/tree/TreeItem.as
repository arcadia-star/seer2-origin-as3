package com.taomee.seer2.app.component.tree
{
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import org.taomee.utils.InvalidateCallback;
   
   public class TreeItem extends Sprite
   {
      
      public static const LAYOUT_COMPLETE:String = "layoutComplete";
       
      
      private var _displayObj:DisplayObject;
      
      private var _parentItem:com.taomee.seer2.app.component.tree.TreeItem;
      
      private var _children:Vector.<com.taomee.seer2.app.component.tree.TreeItem>;
      
      private var _showChildren:Boolean;
      
      private var _xMargin:Number;
      
      private var _yPadding:Number;
      
      public function TreeItem(param1:DisplayObject, param2:Number = 0, param3:Number = 0)
      {
         super();
         this._displayObj = param1;
         addChild(this._displayObj);
         this._yPadding = param2;
         this._xMargin = param3;
         this._children = new Vector.<com.taomee.seer2.app.component.tree.TreeItem>();
         this._showChildren = false;
      }
      
      public function update(param1:*) : void
      {
      }
      
      public function collaseAllChildren() : void
      {
         var _loc1_:com.taomee.seer2.app.component.tree.TreeItem = null;
         this.showChildren = false;
         for each(_loc1_ in this._children)
         {
            _loc1_.showChildren = false;
         }
      }
      
      public function getChildItemAt(param1:int) : com.taomee.seer2.app.component.tree.TreeItem
      {
         if(param1 >= 0 && param1 <= this._children.length - 1)
         {
            return this._children[param1];
         }
         return null;
      }
      
      public function changeToLen(param1:int, param2:Class) : void
      {
         var _loc3_:int = 0;
         if(param1 > this.childrenNum)
         {
            _loc3_ = this.childrenNum;
            while(_loc3_ < param1)
            {
               this.addChildItem(new param2());
               _loc3_++;
            }
         }
         else
         {
            while(this._children.length > param1)
            {
               this.removeChildItemAt(this._children.length - 1);
            }
         }
      }
      
      private function removeChildItemAt(param1:int) : void
      {
         var _loc2_:com.taomee.seer2.app.component.tree.TreeItem = null;
         if(param1 >= 0 && param1 <= this._children.length - 1)
         {
            _loc2_ = this._children[param1];
            _loc2_._parentItem = null;
            _loc2_.dispose();
            this._children.splice(param1,1);
         }
      }
      
      private function addChildItem(param1:com.taomee.seer2.app.component.tree.TreeItem) : void
      {
         if(this._children.indexOf(param1) == -1)
         {
            this._children.push(param1);
            param1._parentItem = this;
         }
      }
      
      public function get childrenNum() : int
      {
         return this._children.length;
      }
      
      public function get parentItem() : com.taomee.seer2.app.component.tree.TreeItem
      {
         return this._parentItem;
      }
      
      public function get rootItem() : com.taomee.seer2.app.component.tree.TreeItem
      {
         var _loc1_:com.taomee.seer2.app.component.tree.TreeItem = this;
         while(_loc1_._parentItem)
         {
            _loc1_ = _loc1_._parentItem;
         }
         return _loc1_;
      }
      
      public function get data() : *
      {
         return null;
      }
      
      public function set showChildren(param1:Boolean) : void
      {
         if(this._showChildren == param1)
         {
            return;
         }
         this._showChildren = param1;
         InvalidateCallback.addFunc(this.rootItem.layoutChildren);
      }
      
      public function get showChildren() : Boolean
      {
         return this._showChildren;
      }
      
      public function get mesuredHeight() : Number
      {
         var _loc2_:int = 0;
         var _loc1_:Number = this._displayObj.height;
         if(this._showChildren)
         {
            _loc2_ = 0;
            while(_loc2_ < this._children.length)
            {
               _loc1_ += this._children[_loc2_].mesuredHeight + this._yPadding;
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      private function layoutChildren() : void
      {
         var _loc3_:com.taomee.seer2.app.component.tree.TreeItem = null;
         var _loc1_:Number = this._displayObj.height;
         var _loc2_:int = 0;
         while(_loc2_ < this._children.length)
         {
            _loc3_ = this._children[_loc2_];
            if(this._showChildren)
            {
               _loc3_.layoutChildren();
               _loc3_.y = _loc1_ + this._yPadding;
               _loc3_.x = this._xMargin;
               addChild(_loc3_);
               _loc1_ += _loc3_.mesuredHeight + this._yPadding;
            }
            else
            {
               DisplayObjectUtil.removeFromParent(_loc3_);
            }
            _loc2_++;
         }
         if(hasEventListener(LAYOUT_COMPLETE))
         {
            dispatchEvent(new Event(LAYOUT_COMPLETE));
         }
      }
      
      public function dispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._children.length)
         {
            this._children[_loc1_].dispose();
            _loc1_++;
         }
         DisplayObjectUtil.removeFromParent(this);
      }
   }
}
