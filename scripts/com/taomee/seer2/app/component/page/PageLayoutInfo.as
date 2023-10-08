package com.taomee.seer2.app.component.page
{
   import flash.geom.Point;
   
   public class PageLayoutInfo
   {
       
      
      private var _pageCount:int;
      
      private var _rowCount:int;
      
      private var _horizontalMargin:Number;
      
      private var _verticalMargin:Number;
      
      private var _horizontalPadding:Number;
      
      private var _verticalPadding:Number;
      
      public function PageLayoutInfo(param1:int, param2:int, param3:Number, param4:Number, param5:Number, param6:Number)
      {
         super();
         this._pageCount = param1;
         this._rowCount = param2;
         this._horizontalMargin = param3;
         this._verticalMargin = param4;
         this._horizontalPadding = param5;
         this._verticalPadding = param6;
      }
      
      public function caculatePostion(param1:int) : Point
      {
         var _loc2_:Number = this._horizontalMargin + param1 % this._rowCount * this._horizontalPadding;
         var _loc3_:Number = this._verticalMargin + int(param1 / this._rowCount) * this._verticalPadding;
         return new Point(_loc2_,_loc3_);
      }
      
      public function get count() : int
      {
         return this._pageCount;
      }
   }
}
