package MEncrypt
{
   public function ptr2funInit() : *
   {
      var _loc1_:Vector.<Function> = null;
      if(typeof ptr2fun != "undefined" && ptr2fun == null && ptr2fun_init is Array)
      {
         new Vector.<Function>().push.apply(null,ptr2fun_init);
         ptr2fun_init.length = 0;
         ptr2fun_init = new Vector.<Function>();
      }
      return ptr2fun_init;
   }
}
