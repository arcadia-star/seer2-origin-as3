package cmodule.desc
{
   internal function AS3_Stage() : Object
   {
      return !!gsprite ? gsprite.stage : null;
   }
}
