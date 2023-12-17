package com.taomee.seer2.app.activity.processor
{
   import com.taomee.seer2.core.net.LittleEndianByteArray;
   
   public class DragonPVPManager
   {
      
      public static var _CONFIG0:Vector.<int> = new Vector.<int>();
      
      public static var _CONFIG1:Vector.<int> = new Vector.<int>();
      
      public static var _currentIndex:int;
      
      public static var _data:LittleEndianByteArray = new LittleEndianByteArray();
       
      
      public function DragonPVPManager()
      {
         super();
      }
      
      public static function setcurrentConfig0(param1:Vector.<int>) : *
      {
         _CONFIG0 = param1;
      }
      
      public static function setcurrentConfig1(param1:Vector.<int>) : *
      {
         _CONFIG1 = param1;
      }
      
      public static function setdata(param1:LittleEndianByteArray) : *
      {
         _data = param1;
      }
      
      public static function get currentConfig0() : *
      {
         var _loc1_:Vector.<int> = new Vector.<int>();
         return _CONFIG0;
      }
      
      public static function get currentConfig1() : *
      {
         var _loc1_:Vector.<int> = new Vector.<int>();
         return _CONFIG1;
      }
      
      public static function get data() : *
      {
         var _loc1_:LittleEndianByteArray = new LittleEndianByteArray();
         return _data;
      }
   }
}
