package MEncrypt.vfs
{
   import flash.utils.ByteArray;
   
   public interface IVFS
   {
       
      
      function addBackingStore(param1:IBackingStore, param2:String) : void;
      
      function addFile(param1:String, param2:ByteArray) : void;
      
      function addDirectory(param1:String) : void;
      
      function deleteFile(param1:String) : void;
      
      function set console(param1:ISpecialFile) : void;
      
      function get console() : ISpecialFile;
      
      function addSpecialFile(param1:String, param2:ISpecialFile) : void;
      
      function getDirectoryEntries(param1:String) : Vector.<FileHandle>;
      
      function checkPath(param1:String) : String;
      
      function openFile(param1:FileHandle, param2:int = -1) : int;
      
      function closeFile(param1:int) : void;
      
      function isValidFileDescriptor(param1:int) : Boolean;
      
      function getFileHandleFromPath(param1:String) : FileHandle;
      
      function getFileHandleFromFileDescriptor(param1:int) : FileHandle;
   }
}
