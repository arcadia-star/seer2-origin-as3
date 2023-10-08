package MEncrypt
{
   public function yield(param1:int = 1) : void
   {
      var _loc2_:* = undefined;
      if(!yieldCond)
      {
         _loc2_ = new mutexClass();
         _loc2_.lock();
         yieldCond = new conditionClass(_loc2_);
      }
      yieldCond.wait(param1);
   }
}
