package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _f292fa2e36b7b5c0fe28876bf3592f68e66238eccf581b591ad65d9d9fc5c675_flash_display_Sprite extends Sprite
   {
       
      
      public function _f292fa2e36b7b5c0fe28876bf3592f68e66238eccf581b591ad65d9d9fc5c675_flash_display_Sprite()
      {
         super();
      }
      
      public function allowDomainInRSL(... rest) : void
      {
         Security.allowDomain.apply(null,rest);
      }
      
      public function allowInsecureDomainInRSL(... rest) : void
      {
         Security.allowInsecureDomain.apply(null,rest);
      }
   }
}
