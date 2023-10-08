package com.greensock.plugins
{
   import com.greensock.*;
   import com.greensock.motionPaths.CirclePath2D;
   import com.greensock.motionPaths.PathFollower;
   import flash.geom.Matrix;
   
   public class CirclePath2DPlugin extends TweenPlugin
   {
      
      private static const _RAD2DEG:Number = 180 / Math.PI;
      
      public static const API:Number = 1;
      
      private static const _2PI:Number = Math.PI * 2;
       
      
      protected var _start:Number;
      
      protected var _autoRotate:Boolean;
      
      protected var _circle:CirclePath2D;
      
      protected var _target:Object;
      
      protected var _autoRemove:Boolean;
      
      protected var _change:Number;
      
      protected var _rotationOffset:Number;
      
      public function CirclePath2DPlugin()
      {
         super();
         this.propName = "circlePath2D";
         this.overwriteProps = ["x","y"];
      }
      
      override public function killProps(param1:Object) : void
      {
         super.killProps(param1);
         if("x" in param1 || "y" in param1)
         {
            this.overwriteProps = [];
         }
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         var _loc2_:Number = (_start + _change * param1) * _2PI;
         var _loc3_:Number = _circle.radius;
         var _loc4_:Matrix = _circle.transform.matrix;
         var _loc5_:Number = Math.cos(_loc2_) * _loc3_;
         var _loc6_:Number = Math.sin(_loc2_) * _loc3_;
         _target.x = _loc5_ * _loc4_.a + _loc6_ * _loc4_.c + _loc4_.tx;
         _target.y = _loc5_ * _loc4_.b + _loc6_ * _loc4_.d + _loc4_.ty;
         if(_autoRotate)
         {
            _loc2_ += Math.PI / 2;
            _loc5_ = Math.cos(_loc2_) * _circle.radius;
            _loc6_ = Math.sin(_loc2_) * _circle.radius;
            _target.rotation = Math.atan2(_loc5_ * _loc4_.b + _loc6_ * _loc4_.d,_loc5_ * _loc4_.a + _loc6_ * _loc4_.c) * _RAD2DEG + _rotationOffset;
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(!("path" in param2) || !(param2.path is CirclePath2D))
         {
            trace("CirclePath2DPlugin error: invalid \'path\' property. Please define a CirclePath2D instance.");
            return false;
         }
         _target = param1;
         _circle = param2.path as CirclePath2D;
         _autoRotate = Boolean(param2.autoRotate == true);
         _rotationOffset = Number(param2.rotationOffset) || 0;
         var _loc4_:PathFollower;
         if((_loc4_ = _circle.getFollower(param1)) != null && !("startAngle" in param2))
         {
            _start = _loc4_.progress;
         }
         else
         {
            _start = _circle.angleToProgress(Number(param2.startAngle) || 0,param2.useRadians);
            _circle.renderObjectAt(_target,_start);
         }
         _change = Number(_circle.anglesToProgressChange(_circle.progressToAngle(_start),Number(param2.endAngle) || 0,String(param2.direction) || "clockwise",uint(param2.extraRevolutions) || 0,Boolean(param2.useRadians)));
         return true;
      }
   }
}
