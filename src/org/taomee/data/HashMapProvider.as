package org.taomee.data
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import org.taomee.ds.HashMap;
   
   public class HashMapProvider extends EventDispatcher
   {
       
      
      private var _data:HashMap;
      
      public var autoUpdate:Boolean = true;
      
      public function HashMapProvider()
      {
         _data = new HashMap();
         super();
      }
      
      public function containsKey(param1:*) : Boolean
      {
         return _data.containsKey(param1);
      }
      
      protected function dispatchPreChangeEvent(param1:String, param2:Array) : void
      {
         if(!autoUpdate)
         {
            return;
         }
         if(hasEventListener(DataChangeEvent.PRE_DATA_CHANGE))
         {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.PRE_DATA_CHANGE,param1,param2));
         }
      }
      
      public function dispatchSelectMulti(param1:IEventDispatcher, param2:Array, param3:Array) : void
      {
         var _loc4_:int = int(param2.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _data.add(param2[_loc5_],param3[_loc5_]);
            _loc5_++;
         }
         param1.dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SELECT,param3.concat()));
      }
      
      public function remove(param1:*) : *
      {
         var _loc2_:* = _data.remove(param1);
         if(_loc2_)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,[_loc2_]);
            return _loc2_;
         }
         return null;
      }
      
      public function addMulti(param1:Array, param2:Array) : Array
      {
         var _loc6_:* = undefined;
         var _loc3_:Array = [];
         var _loc4_:int = int(param1.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if(_loc6_ = _data.add(param1[_loc5_],param2[_loc5_]))
            {
               _loc3_.push(_loc6_);
            }
            _loc5_++;
         }
         dispatchChangeEvent(DataChangeType.ADD,param2.concat());
         return _loc3_;
      }
      
      public function removeForValue(param1:*) : *
      {
         var _loc3_:* = undefined;
         var _loc2_:* = _data.getKey(param1);
         if(_loc2_)
         {
            _loc3_ = _data.remove(_loc2_);
            if(_loc3_)
            {
               dispatchChangeEvent(DataChangeType.REMOVE,[_loc3_]);
               return _loc3_;
            }
         }
         return null;
      }
      
      public function removeMulti(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc4_ = _data.remove(_loc3_))
            {
               _loc2_.push(_loc4_);
            }
         }
         if(_loc2_.length > 0)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,_loc2_.concat());
         }
         return _loc2_;
      }
      
      public function dispatchSelect(param1:IEventDispatcher, param2:*, param3:*) : void
      {
         _data.add(param2,param3);
         param1.dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,DataChangeType.SELECT,[param3]));
      }
      
      public function getValues() : Array
      {
         return _data.getValues();
      }
      
      public function containsValue(param1:*) : Boolean
      {
         return _data.containsValue(param1);
      }
      
      public function refresh() : void
      {
         dispatchChangeEvent(DataChangeType.RESET,_data.getValues());
      }
      
      public function removeMultiForValue(param1:Array) : Array
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc2_:Array = [];
         for each(_loc3_ in param1)
         {
            if(_loc4_ = _data.getKey(_loc3_))
            {
               if(_loc5_ = _data.remove(_loc4_))
               {
                  _loc2_.push(_loc5_);
               }
            }
         }
         if(_loc2_.length > 0)
         {
            dispatchChangeEvent(DataChangeType.REMOVE,_loc2_.concat());
         }
         return _loc2_;
      }
      
      public function upDateForKey(param1:*, param2:*) : void
      {
         var _loc3_:* = undefined;
         if(_data.containsKey(param1))
         {
            _loc3_ = _data.add(param1,param2);
            if(_loc3_)
            {
               dispatchPreChangeEvent(DataChangeType.UPDATE,[_loc3_]);
            }
            dispatchChangeEvent(DataChangeType.UPDATE,[param2]);
         }
      }
      
      public function add(param1:*, param2:*) : *
      {
         var _loc3_:* = _data.add(param1,param2);
         dispatchChangeEvent(DataChangeType.ADD,[param2]);
         return _loc3_;
      }
      
      public function get length() : uint
      {
         return _data.length;
      }
      
      public function getKey(param1:*) : *
      {
         return _data.getKey(param1);
      }
      
      public function getKeys() : Array
      {
         return _data.getKeys();
      }
      
      public function upDateForValue(param1:*, param2:*) : void
      {
         var _loc3_:* = _data.getKey(param1);
         if(_loc3_)
         {
            _data.add(_loc3_,param2);
            dispatchPreChangeEvent(DataChangeType.UPDATE,[param1]);
            dispatchChangeEvent(DataChangeType.UPDATE,[param2]);
         }
      }
      
      protected function dispatchChangeEvent(param1:String, param2:Array) : void
      {
         if(!autoUpdate)
         {
            return;
         }
         if(hasEventListener(DataChangeEvent.DATA_CHANGE))
         {
            dispatchEvent(new DataChangeEvent(DataChangeEvent.DATA_CHANGE,param1,param2));
         }
      }
      
      public function toHashMap() : HashMap
      {
         return _data.clone();
      }
      
      public function getValue(param1:*) : *
      {
         return _data.getValue(param1);
      }
      
      public function removeAll() : void
      {
         var _loc1_:Array = _data.getValues();
         _data.clear();
         dispatchChangeEvent(DataChangeType.REMOVE_ALL,_loc1_);
      }
   }
}
