package cmodule.desc
{
   import flash.utils.ByteArray;
   
   internal class LEByteArray extends ByteArray
   {
       
      
      public function LEByteArray()
      {
         super();
         super.endian = "littleEndian";
      }
      
      override public function set endian(param1:String) : void
      {
         throw "LEByteArray endian set attempted";
      }
   }
}
