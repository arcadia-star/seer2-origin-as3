package MEncrypt
{
   public const workerDomainClass:Class = (function():Class
   {
      var flashsystemNS:* = undefined;
      try
      {
         flashsystemNS = new Namespace("flash.system");
         return flashsystemNS::["WorkerDomain"];
      }
      catch(e:*)
      {
         return null;
      }
   })();
}
