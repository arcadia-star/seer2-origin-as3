package seer2.next.utils {
import flash.external.ExternalInterface;

public class JsUtils {
    public static function call(func:String, ...rest):void {
        if (ExternalInterface.available) {
            ExternalInterface.call(func, rest);
        }
    }
}
}
