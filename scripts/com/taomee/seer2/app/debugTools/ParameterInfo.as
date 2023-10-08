package com.taomee.seer2.app.debugTools
{
   public class ParameterInfo
   {
       
      
      private var _PID:uint;
      
      private var _name:String;
      
      private var _type:String;
      
      private var _isArray:Boolean;
      
      private var _length:uint;
      
      private var _fixedLength:uint;
      
      private var _description:String;
      
      public var structList:Vector.<com.taomee.seer2.app.debugTools.ParameterInfo>;
      
      public function ParameterInfo(param1:uint, param2:String, param3:String, param4:Boolean, param5:uint, param6:uint, param7:String)
      {
         super();
         this._PID = param1;
         this._name = param2;
         this._type = param3;
         this._isArray = param4;
         this._length = param5;
         this._fixedLength = param6;
         this._description = param7;
      }
      
      public function get pid() : uint
      {
         return this._PID;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get isArray() : Boolean
      {
         return this._isArray;
      }
      
      public function get length() : uint
      {
         return this._length;
      }
      
      public function get fixedLength() : uint
      {
         return this._fixedLength;
      }
      
      public function get description() : String
      {
         return this._description;
      }
   }
}
