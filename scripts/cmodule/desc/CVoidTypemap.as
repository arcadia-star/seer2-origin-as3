package cmodule.desc
{
   internal class CVoidTypemap extends CTypemap
   {
       
      
      public function CVoidTypemap()
      {
         super();
      }
      
      override public function fromReturnRegs(param1:Object) : *
      {
         return undefined;
      }
      
      override public function toReturnRegs(param1:Object, param2:*, param3:int = 0) : void
      {
      }
      
      override public function get typeSize() : int
      {
         return 0;
      }
   }
}
