package com.taomee.seer2.app.manager
{
   import com.taomee.seer2.core.map.grids.HashMap;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.events.SceneEvent;
   import com.taomee.seer2.core.ui.UIManager;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class SeatTipsManager
   {
      
      private static var seatMap:HashMap = new HashMap();
      
      private static var sceneTipsMap:HashMap = new HashMap();
      
      private static var uiTipsMap:HashMap = new HashMap();
      
      private static var persistList:Vector.<Point> = new Vector.<Point>();
      
      private static var allTips:Vector.<MovieClip> = new Vector.<MovieClip>();
      
      private static var hasRuning:Boolean = false;
      
      private static var map:Sprite;
      
      private static var currentMapId:int;
       
      
      public function SeatTipsManager()
      {
         super();
      }
      
      public static function registerSeat(param1:Point, param2:int = 0) : void
      {
         if(param2 != 0)
         {
            saveMapAndSeat(param2,param1);
         }
         else
         {
            savePersistSeat(param1);
         }
      }
      
      private static function savePersistSeat(param1:Point) : void
      {
         var _loc2_:int = int(persistList.length);
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            if(persistList[_loc3_].equals(param1))
            {
               return;
            }
            _loc3_++;
         }
         persistList.push(param1);
         var _loc4_:MovieClip;
         (_loc4_ = getTips()).x = param1.x;
         _loc4_.y = param1.y;
         var _loc5_:String = "ui_" + param1.x + "_" + param1.y;
         uiTipsMap.put(_loc5_,_loc4_);
         LayerManager.stage.addChild(_loc4_);
      }
      
      private static function getTips() : MovieClip
      {
         var _loc1_:MovieClip = null;
         if(allTips.length > 0)
         {
            _loc1_ = MovieClip(allTips.splice(0,1)[0]);
         }
         else
         {
            _loc1_ = UIManager.getMovieClip("SeatTipsUI");
         }
         _loc1_.mouseEnabled = _loc1_.mouseChildren = false;
         return _loc1_;
      }
      
      public static function removeSeat(param1:Point, param2:int = 0) : void
      {
         var _loc3_:String = null;
         var _loc4_:MovieClip = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:Vector.<Point> = null;
         if(param2 != 0)
         {
            if(!(_loc7_ = seatMap.getValue(param2) as Vector.<Point>))
            {
               return;
            }
            _loc5_ = int(_loc7_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(_loc7_[_loc6_].equals(param1))
               {
                  _loc7_.splice(_loc6_,1);
                  break;
               }
               _loc6_++;
            }
            if(_loc6_ == _loc5_)
            {
               return;
            }
            _loc3_ = "scene_" + param1.x + "_" + param1.y;
            if(_loc4_ = sceneTipsMap.getValue(_loc3_) as MovieClip)
            {
               sceneTipsMap.remove(_loc3_);
               DisplayObjectUtil.removeFromParent(_loc4_);
               allTips.push(_loc4_);
            }
         }
         else
         {
            if((_loc5_ = int(persistList.length)) == 0)
            {
               return;
            }
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               if(persistList[_loc6_].equals(param1))
               {
                  _loc3_ = "ui_" + param1.x + "_" + param1.y;
                  _loc4_ = uiTipsMap.getValue(_loc3_) as MovieClip;
                  uiTipsMap.remove(_loc3_);
                  DisplayObjectUtil.removeFromParent(_loc4_);
                  allTips.push(_loc4_);
                  persistList.splice(_loc6_,1);
                  break;
               }
               _loc6_++;
            }
         }
      }
      
      private static function saveMapAndSeat(param1:int, param2:Point) : void
      {
         if(!seatMap.containsKey(param1))
         {
            seatMap.put(param1,new Vector.<Point>());
         }
         var _loc3_:Vector.<Point> = seatMap.getValue(param1) as Vector.<Point>;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            if(_loc3_[_loc4_].equals(param2))
            {
               return;
            }
            _loc4_++;
         }
         _loc3_.push(param2);
         if(!hasRuning)
         {
            startRuning();
         }
         checkSeat();
      }
      
      private static function startRuning() : void
      {
         hasRuning = true;
         SceneManager.addEventListener(SceneEvent.SWITCH_START,removeMapTips);
         SceneManager.addEventListener(SceneEvent.SWITCH_COMPLETE,checkSeat);
         checkSeat();
      }
      
      private static function removeMapTips(param1:SceneEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         var _loc2_:Vector.<Point> = seatMap.getValue(currentMapId) as Vector.<Point>;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = "scene_" + _loc2_[_loc3_].x + "_" + _loc2_[_loc3_].y;
            if(_loc5_ = sceneTipsMap.getValue(_loc4_) as MovieClip)
            {
               sceneTipsMap.remove(_loc4_);
               DisplayObjectUtil.removeFromParent(_loc5_);
               allTips.push(_loc5_);
            }
            _loc3_++;
         }
      }
      
      public static function hasSeat(param1:int, param2:Point) : Boolean
      {
         var _loc4_:Vector.<Point> = null;
         var _loc5_:int = 0;
         var _loc3_:Boolean = false;
         if(seatMap)
         {
            if(seatMap.containsKey(param1))
            {
               _loc4_ = seatMap.getValue(param1) as Vector.<Point>;
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  if(_loc4_[_loc5_].equals(param2))
                  {
                     _loc3_ = true;
                     break;
                  }
                  _loc5_++;
               }
            }
         }
         return _loc3_;
      }
      
      private static function checkSeat(param1:SceneEvent = null) : void
      {
         var _loc4_:String = null;
         var _loc5_:MovieClip = null;
         if(seatMap.size() == 0)
         {
            hasRuning = false;
            SceneManager.removeEventListener(SceneEvent.SWITCH_COMPLETE,checkSeat);
            SceneManager.removeEventListener(SceneEvent.SWITCH_START,removeMapTips);
            return;
         }
         currentMapId = SceneManager.active.mapID;
         map = SceneManager.active.mapModel.front;
         var _loc2_:Vector.<Point> = seatMap.getValue(currentMapId) as Vector.<Point>;
         if(!_loc2_)
         {
            return;
         }
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc4_ = "scene_" + _loc2_[_loc3_].x + "_" + _loc2_[_loc3_].y;
            if(!sceneTipsMap.getValue(_loc4_))
            {
               (_loc5_ = getTips()).x = _loc2_[_loc3_].x;
               _loc5_.y = _loc2_[_loc3_].y;
               map.addChild(_loc5_);
               sceneTipsMap.put(_loc4_,_loc5_);
            }
            _loc3_++;
         }
      }
   }
}
