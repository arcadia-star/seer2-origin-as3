package org.taomee.ds
{
   public class TreeList implements ITree
   {
       
      
      private var _root:TreeList;
      
      private var _data:*;
      
      private var _parent:TreeList;
      
      private var _children:Array;
      
      public function TreeList(param1:* = null, param2:TreeList = null)
      {
         super();
         _data = param1;
         _children = [];
         this.parent = param2;
      }
      
      public function get depth() : int
      {
         if(_parent == null)
         {
            return 0;
         }
         var _loc1_:TreeList = _parent;
         var _loc2_:int = 0;
         while(_loc1_)
         {
            _loc2_++;
            _loc1_ = _loc1_.parent;
            if(_loc1_ == this)
            {
               throw new Error("TreeList Infinite Loop");
            }
         }
         return _loc2_;
      }
      
      public function remove() : void
      {
         var _loc1_:TreeList = null;
         if(_parent == null)
         {
            return;
         }
         for each(_loc1_ in _children)
         {
            _loc1_.parent = _parent;
         }
      }
      
      public function clear() : void
      {
         _children = [];
      }
      
      public function set data(param1:*) : void
      {
         _data = param1;
      }
      
      public function get numSiblings() : int
      {
         if(_parent)
         {
            return _parent.numChildren;
         }
         return 0;
      }
      
      public function get root() : TreeList
      {
         return _root;
      }
      
      public function set parent(param1:TreeList) : void
      {
         var _loc2_:int = 0;
         if(_parent)
         {
            _loc2_ = _parent.children.indexOf(this);
            if(_loc2_ != -1)
            {
               _parent.children.splice(_loc2_,1);
            }
         }
         if(param1 == this)
         {
            return;
         }
         _parent = param1;
         if(_parent)
         {
            _parent.children.push(this);
         }
         setRoot();
      }
      
      private function setRoot() : void
      {
         if(_parent == null)
         {
            _root = this;
            return;
         }
         var _loc1_:TreeList = _parent;
         while(_loc1_)
         {
            if(_loc1_.parent == null)
            {
               _root = _loc1_;
               return;
            }
            _loc1_ = _loc1_.parent;
            if(_loc1_ == this)
            {
               throw new Error("TreeList Infinite Loop");
            }
         }
      }
      
      public function get length() : int
      {
         var _loc1_:int = numChildren;
         var _loc2_:TreeList = _parent;
         while(_loc2_)
         {
            _loc1_ += _loc2_.numChildren;
            _loc2_ = _loc2_.parent;
            if(_loc2_ == this)
            {
               throw new Error("TreeList Infinite Loop");
            }
         }
         return _loc1_;
      }
      
      public function get isLeaf() : Boolean
      {
         return _children.length == 0;
      }
      
      public function get data() : *
      {
         return _data;
      }
      
      public function get isRoot() : Boolean
      {
         return _root == this;
      }
      
      public function get numChildren() : int
      {
         return _children.length;
      }
      
      public function get parent() : TreeList
      {
         return _parent;
      }
      
      public function get children() : Array
      {
         return _children;
      }
   }
}
