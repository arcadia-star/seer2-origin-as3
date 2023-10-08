package mx.messaging.config
{
   import flash.display.DisplayObject;
   import mx.utils.LoaderUtil;
   
   public class LoaderConfig
   {
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static const VERSION:String = "4.6.0.23201";
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static var _parameters:Object;
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static var _swfVersion:uint;
      
      §§namespace("http://www.adobe.com/2006/flex/mx/internal") static var _url:String = null;
       
      
      public function LoaderConfig()
      {
         super();
      }
      
      public static function init(param1:DisplayObject) : void
      {
         if(!_url)
         {
            _url = LoaderUtil.normalizeURL(param1.loaderInfo);
            _parameters = param1.loaderInfo.parameters;
            _swfVersion = param1.loaderInfo.swfVersion;
         }
      }
      
      public static function get parameters() : Object
      {
         return _parameters;
      }
      
      public static function get swfVersion() : uint
      {
         return _swfVersion;
      }
      
      public static function get url() : String
      {
         return _url;
      }
   }
}
