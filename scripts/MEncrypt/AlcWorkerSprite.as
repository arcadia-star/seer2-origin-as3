package MEncrypt
{
   import flash.display.Sprite;
   import flash.system.System;
   
   public class AlcWorkerSprite extends Sprite
   {
       
      
      public function AlcWorkerSprite()
      {
         super();
         run();
      }
      
      public function run() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = undefined;
         try
         {
            _loc2_ = int(workerClass["current"].getSharedProperty("flascc.thread_entry"));
            _loc1_ = workerClass["current"].getSharedProperty("flascc.thread_args").readObject();
            CModule.prepForThreadedExec();
            CModule.activeConsole = this;
            if(!CModule.rootSprite)
            {
               CModule.rootSprite = this;
            }
            CModule.callI(_loc2_,_loc1_);
         }
         catch(e:GoingAsync)
         {
         }
         catch(e:*)
         {
            if(e is Exit)
            {
               System.exit(e.code);
            }
            else
            {
               trace("Warning: Worker threw exception: " + threadId + " - " + e + "\n" + e.getStackTrace());
            }
         }
         trace("Warning: Worker returned without exiting: " + threadId);
      }
   }
}
