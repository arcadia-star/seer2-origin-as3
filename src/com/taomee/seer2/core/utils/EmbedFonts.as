package com.taomee.seer2.core.utils {
import flash.text.Font;

public class EmbedFonts {

    private static var _HuakangZhongyiFont:Font;

    {
        Font.registerFont(HuakangZhongyiFont);
    }

    public function EmbedFonts() {
        super();
    }

    public static function getHuakangZhongyiFontName():String {
        if (_HuakangZhongyiFont == null) {
            _HuakangZhongyiFont = new HuakangZhongyiFont() as Font;
        }
        return _HuakangZhongyiFont.fontName;
    }
}
}
