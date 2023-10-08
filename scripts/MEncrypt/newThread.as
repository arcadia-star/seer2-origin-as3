package MEncrypt
{
   import flash.utils.*;
   
   public function newThread(param1:int, param2:int, param3:int, param4:Vector.<int>) : *
   {
      var _loc8_:Function = null;
      var _loc5_:*;
      (_loc5_ = createflasccWorker()).setSharedProperty("flascc.threadId",param1);
      _loc5_.setSharedProperty("flascc.threadArbMutex",threadArbMutex);
      var _loc6_:int = 0;
      while(_loc6_ < 32)
      {
         _loc5_.setSharedProperty("flascc.threadArbCond." + _loc6_,threadArbConds[_loc6_]);
         _loc6_++;
      }
      ram_init.shareable = true;
      _loc5_.setSharedProperty("flascc.ram",ram_init);
      _loc5_.setSharedProperty("flascc.esp_init",param2);
      _loc5_.setSharedProperty("flascc.thread_entry",param3);
      var _loc7_:ByteArray;
      (_loc7_ = new ByteArray()).writeObject(param4);
      _loc5_.setSharedProperty("flascc.thread_args",_loc7_);
      for each(_loc8_ in workerInits)
      {
         _loc8_(_loc5_);
      }
      return _loc5_;
   }
}
