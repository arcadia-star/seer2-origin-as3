package cmodule.desc
{
   import flash.display.*;
   import flash.events.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.utils.*;
   
   internal class GLEByteArrayProvider
   {
       
      
      public function GLEByteArrayProvider()
      {
         super();
      }
      
      public static function get() : ByteArray
      {
         var result:ByteArray = null;
         try
         {
            result = gdomainClass.currentDomain.domainMemory;
         }
         catch(e:*)
         {
         }
         if(!result)
         {
            result = new LEByteArray();
            try
            {
               result.length = gdomainClass.MIN_DOMAIN_MEMORY_LENGTH;
               gdomainClass.currentDomain.domainMemory = result;
            }
            catch(e:*)
            {
               log(3,"Not using domain memory");
            }
         }
         return result;
      }
   }
}
