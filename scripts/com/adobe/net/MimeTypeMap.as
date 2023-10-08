package com.adobe.net
{
   public class MimeTypeMap
   {
       
      
      private var types:Array;
      
      public function MimeTypeMap()
      {
         this.types = [["application/andrew-inset","ez"],["application/atom+xml","atom"],["application/mac-binhex40","hqx"],["application/mac-compactpro","cpt"],["application/mathml+xml","mathml"],["application/msword","doc"],["application/octet-stream","bin","dms","lha","lzh","exe","class","so","dll","dmg"],["application/oda","oda"],["application/ogg","ogg"],["application/pdf","pdf"],["application/postscript","ai","eps","ps"],["application/rdf+xml","rdf"],["application/smil","smi","smil"],["application/srgs","gram"],["application/srgs+xml","grxml"],["application/vnd.adobe.apollo-application-installer-package+zip","air"],["application/vnd.mif","mif"],["application/vnd.mozilla.xul+xml","xul"],["application/vnd.ms-excel","xls"],["application/vnd.ms-powerpoint","ppt"],["application/vnd.rn-realmedia","rm"],["application/vnd.wap.wbxml","wbxml"],["application/vnd.wap.wmlc","wmlc"],["application/vnd.wap.wmlscriptc","wmlsc"],["application/voicexml+xml","vxml"],["application/x-bcpio","bcpio"],["application/x-cdlink","vcd"],["application/x-chess-pgn","pgn"],["application/x-cpio","cpio"],["application/x-csh","csh"],["application/x-director","dcr","dir","dxr"],["application/x-dvi","dvi"],["application/x-futuresplash","spl"],["application/x-gtar","gtar"],["application/x-hdf","hdf"],["application/x-javascript","js"],["application/x-koan","skp","skd","skt","skm"],["application/x-latex","latex"],["application/x-netcdf","nc","cdf"],["application/x-sh","sh"],["application/x-shar","shar"],["application/x-shockwave-flash","swf"],["application/x-stuffit","sit"],["application/x-sv4cpio","sv4cpio"],["application/x-sv4crc","sv4crc"],["application/x-tar","tar"],["application/x-tcl","tcl"],["application/x-tex","tex"],["application/x-texinfo","texinfo","texi"],["application/x-troff","t","tr","roff"],["application/x-troff-man","man"],["application/x-troff-me","me"],["application/x-troff-ms","ms"],["application/x-ustar","ustar"],["application/x-wais-source","src"],["application/xhtml+xml","xhtml","xht"],["application/xml","xml","xsl"],["application/xml-dtd","dtd"],["application/xslt+xml","xslt"],["application/zip","zip"],["audio/basic","au","snd"],["audio/midi","mid","midi","kar"],["audio/mp4","f4a"],["audio/mp4","f4b"],["audio/mpeg","mp3","mpga","mp2"],["audio/x-aiff","aif","aiff","aifc"],["audio/x-mpegurl","m3u"],["audio/x-pn-realaudio","ram","ra"],["audio/x-wav","wav"],["chemical/x-pdb","pdb"],["chemical/x-xyz","xyz"],["image/bmp","bmp"],["image/cgm","cgm"],["image/gif","gif"],["image/ief","ief"],["image/jpeg","jpg","jpeg","jpe"],["image/png","png"],["image/svg+xml","svg"],["image/tiff","tiff","tif"],["image/vnd.djvu","djvu","djv"],["image/vnd.wap.wbmp","wbmp"],["image/x-cmu-raster","ras"],["image/x-icon","ico"],["image/x-portable-anymap","pnm"],["image/x-portable-bitmap","pbm"],["image/x-portable-graymap","pgm"],["image/x-portable-pixmap","ppm"],["image/x-rgb","rgb"],["image/x-xbitmap","xbm"],["image/x-xpixmap","xpm"],["image/x-xwindowdump","xwd"],["model/iges","igs","iges"],["model/mesh","msh","mesh","silo"],["model/vrml","wrl","vrml"],["text/calendar","ics","ifb"],["text/css","css"],["text/html","html","htm"],["text/plain","txt","asc"],["text/richtext","rtx"],["text/rtf","rtf"],["text/sgml","sgml","sgm"],["text/tab-separated-values","tsv"],["text/vnd.wap.wml","wml"],["text/vnd.wap.wmlscript","wmls"],["text/x-setext","etx"],["video/mp4","f4v"],["video/mp4","f4p"],["video/mpeg","mpg","mpeg","mpe"],["video/quicktime","mov","qt"],["video/vnd.mpegurl","m4u","mxu"],["video/x-flv","flv"],["video/x-msvideo","avi"],["video/x-sgi-movie","movie"],["x-conference/x-cooltalk","ice"]];
         super();
      }
      
      public function getMimeType(param1:String) : String
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         param1 = param1.toLocaleLowerCase();
         for each(_loc2_ in this.types)
         {
            for each(_loc3_ in _loc2_)
            {
               if(_loc3_ == param1)
               {
                  return _loc2_[0];
               }
            }
         }
         return null;
      }
      
      public function getExtension(param1:String) : String
      {
         var _loc2_:Array = null;
         param1 = param1.toLocaleLowerCase();
         for each(_loc2_ in this.types)
         {
            if(_loc2_[0] == param1)
            {
               return _loc2_[1];
            }
         }
         return null;
      }
      
      public function addMimeType(param1:String, param2:Array) : void
      {
         var _loc4_:String = null;
         var _loc3_:Array = [param1];
         for each(_loc4_ in param2)
         {
            _loc3_.push(_loc4_);
         }
         this.types.push(_loc3_);
      }
   }
}
