package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _160485629bd30a38e2f52930c56f5a47e28b1a6aca67ef4f081db73bcf0df219_flash_display_Sprite extends Sprite
   {
       
      
      public function _160485629bd30a38e2f52930c56f5a47e28b1a6aca67ef4f081db73bcf0df219_flash_display_Sprite()
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
