package MEncrypt
{
   public function setjmp(param1:int, param2:int, param3:int) : int
   {
      CModule.write32(param1 + 4,param2);
      CModule.write32(param1 + 8,param3);
      return 0;
   }
}
