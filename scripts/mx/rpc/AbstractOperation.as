package mx.rpc
{
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.rpc.events.AbstractEvent;
   
   public class AbstractOperation extends AbstractInvoker
   {
       
      
      public var arguments:Object;
      
      public var properties:Object;
      
      private var resourceManager:IResourceManager;
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") var _service:mx.rpc.AbstractService;
      
      private var _name:String;
      
      public function AbstractOperation(param1:mx.rpc.AbstractService = null, param2:String = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this._service = param1;
         this._name = param2;
         this.arguments = {};
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function set name(param1:String) : void
      {
         var _loc2_:String = null;
         if(!this._name)
         {
            this._name = param1;
            return;
         }
         _loc2_ = String(this.resourceManager.getString("rpc","cannotResetOperationName"));
         throw new Error(_loc2_);
      }
      
      public function get service() : mx.rpc.AbstractService
      {
         return this._service;
      }
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") function setService(param1:mx.rpc.AbstractService) : void
      {
         var _loc2_:String = null;
         if(!this._service)
         {
            this._service = param1;
            return;
         }
         _loc2_ = String(this.resourceManager.getString("rpc","cannotResetService"));
         throw new Error(_loc2_);
      }
      
      public function send(... rest) : AsyncToken
      {
         return null;
      }
      
      override §§namespace("http://www.adobe.com/2006/flex/mx/internal") function dispatchRpcEvent(param1:AbstractEvent) : void
      {
         param1.callTokenResponders();
         if(!param1.isDefaultPrevented())
         {
            if(hasEventListener(param1.type))
            {
               dispatchEvent(param1);
            }
            else if(this._service != null)
            {
               this._service.dispatchEvent(param1);
            }
         }
      }
   }
}
