package com.taomee.seer2.module.login.agent
{
   import com.taomee.seer2.module.login.util.VersionManager;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   
   public class SoundAgent
   {
      
      private static var _sound:Sound;
      
      private static var _channel:SoundChannel;
       
      
      public function SoundAgent()
      {
         super();
      }
      
      public static function play() : void
      {
         var _loc1_:String = LoaderAgent.rootUrl + VersionManager.getURL("res/map/sound/BGM_001.mp3");
         _sound = new Sound();
         _sound.load(new URLRequest(_loc1_));
         _channel = _sound.play(0,int.MAX_VALUE);
      }
      
      public static function stop() : void
      {
         _channel.stop();
      }
      
      public static function dispose() : void
      {
         if(_channel)
         {
            _channel.stop();
         }
         if(_sound)
         {
            try
            {
               _sound.close();
            }
            catch(e:Error)
            {
            }
         }
      }
   }
}
