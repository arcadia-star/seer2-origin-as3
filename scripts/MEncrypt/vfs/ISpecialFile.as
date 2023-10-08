package MEncrypt.vfs
{
   public interface ISpecialFile
   {
       
      
      function read(param1:int, param2:int, param3:int, param4:int) : int;
      
      function write(param1:int, param2:int, param3:int, param4:int) : int;
      
      function fcntl(param1:int, param2:int, param3:int, param4:int) : int;
      
      function ioctl(param1:int, param2:int, param3:int, param4:int) : int;
   }
}

const §0§;
