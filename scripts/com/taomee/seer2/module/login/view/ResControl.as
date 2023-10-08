package com.taomee.seer2.module.login.view
{
   import com.adobe.images.JPGEncoder;
   import com.adobe.serialization.json.JSON;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Loader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import org.taomee.register.event.CaptchaEvent;
   import org.taomee.register.event.RegisterFailEvent;
   import org.taomee.register.event.RegisterSuccessEvent;
   import org.taomee.register.util.RegisterErrorCode;
   
   public class ResControl extends EventDispatcher
   {
      
      private static var _instance:com.taomee.seer2.module.login.view.ResControl;
       
      
      private var _gameId:int = 0;
      
      private var _authCodeSessionId:String;
      
      private var _captchaLoader:Loader;
      
      private var _registerServiceUrl:String = "http://account-httpd.61.com/index.php";
      
      private var _tmCid:String = "0";
      
      private var file:FileReference;
      
      public function ResControl()
      {
         super();
      }
      
      public static function get instance() : com.taomee.seer2.module.login.view.ResControl
      {
         if(_instance == null)
         {
            _instance = new com.taomee.seer2.module.login.view.ResControl();
         }
         return _instance;
      }
      
      public function setup(param1:int, param2:String, param3:String) : void
      {
         this._gameId = param1;
         this._registerServiceUrl = param2;
         this._tmCid = param3;
      }
      
      public function submitRegister(param1:String, param2:String) : void
      {
         if(this._gameId == 0)
         {
            throw new Error("注册参数错误，gameid为0未被初始化，请确定在调用submitRegister()方法前已调用step初始化方法，并传入了正确参数");
         }
         var _loc3_:* = new URLRequest();
         _loc3_.url = this._registerServiceUrl;
         _loc3_.method = URLRequestMethod.POST;
         var _loc4_:*;
         (_loc4_ = new URLVariables()).cmd = 1102;
         _loc4_.pwd = param1;
         _loc4_.cfmpwd = param1;
         _loc4_.seccode = param2;
         _loc4_.gid = this._gameId;
         _loc4_.tad = this._tmCid;
         _loc3_.data = _loc4_;
         var _loc5_:*;
         (_loc5_ = new URLLoader()).load(_loc3_);
         _loc5_.addEventListener(Event.COMPLETE,this.onRegisterComplete);
         _loc5_.addEventListener(IOErrorEvent.IO_ERROR,this.onRegisterIOError);
      }
      
      private function onRegisterComplete(param1:Event) : void
      {
         var resalt:*;
         var json:Object = null;
         var mimiNumber:int = 0;
         var event:Event = param1;
         ;
         var data:* = String(event.target.data);
         try
         {
            json = com.adobe.serialization.json.JSON.decode(data);
         }
         catch(e:Error)
         {
         }
         resalt = json["result"];
         if(resalt == 0)
         {
            mimiNumber = int(json["userid"]);
            dispatchEvent(new RegisterSuccessEvent(RegisterSuccessEvent.REGISTER_SUCCESS,mimiNumber));
         }
         else
         {
            dispatchEvent(new RegisterFailEvent(RegisterFailEvent.REGISTER_FAIL,resalt));
         }
      }
      
      private function onRegisterIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(new RegisterFailEvent(RegisterFailEvent.REGISTER_FAIL,RegisterErrorCode.SYSTEM_ERROR));
      }
      
      public function requestCaptcha() : void
      {
         var _loc1_:* = new URLRequest();
         _loc1_.url = this._registerServiceUrl + "?cmd=1101&type=4&rnd=" + Math.random();
         var _loc2_:* = new LoaderContext(true);
         this._captchaLoader = new Loader();
         this._captchaLoader.load(_loc1_,_loc2_);
         this._captchaLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onCaptchaComplete);
         this._captchaLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onCaptchaIOError);
      }
      
      private function onCaptchaComplete(param1:Event) : void
      {
         var _loc2_:* = this._captchaLoader.content as Bitmap;
         if(_loc2_ != null)
         {
            dispatchEvent(new CaptchaEvent(CaptchaEvent.REGISTER_CAPTCHA_RECEIVED,_loc2_));
         }
         else
         {
            this.onCaptchaIOError(null);
         }
      }
      
      private function onCaptchaIOError(param1:IOErrorEvent) : void
      {
         dispatchEvent(new CaptchaEvent(CaptchaEvent.REGISTER_CAPTCHA_LOAD_ERROR,null));
      }
      
      public function savePasswordByDisplayObject(param1:int, param2:DisplayObject) : void
      {
         var _loc3_:* = this.getDisplayObjectJpegEncode(param2);
         if(this.file == null)
         {
            this.file = new FileReference();
         }
         this.file.save(_loc3_,"我的淘米帐号 - " + param1 + ".jpg");
      }
      
      private function getDisplayObjectJpegEncode(param1:DisplayObject) : ByteArray
      {
         var _loc2_:* = new BitmapData(param1.width,param1.height);
         _loc2_.draw(param1);
         var _loc3_:* = new JPGEncoder(85);
         return _loc3_.encode(_loc2_);
      }
   }
}
