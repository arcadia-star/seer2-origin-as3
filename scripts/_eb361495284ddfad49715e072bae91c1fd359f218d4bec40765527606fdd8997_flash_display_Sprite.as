package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _eb361495284ddfad49715e072bae91c1fd359f218d4bec40765527606fdd8997_flash_display_Sprite extends Sprite
   {
       
      
      public function _eb361495284ddfad49715e072bae91c1fd359f218d4bec40765527606fdd8997_flash_display_Sprite()
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
