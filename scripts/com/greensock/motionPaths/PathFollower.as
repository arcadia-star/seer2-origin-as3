package com.greensock.motionPaths
{
   public class PathFollower
   {
       
      
      public var path:com.greensock.motionPaths.MotionPath;
      
      public var cachedProgress:Number;
      
      public var target:Object;
      
      public var cachedRawProgress:Number;
      
      public var cachedNext:com.greensock.motionPaths.PathFollower;
      
      public var autoRotate:Boolean;
      
      public var rotationOffset:Number;
      
      public var cachedPrev:com.greensock.motionPaths.PathFollower;
      
      public function PathFollower(param1:Object, param2:Boolean = false, param3:Number = 0)
      {
         super();
         this.target = param1;
         this.autoRotate = param2;
         this.rotationOffset = param3;
         this.cachedProgress = this.cachedRawProgress = 0;
      }
      
      public function set progress(param1:Number) : void
      {
         if(param1 > 1)
         {
            this.cachedRawProgress = param1;
            this.cachedProgress = param1 - int(param1);
            if(this.cachedProgress == 0)
            {
               this.cachedProgress = 1;
            }
         }
         else if(param1 < 0)
         {
            this.cachedRawProgress = param1;
            this.cachedProgress = param1 - (int(param1) - 1);
         }
         else
         {
            this.cachedRawProgress = int(this.cachedRawProgress) + param1;
            this.cachedProgress = param1;
         }
         if(this.path)
         {
            this.path.renderObjectAt(this.target,this.cachedProgress,this.autoRotate,this.rotationOffset);
         }
      }
      
      public function set rawProgress(param1:Number) : void
      {
         this.progress = param1;
      }
      
      public function get rawProgress() : Number
      {
         return this.cachedRawProgress;
      }
      
      public function get progress() : Number
      {
         return this.cachedProgress;
      }
   }
}
