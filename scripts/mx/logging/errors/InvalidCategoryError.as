package mx.logging.errors
{
   public class InvalidCategoryError extends Error
   {
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static const VERSION:String = "4.6.0.23201";
       
      
      public function InvalidCategoryError(param1:String)
      {
         super(param1);
      }
      
      public function toString() : String
      {
         return String(message);
      }
   }
}
