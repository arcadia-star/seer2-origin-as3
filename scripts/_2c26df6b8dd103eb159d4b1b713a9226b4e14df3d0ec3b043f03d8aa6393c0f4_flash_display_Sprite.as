package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class _2c26df6b8dd103eb159d4b1b713a9226b4e14df3d0ec3b043f03d8aa6393c0f4_flash_display_Sprite extends Sprite
   {
       
      
      public function _2c26df6b8dd103eb159d4b1b713a9226b4e14df3d0ec3b043f03d8aa6393c0f4_flash_display_Sprite()
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
