package com.taomee.seer2.app.processor.map
{
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.map.MapModel;
   import com.taomee.seer2.core.map.MapProcessor;
   import com.taomee.seer2.core.utils.DisplayObjectUtil;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   
   public class MapProcessor_1 extends MapProcessor
   {
       
      
      private var _petAnimation:MovieClip;
      
      private var _petAnimationIndex:int;
      
      public function MapProcessor_1(param1:MapModel)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         this.initPetAnimation();
      }
      
      private function initPetAnimation() : void
      {
         this._petAnimationIndex = 1;
         this._petAnimation = _map.front["petAnimation"];
         this._petAnimation.gotoAndStop(1);
         this._petAnimation.addEventListener(MouseEvent.CLICK,this.onPetAnimationClick);
         DisplayObjectUtil.enableButtonMode(this._petAnimation);
      }
      
      private function onPetAnimationClick(param1:MouseEvent) : void
      {
         var evt:MouseEvent = param1;
         ++this._petAnimationIndex;
         DisplayObjectUtil.disableButtonMode(this._petAnimation);
         MovieClipUtil.getChildList(this._petAnimation,this._petAnimationIndex,[0],function(param1:Vector.<DisplayObject>):void
         {
            var children:Vector.<DisplayObject> = param1;
            var mc:MovieClip = children[0] as MovieClip;
            MovieClipUtil.playMc(mc,1,mc.totalFrames,function():void
            {
               if(_petAnimationIndex == 3)
               {
                  _petAnimation.removeEventListener(MouseEvent.CLICK,onPetAnimationClick);
                  DisplayObjectUtil.removeFromParent(_petAnimation);
               }
               else
               {
                  DisplayObjectUtil.enableButtonMode(_petAnimation);
               }
            },true);
         });
      }
      
      override public function dispose() : void
      {
         this._petAnimation.removeEventListener(MouseEvent.CLICK,this.onPetAnimationClick);
         this._petAnimation = null;
      }
   }
}
