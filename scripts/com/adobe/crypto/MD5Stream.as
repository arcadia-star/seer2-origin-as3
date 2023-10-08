package com.adobe.crypto
{
   import com.adobe.utils.IntUtil;
   import flash.utils.ByteArray;
   
   public class MD5Stream
   {
      
      private static var mask:int = 255;
       
      
      private var arr:Array;
      
      private var arrLen:int;
      
      private var a:int = 1732584193;
      
      private var b:int = -271733879;
      
      private var c:int = -1732584194;
      
      private var d:int = 271733878;
      
      private var aa:int;
      
      private var bb:int;
      
      private var cc:int;
      
      private var dd:int;
      
      private var arrIndexLen:int = 0;
      
      private var arrProcessIndex:int = 0;
      
      private var cleanIndex:int = 0;
      
      public var memoryBlockSize:int = 16384;
      
      public function MD5Stream()
      {
         this.arr = [];
         super();
      }
      
      private static function f(param1:int, param2:int, param3:int) : int
      {
         return param1 & param2 | ~param1 & param3;
      }
      
      private static function g(param1:int, param2:int, param3:int) : int
      {
         return param1 & param3 | param2 & ~param3;
      }
      
      private static function h(param1:int, param2:int, param3:int) : int
      {
         return param1 ^ param2 ^ param3;
      }
      
      private static function i(param1:int, param2:int, param3:int) : int
      {
         return param2 ^ (param1 | ~param3);
      }
      
      private static function transform(param1:Function, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int) : int
      {
         var _loc9_:int = param2 + int(param1(param3,param4,param5)) + param6 + param8;
         return IntUtil.rol(_loc9_,param7) + param3;
      }
      
      private static function ff(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(f,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function gg(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(g,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function hh(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(h,param1,param2,param3,param4,param5,param6,param7);
      }
      
      private static function ii(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return transform(i,param1,param2,param3,param4,param5,param6,param7);
      }
      
      public function complete(param1:ByteArray = null) : String
      {
         if(this.arr.length == 0)
         {
            if(param1 == null)
            {
               throw new Error("null input to complete without prior call to update. At least an empty bytearray must be passed.");
            }
         }
         if(param1 != null)
         {
            this.readIntoArray(param1);
         }
         this.padArray(this.arrLen);
         this.hashRemainingChunks(false);
         var _loc2_:String = String(IntUtil.toHex(this.a) + IntUtil.toHex(this.b) + IntUtil.toHex(this.c) + IntUtil.toHex(this.d));
         this.resetFields();
         return _loc2_;
      }
      
      public function update(param1:ByteArray) : void
      {
         this.readIntoArray(param1);
         this.hashRemainingChunks();
      }
      
      public function resetFields() : void
      {
         this.arr.length = 0;
         this.arrLen = 0;
         this.a = 1732584193;
         this.b = -271733879;
         this.c = -1732584194;
         this.d = 271733878;
         this.aa = 0;
         this.bb = 0;
         this.cc = 0;
         this.dd = 0;
         this.arrIndexLen = 0;
         this.arrProcessIndex = 0;
         this.cleanIndex = 0;
      }
      
      private function readIntoArray(param1:ByteArray) : void
      {
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:int = param1.length * 8;
         this.arrLen += _loc2_;
         if(this.arrProcessIndex - this.cleanIndex > this.memoryBlockSize)
         {
            _loc4_ = new Array();
            _loc5_ = this.arrProcessIndex;
            while(_loc5_ < this.arr.length)
            {
               _loc4_[_loc5_] = this.arr[_loc5_];
               _loc5_++;
            }
            this.cleanIndex = this.arrProcessIndex;
            this.arr = null;
            this.arr = _loc4_;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            this.arr[int(this.arrIndexLen >> 5)] = this.arr[int(this.arrIndexLen >> 5)] | (param1[_loc3_ / 8] & mask) << this.arrIndexLen % 32;
            this.arrIndexLen += 8;
            _loc3_ += 8;
         }
      }
      
      private function hashRemainingChunks(param1:Boolean = true) : void
      {
         var _loc2_:int = int(this.arr.length);
         if(param1)
         {
            _loc2_ -= 16;
         }
         if(this.arrProcessIndex >= _loc2_ || _loc2_ - this.arrProcessIndex < 15)
         {
            return;
         }
         var _loc3_:int = this.arrProcessIndex;
         while(_loc3_ < _loc2_)
         {
            this.aa = this.a;
            this.bb = this.b;
            this.cc = this.c;
            this.dd = this.d;
            this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 0)],7,-680876936);
            this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 1)],12,-389564586);
            this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 2)],17,606105819);
            this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 3)],22,-1044525330);
            this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 4)],7,-176418897);
            this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 5)],12,1200080426);
            this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 6)],17,-1473231341);
            this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 7)],22,-45705983);
            this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 8)],7,1770035416);
            this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 9)],12,-1958414417);
            this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 10)],17,-42063);
            this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 11)],22,-1990404162);
            this.a = ff(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 12)],7,1804603682);
            this.d = ff(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 13)],12,-40341101);
            this.c = ff(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 14)],17,-1502002290);
            this.b = ff(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 15)],22,1236535329);
            this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 1)],5,-165796510);
            this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 6)],9,-1069501632);
            this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 11)],14,643717713);
            this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 0)],20,-373897302);
            this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 5)],5,-701558691);
            this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 10)],9,38016083);
            this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 15)],14,-660478335);
            this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 4)],20,-405537848);
            this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 9)],5,568446438);
            this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 14)],9,-1019803690);
            this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 3)],14,-187363961);
            this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 8)],20,1163531501);
            this.a = gg(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 13)],5,-1444681467);
            this.d = gg(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 2)],9,-51403784);
            this.c = gg(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 7)],14,1735328473);
            this.b = gg(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 12)],20,-1926607734);
            this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 5)],4,-378558);
            this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 8)],11,-2022574463);
            this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 11)],16,1839030562);
            this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 14)],23,-35309556);
            this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 1)],4,-1530992060);
            this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 4)],11,1272893353);
            this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 7)],16,-155497632);
            this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 10)],23,-1094730640);
            this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 13)],4,681279174);
            this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 0)],11,-358537222);
            this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 3)],16,-722521979);
            this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 6)],23,76029189);
            this.a = hh(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 9)],4,-640364487);
            this.d = hh(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 12)],11,-421815835);
            this.c = hh(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 15)],16,530742520);
            this.b = hh(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 2)],23,-995338651);
            this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 0)],6,-198630844);
            this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 7)],10,1126891415);
            this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 14)],15,-1416354905);
            this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 5)],21,-57434055);
            this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 12)],6,1700485571);
            this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 3)],10,-1894986606);
            this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 10)],15,-1051523);
            this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 1)],21,-2054922799);
            this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 8)],6,1873313359);
            this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 15)],10,-30611744);
            this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 6)],15,-1560198380);
            this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 13)],21,1309151649);
            this.a = ii(this.a,this.b,this.c,this.d,this.arr[int(_loc3_ + 4)],6,-145523070);
            this.d = ii(this.d,this.a,this.b,this.c,this.arr[int(_loc3_ + 11)],10,-1120210379);
            this.c = ii(this.c,this.d,this.a,this.b,this.arr[int(_loc3_ + 2)],15,718787259);
            this.b = ii(this.b,this.c,this.d,this.a,this.arr[int(_loc3_ + 9)],21,-343485551);
            this.a += this.aa;
            this.b += this.bb;
            this.c += this.cc;
            this.d += this.dd;
            _loc3_ += 16;
            this.arrProcessIndex += 16;
         }
      }
      
      private function padArray(param1:int) : void
      {
         this.arr[int(param1 >> 5)] = this.arr[int(param1 >> 5)] | 128 << param1 % 32;
         this.arr[int((param1 + 64 >>> 9 << 4) + 14)] = param1;
         this.arrLen = this.arr.length;
      }
   }
}
