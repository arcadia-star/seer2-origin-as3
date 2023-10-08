package MEncrypt__3A__5C_alchemy_5C_cygwin_5C_tmp_5C_cc80XT98_2E_lto_2E_bc_3A_1b3fc948_2D_82a0_2D_4fee_2D_a9ab_2D_31c892a97f18
{
   import MEncrypt.CModule;
   
   internal function modAllocSects() : Object
   {
      return {
         ".bss":[CModule.allocDataSect(modPkgName,".bss",220440,16),220440],
         ".ctors":[CModule.allocDataSect(modPkgName,".ctors",4,4),4],
         ".data":[CModule.allocDataSect(modPkgName,".data",3720,16),3720],
         ".data.rel":[CModule.allocDataSect(modPkgName,".data.rel",3816,16),3816],
         ".data.rel.local":[CModule.allocDataSect(modPkgName,".data.rel.local",552,16),552],
         ".data.rel.ro.local":[CModule.allocDataSect(modPkgName,".data.rel.ro.local",856,16),856],
         ".dtors":[CModule.allocDataSect(modPkgName,".dtors",4,4),4],
         ".note.ABI-tag":[CModule.allocDataSect(modPkgName,".note.ABI-tag",24,4),24],
         ".rodata":[CModule.allocDataSect(modPkgName,".rodata",21184,16),21184],
         ".rodata.cst16":[CModule.allocDataSect(modPkgName,".rodata.cst16",320,8),320],
         ".rodata.cst8":[CModule.allocDataSect(modPkgName,".rodata.cst8",112,4),112],
         ".rodata.str1.1":[CModule.allocDataSect(modPkgName,".rodata.str1.1",43,0),43],
         ".rodata.str1.16":[CModule.allocDataSect(modPkgName,".rodata.str1.16",31,16),31],
         ".text":[CModule.allocTextSect(modPkgName,".text",147230),147230]
      };
   }
}
