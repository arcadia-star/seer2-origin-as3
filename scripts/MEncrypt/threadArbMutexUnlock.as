package MEncrypt
{
   public function threadArbMutexUnlock() : void
   {
      threadArbLockDepth = _loc1_;
      var _loc1_:*;
      if(!(_loc1_ = threadArbLockDepth - 1))
      {
         threadArbMutex.unlock();
      }
   }
}
