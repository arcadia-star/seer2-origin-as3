package com.adobe.fileformats.vcard
{
   import flash.utils.ByteArray;
   
   public class VCard
   {
       
      
      public var fullName:String;
      
      public var orgs:Array;
      
      public var title:String;
      
      public var image:ByteArray;
      
      public var phones:Array;
      
      public var emails:Array;
      
      public var addresses:Array;
      
      public function VCard()
      {
         super();
         this.orgs = new Array();
         this.phones = new Array();
         this.emails = new Array();
         this.addresses = new Array();
      }
   }
}
