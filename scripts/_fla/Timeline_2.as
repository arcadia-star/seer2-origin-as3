package _fla
{
   import flash.display.MovieClip;
   
   public dynamic class Timeline_2 extends MovieClip
   {
       
      
      public function Timeline_2()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}
