package com.greensock.plugins
{
   import com.greensock.*;
   
   public class SetSizePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1;
       
      
      protected var _setWidth:Boolean;
      
      public var width:Number;
      
      public var height:Number;
      
      protected var _hasSetSize:Boolean;
      
      protected var _setHeight:Boolean;
      
      protected var _target:Object;
      
      public function SetSizePlugin()
      {
         super();
         this.propName = "setSize";
         this.overwriteProps = ["setSize","setActualSize","width","height","scaleX","scaleY"];
         this.round = true;
      }
      
      override public function killProps(param1:Object) : void
      {
         super.killProps(param1);
         if(_tweens.length == 0 || "setSize" in param1)
         {
            this.overwriteProps = [];
         }
      }
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         _target = param1;
         _hasSetSize = Boolean("setSize" in _target);
         if("width" in param2 && _target.width != param2.width)
         {
            addTween(_hasSetSize ? this : _target,"width",_target.width,param2.width,"width");
            _setWidth = _hasSetSize;
         }
         if("height" in param2 && _target.height != param2.height)
         {
            addTween(_hasSetSize ? this : _target,"height",_target.height,param2.height,"height");
            _setHeight = _hasSetSize;
         }
         if(_tweens.length == 0)
         {
            _hasSetSize = false;
         }
         return true;
      }
      
      override public function set changeFactor(param1:Number) : void
      {
         updateTweens(param1);
         if(_hasSetSize)
         {
            _target.setSize(_setWidth ? this.width : _target.width,_setHeight ? this.height : _target.height);
         }
      }
   }
}
