package MEncrypt
{
   public function sbrk(param1:int, param2:int) : int
   {
      var casLen:int = 0;
      var size:int = param1;
      var align:int = param2;
      var curLen:int = int(ram_init.length);
      var result:int = curLen + align - 1 & -align;
      var newLen:int = result + size;
      if(workerClass)
      {
         while(true)
         {
            try
            {
               casLen = int(ram_init.atomicCompareAndSwapLength(curLen,newLen));
            }
            catch(e:*)
            {
               if(throwWhenOutOfMemory)
               {
                  throw e;
               }
               return -1;
            }
            if(casLen == curLen)
            {
               break;
            }
            curLen = casLen;
            result = curLen + align - 1 & -align;
            newLen = result + size;
         }
      }
      else
      {
         try
         {
            ram_init.length = newLen;
         }
         catch(e:*)
         {
            if(throwWhenOutOfMemory)
            {
               throw e;
            }
            return -1;
         }
      }
      return result;
   }
}
