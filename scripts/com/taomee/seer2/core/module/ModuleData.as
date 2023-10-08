package com.taomee.seer2.core.module
{
   import org.taomee.ds.HashMap;
   import org.taomee.ds.HashSet;
   
   public class ModuleData
   {
       
      
      protected var _data;
      
      protected var _listeningFuns:HashMap;
      
      public function ModuleData(param1:Object = null)
      {
         this._listeningFuns = new HashMap();
         super();
         this._data = param1;
         if(this._data == null)
         {
            this._data = {};
         }
      }
      
      public function listenTo(param1:String, param2:Function) : void
      {
         var _loc3_:HashSet = this.getListeningFuns(param1);
         if(!_loc3_)
         {
            _loc3_ = new HashSet();
            this._listeningFuns.add(param1,_loc3_);
         }
         _loc3_.add(param2);
      }
      
      public function stopListening(param1:String, param2:Function) : void
      {
         var _loc3_:HashSet = this.getListeningFuns(param1);
         if(_loc3_)
         {
            _loc3_.remove(param2);
         }
      }
      
      public function setData(param1:String, param2:*) : void
      {
         var funs:HashSet;
         var oldValue:* = undefined;
         var key:String = param1;
         var data:* = param2;
         oldValue = this._data[key];
         this._data[key] = data;
         funs = this.getListeningFuns(key);
         if(funs)
         {
            funs.forEach(function(param1:Function):void
            {
               if(param1.length == 0)
               {
                  param1();
               }
               else if(param1.length == 1)
               {
                  param1(data);
               }
               else if(param1.length == 2)
               {
                  param1(oldValue,data);
               }
            });
         }
      }
      
      public function emit(param1:String) : void
      {
         this.processListeningFuns(param1);
      }
      
      private function processListeningFuns(param1:String) : void
      {
         var key:String = param1;
         var funs:HashSet = this.getListeningFuns(key);
         if(funs)
         {
            funs.forEach(function(param1:Function):void
            {
               param1();
            });
         }
      }
      
      public function getData(param1:String) : *
      {
         return this._data[param1];
      }
      
      private function getListeningFuns(param1:String) : HashSet
      {
         return this._listeningFuns.getValue(param1);
      }
      
      public function destory() : void
      {
         this._listeningFuns.forEach(function(param1:String, param2:HashSet):void
         {
            param2.clear();
         });
         this._listeningFuns.clear();
         this._data = null;
      }
   }
}
