package com.taomee.seer2.app.lobby
{
   import com.taomee.seer2.app.map.MapAnimationWrapper;
   import com.taomee.seer2.app.map.MapHitWrapper;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import org.taomee.ds.HashMap;
   import org.taomee.utils.StringUtil;
   
   public class LobbyMapProcessor extends MapProcessor
   {
      
      private static var ANIMATION_SUFFIX:String = "Animation";
      
      private static var HIT_SUFFIX:String = "Hit";
       
      
      private var _hitWrapperMap:HashMap;
      
      private var _animationWrapperMap:HashMap;
      
      public function LobbyMapProcessor(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this._hitWrapperMap = new HashMap();
         this._animationWrapperMap = new HashMap();
         var _loc1_:MovieClip = _map.front as MovieClip;
         this.initLayerAnimation(_loc1_);
         var _loc2_:MovieClip = _map.content as MovieClip;
         this.initLayerAnimation(_loc2_);
         var _loc3_:MovieClip = _map.ground as MovieClip;
         this.initLayerAnimation(_loc3_);
      }
      
      private function initLayerAnimation(param1:MovieClip) : void
      {
         var _loc2_:String = null;
         var _loc3_:MapHitWrapper = null;
         var _loc4_:MapAnimationWrapper = null;
         var _loc5_:MovieClip = null;
         var _loc6_:DisplayObject = null;
         for each(_loc6_ in param1)
         {
            if(_loc5_ = _loc6_ as MovieClip)
            {
               _loc2_ = _loc5_.name;
               if(StringUtil.endsWith(_loc2_,ANIMATION_SUFFIX))
               {
                  _loc4_ = new MapAnimationWrapper(_loc5_);
                  this._animationWrapperMap.add(_loc2_,_loc4_);
               }
               else if(StringUtil.endsWith(_loc2_,HIT_SUFFIX))
               {
                  _loc3_ = new MapHitWrapper(_loc5_);
                  this._hitWrapperMap.add(_loc2_,_loc3_);
               }
            }
         }
      }
      
      protected function getAnimationWrapper(param1:String) : MapAnimationWrapper
      {
         return this._animationWrapperMap.getValue(param1);
      }
      
      protected function getHitWrapper(param1:String) : MapHitWrapper
      {
         return this._hitWrapperMap.getValue(param1);
      }
      
      override public function dispose() : void
      {
         var _loc1_:MapHitWrapper = null;
         var _loc2_:MapAnimationWrapper = null;
         for each(_loc1_ in this._hitWrapperMap.getValues())
         {
            _loc1_.dispose();
         }
         this._hitWrapperMap.clear();
         this._hitWrapperMap = null;
         for each(_loc2_ in this._animationWrapperMap.getValues())
         {
            _loc2_.dispose();
         }
         this._animationWrapperMap.clear();
         this._animationWrapperMap = null;
      }
   }
}
