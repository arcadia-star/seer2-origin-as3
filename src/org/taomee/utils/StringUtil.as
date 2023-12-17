package org.taomee.utils
{
   import flash.utils.ByteArray;
   
   public class StringUtil
   {
      
      private static const HEX_Head:String = "0x";
      
      private static const DOT:String = ".";
       
      
      public function StringUtil()
      {
         super();
      }
      
      public static function uintToIp(param1:uint) : String
      {
         var _loc2_:String = param1.toString(16);
         var _loc3_:String = uint(HEX_Head + _loc2_.slice(0,2)).toString();
         var _loc4_:String = uint(HEX_Head + _loc2_.slice(2,4)).toString();
         var _loc5_:String = uint(HEX_Head + _loc2_.slice(4,6)).toString();
         var _loc6_:String = uint(HEX_Head + _loc2_.slice(6)).toString();
         return _loc3_ + DOT + _loc4_ + DOT + _loc5_ + DOT + _loc6_;
      }
      
      public static function remove(param1:String, param2:String) : String
      {
         return StringUtil.replace(param1,param2,"");
      }
      
      public static function isWhitespace(param1:String) : Boolean
      {
         switch(param1)
         {
            case " ":
            case "\t":
            case "\r":
            case "\n":
            case "\f":
               return true;
            default:
               return false;
         }
      }
      
      public static function ipToBytes(param1:String, param2:String = null) : ByteArray
      {
         var _loc5_:String = null;
         var _loc3_:Array = param1.split(".");
         var _loc4_:ByteArray = new ByteArray();
         if(param2 != null && param2 != "")
         {
            _loc4_.endian = param2;
         }
         for each(_loc5_ in _loc3_)
         {
            _loc4_.writeByte(uint(_loc5_));
         }
         return _loc4_;
      }
      
      public static function beginsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(0,param2.length);
      }
      
      public static function isDoubleChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /^[^\x00-\xff]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isNumber(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         return !isNaN(Number(param1));
      }
      
      public static function renewZero(param1:String, param2:int) : String
      {
         var _loc5_:int = 0;
         var _loc3_:* = "";
         var _loc4_:int;
         if((_loc4_ = param1.length) < param2)
         {
            _loc5_ = 0;
            while(_loc5_ < param2 - _loc4_)
            {
               _loc3_ += "0";
               _loc5_++;
            }
            return _loc3_ + param1;
         }
         return param1;
      }
      
      public static function leftTrim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:RegExp = /^\s*/;
         return param1.replace(_loc2_,"");
      }
      
      public static function isEmail(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function isDouble(param1:String) : Boolean
      {
         param1 = trim(param1);
         var _loc2_:RegExp = /^[-\+]?\d+(\.\d+)?$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function endsWith(param1:String, param2:String) : Boolean
      {
         return param2 == param1.substring(param1.length - param2.length);
      }
      
      public static function utf16to8(param1:String) : String
      {
         var _loc5_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:uint = uint(param1.length);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = param1.charCodeAt(_loc4_)) >= 1 && _loc5_ <= 127)
            {
               _loc2_[_loc4_] = param1.charAt(_loc4_);
            }
            else if(_loc5_ > 2047)
            {
               _loc2_[_loc4_] = String.fromCharCode(224 | _loc5_ >> 12 & 15,128 | _loc5_ >> 6 & 63,128 | _loc5_ >> 0 & 63);
            }
            else
            {
               _loc2_[_loc4_] = String.fromCharCode(192 | _loc5_ >> 6 & 31,128 | _loc5_ >> 0 & 63);
            }
            _loc4_++;
         }
         return _loc2_.join("");
      }
      
      public static function isChinese(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /^[Α-￥]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function timeFormat(param1:int, param2:String = "-") : String
      {
         var _loc3_:Date = new Date(param1 * 1000);
         return _loc3_.getFullYear().toString() + param2 + (_loc3_.getMonth() + 1).toString() + param2 + _loc3_.getDate().toString();
      }
      
      public static function rightTrim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         var _loc2_:RegExp = /\s*$/;
         return param1.replace(_loc2_,"");
      }
      
      public static function isEnglish(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /^[A-Za-z]+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function stringHasValue(param1:String) : Boolean
      {
         return param1 != null && param1.length > 0;
      }
      
      public static function stopwatchFormat(param1:int) : String
      {
         var _loc2_:int = param1 / 60;
         var _loc3_:int = param1 % 60;
         var _loc4_:String = _loc2_ < 10 ? "0" + _loc2_.toString() : _loc2_.toString();
         var _loc5_:String = _loc3_ < 10 ? "0" + _loc3_.toString() : _loc3_.toString();
         return _loc4_ + ":" + _loc5_;
      }
      
      public static function isURL(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1).toLowerCase();
         var _loc2_:RegExp = /^http:\/\/[A-Za-z0-9]+\.[A-Za-z0-9]+[\/=\?%\-&_~`@[\]\':+!]*([^<>\"\"])*$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function hasChineseChar(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /[^\x00-\xff]/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function stringsAreEqual(param1:String, param2:String, param3:Boolean) : Boolean
      {
         if(param3)
         {
            return param1 == param2;
         }
         return param1.toUpperCase() == param2.toUpperCase();
      }
      
      public static function utf8to16(param1:String) : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc2_:Array = new Array();
         var _loc3_:uint = uint(param1.length);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.charCodeAt(_loc4_++);
            switch(_loc5_ >> 4)
            {
               case 0:
               case 1:
               case 2:
               case 3:
               case 4:
               case 5:
               case 6:
               case 7:
                  _loc2_[_loc2_.length] = param1.charAt(_loc4_ - 1);
                  break;
               case 12:
               case 13:
                  _loc6_ = param1.charCodeAt(_loc4_++);
                  _loc2_[_loc2_.length] = String.fromCharCode((_loc5_ & 31) << 6 | _loc6_ & 63);
                  break;
               case 14:
                  _loc7_ = param1.charCodeAt(_loc4_++);
                  _loc8_ = param1.charCodeAt(_loc4_++);
                  _loc2_[_loc2_.length] = String.fromCharCode((_loc5_ & 15) << 12 | (_loc7_ & 63) << 6 | (_loc8_ & 63) << 0);
                  break;
            }
         }
         return _loc2_.join("");
      }
      
      public static function replace(param1:String, param2:String, param3:String) : String
      {
         return param1.split(param2).join(param3);
      }
      
      public static function toByteArray(param1:String, param2:uint) : ByteArray
      {
         var _loc3_:ByteArray = new ByteArray();
         _loc3_.writeUTFBytes(param1);
         _loc3_.length = param2;
         _loc3_.position = 0;
         return _loc3_;
      }
      
      public static function substituteStr(param1:String, ... rest) : String
      {
         var _loc4_:Array = null;
         if(param1 == null)
         {
            return "";
         }
         var _loc3_:uint = uint(rest.length);
         if(_loc3_ == 1 && rest[0] is Array)
         {
            _loc3_ = (_loc4_ = rest[0] as Array).length;
         }
         else
         {
            _loc4_ = rest;
         }
         var _loc5_:int = 0;
         while(_loc5_ < _loc3_)
         {
            param1 = param1.replace(new RegExp("\\{" + _loc5_ + "\\}","g"),_loc4_[_loc5_]);
            _loc5_++;
         }
         return param1;
      }
      
      public static function hasAccountChar(param1:String, param2:uint = 15) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         if(param2 < 10)
         {
            param2 = 15;
         }
         param1 = trim(param1);
         var _loc3_:RegExp = new RegExp("^[a-zA-Z0-9][a-zA-Z0-9_-]{0," + param2 + "}$","");
         var _loc4_:Object;
         if((_loc4_ = _loc3_.exec(param1)) == null)
         {
            return false;
         }
         return true;
      }
      
      public static function trim(param1:String) : String
      {
         if(param1 == null)
         {
            return "";
         }
         return rightTrim(leftTrim(param1));
      }
      
      public static function isInteger(param1:String) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         param1 = trim(param1);
         var _loc2_:RegExp = /^[-\+]?\d+$/;
         var _loc3_:Object = _loc2_.exec(param1);
         if(_loc3_ == null)
         {
            return false;
         }
         return true;
      }
      
      public static function ipToUint(param1:String) : uint
      {
         var _loc4_:String = null;
         var _loc2_:Array = param1.split(DOT);
         var _loc3_:String = HEX_Head;
         for each(_loc4_ in _loc2_)
         {
            _loc3_ += uint(_loc4_).toString(16);
         }
         return uint(_loc3_);
      }
      
      public static function hexToIp(param1:uint) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUnsignedInt(param1);
         _loc2_.position = 0;
         var _loc3_:String = "";
         var _loc4_:uint = 0;
         while(_loc4_ < 4)
         {
            _loc3_ += _loc2_.readUnsignedByte().toString() + DOT;
            _loc4_++;
         }
         return _loc3_.substr(0,_loc3_.length - 1);
      }
   }
}
