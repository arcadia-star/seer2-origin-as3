package org.taomee.data
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class ArrayProvider extends EventDispatcher
   {
       
      
      private var _data:Array;
      
      public var autoUpdate:Boolean = true;
      
      public function ArrayProvider(param1:Array = null)
      {
         _data = [];
         super();
         if(param1)
         {
            _data = param1.concat();
         }
      }
      
      protected function dispatchPreChangeEvent(param1:String, param2:Array, param3:int = -1, param4:int = -1) : void
      {
         if(!autoUpdate)
         {
            return;
         }
         if(hasEventListener(DataChangeEvent.PRE_DATA_CHANGE))
         {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,param1,param2,param3,param4));
         }
      }
      
      public function shift() : *
      {
         var _loc1_:* = _data.shift();
         dispatchChangeEvent(DataChangeType.REMOVE,[_loc1_],0,0);
         return _loc1_;
      }
      
      public function dispatchSelectMulti(param1:IEventDispatcher, param2:Array) : void
      {
         var _loc3_:int = int(_data.length - 1);
         _data.splice(_loc3_,0,param2);
         param1.dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SELECT,param2,_loc3_,_data.length - 1));
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:int = _data.indexOf(param1);
         if(_loc2_ != -1)
         {
            return removeAt(_loc2_)[0];
         }
         return null;
      }
      
      public function getItemIndex(param1:*) : int
      {
         return _data.indexOf(param1);
      }
      
      public function removeAll() : void
      {
         var _loc1_:Array = _data.concat();
         _data.length = 0;
         dispatchChangeEvent(DataChangeType.REMOVE_ALL,_loc1_,0,_loc1_.length - 1);
      }
      
      public function pop() : *
      {
         var _loc1_:* = _data.pop();
         var _loc2_:int = int(_data.length);
         dispatchChangeEvent(DataChangeType.REMOVE,[_loc1_],_loc2_,_loc2_);
         return _loc1_;
      }
      
      public function removeMulti(param1:Array) : Array
      {
         var arr:Array = null;
         var items:Array = param1;
         arr = [];
         _data = _data.filter(function(param1:*, param2:int, param3:Array):Boolean
         {
            if(items.indexOf(param1) == -1)
            {
               return true;
            }
            arr.push(param1);
            return false;
         },this);
         if(arr.length > 0)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,arr.concat(),0,arr.length - 1);
         }
         return arr;
      }
      
      public function dispatchSelect(param1:IEventDispatcher, param2:*) : void
      {
         var _loc3_:int = int(_data.push(param2));
         param1.dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SELECT,[param2],_loc3_,_loc3_));
      }
      
      public function removeAt(param1:uint, param2:uint = 1) : Array
      {
         checkIndex(param1);
         var _loc3_:Array = _data.splice(param1,param2);
         dispatchChangeEvent(DataChangeType.REMOVE,_loc3_.concat(),param1,param1 + _loc3_.length - 1);
         return _loc3_;
      }
      
      public function swapItemAt(param1:*, param2:*) : void
      {
         var _loc3_:int = _data.indexOf(param1);
         if(_loc3_ == -1)
         {
            return;
         }
         var _loc4_:int;
         if((_loc4_ = _data.indexOf(param2)) == -1)
         {
            return;
         }
         swapIndexAt(_loc3_,_loc4_);
      }
      
      public function removeForProperty(param1:String, param2:*) : *
      {
         var _item:* = undefined;
         var _index:int = 0;
         var p:String = param1;
         var value:* = param2;
         var b:Boolean = _data.some(function(param1:*, param2:int, param3:Array):Boolean
         {
            if(param1[p] == value)
            {
               _item = param1;
               _index = param2;
               return true;
            }
            return false;
         },this);
         if(b)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,[_item],_index,_index);
         }
         return _item;
      }
      
      public function refresh() : void
      {
         dispatchChangeEvent(DataChangeType.RESET,_data.concat(),0,_data.length - 1);
      }
      
      public function getItemAt(param1:uint) : *
      {
         checkIndex(param1);
         return _data[param1];
      }
      
      public function sortOn(param1:Object, param2:Object = null) : Array
      {
         dispatchPreChangeEvent(DataChangeType.SORT,_data.concat(),0,_data.length - 1);
         var _loc3_:Array = _data.sortOn(param1,param2);
         dispatchChangeEvent(DataChangeType.SORT,_data.concat(),0,_data.length - 1);
         return _loc3_;
      }
      
      public function sort(... rest) : Array
      {
         dispatchPreChangeEvent(DataChangeType.SORT,_data.concat(),0,_data.length - 1);
         var _loc2_:Array = _data.sort(rest);
         dispatchChangeEvent(DataChangeType.SORT,_data.concat(),0,_data.length - 1);
         return _loc2_;
      }
      
      public function contains(param1:*) : Boolean
      {
         if(_data.indexOf(param1) == -1)
         {
            return false;
         }
         return true;
      }
      
      public function add(param1:*) : void
      {
         var _loc2_:int = int(_data.push(param1));
         dispatchChangeEvent(DataChangeType.ADD,[param1],_loc2_,_loc2_);
      }
      
      public function every(param1:Function, param2:* = null) : Boolean
      {
         return _data.every(param1,param2);
      }
      
      public function upDateItem(param1:*, param2:*) : *
      {
         var _loc3_:int = _data.indexOf(param1);
         if(_loc3_ != -1)
         {
            return upDateItemAt(_loc3_,param2);
         }
         return null;
      }
      
      public function toArray() : Array
      {
         return _data.concat();
      }
      
      public function get length() : uint
      {
         return _data.length;
      }
      
      public function addMulti(param1:Array) : void
      {
         addMultiAt(param1,_data.length - 1);
      }
      
      public function setItemIndexAt(param1:int, param2:int) : void
      {
         checkIndex(param1);
         checkIndex(param2);
         var _loc3_:Array = _data.splice(param1,1);
         _data.splice(param2,0,_loc3_);
         dispatchChangeEvent(DataChangeType.MOVE,_loc3_,param1,param2);
      }
      
      public function removeMultiForProperty(param1:String, param2:*) : Array
      {
         var arr:Array = null;
         var p:String = param1;
         var value:* = param2;
         arr = [];
         _data = _data.filter(function(param1:*, param2:int, param3:Array):Boolean
         {
            if(param1[p] == value)
            {
               arr.push(param1);
               return false;
            }
            return true;
         },this);
         if(arr.length == 0)
         {
            return arr;
         }
         dispatchChangeEvent(DataChangeType.REMOVE,arr,0,arr.length - 1);
         return arr;
      }
      
      public function setItemIndex(param1:*, param2:int) : void
      {
         checkIndex(param2);
         var _loc3_:int = _data.indexOf(param1);
         if(_loc3_ == -1)
         {
            return;
         }
         setItemIndexAt(_loc3_,param2);
      }
      
      public function addMultiAt(param1:Array, param2:uint) : void
      {
         checkIndex(param2);
         _data.splice(param2,0,param1);
         dispatchChangeEvent(DataChangeType.ADD,param1.concat(),param2,param2 + param1.length - 1);
      }
      
      override public function toString() : String
      {
         return "ArrayProvider [" + _data.join(" , ") + "]";
      }
      
      public function upDateItemAt(param1:uint, param2:*) : *
      {
         checkIndex(param1);
         var _loc3_:* = _data[param1];
         dispatchPreChangeEvent(DataChangeType.UPDATE,[_loc3_],param1,param1);
         _data[param1] = param2;
         dispatchChangeEvent(DataChangeType.UPDATE,[param2],param1,param1);
         return _loc3_;
      }
      
      protected function checkIndex(param1:int) : void
      {
         if(param1 > _data.length - 1 || param1 < 0)
         {
            throw new RangeError("ArrayProvider index (" + param1.toString() + ") is not in acceptable range (0 - " + (_data.length - 1).toString() + ")");
         }
      }
      
      public function addAt(param1:*, param2:uint) : void
      {
         checkIndex(param2);
         _data.splice(param2,0,param1);
         dispatchChangeEvent(DataChangeType.ADD,[param1],param2,param2);
      }
      
      protected function dispatchChangeEvent(param1:String, param2:Array, param3:int = -1, param4:int = -1) : void
      {
         if(!autoUpdate)
         {
            return;
         }
         if(hasEventListener(DataChangeEvent.DATA_CHANGE))
         {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,param1,param2,param3,param4));
         }
      }
      
      public function filter(param1:Function, param2:* = null) : Array
      {
         return _data.filter(param1,param2);
      }
      
      public function forEach(param1:Function, param2:* = null) : void
      {
         _data.forEach(param1,param2);
      }
      
      public function some(param1:Function, param2:* = null) : Boolean
      {
         return _data.some(param1,param2);
      }
      
      public function removeMultiIndex(param1:Array) : Array
      {
         var arr:Array = null;
         var indexs:Array = param1;
         arr = [];
         _data = _data.filter(function(param1:*, param2:int, param3:Array):Boolean
         {
            if(indexs.indexOf(param2) == -1)
            {
               return true;
            }
            arr.push(param1);
            return false;
         },this);
         if(arr.length > 0)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,arr.concat(),0,arr.length - 1);
         }
         return arr;
      }
      
      public function map(param1:Function, param2:* = null) : Array
      {
         return _data.map(param1,param2);
      }
      
      public function swapIndexAt(param1:int, param2:int) : void
      {
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         if(param1 == param2)
         {
            return;
         }
         checkIndex(param1);
         checkIndex(param2);
         if(param1 < param2)
         {
            _loc4_ = _data.splice(param2,1);
            _loc3_ = _data.splice(param1,1,_loc4_);
            _data.splice(param2,1,_loc3_);
            dispatchChangeEvent(DataChangeType.SWAP,_loc4_.concat(_loc3_),param1,param2);
         }
         else
         {
            _loc3_ = _data.splice(param1,1);
            _loc4_ = _data.splice(param2,1);
            _data.splice(param1,1,_loc4_);
            dispatchChangeEvent(DataChangeType.SWAP,_loc3_.concat(_loc4_),param2,param1);
         }
      }
   }
}
