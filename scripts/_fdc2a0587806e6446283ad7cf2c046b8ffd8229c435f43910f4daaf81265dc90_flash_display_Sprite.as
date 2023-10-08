package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _fdc2a0587806e6446283ad7cf2c046b8ffd8229c435f43910f4daaf81265dc90_flash_display_Sprite extends Sprite
   {
       
      
      public function _fdc2a0587806e6446283ad7cf2c046b8ffd8229c435f43910f4daaf81265dc90_flash_display_Sprite()
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
