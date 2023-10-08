package cmodule.desc
{
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class DynamicProxy extends Proxy
   {
       
      
      flash_delegate var nextValue:Function;
      
      flash_delegate var getProperty:Function;
      
      flash_delegate var isAttribute:Function;
      
      flash_delegate var nextNameIndex:Function;
      
      flash_delegate var hasProperty:Function;
      
      flash_delegate var callProperty:Function;
      
      flash_delegate var nextName:Function;
      
      flash_delegate var getDescendants:Function;
      
      flash_delegate var deleteProperty:Function;
      
      flash_delegate var setProperty:Function;
      
      public function DynamicProxy()
      {
         super();
      }
      
      override flash_proxy function hasProperty(param1:*) : Boolean
      {
         return this.flash_delegate::hasProperty(param1);
      }
      
      override flash_proxy function callProperty(param1:*, ... rest) : *
      {
         return this.flash_delegate::callProperty(param1,rest);
      }
      
      override flash_proxy function setProperty(param1:*, param2:*) : void
      {
         this.flash_delegate::setProperty(param1,param2);
      }
      
      override flash_proxy function isAttribute(param1:*) : Boolean
      {
         return this.flash_delegate::isAttribute(param1);
      }
      
      override flash_proxy function getProperty(param1:*) : *
      {
         return this.flash_delegate::getProperty(param1);
      }
      
      override flash_proxy function nextNameIndex(param1:int) : int
      {
         return this.flash_delegate::nextNameIndex(param1);
      }
      
      override flash_proxy function deleteProperty(param1:*) : Boolean
      {
         return this.flash_delegate::deleteProperty(param1);
      }
      
      override flash_proxy function nextName(param1:int) : String
      {
         return this.flash_delegate::nextName(param1);
      }
      
      override flash_proxy function getDescendants(param1:*) : *
      {
         return this.flash_delegate::getDescendants(param1);
      }
      
      override flash_proxy function nextValue(param1:int) : *
      {
         return this.flash_delegate::nextValue(param1);
      }
   }
}
