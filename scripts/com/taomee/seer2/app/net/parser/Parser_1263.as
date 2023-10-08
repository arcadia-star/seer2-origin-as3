package com.taomee.seer2.app.net.parser
{
   import com.taomee.seer2.app.starMagic.StarInfo;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class Parser_1263
   {
       
      
      public var starInfo:Vector.<StarInfo>;
      
      public function Parser_1263(param1:IDataInput)
      {
         var _loc2_:int = 0;
         var _loc3_:StarInfo = null;
         var _loc4_:int = 0;
         this.starInfo = new Vector.<StarInfo>();
         super();
         (param1 as ByteArray).position = 0;
         _loc2_ = int(param1.readUnsignedInt());
         if(_loc2_ > 0)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = new StarInfo();
               _loc3_.user_id = param1.readUnsignedInt();
               _loc3_.id = param1.readUnsignedInt();
               _loc3_.buffId = param1.readUnsignedInt();
               _loc3_.time = param1.readUnsignedInt();
               _loc3_.level = param1.readUnsignedInt();
               _loc3_.exp = param1.readUnsignedInt();
               _loc3_.nextExp = param1.readUnsignedInt();
               _loc3_.maxLevel = param1.readUnsignedInt();
               _loc3_.level_cof = param1.readUnsignedInt();
               _loc3_.pos = param1.readUnsignedInt();
               _loc3_.petCatchTime = param1.readUnsignedInt();
               _loc3_.sell_exp = param1.readUnsignedInt();
               _loc3_.type = param1.readUnsignedInt();
               _loc3_.buffSwf = param1.readUnsignedInt();
               this.starInfo.push(_loc3_);
               _loc4_++;
            }
         }
      }
   }
}
