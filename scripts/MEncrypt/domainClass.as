package MEncrypt
{
   public const domainClass:Class = (function():Class
   {
      var avmplusNS:*;
      var flashsystemNS:* = undefined;
      try
      {
         flashsystemNS = new Namespace("flash.system");
         return flashsystemNS::["ApplicationDomain"];
      }
      catch(e:*)
      {
         avmplusNS = new Namespace("avmplus");
         return avmplusNS::["Domain"];
      }
   })();
}
