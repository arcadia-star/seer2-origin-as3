package MEncrypt
{
   public const workerClass:Class = mutexClass && conditionClass && workerDomainClass && (function():Class
   {
      var flashsystemNS:* = undefined;
      try
      {
         flashsystemNS = new Namespace("flash.system");
         return flashsystemNS::["Worker"];
      }
      catch(e:*)
      {
         return null;
      }
   })();
}
