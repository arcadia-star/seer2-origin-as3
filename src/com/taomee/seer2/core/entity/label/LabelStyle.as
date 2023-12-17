package com.taomee.seer2.core.entity.label
{
   public class LabelStyle
   {
       
      
      private var _frontColor:uint;
      
      private var _backColor:uint;
      
      public function LabelStyle(param1:uint, param2:uint)
      {
         super();
         this._frontColor = param1;
         this._backColor = param2;
      }
      
      public function get frontColor() : uint
      {
         return this._frontColor;
      }
      
      public function get backColor() : uint
      {
         return this._backColor;
      }
   }
}
