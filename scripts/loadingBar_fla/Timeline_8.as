package loadingBar_fla
{
   import flash.display.MovieClip;
   
   public dynamic class Timeline_8 extends MovieClip
   {
       
      
      public function Timeline_8()
      {
         super();
         addFrameScript(0,this.frame1,99,this.frame100);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame100() : *
      {
         stop();
      }
   }
}
