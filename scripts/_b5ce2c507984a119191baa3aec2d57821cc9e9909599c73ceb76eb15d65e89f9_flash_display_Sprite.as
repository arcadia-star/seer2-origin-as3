package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _b5ce2c507984a119191baa3aec2d57821cc9e9909599c73ceb76eb15d65e89f9_flash_display_Sprite extends Sprite
   {
       
      
      public function _b5ce2c507984a119191baa3aec2d57821cc9e9909599c73ceb76eb15d65e89f9_flash_display_Sprite()
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
