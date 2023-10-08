package com.taomee.seer2.core.map.grids
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   
   public class ImageLoader extends BaseLoader
   {
       
      
      public var _data:BitmapData;
      
      public function ImageLoader(param1:Object = null, param2:LoaderContext = null)
      {
         super();
         _type = HeptaFishConstant.TYPE_LOADER_IMAGELOADER;
         if(param1 != null)
         {
            if(param1 is ByteArray)
            {
               loadBytes(param1 as ByteArray,param2);
            }
            else
            {
               if(!(param1 is String))
               {
                  throw new Error("参数错误，构造函数第一参数只接受ByteArray或String");
               }
               load(param1 as String,param2);
            }
         }
      }
      
      override protected function completeFun(param1:Event) : void
      {
         this._data = _loader.content["bitmapData"];
         super.completeFun(param1);
      }
      
      override public function clear() : void
      {
         this._data = null;
         super.clear();
      }
   }
}
