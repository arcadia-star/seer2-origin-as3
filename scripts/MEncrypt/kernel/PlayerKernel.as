package MEncrypt.kernel
{
   import MEncrypt.CModule;
   import MEncrypt.ram;
   import MEncrypt.vfs.FileHandle;
   import MEncrypt.vfs.PathUtils;
   import MEncrypt.workerClass;
   import MEncrypt.yield;
   import flash.utils.ByteArray;
   
   public class PlayerKernel implements IKernel
   {
       
      
      private var _ruid:int = 0;
      
      private var _euid:int = 0;
      
      private var _egid:int = 0;
      
      public function PlayerKernel()
      {
         super();
      }
      
      private function getFileHandleFromFileDescriptor(param1:int, param2:int) : FileHandle
      {
         var _loc3_:FileHandle = CModule.vfs.getFileHandleFromFileDescriptor(param1);
         if(!_loc3_)
         {
            CModule.write32(param2,9);
         }
         return _loc3_;
      }
      
      private function create(param1:String) : FileHandle
      {
         CModule.vfs.addFile(param1,new ByteArray());
         return CModule.vfs.getFileHandleFromPath(param1);
      }
      
      private function readNullTerminatedStr(param1:int) : String
      {
         var _loc2_:* = 0;
         _loc2_ = 0;
         while(CModule.read8(param1 + _loc2_) != 0)
         {
            _loc2_++;
         }
         return CModule.readString(param1,_loc2_);
      }
      
      public function read(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:FileHandle;
         if(!(_loc6_ = getFileHandleFromFileDescriptor(param1,param4)))
         {
            return -1;
         }
         if(!_loc6_.readable)
         {
            CModule.write32(param4,9);
            return -1;
         }
         if(_loc6_.isDirectory)
         {
            CModule.write32(param4,21);
            return -1;
         }
         if(_loc6_.callback)
         {
            return _loc6_.callback.read(param1,param2,param3,param4);
         }
         _loc6_.bytes.position = _loc6_.position;
         var _loc5_:uint;
         if((_loc5_ = Math.min(param3,_loc6_.bytes.bytesAvailable)) > 0)
         {
            CModule.writeBytes(param2,_loc5_,_loc6_.bytes);
         }
         _loc6_.position = _loc6_.bytes.position;
         return _loc5_;
      }
      
      public function write(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:* = 0;
         var _loc5_:FileHandle;
         if(!(_loc5_ = getFileHandleFromFileDescriptor(param1,param4)))
         {
            return -1;
         }
         if(_loc5_.callback)
         {
            return _loc5_.callback.write(param1,param2,param3,param4);
         }
         if(_loc5_.writeable)
         {
            _loc5_.bytes.position = _loc5_.appending ? _loc5_.bytes.length : _loc5_.position;
            _loc6_ = 0;
            while(_loc6_ < param3)
            {
               _loc5_.bytes.writeByte(CModule.read8(param2 + _loc6_));
               _loc6_++;
            }
            _loc5_.position = _loc5_.bytes.position;
         }
         else
         {
            CModule.write32(param4,9);
            param3 = -1;
         }
         return param3;
      }
      
      private function iov(param1:int, param2:int, param3:int, param4:int, param5:Function) : int
      {
         var _loc8_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < param3)
         {
            if((_loc6_ = param5(param1,CModule.read32(param2),CModule.read32(param2 + 4),param4)) < 0)
            {
               return -1;
            }
            _loc7_ += _loc6_;
            param2 += 8;
            _loc8_++;
         }
         return _loc7_;
      }
      
      public function writev(param1:int, param2:int, param3:int, param4:int) : int
      {
         return iov(param1,param2,param3,param4,write);
      }
      
      public function readv(param1:int, param2:int, param3:int, param4:int) : int
      {
         return iov(param1,param2,param3,param4,read);
      }
      
      public function open(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:String = null;
         var _loc7_:String = readNullTerminatedStr(param1);
         var _loc12_:FileHandle = CModule.vfs.getFileHandleFromPath(_loc7_);
         var _loc9_:Boolean;
         var _loc8_:Boolean = (_loc9_ = Boolean(param2 & 512)) && param2 & 2048;
         var _loc5_:int = -1;
         if(!_loc7_.length)
         {
            CModule.write32(param4,2);
            return -1;
         }
         if(!_loc12_ && _loc9_)
         {
            if((_loc6_ = CModule.vfs.checkPath(_loc7_)) == "pathComponentDoesNotExist")
            {
               CModule.write32(param4,2);
               return -1;
            }
            if(_loc6_ == "pathComponentIsNotDirectory")
            {
               CModule.write32(param4,20);
               return -1;
            }
            var _loc10_:FileHandle;
            if(!(_loc10_ = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc7_))).writeable)
            {
               CModule.write32(param4,30);
               return -1;
            }
            _loc12_ = create(_loc7_);
         }
         else if(_loc12_ && _loc8_)
         {
            CModule.write32(param4,17);
            return _loc5_;
         }
         if(_loc12_)
         {
            if(param2 & (1 | 2 | 512 | 1024) && !_loc12_.writeable)
            {
               CModule.write32(param4,30);
               return -1;
            }
            if(param2 & (1 | 2) && _loc12_.isDirectory)
            {
               CModule.write32(param4,21);
               return -1;
            }
            if(param2 & 1024)
            {
               _loc12_.bytes.length = 0;
            }
            else if(param2 & 8)
            {
               _loc12_.appending = true;
            }
            _loc12_.writeable = Boolean(param2 & 1) || Boolean(param2 & 2);
            _loc12_.readable = !(param2 & 1) || param2 & 2;
            _loc5_ = CModule.vfs.openFile(_loc12_);
         }
         else
         {
            if((_loc6_ = CModule.vfs.checkPath(_loc7_)) == "pathComponentIsNotDirectory")
            {
               CModule.write32(param4,20);
            }
            else
            {
               CModule.write32(param4,2);
            }
            _loc5_ = -1;
         }
         return _loc5_;
      }
      
      public function close(param1:int, param2:int) : int
      {
         if(!CModule.vfs.isValidFileDescriptor(param1))
         {
            CModule.write32(param2,9);
            return -1;
         }
         CModule.vfs.closeFile(param1);
         return 0;
      }
      
      public function mkdir(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:String;
         if(!(_loc5_ = readNullTerminatedStr(param1)).length)
         {
            CModule.write32(param3,2);
            return -1;
         }
         if(CModule.vfs.getFileHandleFromPath(_loc5_))
         {
            CModule.write32(param3,17);
            return -1;
         }
         var _loc4_:String;
         if((_loc4_ = CModule.vfs.checkPath(_loc5_)) == "pathComponentDoesNotExist")
         {
            CModule.write32(param3,2);
            return -1;
         }
         if(_loc4_ == "pathComponentIsNotDirectory")
         {
            CModule.write32(param3,20);
            return -1;
         }
         var _loc6_:FileHandle;
         if(!(_loc6_ = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc5_))).writeable)
         {
            CModule.write32(param3,30);
            return -1;
         }
         CModule.vfs.addDirectory(_loc5_);
         return 0;
      }
      
      private function statImpl(param1:FileHandle, param2:int, param3:int) : int
      {
         var _loc4_:uint = param1.callback || param1.isDirectory ? 0 : param1.bytes.length;
         CModule.write16(param2 + 8,param1.isDirectory ? 16384 : (!!param1.callback ? 8192 : 32768));
         CModule.write16(param2 + 10,1);
         CModule.write32(param2 + 48,_loc4_);
         CModule.write32(param2 + 64,4096);
         CModule.write32(param2 + 56,_loc4_ / 4096 + (_loc4_ % 4096 == 0 ? 0 : 1));
         return 0;
      }
      
      public function stat(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:String = readNullTerminatedStr(param1);
         var _loc4_:String;
         if((_loc4_ = CModule.vfs.checkPath(_loc5_)) == "pathComponentIsNotDirectory")
         {
            CModule.write32(param3,20);
            return -1;
         }
         var _loc6_:FileHandle;
         if(!(_loc6_ = CModule.vfs.getFileHandleFromPath(_loc5_)))
         {
            CModule.write32(param3,2);
            return -1;
         }
         return statImpl(_loc6_,param2,param3);
      }
      
      public function fstat(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:FileHandle;
         if(!(_loc4_ = CModule.vfs.getFileHandleFromFileDescriptor(param1)))
         {
            CModule.write32(param3,9);
            return -1;
         }
         return statImpl(_loc4_,param2,param3);
      }
      
      public function lstat(param1:int, param2:int, param3:int) : int
      {
         return stat(param1,param2,param3);
      }
      
      private function twoInts(param1:int, param2:int) : Array
      {
         return [param1,param2];
      }
      
      private function lseekImpl(param1:int, param2:int, param3:int, param4:int) : *
      {
         var _loc8_:* = 0;
         var _loc5_:Number = NaN;
         var _loc6_:FileHandle;
         if(!(_loc6_ = CModule.vfs.getFileHandleFromFileDescriptor(param1)))
         {
            CModule.write32(param4,9);
            return null;
         }
         if(_loc6_.callback)
         {
            CModule.write32(param4,29);
            return null;
         }
         _loc8_ = _loc6_.position;
         switch(param3)
         {
            case 0:
               _loc5_ = param2;
               break;
            case 1:
               _loc5_ = _loc8_ + param2;
               break;
            case 2:
               _loc5_ = _loc6_.bytes.length + param2;
               break;
            default:
               CModule.write32(param4,22);
               return null;
         }
         if(_loc5_ > 4294967295)
         {
            CModule.write32(param4,84);
            return null;
         }
         if(_loc5_ < 0)
         {
            CModule.write32(param4,22);
            return null;
         }
         var _loc7_:uint = _loc5_;
         _loc6_.position = _loc7_;
         return _loc7_;
      }
      
      public function lseek(param1:int, param2:int, param3:int, param4:int, param5:int) : Object
      {
         if(param2 != 0 && param2 != -1)
         {
            CModule.write32(param5,84);
            return twoInts(-1,-1);
         }
         var _loc6_:*;
         if((_loc6_ = lseekImpl(param1,param3,param4,param5)) == null)
         {
            return twoInts(-1,-1);
         }
         return twoInts(0,_loc6_);
      }
      
      public function rmdir(param1:int, param2:int) : int
      {
         var _loc3_:String = readNullTerminatedStr(param1);
         if(_loc3_ == "." || _loc3_.substring(_loc3_.length - 2) == "/.")
         {
            CModule.write32(param2,22);
            return -1;
         }
         var _loc4_:FileHandle;
         if(_loc4_ = CModule.vfs.getFileHandleFromPath(_loc3_))
         {
            if(_loc4_.isDirectory)
            {
               if(CModule.vfs.getDirectoryEntries(_loc3_).length > 0)
               {
                  CModule.write32(param2,66);
                  return -1;
               }
               if(!_loc4_.writeable)
               {
                  CModule.write32(param2,30);
                  return -1;
               }
               CModule.vfs.deleteFile(_loc3_);
               return 0;
            }
            CModule.write32(param2,20);
            return -1;
         }
         CModule.write32(param2,2);
         return -1;
      }
      
      public function unlink(param1:int, param2:int) : int
      {
         var _loc4_:String = readNullTerminatedStr(param1);
         var _loc3_:String = CModule.vfs.checkPath(_loc4_);
         if(_loc3_ == "pathComponentIsNotDirectory")
         {
            CModule.write32(param2,20);
            return -1;
         }
         var _loc5_:FileHandle;
         if(_loc5_ = CModule.vfs.getFileHandleFromPath(_loc4_))
         {
            if(_loc5_.isDirectory)
            {
               CModule.write32(param2,1);
               return -1;
            }
            if(!_loc5_.writeable)
            {
               CModule.write32(param2,30);
               return -1;
            }
            CModule.vfs.deleteFile(_loc4_);
            return 0;
         }
         CModule.write32(param2,2);
         return -1;
      }
      
      public function fcntl(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc6_:* = 0;
         if(param2 == 0)
         {
            _loc6_ = param3;
            while(CModule.vfs.isValidFileDescriptor(_loc6_))
            {
               _loc6_++;
            }
            return dup2(param1,_loc6_,param4);
         }
         var _loc5_:FileHandle;
         if(!(_loc5_ = getFileHandleFromFileDescriptor(param1,param4)))
         {
            return -1;
         }
         if(_loc5_.callback)
         {
            return _loc5_.callback.fcntl(param1,param2,param3,param4);
         }
         return 0;
      }
      
      public function ioctl(param1:int, param2:int, param3:int, param4:int) : int
      {
         var _loc5_:FileHandle;
         if(!(_loc5_ = getFileHandleFromFileDescriptor(param1,param4)))
         {
            return -1;
         }
         if(_loc5_.callback)
         {
            return _loc5_.callback.ioctl(param1,param2,param3,param4);
         }
         return 0;
      }
      
      public function getdirentries(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         var _loc9_:* = 0;
         var _loc7_:String = null;
         var _loc14_:* = 0;
         var _loc11_:* = 0;
         var _loc8_:* = 0;
         var _loc13_:FileHandle;
         if(!(_loc13_ = CModule.vfs.getFileHandleFromFileDescriptor(param1)) || !_loc13_.path)
         {
            return 0;
         }
         var _loc6_:ByteArray;
         (_loc6_ = new ByteArray()).endian = "littleEndian";
         var _loc10_:uint = 10;
         var _loc12_:Vector.<FileHandle> = CModule.vfs.getDirectoryEntries(_loc13_.path);
         CModule.write32(param4,_loc13_.position);
         _loc9_ = _loc13_.position;
         while(_loc9_ < _loc12_.length)
         {
            _loc7_ = String((_loc7_ = _loc12_[_loc9_].path.substr(_loc13_.path.length)).split(/\//)[1]);
            _loc11_ = uint((_loc14_ = uint(8 + _loc7_.length + 1)) + 3 & -4);
            if(_loc6_.length + _loc11_ > param3)
            {
               break;
            }
            _loc6_.writeUnsignedInt(_loc10_++);
            _loc6_.writeShort(_loc11_);
            _loc6_.writeByte(_loc12_[_loc9_].isDirectory ? 4 : 8);
            _loc6_.writeByte(_loc7_.length);
            _loc6_.writeUTFBytes(_loc7_);
            _loc6_.writeByte(0);
            _loc8_ = 0;
            while(_loc8_ < _loc11_ - _loc14_)
            {
               _loc6_.writeByte(0);
               _loc8_++;
            }
            _loc13_.position++;
            _loc9_++;
         }
         if(_loc6_.length <= 0)
         {
            return 0;
         }
         ram.position = param2;
         ram.writeBytes(_loc6_,0,_loc6_.length);
         return _loc6_.length;
      }
      
      public function dup(param1:int, param2:int) : int
      {
         var _loc3_:int = -1;
         if(CModule.vfs.isValidFileDescriptor(param1))
         {
            _loc3_ = CModule.vfs.openFile(CModule.vfs.getFileHandleFromFileDescriptor(param1));
         }
         else
         {
            CModule.write32(param2,9);
         }
         return _loc3_;
      }
      
      public function dup2(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:FileHandle = null;
         var _loc4_:int = -1;
         if(param2 < 0)
         {
            CModule.write32(param3,9);
         }
         else if(CModule.vfs.isValidFileDescriptor(param1))
         {
            _loc5_ = CModule.vfs.getFileHandleFromFileDescriptor(param1);
            if(CModule.vfs.isValidFileDescriptor(param2))
            {
               CModule.vfs.closeFile(param2);
            }
            _loc4_ = CModule.vfs.openFile(_loc5_,param2);
         }
         else
         {
            CModule.write32(param3,9);
         }
         return _loc4_;
      }
      
      public function rename(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:String = readNullTerminatedStr(param1);
         var _loc6_:String = readNullTerminatedStr(param2);
         if(_loc4_.length == 0 || _loc6_.length == 0)
         {
            CModule.write32(param3,2);
            return -1;
         }
         if(_loc4_.charAt(_loc4_.length - 1) == ".")
         {
            CModule.write32(param3,22);
            return -1;
         }
         _loc4_ = PathUtils.toCanonicalPath(_loc4_);
         if((_loc6_ = PathUtils.toCanonicalPath(_loc6_)) == _loc4_.substr(0,_loc6_.length))
         {
            CModule.write32(param3,22);
            return -1;
         }
         var _loc5_:String = CModule.vfs.checkPath(_loc4_);
         var _loc8_:String = CModule.vfs.checkPath(_loc6_);
         var _loc10_:FileHandle = CModule.vfs.getFileHandleFromPath(_loc4_);
         var _loc9_:FileHandle = CModule.vfs.getFileHandleFromPath(_loc6_);
         if(_loc5_ == "pathComponentIsNotDirectory" || _loc8_ == "pathComponentIsNotDirectory")
         {
            CModule.write32(param3,20);
            return -1;
         }
         if(_loc5_ == "pathComponentDoesNotExist" || _loc8_ == "pathComponentDoesNotExist" || !_loc10_)
         {
            CModule.write32(param3,2);
            return -1;
         }
         if(_loc9_ && _loc9_.isDirectory && !_loc10_.isDirectory)
         {
            CModule.write32(param3,21);
            return -1;
         }
         if(_loc9_ && _loc9_.isDirectory && CModule.vfs.getDirectoryEntries(_loc6_).length)
         {
            CModule.write32(param3,66);
            return -1;
         }
         if(_loc10_.isDirectory && _loc9_ && !_loc9_.isDirectory)
         {
            CModule.write32(param3,20);
            return -1;
         }
         var _loc7_:FileHandle;
         if(!(_loc7_ = CModule.vfs.getFileHandleFromPath(PathUtils.getDirectory(_loc6_))).writeable)
         {
            CModule.write32(param3,30);
            return -1;
         }
         if(!_loc10_.writeable)
         {
            CModule.write32(param3,30);
            return -1;
         }
         if(_loc9_)
         {
            CModule.vfs.deleteFile(_loc6_);
         }
         if(_loc10_.isDirectory)
         {
            CModule.vfs.addDirectory(_loc6_);
            moveFiles(_loc4_,_loc6_);
         }
         else
         {
            CModule.vfs.addFile(_loc6_,_loc10_.bytes);
         }
         CModule.vfs.deleteFile(_loc4_);
         return 0;
      }
      
      private function moveFiles(param1:String, param2:String) : void
      {
         var _loc6_:* = 0;
         var _loc4_:FileHandle = null;
         var _loc3_:String = null;
         var _loc5_:Vector.<FileHandle> = CModule.vfs.getDirectoryEntries(param1);
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc6_];
            _loc3_ = PathUtils.toCanonicalPath(param2 + "/" + _loc4_.path.substring(param1.length));
            if(_loc4_.isDirectory)
            {
               CModule.vfs.addDirectory(_loc3_);
               moveFiles(_loc4_.path,_loc3_);
            }
            else
            {
               CModule.vfs.addFile(_loc3_,_loc4_.bytes);
            }
            CModule.vfs.deleteFile(_loc4_.path);
            _loc6_++;
         }
      }
      
      public function access(param1:int, param2:int, param3:int) : int
      {
         return 0;
      }
      
      public function issetugid(param1:int) : int
      {
         return 0;
      }
      
      public function seteuid(param1:int, param2:int) : int
      {
         _euid = param1;
         return 0;
      }
      
      public function geteuid(param1:int) : int
      {
         return _euid;
      }
      
      public function setreuid(param1:int, param2:int, param3:int) : int
      {
         _ruid = param1;
         _euid = param2;
         return 0;
      }
      
      public function getuid(param1:int) : int
      {
         return _ruid;
      }
      
      public function getpid(param1:int) : int
      {
         return 42;
      }
      
      public function setegid(param1:int, param2:int) : int
      {
         _egid = param1;
         return 0;
      }
      
      public function getgid(param1:int) : int
      {
         return _egid;
      }
      
      public function __getcwd(param1:int, param2:int, param3:int) : int
      {
         CModule.write32(param3,78);
         return -1;
      }
      
      public function nanosleep(param1:int, param2:int, param3:int) : int
      {
         if(workerClass)
         {
            var _loc4_:uint = uint(CModule.read32(param1 + 4));
            var _loc6_:int = uint(CModule.read32(param1)) * 1000 + _loc4_ / 1000000;
            yield(_loc6_);
            if(param2)
            {
               CModule.write32(param2,0);
               CModule.write32(param2 + 4,0);
            }
            return 0;
         }
         CModule.write32(param3,78);
         return -1;
      }
      
      public function clock_gettime(param1:int, param2:int, param3:int) : int
      {
         if(param1 == 0)
         {
            var _loc4_:Date = new Date();
            CModule.write32(param2,_loc4_.time / 1000);
            CModule.write32(param2 + 4,_loc4_.getMilliseconds() * 1000000);
            return 0;
         }
         CModule.write32(param3,22);
         return -1;
      }
      
      public function sigprocmask(param1:int, param2:int, param3:int, param4:int) : int
      {
         CModule.write32(param4,78);
         return -1;
      }
      
      public function fork(param1:int) : int
      {
         return -1;
      }
      
      public function wait4(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         return -1;
      }
      
      public function link(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function chdir(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function fchdir(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function chmod(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function chown(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function setuid(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function sync(param1:int) : void
      {
      }
      
      public function kill(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function getppid(param1:int) : int
      {
         return -1;
      }
      
      public function pipe(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function getegid(param1:int) : int
      {
         return -1;
      }
      
      public function revoke(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function symlink(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function umask(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function chroot(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function msync(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function vfork(param1:int) : int
      {
         return -1;
      }
      
      public function getgroups(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function setgroups(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function getpgrp(param1:int) : int
      {
         return -1;
      }
      
      public function setpgid(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function getdtablesize(param1:int) : int
      {
         return -1;
      }
      
      public function fsync(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function setpriority(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function socket(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function getpriority(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function setsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         return -1;
      }
      
      public function listen(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function sigsuspend(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function getrusage(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function getsockopt(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         return -1;
      }
      
      public function fchown(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function fchmod(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function setregid(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function mkfifo(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function shutdown(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function socketpair(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         return -1;
      }
      
      public function setsid(param1:int) : int
      {
         return -1;
      }
      
      public function setgid(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function pathconf(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function fpathconf(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function getpgid(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function semget(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function msgget(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function msgsnd(param1:int, param2:int, param3:int, param4:int, param5:int) : int
      {
         return -1;
      }
      
      public function msgrcv(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int) : int
      {
         return -1;
      }
      
      public function shmdt(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function shmget(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function lchown(param1:int, param2:int, param3:int, param4:int) : int
      {
         return -1;
      }
      
      public function getsid(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function sched_yield(param1:int) : int
      {
         return -1;
      }
      
      public function sched_get_priority_max(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function sched_get_priority_min(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function sigpending(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function sigwait(param1:int, param2:int, param3:int) : int
      {
         return -1;
      }
      
      public function shm_unlink(param1:int, param2:int) : int
      {
         return -1;
      }
      
      public function pselect(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int) : int
      {
         return -1;
      }
   }
}
