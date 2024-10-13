package seer2.next.utils {
public class TextUtils {
    public function TextUtils() {

    }

    /**
     * [颜色]文字[-]
     */
    public static function replaceColorFormat(input:String):String {
        // 先替换 [br] 为 <br>
        input = input.replace(/\[br]/g, "<br>");

        // 使用正则表达式匹配 [颜色]文字[-] 格式
        var pattern:RegExp = /\[(\w+)](.*?)\[-]/g;

        // 使用 replace 方法进行替换
        var output:String = input.replace(pattern, "<font color='#$1'>$2</font>");

        return output;
    }

    public static function wrapHtmlFontSize(input:String):String {
        return "<font color='#ffffff' size='10'>" + input + "</font>"
    }
}
}
