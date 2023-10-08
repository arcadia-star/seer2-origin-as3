package com.taomee.seer2.app.net.parser
{
   import flash.utils.Dictionary;
   import flash.utils.IDataInput;
   
   public class Parser_1209
   {
       
      
      public var limitMap:Dictionary;
      
      public function Parser_1209(param1:IDataInput)
      {
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         this.limitMap = new Dictionary();
         super();
         var _loc2_:uint = uint(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = uint(param1.readUnsignedInt());
            _loc5_ = uint(param1.readUnsignedInt());
            this.limitMap[_loc4_] = _loc5_;
            _loc3_++;
         }
      }
   }
}
