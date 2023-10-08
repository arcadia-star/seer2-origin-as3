package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   internal class CSizedStrUTF8Typemap extends CTypemap
   {
       
      
      public function CSizedStrUTF8Typemap()
      {
         super();
      }
      
      override public function fromC(param1:Array) : *
      {
         mstate.ds.position = param1[0];
         return mstate.ds.readUTFBytes(param1[1]);
      }
      
      override public function get typeSize() : int
      {
         return 8;
      }
   }
}
