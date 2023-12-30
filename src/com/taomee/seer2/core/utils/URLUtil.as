package com.taomee.seer2.core.utils
{
   import com.taomee.seer2.core.config.ClientConfig;
   import com.taomee.seer2.core.manager.VersionManager;
   import flash.utils.getDefinitionByName;
   
   public class URLUtil
   {
      
      public static const POSTFIX_XML:String = ".xml";
      
      public static const POSTFIX_SWF:String = ".swf";
      
      public static const POSTFIX_MP3:String = ".mp3";
      
      public static const POSTFIX_JPG:String = ".jpg";
      
      private static var _resURL:String;
      
      private static var _moduleURL:String;
      
      private static var _equipBase:String;
      
      private static var _equipPreviewBase:String;
      
      private static var _equipIconBase:String;
      
      private static var _petRelateBase:String;
      
      private static var _petRelateIconBase:String;
      
      private static var _emblemBase:String;
      
      private static var _emblemIconBase:String;
      
      private static var _featureIconBase:String;
      
      private static var _collectionBase:String;
      
      private static var _collectionIconBase:String;
      
      private static var _medalBase:String;
      
      private static var _medalIconBase:String;
      
      private static var _petSpirtTrainIconBase:String;
      
      private static var _petBase:String;
      
      private static var _nonoBase:String;
      
      private static var _nonoEquip:String;
      
      private static var _nonoPreview:String;
      
      private static var _nonoEquipIcon:String;
      
      private static var _petTrailDoor:String;
      
      private static var _petDictionary:String;
      
      private static var _petFightBase:String;
      
      private static var _petSoundBase:String;
      
      private static var _gameSoundBase:String;
      
      private static var _skillEffectBase:String;
      
      private static var _skillSideEffectIconBase:String;
      
      private static var _skillMusicBase:String;
      
      private static var _petIconBase:String;
      
      private static var _petDemoBase:String;
      
      private static var _questMusicBase:String;
      
      private static var _questAnimationBase:String;
      
      private static var _activityAnimationBase:String;
      
      private static var _activityIconBase:String;
      
      private static var _activityFullScreenBase:String;
      
      private static var _activityNpcTalkBase:String;
      
      private static var _activityNoticeBase:String;
      
      private static var _activityNoticeNewBase:String;
      
      private static var _activityWanWangBattleBase:String;
      
      private static var _activityMoreEnjoy:String;
      
      private static var _animationBase:String;
      
      private static var _copyAnimationBase:String;
      
      private static var _copyFullScreenBase:String;
      
      private static var _copySceneTalkBase:String;
      
      private static var _miniGameIntroBase:String;
      
      private static var _miniGameSwfBase:String;
      
      private static var _miniGameIconBase:String;
      
      private static var _petPotentialIconBase:String;
      
      private static var _firstTeachBase:String;
      
      private static var _specialIconBase:String;
      
      private static var _shootSoundBase:String;
      
      private static var _activityXmlBase:String;
      
      private static var _petInfoBase:String;
      
      private static var _diceMapBase:String;
      
      private static var _moduleResBase:String;
      
      public static var  rewrite:Function;

      {
         rewrite = function (param1:String):String {
            return param1;
         }
         initialize();
      }
      
      public function URLUtil()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _moduleURL = "module/";
         _resURL = "res/";
         _moduleResBase = _resURL + "module/";
         _equipBase = _resURL + "item/equip/swf/";
         _equipPreviewBase = _resURL + "item/equip/preview/";
         _equipIconBase = _resURL + "item/equip/icon/";
         _petRelateBase = _resURL + "item/pet/swf/";
         _petRelateIconBase = _resURL + "item/pet/icon/";
         _emblemBase = _resURL + "item/emblem/swf/";
         _emblemIconBase = _resURL + "item/emblem/icon/";
         _featureIconBase = _resURL + "item/feature/icon/";
         _collectionBase = _resURL + "item/collection/swf/";
         _collectionIconBase = _resURL + "item/collection/icon/";
         _medalBase = _resURL + "item/medal/swf/";
         _medalIconBase = _resURL + "item/medal/icon/";
         _petSpirtTrainIconBase = _resURL + "item/petSpirtTrain/icon/";
         _questAnimationBase = _resURL + "quest/";
         _activityAnimationBase = _resURL + "activity/animation/";
         _activityIconBase = _resURL + "activity/icon/";
         _activityFullScreenBase = _resURL + "activity/fullScreen/";
         _activityNpcTalkBase = _resURL + "activity/npcTalk/";
         _activityNoticeBase = _resURL + "activity/notice/";
         _activityNoticeNewBase = _resURL + "activity/noticeNew/";
         _activityWanWangBattleBase = _resURL + "activity/wwbattle/";
         _activityXmlBase = _resURL + "activity/xml/";
         _petInfoBase = _resURL + "activity/petInfo/";
         _activityMoreEnjoy = _resURL + "activity/moreEnjoy/";
         _diceMapBase = _resURL + "map/dice/";
         _animationBase = _resURL + "animation/";
         _questMusicBase = _resURL + "quest/sound/";
         _copyAnimationBase = _resURL + "copy/animation/";
         _copyFullScreenBase = _resURL + "copy/fullScreen/";
         _copySceneTalkBase = _resURL + "copy/npcTalk/";
         _petBase = _resURL + "pet/normal/";
         _petFightBase = _resURL + "pet/fight/";
         _petSoundBase = _resURL + "pet/sound/";
         _petTrailDoor = _resURL + "pet/primary/";
         _petDictionary = _resURL + "pet/dictionary/";
         _petIconBase = _resURL + "pet/icon/";
         _petDemoBase = _resURL + "pet/demo/";
         _nonoBase = _resURL + "nono/";
         _nonoEquip = _resURL + "nono/nonoEquip/";
         _nonoPreview = _resURL + "nono/nonoPreview/";
         _nonoEquipIcon = _resURL + "nono/nonoEquipIcon/";
         _gameSoundBase = _resURL + "game/sound/";
         _skillEffectBase = _resURL + "skill/effect/";
         _skillSideEffectIconBase = _resURL + "skill/sideEffect/";
         _skillMusicBase = _resURL + "skill/sound/";
         _miniGameIntroBase = _resURL + "game/intro/";
         _miniGameSwfBase = _resURL + "game/swf/";
         _miniGameIconBase = _resURL + "game/icon/";
         _petPotentialIconBase = _resURL + "pet/potential/icon/";
         _firstTeachBase = _resURL + "firstTeach/";
         _specialIconBase = _resURL + "item/special/icon/";
         _shootSoundBase = _resURL + "shoot/sound/";
      }
      
      public static function getModuleRes(param1:String) : String
      {
         var _loc2_:String = _moduleResBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getFileName(param1:String) : String
      {
         var _loc2_:int = param1.indexOf("?");
         if(_loc2_ == -1)
         {
            _loc2_ = int.MAX_VALUE;
         }
         var _loc3_:int = param1.lastIndexOf(".",_loc2_);
         var _loc4_:int = param1.lastIndexOf("/") + 1;
         return param1.substring(_loc4_,_loc3_);
      }
      
      public static function getRes(param1:String) : String
      {
         param1 = _resURL + param1;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(param1));
      }
      
      public static function getTimeNewsVersion() : String
      {
         var _loc1_:* = _resURL + "timenews/version.txt";
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getTimeNews(param1:String, param2:String) : String
      {
         var _loc3_:String = _resURL + "timenews/" + param1 + "/" + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getUISwf(param1:String) : String
      {
         var _loc2_:String = _resURL + "ui/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapConfig(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/config/" + param1 + POSTFIX_XML;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapData(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/data/" + param1 + POSTFIX_XML;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapImage(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/pics/" + param1 + POSTFIX_JPG;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getSharePic(param1:String) : String
      {
         var _loc2_:String = _resURL + "sharePic/" + param1 + POSTFIX_JPG;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getDiceMapData(param1:int) : String
      {
         var _loc2_:String = _diceMapBase + "config/" + param1.toString() + POSTFIX_XML;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getDiceMapTiles(param1:String) : String
      {
         var _loc2_:String = _diceMapBase + "tiles/" + param1;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapSwf(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/swf/" + param1;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapSoundUrl(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/sound/" + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapSignSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "map/sign/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapSignXml(param1:uint) : String
      {
         var _loc2_:String = _resURL + "map/sign/" + param1 + POSTFIX_XML;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapMineSwf(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/mine/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapSoundSetting() : String
      {
         var _loc1_:* = _resURL + "map/" + "soundSetting.xml";
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getNoticeSetting() : String
      {
         var _loc1_:* = _resURL + "notice/" + "noticeSetting.xml";
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getNpcSoundSetting() : String
      {
         var _loc1_:* = _resURL + "npc/sound/" + "npcSoundSetting.xml";
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getNpcSound(param1:String) : String
      {
         var _loc2_:String = _resURL + "npc/sound/" + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEquipSwf(param1:String) : String
      {
         var _loc2_:String = _equipBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEquipPreview(param1:String) : String
      {
         var _loc2_:String = _equipPreviewBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEquipIcon(param1:uint) : String
      {
         var _loc2_:String = _equipIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCoinsIcon() : String
      {
         return getItemIcon(1);
      }
      
      public static function getPetRelateSwf(param1:uint) : String
      {
         var _loc2_:String = _petRelateBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getSpecialIcon(param1:uint) : String
      {
         var _loc2_:String = _specialIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetRelateIcon(param1:uint) : String
      {
         var _loc2_:String = _petRelateIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEmblemSwf(param1:uint) : String
      {
         var _loc2_:String = _emblemBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEmblemIcon(param1:uint) : String
      {
         var _loc2_:String = _emblemIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getDecoratinIcon(param1:uint) : String
      {
         var _loc2_:String = _emblemIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getFeatureIcon(param1:uint) : String
      {
         var _loc2_:String = _featureIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCollectionSwf(param1:uint) : String
      {
         var _loc2_:String = _collectionBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCollectionIcon(param1:uint) : String
      {
         var _loc2_:String = _collectionIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetSpirtTrainIcon(param1:uint) : String
      {
         var _loc2_:String = _petSpirtTrainIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getItemIcon(param1:int) : String
      {
         var _loc2_:String = _resURL + "item/icon/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getTempListenerConfig() : String
      {
         var _loc1_:String = "config/tempListenerConfig.xml";
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getMeeItemIcon(param1:int) : String
      {
         var _loc2_:String = _resURL + "item/meeIcon/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getGroupIcon(param1:String, param2:int) : String
      {
         var _loc3_:String = _resURL + "itemGroup/" + param1 + "/" + param2 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getMedalSwf(param1:uint) : String
      {
         var _loc2_:String = _medalBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMedalIcon(param1:uint) : String
      {
         var _loc2_:String = _medalIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getQuestAnimation(param1:String) : String
      {
         var _loc2_:String = _questAnimationBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getQuestFullScreenAnimation(param1:String) : String
      {
         var _loc2_:String = _questAnimationBase + "fullScreen/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getQuestNpcTalkAnimation(param1:String) : String
      {
         var _loc2_:String = _questAnimationBase + "npcTalk/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getQuestResouce(param1:int, param2:String) : String
      {
         var _loc3_:String = _questAnimationBase + param1 + "/" + param2 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getQuestIntro(param1:int) : String
      {
         var _loc2_:String = _questAnimationBase + "intro/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityAnimation(param1:String) : String
      {
         var _loc2_:String = _activityAnimationBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityIcon(param1:String) : String
      {
         var _loc2_:String = _activityIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCopyAnimation(param1:String) : String
      {
         var _loc2_:String = _copyAnimationBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCopyFullScreen(param1:String) : String
      {
         var _loc2_:String = _copyFullScreenBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCopySceneTalk(param1:String) : String
      {
         var _loc2_:String = _copySceneTalkBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityFullScreen(param1:String) : String
      {
         var _loc2_:String = _activityFullScreenBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityNpcTalk(param1:String) : String
      {
         var _loc2_:String = _activityNpcTalkBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityNotice(param1:String, param2:String = ".swf") : String
      {
         var _loc3_:String = _activityNoticeBase + param1 + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getActivityNoticeNew(param1:String, param2:String = ".swf") : String
      {
         var _loc3_:String = _activityNoticeNewBase + param1 + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getActivityWWBattle(param1:String, param2:String = ".swf") : String
      {
         var _loc3_:String = _activityWanWangBattleBase + param1 + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getActivityXML(param1:String, param2:String = ".xml") : String
      {
         var _loc3_:String = _activityXmlBase + param1 + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getPetInfoSwf(param1:String, param2:String = ".swf") : String
      {
         var _loc3_:String = _petInfoBase + param1 + param2;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc3_));
      }
      
      public static function getAnimation(param1:String) : String
      {
         var _loc2_:String = _animationBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNpcSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "npc/swf/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityMoreEnjoy(param1:String) : String
      {
         var _loc2_:String = _activityMoreEnjoy + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityMobile(param1:String) : String
      {
         var _loc2_:String = _resURL + "activity/mobile/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNpcPreview(param1:String) : String
      {
         var _loc2_:String = _resURL + "npc/preview/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getActivityMonsterSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "activity/monster/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetSwf(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      private static function getResRealId(param1:uint) : uint
      {
         var _loc2_:* = getDefinitionByName("com.taomee.seer2.app.config.PetConfig").getPetDefinition(param1);
         if(_loc2_ == null)
         {
            return param1;
         }
         return _loc2_.realId;
      }
      
      public static function getActivityActorSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "activity/character/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNonoSWF(param1:uint) : String
      {
         var _loc2_:String = _nonoBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNonoEquipSwf(param1:uint) : String
      {
         var _loc2_:String = _nonoEquip + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNonoPreviewSwf(param1:uint) : String
      {
         var _loc2_:String = _nonoPreview + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getNonoEquipIconSwf(param1:uint) : String
      {
         var _loc2_:String = _nonoEquipIcon + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetFightSwf(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petFightBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getDecorationSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "pet/decoration/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetTrailDoorSWF(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petTrailDoor + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetSound(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petSoundBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getGameSound(param1:uint) : String
      {
         var _loc2_:String = _gameSoundBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getGameSoundByName(param1:String) : String
      {
         var _loc2_:String = _gameSoundBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetDictionary(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petDictionary + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMapDecorationSwf(param1:String) : String
      {
         var _loc2_:String = _resURL + "map/decoration/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getModule(param1:String) : String
      {
         param1 = _moduleURL + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(param1));
      }
      
      public static function getAppModule(param1:String) : String
      {
         var _loc2_:String = _moduleURL + "app/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getSkillEffectSwf(param1:String) : String
      {
         var _loc2_:String = _skillEffectBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getSkillSideEffectIcon(param1:uint) : String
      {
         var _loc2_:String = _skillSideEffectIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getSkillSound(param1:String) : String
      {
         var _loc2_:String = _skillMusicBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getQuestSound(param1:String) : String
      {
         var _loc2_:String = _questMusicBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetIcon(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetDemo(param1:uint) : String
      {
         param1 = getResRealId(param1);
         var _loc2_:String = _petDemoBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMiniGameIntro(param1:String) : String
      {
         var _loc2_:String = _miniGameIntroBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMiniGameSwf(param1:String) : String
      {
         var _loc2_:String = _miniGameSwfBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getMiniGameIcon(param1:int) : String
      {
         var _loc2_:String = _miniGameIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getPetPotentialIcon(param1:int) : String
      {
         var _loc2_:String = _petPotentialIconBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getFirstTeachAnimation(param1:String) : String
      {
         var _loc2_:String = _firstTeachBase + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getShootIcon(param1:uint) : String
      {
         var _loc2_:String = _resURL + "shoot/icon/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getShootSwf(param1:uint) : String
      {
         var _loc2_:String = _resURL + "shoot/swf/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getShootSound(param1:uint) : String
      {
         var _loc2_:String = _shootSoundBase + param1 + POSTFIX_MP3;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getTeamIcon(param1:String) : String
      {
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_resURL + "common/team/" + param1 + POSTFIX_SWF));
      }
      
      public static function getTeamEffectIcon(param1:String) : String
      {
         var _loc2_:String = _resURL + "common/team/effect/icon/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCavingNotice(param1:uint) : String
      {
         var _loc2_:String = _resURL + "cavingnotice/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getEmotionSource(param1:int) : String
      {
         var _loc2_:String = _resURL + "emotion/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getDreamSceneAnimation() : String
      {
         var _loc1_:String = _resURL + "dream/closeOpenEye" + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc1_));
      }
      
      public static function getVipUrl(param1:String) : String
      {
         var _loc2_:String = _resURL + "vip/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getTrainerUrl(param1:int) : String
      {
         var _loc2_:String = _resURL + "train/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
      
      public static function getCavingURL(param1:uint) : String
      {
         var _loc2_:String = _resURL + "caving/" + param1 + POSTFIX_SWF;
         return rewrite(ClientConfig.rootURL + VersionManager.getURL(_loc2_));
      }
   }
}
