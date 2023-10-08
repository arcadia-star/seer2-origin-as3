package MEncrypt
{
   public function createflasccWorker() : *
   {
      if(!workerSWFBytes)
      {
         workerSWFBytes = retargetSWF();
      }
      return workerDomainClass["current"].createWorker(workerSWFBytes);
   }
}
