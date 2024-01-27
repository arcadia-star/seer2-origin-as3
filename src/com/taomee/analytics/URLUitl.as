package com.taomee.analytics {
internal class URLUitl {


    public function URLUitl() {
        super();
    }

    public static function reviseURL(param1:String):String {
        param1 = String(param1).split("://").join(":||");
        param1 = String(param1).split("//").join("/");
        return String(param1).split(":||").join("://");
    }
}
}
