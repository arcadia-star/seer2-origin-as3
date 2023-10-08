package mx.rpc.events
{
   import mx.messaging.events.MessageEvent;
   import mx.messaging.messages.IMessage;
   import mx.rpc.AsyncToken;
   
   public class AbstractEvent extends MessageEvent
   {
       
      
      private var _token:AsyncToken;
      
      public function AbstractEvent(param1:String, param2:Boolean = false, param3:Boolean = true, param4:AsyncToken = null, param5:IMessage = null)
      {
         super(param1,param2,param3,param5);
         this._token = param4;
      }
      
      public function get token() : AsyncToken
      {
         return this._token;
      }
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") function setToken(param1:AsyncToken) : void
      {
         this._token = param1;
      }
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") function callTokenResponders() : void
      {
      }
   }
}
