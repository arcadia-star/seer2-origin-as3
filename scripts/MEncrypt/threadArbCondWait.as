package MEncrypt
{
   public function threadArbCondWait(param1:Number) : Boolean
   {
      var _loc2_:Boolean = false;
      return Boolean(threadArbConds[threadId & 31].wait(param1));
   }
}
