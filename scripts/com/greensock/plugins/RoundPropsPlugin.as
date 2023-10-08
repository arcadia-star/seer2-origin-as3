package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class RoundPropsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _tween:TweenLite;
      
      public function RoundPropsPlugin()
      {
         super();
         this.propName = "roundProps";
         this.overwriteProps = ["roundProps"];
         this.round = true;
         this.priority = -1;
         this.onInitAllProps = _initAllProps;
      }
      
      public function add(param1:Object, param2:String, param3:Number, param4:Number) : void
      {
         addTween(param1,param2,param3,param3 + param4,param2);
         this.overwriteProps[this.overwriteProps.length] = param2;
      }
      
      protected function _removePropTween(param1:PropTween) : void
      {
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(_tween.cachedPT1 == param1)
         {
            _tween.cachedPT1 = param1.nextNode;
         }
         if(param1.isPlugin && Boolean(param1.target.onDisable))
         {
            param1.target.onDisable();
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _tween = param3;
         this.overwriteProps = this.overwriteProps.concat(param2 as Array);
         return true;
      }
      
      protected function _initAllProps() : void
      {
         var _loc1_:String = null;
         var _loc2_:* = null;
         var _loc4_:PropTween = null;
         var _loc3_:Array = _tween.vars.roundProps;
         var _loc5_:int = int(_loc3_.length);
         while(--_loc5_ > -1)
         {
            _loc1_ = String(_loc3_[_loc5_]);
            _loc4_ = _tween.cachedPT1;
            while(_loc4_)
            {
               if(_loc4_.name == _loc1_)
               {
                  if(_loc4_.isPlugin)
                  {
                     _loc4_.target.round = true;
                  }
                  else
                  {
                     add(_loc4_.target,_loc1_,_loc4_.start,_loc4_.change);
                     _removePropTween(_loc4_);
                     _tween.propTweenLookup[_loc1_] = _tween.propTweenLookup.roundProps;
                  }
               }
               else if(_loc4_.isPlugin && _loc4_.name == "_MULTIPLE_" && !_loc4_.target.round)
               {
                  _loc2_ = " " + _loc4_.target.overwriteProps.join(" ") + " ";
                  if(_loc2_.indexOf(" " + _loc1_ + " ") != -1)
                  {
                     _loc4_.target.round = true;
                  }
               }
               _loc4_ = _loc4_.nextNode;
            }
         }
      }
   }
}
