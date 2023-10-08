package MEncrypt
{
   public function threadArbMutexLock() : void
   {
      var _loc1_:* = threadArbLockDepth + 1;
      threadArbLockDepth = _loc1_;
      if(!threadArbLockDepth)
      {
         threadArbMutex.lock();
      }
   }
}
