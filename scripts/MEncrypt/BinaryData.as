package MEncrypt
{
   import flash.utils.ByteArray;
   
   public class BinaryData extends ByteArray
   {
       
      
      public function BinaryData()
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc10_:* = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:int = 0;
         super();
         if(length)
         {
            return;
         }
         for each(var _loc9_ in (_loc7_ = CModule.describeType(this))..metadata.(@name == "HexData"))
         {
            var _loc19_:int = 0;
            var _loc18_:* = _loc9_..arg.(@key == "");
            while(§§hasnext(_loc18_,_loc19_))
            {
               _loc10_ = 0;
               while(_loc10_ < _loc8_)
               {
                  _loc4_ = _loc5_.charCodeAt(_loc10_);
                  _loc6_ = _loc5_.charCodeAt(_loc10_ + 1);
                  _loc1_ = 0;
                  if(_loc4_ < 58)
                  {
                     _loc1_ = _loc4_ - 48;
                  }
                  else if(_loc4_ < 71)
                  {
                     _loc1_ = 10 + (_loc4_ - 65);
                  }
                  else if(_loc4_ < 103)
                  {
                     _loc1_ = 10 + (_loc4_ - 97);
                  }
                  _loc1_ *= 16;
                  if(_loc6_ < 58)
                  {
                     _loc1_ += _loc6_ - 48;
                  }
                  else if(_loc6_ < 71)
                  {
                     _loc1_ += 10 + (_loc6_ - 65);
                  }
                  else if(_loc6_ < 103)
                  {
                     _loc1_ += 10 + (_loc6_ - 97);
                  }
                  writeByte(_loc1_);
                  _loc10_ += 2;
               }
            }
         }
         position = 0;
      }
   }
}

const §7§;
