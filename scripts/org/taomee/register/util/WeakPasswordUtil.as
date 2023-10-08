package org.taomee.register.util
{
   import flash.utils.Dictionary;
   
   public class WeakPasswordUtil
   {
      
      public static const MAX_CONTINUATION_NUM:int = 5;
      
      public static const WEAK_PASSWORD_MAP:Dictionary = new Dictionary();
      
      {
         WEAK_PASSWORD_MAP["123456"] = "";
         WEAK_PASSWORD_MAP["123456789"] = "";
         WEAK_PASSWORD_MAP["111111"] = "";
         WEAK_PASSWORD_MAP["123123"] = "";
         WEAK_PASSWORD_MAP["1234567890"] = "";
         WEAK_PASSWORD_MAP["000000"] = "";
         WEAK_PASSWORD_MAP["123321"] = "";
         WEAK_PASSWORD_MAP["zxcvbnm"] = "";
         WEAK_PASSWORD_MAP["qwertyuiop"] = "";
         WEAK_PASSWORD_MAP["1234567"] = "";
         WEAK_PASSWORD_MAP["789456123"] = "";
         WEAK_PASSWORD_MAP["asdfghjkl"] = "";
         WEAK_PASSWORD_MAP["789456"] = "";
         WEAK_PASSWORD_MAP["147258369"] = "";
         WEAK_PASSWORD_MAP["741852963"] = "";
         WEAK_PASSWORD_MAP["987654321"] = "";
         WEAK_PASSWORD_MAP["112233"] = "";
         WEAK_PASSWORD_MAP["qwerty"] = "";
         WEAK_PASSWORD_MAP["666666"] = "";
         WEAK_PASSWORD_MAP["123123123"] = "";
         WEAK_PASSWORD_MAP["12345678910"] = "";
         WEAK_PASSWORD_MAP["asdfgh"] = "";
         WEAK_PASSWORD_MAP["555555"] = "";
         WEAK_PASSWORD_MAP["qazwsx"] = "";
         WEAK_PASSWORD_MAP["159753"] = "";
         WEAK_PASSWORD_MAP["5201314"] = "";
         WEAK_PASSWORD_MAP["121212"] = "";
         WEAK_PASSWORD_MAP["456123"] = "";
         WEAK_PASSWORD_MAP["456789"] = "";
         WEAK_PASSWORD_MAP["159357"] = "";
         WEAK_PASSWORD_MAP["147258"] = "";
         WEAK_PASSWORD_MAP["963852741"] = "";
         WEAK_PASSWORD_MAP["aaaaaa"] = "";
         WEAK_PASSWORD_MAP["12345678"] = "";
         WEAK_PASSWORD_MAP["123654"] = "";
         WEAK_PASSWORD_MAP["asdasd"] = "";
         WEAK_PASSWORD_MAP["654321"] = "";
         WEAK_PASSWORD_MAP["7758258"] = "";
         WEAK_PASSWORD_MAP["zxcvbn"] = "";
         WEAK_PASSWORD_MAP["1233211234567"] = "";
         WEAK_PASSWORD_MAP["qazwsxedc"] = "";
         WEAK_PASSWORD_MAP["147852369"] = "";
         WEAK_PASSWORD_MAP["741852"] = "";
         WEAK_PASSWORD_MAP["0123456789"] = "";
         WEAK_PASSWORD_MAP["123789"] = "";
         WEAK_PASSWORD_MAP["753951"] = "";
         WEAK_PASSWORD_MAP["1234560"] = "";
         WEAK_PASSWORD_MAP["7894561230"] = "";
         WEAK_PASSWORD_MAP["a123456"] = "";
         WEAK_PASSWORD_MAP["456456"] = "";
      }
      
      public function WeakPasswordUtil()
      {
         super();
      }
      
      public static function isContainIllegalChar(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^[a-zA-Z0-9_]{6,16}$/;
         return !_loc2_.test(param1);
      }
      
      public static function isWeakPassword(param1:String) : Boolean
      {
         if(WEAK_PASSWORD_MAP[param1] != null)
         {
            return true;
         }
         if(isSameStr(param1))
         {
            return true;
         }
         if(isContinuationStr(param1))
         {
            return true;
         }
         return false;
      }
      
      private static function isSameStr(param1:String) : Boolean
      {
         var _loc2_:RegExp = /^(\w)\1{5}$/;
         return _loc2_.test(param1);
      }
      
      private static function isContinuationStr(param1:String) : Boolean
      {
         var _loc4_:int = 0;
         var _loc6_:Number = NaN;
         var _loc2_:int = param1.length;
         if(int(param1) == 0 || _loc2_ != 6)
         {
            return false;
         }
         var _loc3_:Number = param1.charCodeAt(0);
         var _loc5_:int = 1;
         while(_loc5_ < _loc2_)
         {
            _loc6_ = param1.charCodeAt(_loc5_);
            if(_loc3_ != _loc6_ - 1)
            {
               return false;
            }
            _loc3_ = _loc6_;
            _loc5_++;
         }
         return true;
      }
   }
}
