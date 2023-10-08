package com.adobe.fileformats.vcard
{
   public class Address
   {
       
      
      public var type:String;
      
      public var street:String;
      
      public var city:String;
      
      public var state:String;
      
      public var postalCode:String;
      
      public function Address()
      {
         super();
      }
      
      public function toString() : String
      {
         return this.street + " " + this.city + ", " + this.state + " " + this.postalCode;
      }
   }
}
