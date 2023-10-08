package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _7cc553db87c049d7b535140e5c250ac7dda6863a84f210f91fc393756135fbcb_flash_display_Sprite extends Sprite
   {
       
      
      public function _7cc553db87c049d7b535140e5c250ac7dda6863a84f210f91fc393756135fbcb_flash_display_Sprite()
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
