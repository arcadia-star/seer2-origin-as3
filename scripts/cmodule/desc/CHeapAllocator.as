package cmodule.desc
{
   internal class CHeapAllocator implements ICAllocator
   {
       
      
      private var pmalloc:Function;
      
      private var pfree:Function;
      
      public function CHeapAllocator()
      {
         super();
      }
      
      public function free(param1:int) : void
      {
         if(this.pfree == null)
         {
            this.pfree = new CProcTypemap(CTypemap.VoidType,[CTypemap.PtrType]).fromC([_free]);
         }
         this.pfree(param1);
      }
      
      public function alloc(param1:int) : int
      {
         var _loc2_:int = 0;
         if(this.pmalloc == null)
         {
            this.pmalloc = new CProcTypemap(CTypemap.PtrType,[CTypemap.IntType]).fromC([_malloc]);
         }
         return this.pmalloc(param1);
      }
   }
}
