package com.taomee.seer2.module.login.view
{
   import com.taomee.seer2.module.login.*;
   import com.taomee.seer2.module.login.agent.LoaderAgent;
   import com.taomee.seer2.module.login.loader.LoaderManager;
   import com.taomee.seer2.module.login.util.DisplayObjectUtil;
   import com.taomee.seer2.module.login.util.LoginStatistics;
   import com.taomee.seer2.module.login.util.VersionManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.ApplicationDomain;
   
   public class IntroAnimationPanel extends Sprite
   {
      
      public static const EVT_END:String = "end";
       
      
      private var _skipBtn:SimpleButton;
      
      private var _animation:MovieClip;
      
      private var _account:String;
      
      private var _url:String;
      
      public function IntroAnimationPanel(param1:String = "")
      {
         super();
         this._account = param1;
         LoginStatistics.newSendNovice("新手引导tyler版",this._account,"2014上半年版新手引导tyler版","开场动画（开始加载）");
         this._url = LoaderAgent.rootUrl + VersionManager.getURL("res/login/intro.swf");
         LoaderManager.Load(this._url,this.onLoadComplete);
      }
      
      private function onLoadComplete(param1:String, param2:ApplicationDomain, param3:DisplayObject) : void
      {
         this._animation = param3 as MovieClip;
         addChildAt(this._animation,0);
         this._skipBtn = this._animation["gotoBtn"];
         this._skipBtn.addEventListener(MouseEvent.CLICK,this.onSkipBtn);
         this._animation.addEventListener(MouseEvent.CLICK,this.onNext);
         LoginStatistics.sendNovice("0x1003467D",this._account);
      }
      
      private function onNext(param1:MouseEvent) : void
      {
         if(param1.target == this._skipBtn)
         {
            return;
         }
         this._animation.nextFrame();
         switch(this._animation.currentFrame)
         {
            case 2:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步1");
               break;
            case 3:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步2");
               break;
            case 4:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步3");
               break;
            case 5:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步4");
               break;
            case 6:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步5");
               break;
            case 7:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步6");
               break;
            case 8:
               LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画下一步7");
         }
         this.onAnimationPlay();
      }
      
      private function onSkipBtn(param1:MouseEvent) : void
      {
         LoginStatistics.newSendNovice("新手引导",this._account,"新手引导","全屏动画跳过");
         this._animation.gotoAndStop(this._animation.totalFrames);
         this.end();
         LoaderManager.cancel(this._url,this.onLoadComplete);
      }
      
      private function onAnimationPlay() : void
      {
         if(this._animation.currentFrame == this._animation.totalFrames)
         {
            this.end();
         }
      }
      
      private function end() : void
      {
         if(this._animation)
         {
            DisplayObjectUtil.removeFromParent(this._animation);
            this._animation.stop();
            this._animation.removeEventListener(Event.ENTER_FRAME,this.onAnimationPlay);
            this._animation = null;
         }
         LoginStatistics.newSendNovice("新手引导tyler版",this._account,"2014上半年版新手引导tyler版","开场动画（看完动画）");
         dispatchEvent(new Event(EVT_END));
      }
   }
}
