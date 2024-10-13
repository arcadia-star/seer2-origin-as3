package test {
import flash.display.Loader;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.clearTimeout;
import flash.utils.setTimeout;

internal class RequestPool {
    public static function sendSwfRequest(url:String, onSuccess:Function, onError:Function = null):void {
        var loader:Loader = new Loader();
        loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (event:Event):void {
            clearTimeout(timerId);
            onSuccess && onSuccess(loader.contentLoaderInfo.applicationDomain);
        });
        loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event):void {
            clearTimeout(timerId);
            onError && onError("Request failed: " + event.toString());
        });
        var timerId:Number = setTimeout(function ():void {
            onError && onError("Request timeout")
        }, 5000);
        loader.load(new URLRequest(url));
    }

    public static function sendHttpGetRequest(url:String, onSuccess:Function, onError:Function = null):void {
        var urlLoader:URLLoader = new URLLoader();
        urlLoader.addEventListener(Event.COMPLETE, function (event:Event):void {
            clearTimeout(timerId);
            onSuccess && onSuccess(urlLoader.data);
        });
        urlLoader.addEventListener(IOErrorEvent.IO_ERROR, function (event:Event):void {
            clearTimeout(timerId);
            onError && onError("Request failed: " + event.toString());
        });
        var timerId:Number = setTimeout(function ():void {
            onError && onError("Request timeout")
        }, 5000);
        urlLoader.load(new URLRequest(url));
    }

}
}