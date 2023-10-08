package mx.messaging.messages
{
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class AcknowledgeMessageExt extends mx.messaging.messages.AcknowledgeMessage implements IExternalizable
   {
       
      
      private var _message:mx.messaging.messages.AcknowledgeMessage;
      
      public function AcknowledgeMessageExt(param1:mx.messaging.messages.AcknowledgeMessage = null)
      {
         super();
         this._message = param1;
      }
      
      override public function writeExternal(param1:IDataOutput) : void
      {
         if(this._message != null)
         {
            this._message.writeExternal(param1);
         }
         else
         {
            super.writeExternal(param1);
         }
      }
      
      override public function get messageId() : String
      {
         if(this._message != null)
         {
            return this._message.messageId;
         }
         return super.messageId;
      }
   }
}
