package com.greensock.loading
{
   import flash.events.Event;
   import flash.text.StyleSheet;
   
   public class CSSLoader extends DataLoader
   {
      
      private static var _classActivated:Boolean = _activateClass("CSSLoader",CSSLoader,"css");
       
      
      public function CSSLoader(param1:*, param2:Object = null)
      {
         super(param1,param2);
         _loader.dataFormat = "text";
         _type = "CSSLoader";
      }
      
      override protected function _receiveDataHandler(param1:Event) : void
      {
         var _loc2_:StyleSheet = _content = new StyleSheet();
         _loc2_.parseCSS(_loader.data);
         super._completeHandler(param1);
      }
   }
}
