package com.taomee.seer2.app.processor.activity.frozen
{
   import com.taomee.seer2.app.activity.ActivityManager;
   import com.taomee.seer2.app.shoot.ShootController;
   import com.taomee.seer2.app.utils.MovieClipUtil;
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.system.ApplicationDomain;
   import org.taomee.utils.DisplayUtil;
   import org.taomee.utils.DomainUtil;
   
   public class FrozenStatus
   {
      
      private static var _status:uint;
      
      private static var _mc:MovieClip;
      
      public static var _isLoad:Boolean;
      
      private static var _loader:Loader;
      
      private static var _isFightLoad:Boolean;
      
      private static var _isFightMc:MovieClip;
      
      private static var _funList:Vector.<Function> = Vector.<Function>([]);
      
      private static var _frozenDomain:ApplicationDomain;
       
      
      public function FrozenStatus()
      {
         super();
      }
      
      public static function playAnimation1(param1:Function, param2:MovieClip) : void
      {
         var url:String;
         var url2:String = null;
         var fun:Function = param1;
         var mc:MovieClip = param2;
         ShootController.close();
         url = String(URLUtil.getActivityAnimation("8/1"));
         url2 = String(URLUtil.getActivityAnimation("8/2"));
         MovieClipUtil.playFullScreen(url,function():void
         {
            mc.gotoAndStop(76);
            MovieClipUtil.playFullScreen(url2,fun,false);
         },false);
      }
      
      public static function playAnimation2(param1:MovieClip, param2:Function) : void
      {
         var mc:MovieClip = param1;
         var fun:Function = param2;
         MovieClipUtil.playMc(mc["frozen0"],2,mc["frozen0"].totalFrames,function():void
         {
            mc.gotoAndStop(111);
            fun();
         });
      }
      
      public static function playAnimation3(param1:MovieClip, param2:Function) : void
      {
         var mc:MovieClip = param1;
         var fun:Function = param2;
         MovieClipUtil.playMc(mc["frozen1"],2,mc["frozen1"].totalFrames,function():void
         {
            mc.gotoAndStop(152);
            fun();
         });
      }
      
      public static function playAnimation4() : void
      {
         ShootController.close();
         var _loc1_:String = String(URLUtil.getActivityAnimation("8/3"));
         MovieClipUtil.playFullScreen(_loc1_,null,false);
      }
      
      public static function clearAnimation() : void
      {
         var _loc1_:String = String(URLUtil.getActivityAnimation("8/1"));
         if(ActivityManager.isPlayActivityAnimation(8,_loc1_))
         {
            return;
         }
         ActivityManager.clearSo(8,_loc1_);
      }
      
      public static function playAnimation5(param1:Function) : void
      {
         var url:String = null;
         var fun:Function = param1;
         ShootController.close();
         if(_isFightLoad == false)
         {
            url = String(URLUtil.getActivityAnimation("8/4"));
            MovieClipUtil.getSwfContent(url,function(param1:MovieClip):void
            {
               var mc:MovieClip = param1;
               _isFightMc = mc;
               _isFightLoad = true;
               LayerManager.topLayer.addChild(_isFightMc);
               MovieClipUtil.playMc(_isFightMc,2,_isFightMc.totalFrames,function():void
               {
                  DisplayUtil.removeForParent(_isFightMc);
                  fun();
               },true);
            });
         }
         else
         {
            LayerManager.topLayer.addChild(_isFightMc);
            MovieClipUtil.playMc(_isFightMc,2,_isFightMc.totalFrames,function():void
            {
               DisplayUtil.removeForParent(_isFightMc);
               fun();
            },true);
         }
      }
      
      public static function playAnimation6() : void
      {
         ShootController.close();
         var _loc1_:String = String(URLUtil.getActivityAnimation("8/5"));
         MovieClipUtil.playFullScreen(_loc1_,null,false);
      }
      
      public static function playAnimation7(param1:Function) : void
      {
         ShootController.close();
         var _loc2_:String = String(URLUtil.getActivityAnimation("8/7"));
         MovieClipUtil.playFullScreen(_loc2_,param1,false);
      }
      
      public static function getSwfContent(param1:Function) : void
      {
         var fun:Function = param1;
         _funList.push(fun);
         if(_frozenDomain == null)
         {
            QueueLoader.load(URLUtil.getActivityAnimation("8/6"),LoadType.DOMAIN,function(param1:ContentInfo):void
            {
               var _loc2_:Function = null;
               _frozenDomain = param1.content;
               for each(_loc2_ in _funList)
               {
                  _loc2_();
               }
               _funList = Vector.<Function>([]);
            });
         }
         else
         {
            fun();
         }
      }
      
      public static function getFrozen() : MovieClip
      {
         if(_frozenDomain)
         {
            return DomainUtil.getMovieClip("frozen",_frozenDomain);
         }
         return null;
      }
      
      public static function getBlood() : MovieClip
      {
         if(_frozenDomain)
         {
            return DomainUtil.getMovieClip("blood",_frozenDomain);
         }
         return null;
      }
      
      public static function getFrozenBlood(param1:uint) : MovieClip
      {
         if(_frozenDomain)
         {
            return DomainUtil.getMovieClip("grozenBlood" + param1,_frozenDomain);
         }
         return null;
      }
      
      public static function getStone() : MovieClip
      {
         if(_frozenDomain)
         {
            return DomainUtil.getMovieClip("stone",_frozenDomain);
         }
         return null;
      }
      
      public static function getBubble() : MovieClip
      {
         if(_frozenDomain)
         {
            return DomainUtil.getMovieClip("bubble",_frozenDomain);
         }
         return null;
      }
      
      public static function removeFigthMc() : void
      {
         _isFightLoad = false;
         DisplayUtil.removeForParent(_isFightMc);
         _isFightMc = null;
      }
   }
}
