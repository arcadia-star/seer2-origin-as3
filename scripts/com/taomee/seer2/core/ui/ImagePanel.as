package com.taomee.seer2.core.ui
{
   import com.greensock.TweenLite;
   import com.taomee.seer2.core.cookie.SharedObjectManager;
   import com.taomee.seer2.core.scene.ImageLevelManager;
   import com.taomee.seer2.core.scene.LayerManager;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.scene.SceneType;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Stage;
   import flash.display.StageQuality;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.media.SoundMixer;
   import flash.media.SoundTransform;
   import flash.net.SharedObject;
   import flash.utils.getDefinitionByName;
   import org.taomee.utils.AlignType;
   import org.taomee.utils.DisplayUtil;
   
   public class ImagePanel
   {
      
      private static var _mc:MovieClip;
      
      private static var _closeBtn:SimpleButton;
      
      private static var _btnList:Vector.<MovieClip>;
      
      private static var _remoteOnBtn:MovieClip;
      
      private static var _remoteOffBtn:MovieClip;
      
      private static var _soundOnBtn:MovieClip;
      
      private static var _soundOffBtn:MovieClip;
      
      private static var _stage:Stage;
      
      private static var actorManagetClass = getDefinitionByName("com.taomee.seer2.app.actor.ActorManager");
       
      
      public function ImagePanel()
      {
         super();
      }
      
      public static function showImage(param1:Stage) : void
      {
         _stage = param1;
         _mc = new UI_Image_Level();
         _closeBtn = _mc["closeBtn"];
         _closeBtn.addEventListener(MouseEvent.CLICK,onClose);
         initImage();
         initRemote();
         initSound();
         param1.addChild(_mc);
         DisplayUtil.align(_mc,AlignType.MIDDLE_CENTER,new Rectangle(0,0,param1.stageWidth,param1.stageHeight));
      }
      
      private static function initSound() : void
      {
         _soundOnBtn = _mc["soundOnBtn"];
         _soundOffBtn = _mc["soundOffBtn"];
         _soundOnBtn.buttonMode = true;
         _soundOffBtn.buttonMode = true;
         var _loc1_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.USER_SETTING);
         if(_loc1_.data["sound"] == null || _loc1_.data["sound"] == 1)
         {
            _loc1_.data["sound"] = 1;
            _soundOnBtn.gotoAndStop(2);
            _soundOffBtn.gotoAndStop(1);
         }
         else
         {
            _soundOnBtn.gotoAndStop(1);
            _soundOffBtn.gotoAndStop(2);
         }
         _soundOnBtn.addEventListener(MouseEvent.CLICK,onSoundOn);
         _soundOffBtn.addEventListener(MouseEvent.CLICK,onSoundOff);
      }
      
      private static function onSoundOn(param1:MouseEvent) : void
      {
         var _loc2_:SoundTransform = new SoundTransform(1);
         SoundMixer.soundTransform = _loc2_;
         writeSoundCookie(true);
      }
      
      private static function onSoundOff(param1:MouseEvent) : void
      {
         var _loc2_:SoundTransform = new SoundTransform(0);
         SoundMixer.soundTransform = _loc2_;
         writeSoundCookie(false);
      }
      
      private static function writeSoundCookie(param1:Boolean) : void
      {
         var _loc2_:SharedObject = SharedObjectManager.getUserSharedObject(SharedObjectManager.USER_SETTING);
         _loc2_.data["sound"] = param1 ? 1 : 0;
         SharedObjectManager.flush(_loc2_);
         if(param1)
         {
            _soundOnBtn.gotoAndStop(2);
            _soundOffBtn.gotoAndStop(1);
         }
         else
         {
            _soundOnBtn.gotoAndStop(1);
            _soundOffBtn.gotoAndStop(2);
         }
      }
      
      private static function initRemote() : void
      {
         _remoteOnBtn = _mc["remoteOnBtn"];
         _remoteOffBtn = _mc["remoteOffBtn"];
         _remoteOnBtn.buttonMode = true;
         _remoteOffBtn.buttonMode = true;
         updateRemote();
         _remoteOnBtn.addEventListener(MouseEvent.CLICK,onRemoteOn);
         _remoteOffBtn.addEventListener(MouseEvent.CLICK,onRemoteOff);
      }
      
      private static function onRemoteOn(param1:MouseEvent) : void
      {
         actorManagetClass.showRemoteActor = true;
         updateRemote();
      }
      
      private static function onRemoteOff(param1:MouseEvent) : void
      {
         actorManagetClass.showRemoteActor = false;
         updateRemote();
      }
      
      private static function updateRemote() : void
      {
         if(actorManagetClass.showRemoteActor)
         {
            _remoteOnBtn.gotoAndStop(2);
            _remoteOffBtn.gotoAndStop(1);
         }
         else
         {
            _remoteOnBtn.gotoAndStop(1);
            _remoteOffBtn.gotoAndStop(2);
         }
      }
      
      private static function initImage() : void
      {
         _btnList = Vector.<MovieClip>([]);
         var _loc1_:int = 0;
         while(_loc1_ < 3)
         {
            _btnList.push(_mc["btn" + _loc1_]);
            _btnList[_loc1_].buttonMode = true;
            _btnList[_loc1_].addEventListener(MouseEvent.CLICK,onClick);
            _btnList[_loc1_].gotoAndStop(1);
            _loc1_++;
         }
         if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.ARENA)
         {
            _btnList[getQualityIndex(ImageLevelManager.getFightImageQuality())].gotoAndStop(2);
         }
         else
         {
            _btnList[getQualityIndex(ImageLevelManager.getImageQuality())].gotoAndStop(2);
         }
      }
      
      private static function getQualityIndex(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case StageQuality.LOW:
               _loc2_ = 0;
               break;
            case StageQuality.MEDIUM:
               _loc2_ = 1;
               break;
            case StageQuality.HIGH:
               _loc2_ = 2;
         }
         return _loc2_;
      }
      
      private static function onClick(param1:MouseEvent) : void
      {
         var _loc3_:MovieClip = null;
         var _loc4_:String = null;
         var _loc2_:int = _btnList.indexOf(param1.currentTarget as MovieClip);
         for each(_loc3_ in _btnList)
         {
            _loc3_.gotoAndStop(1);
         }
         _btnList[_loc2_].gotoAndStop(2);
         switch(_loc2_)
         {
            case 0:
               _loc4_ = StageQuality.LOW;
               break;
            case 1:
               _loc4_ = StageQuality.MEDIUM;
               break;
            case 2:
               _loc4_ = StageQuality.HIGH;
         }
         if(Boolean(SceneManager.active) && SceneManager.active.type == SceneType.ARENA)
         {
            ImageLevelManager.setFightImageLevel(_loc4_);
         }
         else
         {
            ImageLevelManager.setImageLevel(_loc4_);
         }
      }
      
      private static function onClose(param1:MouseEvent) : void
      {
         var bitmap:Bitmap = null;
         var bitmapData:BitmapData = null;
         var remove:Function = null;
         var event:MouseEvent = param1;
         remove = function():void
         {
            _stage.removeChild(bitmap);
            bitmap = null;
            bitmapData.dispose();
            bitmapData = null;
         };
         bitmap = new Bitmap();
         bitmapData = new BitmapData(_mc.width,_mc.height,true,0);
         bitmapData.draw(_mc);
         bitmap.bitmapData = bitmapData;
         _stage.addChild(bitmap);
         bitmap.x = _mc.x;
         bitmap.y = _mc.y;
         TweenLite.to(bitmap,1,{
            "x":LayerManager.stage.stageWidth / 2 - 70,
            "y":LayerManager.stage.stageHeight - 35,
            "scaleX":0.05,
            "scaleY":0.05,
            "onComplete":remove
         });
         _stage.removeChild(_mc);
         ImageLevelManager._isShow = false;
      }
   }
}
