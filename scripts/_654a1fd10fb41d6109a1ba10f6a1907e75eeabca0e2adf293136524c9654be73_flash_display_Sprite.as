package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _654a1fd10fb41d6109a1ba10f6a1907e75eeabca0e2adf293136524c9654be73_flash_display_Sprite extends Sprite
   {
       
      
      public function _654a1fd10fb41d6109a1ba10f6a1907e75eeabca0e2adf293136524c9654be73_flash_display_Sprite()
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
