package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.manager.TimeManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.MovieClip;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.Tick;
   
   public class CaesarActivityManager
   {
      
      public static const SECONDS_ONE_DAY:Number = 60 * 60 * 24;
      
      public static const MILI_SECONDS:Number = 1000;
      
      public static const DISTANCE_TIME:Number = 20;
      
      public static const MOVIE:String = "movie";
      
      public static const TIME_VEC:Vector.<Date> = Vector.<Date>([new Date(2012,6,20,14)]);
      
      private static var _info:ContentInfo;
      
      private static var dateIndex:Date;
      
      private static var _caesarMc:MovieClip;
      
      private static var _movieIndex:int;
       
      
      public function CaesarActivityManager()
      {
         super();
      }
      
      public static function setup() : void
      {
         loadRes();
         Tick.instance.addRender(activateMovie,1000);
      }
      
      private static function activateMovie(param1:* = null) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:Number = Number(TimeManager.getServerTime());
         _loc2_ %= SECONDS_ONE_DAY;
         var _loc3_:int = 0;
         while(_loc3_ < TIME_VEC.length)
         {
            _loc4_ = (_loc4_ = TIME_VEC[_loc3_].getTime()) / MILI_SECONDS % SECONDS_ONE_DAY;
            if(_loc2_ > _loc4_ && _loc2_ < _loc4_ + DISTANCE_TIME)
            {
               if(dateIndex != TIME_VEC[_loc3_])
               {
                  dateIndex = TIME_VEC[_loc3_];
                  _movieIndex = _loc3_;
                  playMovie(_movieIndex);
               }
            }
            _loc3_++;
         }
      }
      
      private static function playMovie(param1:int) : void
      {
         var movieIndex:int = param1;
         var movieName:String = MOVIE + movieIndex.toString();
         var classRef:Class = _info.domain.getDefinition(movieName) as Class;
         _caesarMc = new classRef();
         LayerManager.topLayer.addChild(_caesarMc);
         _caesarMc.addFrameScript(_caesarMc.totalFraes - 1,function():void
         {
            _caesarMc.stop();
            DisplayUtil.removeForParent(_caesarMc);
         });
      }
      
      private static function loadRes() : void
      {
         QueueLoader.load(URLUtil.getActivityAnimation("CaesarWarn"),LoadType.SWF,onResLoaded);
      }
      
      private static function onResLoaded(param1:ContentInfo = null) : void
      {
         if(_info == null)
         {
            _info = param1;
         }
      }
   }
}
