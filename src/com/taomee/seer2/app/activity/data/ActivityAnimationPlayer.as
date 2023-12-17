package com.taomee.seer2.app.activity.data
{
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.net.URLRequest;
   
   public class ActivityAnimationPlayer extends Sprite
   {
      
      public static const EVT_END:String = "end";
      
      public static const OPEN_INTERACTOR:String = "openInteractor";
      
      public static const CLOSE_INTERACTOR:String = "closeInteractor";
       
      
      private var _loader:Loader;
      
      private var _mc:MovieClip;
      
      private var _anmationPath:String;
      
      private var _anmationUrl:String;
      
      public function ActivityAnimationPlayer(param1:String)
      {
         super();
         this._anmationPath = param1;
         this.initialize();
         this.play();
      }
      
      private function initialize() : void
      {
         this._anmationUrl = URLUtil.getActivityAnimation(this._anmationPath);
         this.createChildren();
         this.closeInteraction();
      }
      
      public function closeInteraction() : void
      {
         this.mouseChildren = false;
      }
      
      public function openInteraction() : void
      {
         this.mouseChildren = true;
      }
      
      private function createChildren() : void
      {
         this._loader = new Loader();
         addChild(this._loader);
      }
      
      private function play() : void
      {
         this._loader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this._loader.load(new URLRequest(this._anmationUrl));
      }
      
      private function onLoadComplete(param1:Event) : void
      {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         this._mc = _loc2_.content as MovieClip;
         this._mc.addEventListener(Event.ENTER_FRAME,this.onAnimationPlay);
         this._mc.addEventListener(Event.CLOSE,this.onAnimationClose);
         this._mc.addEventListener(OPEN_INTERACTOR,this.onOpenInteractor);
         this._mc.addEventListener(CLOSE_INTERACTOR,this.onCloseInteractor);
      }
      
      private function onOpenInteractor(param1:Event) : void
      {
         this.openInteraction();
         param1.stopImmediatePropagation();
      }
      
      private function onCloseInteractor(param1:Event) : void
      {
         this.closeInteraction();
         param1.stopImmediatePropagation();
      }
      
      private function onAnimationPlay(param1:Event) : void
      {
         if(this._mc.currentFrame == this._mc.totalFrames)
         {
            this._mc.stop();
            this._mc.removeEventListener(Event.ENTER_FRAME,this.onAnimationPlay);
            dispatchEvent(new Event(EVT_END));
         }
      }
      
      private function onAnimationClose(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CLOSE));
         param1.stopImmediatePropagation();
      }
      
      public function dispose() : void
      {
         this._loader.unloadAndStop();
         removeChild(this._loader);
         this._mc.removeEventListener(Event.ENTER_FRAME,this.onAnimationPlay);
         this._mc.removeEventListener(OPEN_INTERACTOR,this.onOpenInteractor);
         this._mc.removeEventListener(CLOSE_INTERACTOR,this.onCloseInteractor);
         this._mc = null;
         this._loader = null;
      }
   }
}
