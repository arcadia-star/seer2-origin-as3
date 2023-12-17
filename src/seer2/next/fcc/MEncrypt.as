package seer2.next.fcc {
import flash.utils.ByteArray;

public function MEncrypt(param1:ByteArray, param2:int, param3:ByteArray):void {
    CLibInit.encrypt(param1, param3);
}
}
