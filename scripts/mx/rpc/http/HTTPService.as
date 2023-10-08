package mx.rpc.http
{
   import mx.messaging.ChannelSet;
   import mx.messaging.config.LoaderConfig;
   import mx.rpc.AbstractInvoker;
   import mx.rpc.AsyncRequest;
   import mx.rpc.AsyncToken;
   import mx.utils.URLUtil;
   
   public class HTTPService extends AbstractInvoker
   {
      
      public static const RESULT_FORMAT_E4X:String = "e4x";
      
      public static const RESULT_FORMAT_FLASHVARS:String = "flashvars";
      
      public static const RESULT_FORMAT_OBJECT:String = "object";
      
      public static const RESULT_FORMAT_ARRAY:String = "array";
      
      public static const RESULT_FORMAT_TEXT:String = "text";
      
      public static const RESULT_FORMAT_XML:String = "xml";
      
      public static const CONTENT_TYPE_XML:String = "application/xml";
      
      public static const CONTENT_TYPE_FORM:String = "application/x-www-form-urlencoded";
      
      public static const DEFAULT_DESTINATION_HTTP:String = "DefaultHTTP";
      
      public static const DEFAULT_DESTINATION_HTTPS:String = "DefaultHTTPS";
      
      public static const ERROR_URL_REQUIRED:String = "Client.URLRequired";
      
      public static const ERROR_DECODING:String = "Client.CouldNotDecode";
      
      public static const ERROR_ENCODING:String = "Client.CouldNotEncode";
       
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") var operation:mx.rpc.http.AbstractOperation;
      
      public function HTTPService(param1:String = null, param2:String = null)
      {
         super();
         this.operation = new HTTPOperation(this);
         this.operation.makeObjectsBindable = true;
         this.operation._rootURL = param1;
         if(param2 == null)
         {
            if(URLUtil.isHttpsURL(LoaderConfig.url))
            {
               this.asyncRequest.destination = DEFAULT_DESTINATION_HTTPS;
            }
            else
            {
               this.asyncRequest.destination = DEFAULT_DESTINATION_HTTP;
            }
         }
         else
         {
            this.asyncRequest.destination = param2;
            this.useProxy = true;
         }
      }
      
      override public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         this.operation.addEventListener(param1,param2,param3,param4,param5);
         super.addEventListener(param1,param2,param3,param4,param5);
      }
      
      override public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         this.operation.removeEventListener(param1,param2,param3);
         super.removeEventListener(param1,param2,param3);
      }
      
      override §§namespace("http://www.adobe.com/2006/flex/mx/internal") function set asyncRequest(param1:AsyncRequest) : void
      {
         this.operation.asyncRequest = param1;
      }
      
      override §§namespace("http://www.adobe.com/2006/flex/mx/internal") function get asyncRequest() : AsyncRequest
      {
         return this.operation.asyncRequest;
      }
      
      public function get channelSet() : ChannelSet
      {
         return this.asyncRequest.channelSet;
      }
      
      public function set channelSet(param1:ChannelSet) : void
      {
         this.useProxy = true;
         this.asyncRequest.channelSet = param1;
      }
      
      public function get contentType() : String
      {
         return this.operation.contentType;
      }
      
      public function set contentType(param1:String) : void
      {
         this.operation.contentType = param1;
      }
      
      public function get concurrency() : String
      {
         return this.operation.concurrency;
      }
      
      public function set concurrency(param1:String) : void
      {
         this.operation.concurrency = param1;
      }
      
      public function get destination() : String
      {
         return this.asyncRequest.destination;
      }
      
      public function set destination(param1:String) : void
      {
         this.useProxy = true;
         this.asyncRequest.destination = param1;
      }
      
      override public function get makeObjectsBindable() : Boolean
      {
         return this.operation.makeObjectsBindable;
      }
      
      override public function set makeObjectsBindable(param1:Boolean) : void
      {
         this.operation.makeObjectsBindable = param1;
      }
      
      public function get headers() : Object
      {
         return this.operation.headers;
      }
      
      public function set headers(param1:Object) : void
      {
         this.operation.headers = param1;
      }
      
      public function get method() : String
      {
         return this.operation.method;
      }
      
      public function set method(param1:String) : void
      {
         this.operation.method = param1;
      }
      
      public function get request() : Object
      {
         return this.operation.request;
      }
      
      public function set request(param1:Object) : void
      {
         this.operation.request = param1;
      }
      
      public function get resultFormat() : String
      {
         return this.operation.resultFormat;
      }
      
      public function set resultFormat(param1:String) : void
      {
         this.operation.resultFormat = param1;
      }
      
      public function get rootURL() : String
      {
         return this.operation.rootURL;
      }
      
      public function set rootURL(param1:String) : void
      {
         this.operation.rootURL = param1;
      }
      
      public function get showBusyCursor() : Boolean
      {
         return this.operation.showBusyCursor;
      }
      
      public function set showBusyCursor(param1:Boolean) : void
      {
         this.operation.showBusyCursor = param1;
      }
      
      public function get serializationFilter() : SerializationFilter
      {
         return this.operation.serializationFilter;
      }
      
      public function set serializationFilter(param1:SerializationFilter) : void
      {
         this.operation.serializationFilter = param1;
      }
      
      public function get url() : String
      {
         return this.operation.url;
      }
      
      public function set url(param1:String) : void
      {
         this.operation.url = param1;
      }
      
      public function get useProxy() : Boolean
      {
         return this.operation.useProxy;
      }
      
      public function set useProxy(param1:Boolean) : void
      {
         this.operation.useProxy = param1;
      }
      
      public function get xmlDecode() : Function
      {
         return this.operation.xmlDecode;
      }
      
      public function set xmlDecode(param1:Function) : void
      {
         this.operation.xmlDecode = param1;
      }
      
      public function get xmlEncode() : Function
      {
         return this.operation.xmlEncode;
      }
      
      public function set xmlEncode(param1:Function) : void
      {
         this.operation.xmlEncode = param1;
      }
      
      [Bindable("resultForBinding")]
      override public function get lastResult() : Object
      {
         return this.operation.lastResult;
      }
      
      override public function clearResult(param1:Boolean = true) : void
      {
         this.operation.clearResult(param1);
      }
      
      public function get requestTimeout() : int
      {
         return this.asyncRequest.requestTimeout;
      }
      
      public function set requestTimeout(param1:int) : void
      {
         if(this.asyncRequest.requestTimeout != param1)
         {
            this.asyncRequest.requestTimeout = param1;
            if(this.operation)
            {
               this.operation.requestTimeout = param1;
            }
         }
      }
      
      public function logout() : void
      {
         this.asyncRequest.logout();
      }
      
      public function send(param1:Object = null) : AsyncToken
      {
         if(param1 == null)
         {
            param1 = this.request;
         }
         return this.operation.sendBody(param1);
      }
      
      public function disconnect() : void
      {
         this.asyncRequest.disconnect();
      }
      
      public function setCredentials(param1:String, param2:String, param3:String = null) : void
      {
         this.asyncRequest.setCredentials(param1,param2,param3);
      }
      
      public function setRemoteCredentials(param1:String, param2:String, param3:String = null) : void
      {
         this.asyncRequest.setRemoteCredentials(param1,param2,param3);
      }
      
      override public function cancel(param1:String = null) : AsyncToken
      {
         return this.operation.cancel(param1);
      }
   }
}

import mx.rpc.events.AbstractEvent;
import mx.rpc.http.AbstractOperation;
import mx.rpc.http.HTTPService;

class HTTPOperation extends AbstractOperation
{
    
   
   private var httpService:HTTPService;
   
   public function HTTPOperation(param1:HTTPService, param2:String = null)
   {
      super(null,param2);
      this.httpService = param1;
   }
   
   override §§namespace("http://www.adobe.com/2006/flex/mx/internal") function dispatchRpcEvent(param1:AbstractEvent) : void
   {
      if(hasEventListener(param1.type))
      {
         param1.callTokenResponders();
         if(!param1.isDefaultPrevented())
         {
            dispatchEvent(param1);
         }
      }
      else if(this.httpService != null)
      {
         this.httpService.dispatchRpcEvent(param1);
      }
      else
      {
         param1.callTokenResponders();
      }
   }
}
