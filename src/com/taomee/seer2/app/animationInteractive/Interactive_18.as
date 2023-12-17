package com.taomee.seer2.app.animationInteractive
{
   import com.taomee.seer2.app.utils.MovieClipUtil;
   
   public class Interactive_18 extends BaseAniamationInteractive
   {
       
      
      public function Interactive_18()
      {
         super();
      }
      
      override protected function paramAnimation() : void
      {
         _animation.stop();
         MovieClipUtil.playMc(_animation,1,_animation.totalFrames);
      }
   }
}
