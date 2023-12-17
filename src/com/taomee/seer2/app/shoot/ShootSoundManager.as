package com.taomee.seer2.app.shoot
{
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   
   public class ShootSoundManager
   {
      
      private static var instance:ShootSoundManager;
      
      private static var _goChannel:SoundChannel;
      
      private static var _shootSound:Sound;
       
      
      public function ShootSoundManager(param1:PrivateClass)
      {
         super();
      }
      
      public static function getInstance() : ShootSoundManager
      {
         if(instance == null)
         {
            instance = new ShootSoundManager(new PrivateClass());
         }
         return instance;
      }
      
      public function playSound(param1:int) : void
      {
         if(_goChannel != null)
         {
            _goChannel.stop();
         }
         _shootSound = new Sound();
         var _loc2_:URLRequest = new URLRequest(URLUtil.getShootSound(param1));
         _shootSound.load(_loc2_);
         _goChannel = _shootSound.play();
      }
      
      public function stopSound() : void
      {
         if(_goChannel != null)
         {
            _goChannel.stop();
         }
      }
   }
}

class PrivateClass
{
    
   
   public function PrivateClass()
   {
      super();
   }
}
