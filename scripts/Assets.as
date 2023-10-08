package
{
   import flash.display.Sprite;
   import flash.system.Security;
   
   public class Assets extends Sprite
   {
       
      
      public function Assets()
      {
         super();
         Security.allowDomain("*");
      }
   }
}
