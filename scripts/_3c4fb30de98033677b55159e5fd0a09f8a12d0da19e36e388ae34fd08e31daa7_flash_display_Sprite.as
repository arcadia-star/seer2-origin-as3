package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _3c4fb30de98033677b55159e5fd0a09f8a12d0da19e36e388ae34fd08e31daa7_flash_display_Sprite extends Sprite
   {
       
      
      public function _3c4fb30de98033677b55159e5fd0a09f8a12d0da19e36e388ae34fd08e31daa7_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain(rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain(rest);
      }
   }
}
