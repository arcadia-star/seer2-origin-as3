package com.taomee.seer2.core.map.grids
{
   import flash.utils.Dictionary;
   
   public class HashMap
   {
       
      
      private var _keys:Array = null;
      
      private var props:Dictionary = null;
      
      public function HashMap()
      {
         super();
         this.clear();
      }
      
      public function clear() : void
      {
         this.props = new Dictionary();
         this._keys = new Array();
      }
      
      public function containsKey(param1:Object) : Boolean
      {
         return this.props[param1] != null;
      }
      
      public function containsValue(param1:Object) : Boolean
      {
         var _loc4_:uint = 0;
         var _loc2_:Boolean = false;
         var _loc3_:uint = this.size();
         if(_loc3_ > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               if(this.props[this._keys[_loc4_]] == param1)
               {
                  _loc2_ = true;
                  break;
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public function getValue(param1:Object) : Object
      {
         return this.props[param1];
      }
      
      public function put(param1:Object, param2:Object) : Object
      {
         var _loc3_:Object = null;
         if(this.containsKey(param1))
         {
            _loc3_ = this.getValue(param1);
            this.props[param1] = param2;
         }
         else
         {
            this.props[param1] = param2;
            this._keys.push(param1);
         }
         return _loc3_;
      }
      
      public function remove(param1:Object) : Object
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         if(this.containsKey(param1))
         {
            delete this.props[param1];
            _loc3_ = this._keys.indexOf(param1);
            if(_loc3_ > -1)
            {
               this._keys.splice(_loc3_,1);
            }
         }
         return _loc2_;
      }
      
      public function putAll(param1:HashMap) : void
      {
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         this.clear();
         var _loc2_:uint = param1.size();
         if(_loc2_ > 0)
         {
            _loc3_ = param1.keys();
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               this.put(_loc3_[_loc4_],param1.getValue(_loc3_[_loc4_]));
               _loc4_++;
            }
         }
      }
      
      public function size() : uint
      {
         return this._keys.length;
      }
      
      public function isEmpty() : Boolean
      {
         return this.size() < 1;
      }
      
      public function values() : Array
      {
         var _loc3_:uint = 0;
         var _loc1_:Array = new Array();
         var _loc2_:uint = this.size();
         if(_loc2_ > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc1_.push(this.props[this._keys[_loc3_]]);
               _loc3_++;
            }
         }
         return _loc1_;
      }
      
      public function keys() : Array
      {
         return this._keys;
      }
   }
}
