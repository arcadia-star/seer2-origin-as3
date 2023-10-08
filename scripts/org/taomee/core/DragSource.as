package org.taomee.core
{
   public class DragSource
   {
       
      
      private var _dataHolder:Object;
      
      private var _formats:Array;
      
      private var _formatHandlers:Object;
      
      public function DragSource()
      {
         _dataHolder = {};
         _formatHandlers = {};
         _formats = [];
         super();
      }
      
      public function addHandler(param1:Function, param2:String) : void
      {
         _formats.push(param2);
         _formatHandlers[param2] = param1;
      }
      
      public function addData(param1:*, param2:String) : void
      {
         _formats.push(param2);
         _dataHolder[param2] = param1;
      }
      
      public function hasFormat(param1:String) : Boolean
      {
         var format:String = param1;
         var b:Boolean = _formats.some(function(param1:String, param2:int, param3:Array):Boolean
         {
            if(param1 == format)
            {
               return true;
            }
            return false;
         });
         return b;
      }
      
      public function dataForFormat(param1:String) : *
      {
         var _loc2_:Object = _dataHolder[param1];
         if(_loc2_)
         {
            return _loc2_;
         }
         if(_formatHandlers[param1])
         {
            return _formatHandlers[param1]();
         }
         return null;
      }
      
      public function get formats() : Array
      {
         return _formats;
      }
   }
}
