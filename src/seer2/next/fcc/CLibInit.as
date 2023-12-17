package seer2.next.fcc {
import flash.utils.ByteArray;

public class CLibInit {
    public static const KEY_RAW:String = "taomee_seer2_k_~#t";
    public static const KEY:Array = [116, 97, 111, 109, 101, 101, 95, 115, 101, 101, 114, 50, 95, 107, 95, 126, 35, 116];
    public static const NO_ENCRYPT_LEN:int = 6;

    public static function Desc(cid:uint, len:int, last_seq:int):int {
        var t:int = last_seq / 7;
        return cid % 13 + len % 21 + last_seq + 147 - t;
    }

    public static function encrypt(bytes:ByteArray, outBytes:ByteArray):void {
        outBytes.length = bytes.length + 1;
        var i:int = 0;
        var j:int = NO_ENCRYPT_LEN;
        var len:int = bytes.length;
        while (j < len) {
            if (i == KEY.length) {
                i = 0;
            }
            outBytes[j] = KEY[i] ^ bytes[j];
            i++;
            j++;
        }

        j = outBytes.length - 1;
        while (j > NO_ENCRYPT_LEN) {
            outBytes[j] = outBytes[j] | ((outBytes[j - 1] & 0xFF) >> 3);
            outBytes[j - 1] <<= 5;
            j--;
        }

        outBytes[NO_ENCRYPT_LEN] |= 3;
    }

    public static function decrypt(bytes:ByteArray, outBytes:ByteArray):void {
        outBytes.length = bytes.length - 1;

        var i:int = 0;
        var j:int = NO_ENCRYPT_LEN;
        var len:int = outBytes.length;

        while (j < len) {
            if (i == KEY.length) {
                i = 0;
            }
            outBytes[j] = ((bytes[j] & 0xFF) >> 5) | (bytes[j + 1] << 3);
            outBytes[j] ^= KEY[i];
            i++;
            j++;
        }
    }
}
}
