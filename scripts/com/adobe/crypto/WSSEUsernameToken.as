package com.adobe.crypto
{
   import mx.formatters.DateFormatter;
   import mx.utils.Base64Encoder;
   
   public class WSSEUsernameToken
   {
       
      
      public function WSSEUsernameToken()
      {
         super();
      }
      
      public static function getUsernameToken(param1:String, param2:String, param3:String = null, param4:Date = null) : String
      {
         if(param3 == null)
         {
            param3 = generateNonce();
         }
         param3 = base64Encode(param3);
         var _loc5_:String = generateTimestamp(param4);
         var _loc6_:String = getBase64Digest(param3,_loc5_,param2);
         var _loc7_:String;
         return (_loc7_ = new String("UsernameToken Username=\"")) + (param1 + "\", " + "PasswordDigest=\"" + _loc6_ + "\", " + "Nonce=\"" + param3 + "\", " + "Created=\"" + _loc5_ + "\"");
      }
      
      private static function generateNonce() : String
      {
         var _loc1_:String = Math.random().toString();
         return _loc1_.replace(".","");
      }
      
      internal static function base64Encode(param1:String) : String
      {
         var _loc2_:Base64Encoder = new Base64Encoder();
         _loc2_.encode(param1);
         return _loc2_.flush();
      }
      
      internal static function generateTimestamp(param1:Date) : String
      {
         if(param1 == null)
         {
            param1 = new Date();
         }
         var _loc2_:DateFormatter = new DateFormatter();
         _loc2_.formatString = "YYYY-MM-DDTJJ:NN:SS";
         return _loc2_.format(param1) + "Z";
      }
      
      internal static function getBase64Digest(param1:String, param2:String, param3:String) : String
      {
         return SHA1.hashToBase64(param1 + param2 + param3);
      }
   }
}
