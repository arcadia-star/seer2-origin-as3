package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   internal class CPtrTypemap extends CTypemap
   {
       
      
      public function CPtrTypemap()
      {
         super();
      }
      
      override public function fromC(param1:Array) : *
      {
         return int(param1[0]);
      }
      
      override public function createC(param1:*, param2:int = 0) : Array
      {
         return [int(param1)];
      }
   }
}
