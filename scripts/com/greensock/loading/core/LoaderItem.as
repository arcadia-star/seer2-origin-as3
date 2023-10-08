package com.greensock.loading.core
{
   import com.greensock.events.LoaderEvent;
   import com.greensock.loading.LoaderStatus;
   import flash.events.Event;
   import flash.events.ProgressEvent;
   import flash.net.URLRequest;
   import flash.net.URLStream;
   import flash.net.URLVariables;
   
   public class LoaderItem extends LoaderCore
   {
      
      protected static var _cacheID:Number = new Date().getTime();
       
      
      protected var _auditStream:URLStream;
      
      protected var _request:URLRequest;
      
      protected var _skipAlternateURL:Boolean;
      
      protected var _scriptAccessDenied:Boolean;
      
      protected var _url:String;
      
      protected var _preferEstimatedBytesInAudit:Boolean;
      
      protected var _httpStatus:int;
      
      public function LoaderItem(param1:*, param2:Object = null)
      {
         super(param2);
         _request = param1 is URLRequest ? param1 as URLRequest : new URLRequest(param1);
         _url = _request.url;
         _setRequestURL(_request,_url);
      }
      
      public function get scriptAccessDenied() : Boolean
      {
         return _scriptAccessDenied;
      }
      
      override protected function _failHandler(param1:Event, param2:Boolean = true) : void
      {
         if(this.vars.alternateURL != undefined && this.vars.alternateURL != "" && !_skipAlternateURL)
         {
            _skipAlternateURL = true;
            _url = "temp" + Math.random();
            this.url = this.vars.alternateURL;
            _errorHandler(param1);
         }
         else
         {
            super._failHandler(param1,param2);
         }
      }
      
      public function get request() : URLRequest
      {
         return _request;
      }
      
      protected function _httpStatusHandler(param1:Event) : void
      {
         _httpStatus = (param1 as Object).status;
         dispatchEvent(new LoaderEvent(LoaderEvent.HTTP_STATUS,this));
      }
      
      override protected function _dump(param1:int = 0, param2:int = 0, param3:Boolean = false) : void
      {
         _closeStream();
         super._dump(param1,param2,param3);
      }
      
      protected function _closeStream() : void
      {
         if(_auditStream != null)
         {
            _auditStream.removeEventListener(ProgressEvent.PROGRESS,_auditStreamHandler);
            _auditStream.removeEventListener(Event.COMPLETE,_auditStreamHandler);
            _auditStream.removeEventListener("ioError",_auditStreamHandler);
            _auditStream.removeEventListener("securityError",_auditStreamHandler);
            try
            {
               _auditStream.close();
            }
            catch(error:Error)
            {
            }
            _auditStream = null;
         }
      }
      
      public function set url(param1:String) : void
      {
         var _loc2_:Boolean = false;
         if(_url != param1)
         {
            _url = param1;
            _setRequestURL(_request,_url);
            _loc2_ = Boolean(_status == LoaderStatus.LOADING);
            _dump(0,LoaderStatus.READY,true);
            if(_loc2_)
            {
               _load();
            }
         }
      }
      
      public function get httpStatus() : int
      {
         return _httpStatus;
      }
      
      protected function _prepRequest() : void
      {
         _scriptAccessDenied = false;
         _httpStatus = 0;
         _closeStream();
         if(Boolean(this.vars.noCache) && (!_isLocal || _url.substr(0,4) == "http"))
         {
            _setRequestURL(_request,_url,"gsCacheBusterID=" + _cacheID++);
         }
      }
      
      protected function _setRequestURL(param1:URLRequest, param2:String, param3:String = "") : void
      {
         var _loc8_:URLVariables = null;
         var _loc9_:Array = null;
         var _loc4_:Array;
         var _loc5_:String = String((_loc4_ = !!this.vars.allowMalformedURL ? [param2] : param2.split("?"))[0]);
         var _loc6_:String = "";
         var _loc7_:int = 0;
         while(_loc7_ < _loc5_.length)
         {
            _loc6_ += _loc5_.charAt(_loc7_);
            _loc7_++;
         }
         param1.url = _loc6_;
         if(_loc4_.length >= 2)
         {
            param3 += param3 == "" ? _loc4_[1] : "&" + _loc4_[1];
         }
         if(param3 != "")
         {
            _loc8_ = param1.data == null ? new URLVariables() : param1.data as URLVariables;
            _loc7_ = int((_loc4_ = param3.split("&")).length);
            while(--_loc7_ > -1)
            {
               _loc9_ = _loc4_[_loc7_].split("=");
               _loc8_[_loc9_.shift()] = _loc9_.join("=");
            }
            param1.data = _loc8_;
         }
      }
      
      protected function _auditStreamHandler(param1:Event) : void
      {
         var _loc2_:URLRequest = null;
         if(param1 is ProgressEvent)
         {
            _cachedBytesTotal = (param1 as ProgressEvent).bytesTotal;
            if(_preferEstimatedBytesInAudit && uint(this.vars.estimatedBytes) > _cachedBytesTotal)
            {
               _cachedBytesTotal = uint(this.vars.estimatedBytes);
            }
         }
         else if(param1.type == "ioError" || param1.type == "securityError")
         {
            if(this.vars.alternateURL != undefined && this.vars.alternateURL != "" && this.vars.alternateURL != _url)
            {
               _url = this.vars.alternateURL;
               _setRequestURL(_request,_url);
               _loc2_ = new URLRequest();
               _loc2_.data = _request.data;
               _setRequestURL(_loc2_,_url,!_isLocal || _url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
               _auditStream.load(_loc2_);
               _errorHandler(param1);
               return;
            }
            super._failHandler(param1);
         }
         _auditedSize = true;
         _closeStream();
         dispatchEvent(new Event("auditedSize"));
      }
      
      public function get url() : String
      {
         return _url;
      }
      
      override public function auditSize() : void
      {
         var _loc1_:URLRequest = null;
         if(_auditStream == null)
         {
            _auditStream = new URLStream();
            _auditStream.addEventListener(ProgressEvent.PROGRESS,_auditStreamHandler,false,0,true);
            _auditStream.addEventListener(Event.COMPLETE,_auditStreamHandler,false,0,true);
            _auditStream.addEventListener("ioError",_auditStreamHandler,false,0,true);
            _auditStream.addEventListener("securityError",_auditStreamHandler,false,0,true);
            _loc1_ = new URLRequest();
            _loc1_.data = _request.data;
            _setRequestURL(_loc1_,_url,!_isLocal || _url.substr(0,4) == "http" ? "gsCacheBusterID=" + _cacheID++ + "&purpose=audit" : "");
            _auditStream.load(_loc1_);
         }
      }
   }
}
