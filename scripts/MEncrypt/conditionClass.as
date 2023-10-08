package MEncrypt
{
   public const conditionClass:Class = (function():Class
   {
      var flashconcNS:* = undefined;
      try
      {
         flashconcNS = new Namespace("flash.concurrent");
         return flashconcNS::["Condition"];
      }
      catch(e:*)
      {
         return null;
      }
   })();
}
