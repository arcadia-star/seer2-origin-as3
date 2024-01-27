package seer2.next.entry {
import com.adobe.crypto.MD5;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.loader.LoadType;
import com.taomee.seer2.core.loader.UILoader;
import com.taomee.seer2.core.utils.URLUtil;

import flash.utils.ByteArray;

import mx.utils.Base64Decoder;

public class UrlRewriter {


    public function UrlRewriter() {
        super();
    }

    public static function loadConfig():void {
        UILoader.load("config/bloom-path.data", LoadType.TEXT, function (param1:ContentInfo):void {
            var mightContains:Function = parseData(param1.content);
            URLUtil.rewrite = function (param1:String):String {
                var path:String = "/" + getPathFromURL(param1);
                if (Boolean(mightContains(path))) {
                    trace("seer2-next-url-rewrite hit: " + param1);
                    return param1;
                }
                trace("seer2-next-url-rewrite miss: " + param1);
                return (DynSwitch.bloomfilterFallbackUrl || "//seer2.61.com/") + param1;
            };
        });
    }

    public static function parseData(data:String):Function {
        var base64Decoded:ByteArray;
        var bloom:Vector.<Boolean>;
        var byte0:uint;
        var i:int;
        var mightContains:Function;
        var split:Array = data.split("\n");
        var func_num:uint = uint(split[1]);
        var base64Decoder:Base64Decoder = new Base64Decoder();
        base64Decoder.decode(split[2]);
        base64Decoded = base64Decoder.toByteArray();
        base64Decoded.position = 0;
        bloom = new Vector.<Boolean>();
        while (base64Decoded.bytesAvailable > 0) {
            byte0 = base64Decoded.readUnsignedByte();
            i = 0;
            while (i < 8) {
                bloom.push((byte0 >> i & 1) == 1);
                i++;
            }
        }
        mightContains = function (data:String):Boolean {
            var md5:String = String(MD5.hash(data));
            var hash1:uint = uint(uint("0x" + md5.substr(0, 8)) ^ uint("0x" + md5.substr(8, 8)));
            var hash2:uint = uint(uint("0x" + md5.substr(16, 8)) ^ uint("0x" + md5.substr(24, 8)));
            var combinedHash:uint = hash1;
            var j:int = 0;
            while (j < func_num) {
                if (!bloom[combinedHash % bloom.length]) {
                    return false;
                }
                combinedHash += hash2;
                j++;
            }
            return true;
        };
        return mightContains;
    }

    public static function getPathFromURL(url:String):String {
        var index:int = url.indexOf("?");
        if (index != -1) {
            url = url.substring(0, index);
        }
        return url;
    }
}
}
