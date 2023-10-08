package com.taomee.seer2.core.sound
{
   import com.taomee.seer2.core.loader.ContentInfo;
   import com.taomee.seer2.core.loader.LoadType;
   import com.taomee.seer2.core.loader.QueueLoader;
   import com.taomee.seer2.core.scene.SceneManager;
   import com.taomee.seer2.core.utils.URLUtil;
   import flash.media.SoundMixer;
   import org.taomee.ds.HashMap;
   import org.taomee.media.ListSoundPlayer;
   
   public class SoundManager
   {
      
      private static var _backSoundEnabled:Boolean = true;
      
      private static var _soundSettingData:XML;
      
      private static var _bgPlayer:com.taomee.seer2.core.sound.SceneSoundPlayer;
      
      private static var _hjPlayer:com.taomee.seer2.core.sound.SceneSoundPlayer;
      
      private static var _soundPlayerMap:HashMap;
      
      private static var _isBgPlaying:Boolean = false;
      
      {
         initialize();
      }
      
      public function SoundManager()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _bgPlayer = new com.taomee.seer2.core.sound.SceneSoundPlayer();
         _hjPlayer = new com.taomee.seer2.core.sound.SceneSoundPlayer();
         _soundPlayerMap = new HashMap();
      }
      
      public static function play(param1:String, param2:Number = 1, param3:Boolean = false, param4:Number = 0) : void
      {
         var _loc5_:ListSoundPlayer = null;
         if(isAvailable)
         {
            (_loc5_ = new ListSoundPlayer()).volume = param2;
            _loc5_.cyc = param3;
            _loc5_.addPlay(param1,param4);
            _loc5_.play();
            _soundPlayerMap.add(param1,_loc5_);
         }
      }
      
      public static function stop(param1:String) : void
      {
         var _loc2_:ListSoundPlayer = _soundPlayerMap.getValue(param1);
         if(_loc2_)
         {
            _loc2_.stop();
            _loc2_.clear();
            _soundPlayerMap.remove(param1);
         }
      }
      
      public static function set backgroundSoundEnabled(param1:Boolean) : void
      {
         _backSoundEnabled = param1;
         if(_backSoundEnabled)
         {
            playBackSound();
         }
         else
         {
            stopBackSound();
         }
      }
      
      public static function set enabled(param1:Boolean) : void
      {
         backgroundSoundEnabled = param1;
         _bgPlayer.enabled = param1;
         _hjPlayer.enabled = param1;
         if(param1 == false)
         {
            stopAll();
         }
      }
      
      public static function get isAvailable() : Boolean
      {
         return SoundMixer.soundTransform.volume != 0;
      }
      
      private static function get bgPlayer() : com.taomee.seer2.core.sound.SceneSoundPlayer
      {
         return _bgPlayer;
      }
      
      private static function stopAll() : void
      {
         var _loc2_:String = null;
         var _loc1_:Array = _soundPlayerMap.getKeys();
         for each(_loc2_ in _loc1_)
         {
            stop(_loc2_);
         }
      }
      
      private static function playBackSound() : void
      {
         if(_soundSettingData == null)
         {
            QueueLoader.load(URLUtil.getMapSoundSetting(),LoadType.TEXT,onSettingDataLoaded);
         }
         else
         {
            parseBackSound(getCurrentMapSoundSetting());
            parseHJSound(getCurrentMapHJSoundSetting());
         }
      }
      
      private static function onSettingDataLoaded(param1:ContentInfo) : void
      {
         _soundSettingData = XML(param1.content);
         parseBackSound(getCurrentMapSoundSetting());
         parseHJSound(getCurrentMapHJSoundSetting());
      }
      
      private static function getCurrentMapHJSoundSetting() : String
      {
         var _loc3_:XML = null;
         if(SceneManager.active == null)
         {
            return "";
         }
         var _loc1_:uint = uint(SceneManager.active.mapResourceID);
         var _loc2_:XMLList = _soundSettingData.elements("map");
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.attribute("id").toString() == _loc1_.toString())
            {
               return _loc3_.attribute("fxId").toString();
            }
         }
         return "";
      }
      
      private static function getCurrentMapSoundSetting() : String
      {
         var _loc3_:XML = null;
         if(SceneManager.active == null)
         {
            return "";
         }
         var _loc1_:uint = uint(SceneManager.active.mapResourceID);
         var _loc2_:XMLList = _soundSettingData.elements("map");
         for each(_loc3_ in _loc2_)
         {
            if(_loc3_.attribute("id").toString() == _loc1_.toString())
            {
               return _loc3_.attribute("musicId").toString();
            }
         }
         return "";
      }
      
      private static function parseHJSound(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         if(param1 != "")
         {
            _loc2_ = parseSoundSetting(param1);
            _loc3_ = false;
            for each(_loc4_ in _loc2_)
            {
               if(!_hjPlayer.hasURL(_loc4_.url))
               {
                  _loc3_ = true;
                  break;
               }
            }
            updateHJPlayer(_loc3_,_loc2_);
         }
         else
         {
            _hjPlayer.stop();
            _hjPlayer.clear();
         }
      }
      
      private static function parseBackSound(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         if(param1 != "")
         {
            _loc2_ = parseSoundSetting(param1);
            _loc3_ = false;
            for each(_loc4_ in _loc2_)
            {
               if(!_bgPlayer.hasURL(_loc4_.url))
               {
                  _loc3_ = true;
                  break;
               }
            }
            updateSoundPlayer(_loc3_,_loc2_);
         }
         else
         {
            _isBgPlaying = false;
            _bgPlayer.stop();
            _bgPlayer.clear();
         }
      }
      
      private static function updateHJPlayer(param1:Boolean, param2:Array) : void
      {
         updatePlayerList(param1,param2,_hjPlayer);
         if(_backSoundEnabled)
         {
            if(param1)
            {
               _hjPlayer.play();
            }
         }
         else
         {
            _hjPlayer.stop();
         }
      }
      
      private static function updateSoundPlayer(param1:Boolean, param2:Array) : void
      {
         updatePlayerList(param1,param2,_bgPlayer);
         if(_backSoundEnabled)
         {
            if(param1 || _isBgPlaying == false)
            {
               _isBgPlaying = true;
               _bgPlayer.play();
            }
         }
         else
         {
            _isBgPlaying = false;
            _bgPlayer.stop();
         }
      }
      
      private static function updatePlayerList(param1:Boolean, param2:Array, param3:com.taomee.seer2.core.sound.SceneSoundPlayer) : void
      {
         var _loc4_:Object = null;
         if(param1)
         {
            param3.clear();
            for each(_loc4_ in param2)
            {
               param3.addPlay(_loc4_.url,_loc4_.rep);
            }
         }
         else
         {
            for each(_loc4_ in param2)
            {
               param3.upDateRepInterval(_loc4_.url,_loc4_.rep);
            }
         }
      }
      
      private static function parseSoundSetting(param1:String) : Array
      {
         var _loc6_:String = null;
         var _loc7_:Array = null;
         var _loc8_:String = null;
         var _loc2_:Array = [];
         var _loc3_:Array = param1.split(",");
         var _loc4_:int = int(_loc3_.length);
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            if((_loc8_ = String((_loc7_ = (_loc6_ = String(_loc3_[_loc5_])).split(":"))[0])) != "" && _loc8_ != null)
            {
               _loc2_.push({
                  "url":URLUtil.getMapSoundUrl(_loc8_),
                  "rep":Number(_loc7_[1])
               });
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      private static function stopBackSound() : void
      {
         _isBgPlaying = false;
         _bgPlayer.stop();
         _hjPlayer.stop();
      }
   }
}
