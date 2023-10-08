package com.adobe.utils
{
   import mx.formatters.DateBase;
   
   public class DateUtil
   {
       
      
      public function DateUtil()
      {
         super();
      }
      
      public static function getShortMonthName(param1:Date) : String
      {
         return DateBase.monthNamesShort[param1.getMonth()];
      }
      
      public static function getShortMonthIndex(param1:String) : int
      {
         return DateBase.monthNamesShort.indexOf(param1);
      }
      
      public static function getFullMonthName(param1:Date) : String
      {
         return DateBase.monthNamesLong[param1.getMonth()];
      }
      
      public static function getFullMonthIndex(param1:String) : int
      {
         return DateBase.monthNamesLong.indexOf(param1);
      }
      
      public static function getShortDayName(param1:Date) : String
      {
         return DateBase.dayNamesShort[param1.getDay()];
      }
      
      public static function getShortDayIndex(param1:String) : int
      {
         return DateBase.dayNamesShort.indexOf(param1);
      }
      
      public static function getFullDayName(param1:Date) : String
      {
         return DateBase.dayNamesLong[param1.getDay()];
      }
      
      public static function getFullDayIndex(param1:String) : int
      {
         return DateBase.dayNamesLong.indexOf(param1);
      }
      
      public static function getShortYear(param1:Date) : String
      {
         var _loc2_:String = String(param1.getFullYear());
         if(_loc2_.length < 3)
         {
            return _loc2_;
         }
         return _loc2_.substr(_loc2_.length - 2);
      }
      
      public static function compareDates(param1:Date, param2:Date) : int
      {
         var _loc3_:Number = param1.getTime();
         var _loc4_:Number = param2.getTime();
         if(_loc3_ > _loc4_)
         {
            return -1;
         }
         if(_loc3_ < _loc4_)
         {
            return 1;
         }
         return 0;
      }
      
      public static function getShortHour(param1:Date) : int
      {
         var _loc2_:int = param1.hours;
         if(_loc2_ == 0 || _loc2_ == 12)
         {
            return 12;
         }
         if(_loc2_ > 12)
         {
            return _loc2_ - 12;
         }
         return _loc2_;
      }
      
      public static function getAMPM(param1:Date) : String
      {
         return param1.hours > 11 ? "PM" : "AM";
      }
      
      public static function parseRFC822(param1:String) : Date
      {
         var finalDate:Date = null;
         var dateParts:Array = null;
         var day:String = null;
         var date:Number = NaN;
         var month:Number = NaN;
         var year:Number = NaN;
         var timeParts:Array = null;
         var hour:Number = NaN;
         var minute:Number = NaN;
         var second:Number = NaN;
         var milliseconds:Number = NaN;
         var timezone:String = null;
         var offset:Number = NaN;
         var multiplier:Number = NaN;
         var oHours:Number = NaN;
         var oMinutes:Number = NaN;
         var eStr:String = null;
         var str:String = param1;
         try
         {
            dateParts = str.split(" ");
            day = null;
            if(dateParts[0].search(/\d/) == -1)
            {
               day = String(dateParts.shift().replace(/\W/,""));
            }
            date = Number(dateParts.shift());
            month = Number(DateUtil.getShortMonthIndex(dateParts.shift()));
            year = Number(dateParts.shift());
            timeParts = dateParts.shift().split(":");
            hour = int(timeParts.shift());
            minute = int(timeParts.shift());
            second = timeParts.length > 0 ? int(timeParts.shift()) : 0;
            milliseconds = Date.UTC(year,month,date,hour,minute,second,0);
            timezone = dateParts.shift();
            offset = 0;
            if(timezone.search(/\d/) == -1)
            {
               switch(timezone)
               {
                  case "UT":
                     offset = 0;
                     break;
                  case "UTC":
                     offset = 0;
                     break;
                  case "GMT":
                     offset = 0;
                     break;
                  case "EST":
                     offset = -5 * 3600000;
                     break;
                  case "EDT":
                     offset = -4 * 3600000;
                     break;
                  case "CST":
                     offset = -6 * 3600000;
                     break;
                  case "CDT":
                     offset = -5 * 3600000;
                     break;
                  case "MST":
                     offset = -7 * 3600000;
                     break;
                  case "MDT":
                     offset = -6 * 3600000;
                     break;
                  case "PST":
                     offset = -8 * 3600000;
                     break;
                  case "PDT":
                     offset = -7 * 3600000;
                     break;
                  case "Z":
                     offset = 0;
                     break;
                  case "A":
                     offset = -1 * 3600000;
                     break;
                  case "M":
                     offset = -12 * 3600000;
                     break;
                  case "N":
                     offset = 1 * 3600000;
                     break;
                  case "Y":
                     offset = 12 * 3600000;
                     break;
                  default:
                     offset = 0;
               }
            }
            else
            {
               multiplier = 1;
               oHours = 0;
               oMinutes = 0;
               if(timezone.length != 4)
               {
                  if(timezone.charAt(0) == "-")
                  {
                     multiplier = -1;
                  }
                  timezone = timezone.substr(1,4);
               }
               oHours = Number(timezone.substr(0,2));
               oMinutes = Number(timezone.substr(2,2));
               offset = (oHours * 3600000 + oMinutes * 60000) * multiplier;
            }
            finalDate = new Date(milliseconds - offset);
            if(finalDate.toString() == "Invalid Date")
            {
               throw new Error("This date does not conform to RFC822.");
            }
         }
         catch(e:Error)
         {
            eStr = "Unable to parse the string [" + str + "] into a date. ";
            eStr += "The internal error was: " + e.toString();
            throw new Error(eStr);
         }
         return finalDate;
      }
      
      public static function toRFC822(param1:Date) : String
      {
         var _loc2_:Number = param1.getUTCDate();
         var _loc3_:Number = param1.getUTCHours();
         var _loc4_:Number = param1.getUTCMinutes();
         var _loc5_:Number = param1.getUTCSeconds();
         var _loc6_:* = (_loc6_ = (_loc6_ = new String()) + DateBase.dayNamesShort[param1.getUTCDay()]) + ", ";
         if(_loc2_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ = (_loc6_ += _loc2_) + " ") + DateBase.monthNamesShort[param1.getUTCMonth()]) + " ") + param1.getUTCFullYear()) + " ";
         if(_loc3_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ = (_loc6_ += _loc3_) + ":";
         if(_loc4_ < 10)
         {
            _loc6_ += "0";
         }
         _loc6_ = (_loc6_ += _loc4_) + ":";
         if(_loc5_ < 10)
         {
            _loc6_ += "0";
         }
         return (_loc6_ += _loc5_) + " GMT";
      }
      
      public static function parseW3CDTF(param1:String) : Date
      {
         var finalDate:Date = null;
         var dateStr:String = null;
         var timeStr:String = null;
         var dateArr:Array = null;
         var year:Number = NaN;
         var month:Number = NaN;
         var date:Number = NaN;
         var multiplier:Number = NaN;
         var offsetHours:Number = NaN;
         var offsetMinutes:Number = NaN;
         var offsetStr:String = null;
         var timeArr:Array = null;
         var hour:Number = NaN;
         var minutes:Number = NaN;
         var secondsArr:Array = null;
         var seconds:Number = NaN;
         var milliseconds:Number = NaN;
         var utc:Number = NaN;
         var offset:Number = NaN;
         var eStr:String = null;
         var str:String = param1;
         try
         {
            dateStr = str.substring(0,str.indexOf("T"));
            timeStr = str.substring(str.indexOf("T") + 1,str.length);
            dateArr = dateStr.split("-");
            year = Number(dateArr.shift());
            month = Number(dateArr.shift());
            date = Number(dateArr.shift());
            if(timeStr.indexOf("Z") != -1)
            {
               multiplier = 1;
               offsetHours = 0;
               offsetMinutes = 0;
               timeStr = timeStr.replace("Z","");
            }
            else if(timeStr.indexOf("+") != -1)
            {
               multiplier = 1;
               offsetStr = timeStr.substring(timeStr.indexOf("+") + 1,timeStr.length);
               offsetHours = Number(offsetStr.substring(0,offsetStr.indexOf(":")));
               offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":") + 1,offsetStr.length));
               timeStr = timeStr.substring(0,timeStr.indexOf("+"));
            }
            else
            {
               multiplier = -1;
               offsetStr = timeStr.substring(timeStr.indexOf("-") + 1,timeStr.length);
               offsetHours = Number(offsetStr.substring(0,offsetStr.indexOf(":")));
               offsetMinutes = Number(offsetStr.substring(offsetStr.indexOf(":") + 1,offsetStr.length));
               timeStr = timeStr.substring(0,timeStr.indexOf("-"));
            }
            timeArr = timeStr.split(":");
            hour = Number(timeArr.shift());
            minutes = Number(timeArr.shift());
            secondsArr = timeArr.length > 0 ? String(timeArr.shift()).split(".") : null;
            seconds = secondsArr != null && secondsArr.length > 0 ? Number(secondsArr.shift()) : 0;
            milliseconds = secondsArr != null && secondsArr.length > 0 ? 1000 * parseFloat("0." + secondsArr.shift()) : 0;
            utc = Date.UTC(year,month - 1,date,hour,minutes,seconds,milliseconds);
            offset = (offsetHours * 3600000 + offsetMinutes * 60000) * multiplier;
            finalDate = new Date(utc - offset);
            if(finalDate.toString() == "Invalid Date")
            {
               throw new Error("This date does not conform to W3CDTF.");
            }
         }
         catch(e:Error)
         {
            eStr = "Unable to parse the string [" + str + "] into a date. ";
            eStr += "The internal error was: " + e.toString();
            throw new Error(eStr);
         }
         return finalDate;
      }
      
      public static function toW3CDTF(param1:Date, param2:Boolean = false) : String
      {
         var _loc3_:Number = param1.getUTCDate();
         var _loc4_:Number = param1.getUTCMonth();
         var _loc5_:Number = param1.getUTCHours();
         var _loc6_:Number = param1.getUTCMinutes();
         var _loc7_:Number = param1.getUTCSeconds();
         var _loc8_:Number = param1.getUTCMilliseconds();
         var _loc9_:* = (_loc9_ = (_loc9_ = new String()) + param1.getUTCFullYear()) + "-";
         if(_loc4_ + 1 < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ = (_loc9_ += _loc4_ + 1) + "-";
         if(_loc3_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ = (_loc9_ += _loc3_) + "T";
         if(_loc5_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ = (_loc9_ += _loc5_) + ":";
         if(_loc6_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ = (_loc9_ += _loc6_) + ":";
         if(_loc7_ < 10)
         {
            _loc9_ += "0";
         }
         _loc9_ += _loc7_;
         if(param2 && _loc8_ > 0)
         {
            _loc9_ = (_loc9_ += ".") + _loc8_;
         }
         return _loc9_ + "-00:00";
      }
      
      public static function makeMorning(param1:Date) : Date
      {
         param1 = new Date(param1.time);
         param1.hours = 0;
         param1.minutes = 0;
         param1.seconds = 0;
         param1.milliseconds = 0;
         return param1;
      }
      
      public static function makeNight(param1:Date) : Date
      {
         param1 = new Date(param1.time);
         param1.hours = 23;
         param1.minutes = 59;
         param1.seconds = 59;
         param1.milliseconds = 999;
         return param1;
      }
      
      public static function getUTCDate(param1:Date) : Date
      {
         var _loc2_:Date = new Date();
         var _loc3_:Number = param1.getTimezoneOffset() * 60 * 1000;
         _loc2_.setTime(param1.getTime() + _loc3_);
         return _loc2_;
      }
   }
}
