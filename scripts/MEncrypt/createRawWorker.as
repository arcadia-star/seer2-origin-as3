package MEncrypt
{
   import flash.utils.ByteArray;
   
   public function createRawWorker(param1:ByteArray) : *
   {
      return workerDomainClass["current"].createWorker(param1);
   }
}
