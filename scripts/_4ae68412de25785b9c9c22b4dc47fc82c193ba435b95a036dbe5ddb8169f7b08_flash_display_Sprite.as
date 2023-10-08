package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _4ae68412de25785b9c9c22b4dc47fc82c193ba435b95a036dbe5ddb8169f7b08_flash_display_Sprite extends Sprite
   {
       
      
      public function _4ae68412de25785b9c9c22b4dc47fc82c193ba435b95a036dbe5ddb8169f7b08_flash_display_Sprite()
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
