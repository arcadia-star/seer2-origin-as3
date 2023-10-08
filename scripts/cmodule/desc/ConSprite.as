package cmodule.desc
{
   import flash.display.Sprite;
   
   public class ConSprite extends Sprite
   {
       
      
      private var runner:cmodule.desc.CRunner;
      
      public function ConSprite()
      {
         this.runner = new cmodule.desc.CRunner();
         super();
         if(gsprite)
         {
            log(1,"More than one sprite!");
         }
         gsprite = this;
         this.runner.startSystem();
      }
   }
}
