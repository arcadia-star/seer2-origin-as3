package MEncrypt
{
   public function longjmp(param1:int, param2:int) : void
   {
      var _loc4_:int = CModule.read32(param1 + 4);
      var _loc3_:int = CModule.read32(param1 + 8);
      throw new LongJmp(_loc3_,_loc4_,param2);
   }
}
