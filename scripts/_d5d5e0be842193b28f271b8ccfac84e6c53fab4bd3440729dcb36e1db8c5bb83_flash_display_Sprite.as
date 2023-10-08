package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _d5d5e0be842193b28f271b8ccfac84e6c53fab4bd3440729dcb36e1db8c5bb83_flash_display_Sprite extends Sprite
   {
       
      
      public function _d5d5e0be842193b28f271b8ccfac84e6c53fab4bd3440729dcb36e1db8c5bb83_flash_display_Sprite()
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
