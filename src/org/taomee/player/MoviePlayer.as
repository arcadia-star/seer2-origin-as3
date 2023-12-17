package org.taomee.player
{
   import flash.display.MovieClip;
   
   public class MoviePlayer extends TimePlayer
   {
       
      
      private var _mc:MovieClip;
      
      public function MoviePlayer(param1:MovieClip = null, param2:uint = 40)
      {
         super(param2);
         if(param1 != null)
         {
            this.movie = param1;
         }
      }
      
      public function set movie(param1:MovieClip) : void
      {
         reset();
         this._mc = param1;
         _totalFrames = this._mc.totalFrames;
         setTotalTime();
         this.update();
      }
      
      public function get movie() : MovieClip
      {
         return this._mc;
      }
      
      public function destroy() : void
      {
         this._mc = null;
      }
      
      override protected function update() : void
      {
         if(this._mc)
         {
            this._mc.gotoAndStop(_currentFrame + 1);
         }
      }
   }
}
