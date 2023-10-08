package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   internal class CBufferTypemap extends CTypemap
   {
       
      
      public function CBufferTypemap()
      {
         super();
      }
      
      override public function destroyC(param1:Array) : void
      {
         CBuffer.free(param1[0]);
      }
      
      override public function createC(param1:*, param2:int = 0) : Array
      {
         var _loc3_:CBuffer = null;
         _loc3_ = param1;
         _loc3_.reset();
         return [_loc3_.ptr];
      }
   }
}
