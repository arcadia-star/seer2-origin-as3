package seer2.next.fcc {
import flash.utils.ByteArray;
import flash.utils.Endian;

public function MDecrypt(param1:ByteArray, param2:int, param3:ByteArray):void {
    var bytes:ByteArray = new ByteArray();
    bytes.endian = Endian.LITTLE_ENDIAN;
    bytes.writeUnsignedInt(0);
    bytes.writeShort(0);
    param1.readBytes(bytes, 6, param2);
    CLibInit.decrypt(bytes, param3);
}
}
