package com.taomee.seer2.app.net.parser
{
   import flash.utils.IDataInput;
   
   public class Parser_1251
   {
       
      
      public var petCatchTimeList:Vector.<int>;
      
      public function Parser_1251(param1:IDataInput)
      {
         super();
         this.petCatchTimeList = new Vector.<int>();
         var _loc2_:int = int(param1.readUnsignedInt());
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.petCatchTimeList.push(param1.readUnsignedInt());
            _loc3_++;
         }
      }
   }
}
