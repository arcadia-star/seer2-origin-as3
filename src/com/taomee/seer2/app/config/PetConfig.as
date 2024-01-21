package com.taomee.seer2.app.config
{
   import com.taomee.seer2.app.config.info.PetDialogInfo;
   import com.taomee.seer2.app.config.info.PetDictionaryInfo;
   import com.taomee.seer2.app.config.pet.PetDefinition;
   import com.taomee.seer2.app.config.skill.PetSkillSettingDefinition;
   import org.taomee.ds.HashMap;
   import seer2.next.entry.DynConfig;
   
   public class PetConfig
   {
      
      private static var _petXmlClass:Class = PetConfig__petXmlClass;
      
      private static var _petConfigXML:XML;
      
      private static var _dictionaryXmlClass:Class = PetConfig__dictionaryXmlClass;
      
      private static var _dictionaryConfigXML:XML;
      
      private static var _dialogXmlClass:Class = PetConfig__dialogXmlClass;
      
      private static var _dialogConfigXML:XML;
      
      private static var _petDefinitionMap:HashMap;
      
      private static var _bunchSkillSettingMap:HashMap;
      
      private static var _bunchSkillSettingMap_2:HashMap;
      
      private static var _petDefinitonInfoMap:HashMap;
      
      private static var _petDialogMap:HashMap;
      
      private static var _handbookXml:XML;
      
      private static var _petXml:XML;
      
      private static var _sloganXml:XML;
      
      private static var _maxPetResourceId:int = 0;
      
      private static var _petNewVec:Vector.<int> = new Vector.<int>();
      
      {
         initialize();
      }
      
      public function PetConfig()
      {
         super();
      }
      
      private static function initialize() : void
      {
         _petDefinitionMap = new HashMap();
         _bunchSkillSettingMap = new HashMap();
         _bunchSkillSettingMap_2 = new HashMap();
         _petDefinitonInfoMap = new HashMap();
         _petDialogMap = new HashMap();
         setup();
      }
      
      private static function setup() : void
      {
         _petConfigXML = DynConfig.petConfigXML || XML(new _petXmlClass());
         _dictionaryConfigXML = DynConfig.dictionaryConfigXML || XML(new _dictionaryXmlClass());
         _dialogConfigXML = XML(new _dialogXmlClass());
         parseData(_petConfigXML,_dictionaryConfigXML,_dialogConfigXML);
      }
      
      public static function parseData(param1:XML, param2:XML, param3:XML) : void
      {
         var _loc5_:XML = null;
         var _loc6_:XML = null;
         var _loc7_:XML = null;
         var _loc8_:XML = null;
         _sloganXml = param3;
         var _loc4_:XMLList = param2.elements("Monster");
         for each(_loc5_ in _loc4_)
         {
            parsePetDictionary(_loc5_);
         }
         _loc4_ = param3.elements("Monster");
         for each(_loc6_ in _loc4_)
         {
            parsePetDialog(_loc6_);
         }
         _loc4_ = param1.elements("Monster");
         for each(_loc7_ in _loc4_)
         {
            parsePet(_loc7_);
         }
         for each(_loc8_ in _loc4_)
         {
            parsePetBunchSkill(_loc8_);
         }
      }
      
      private static function parsePetDialog(param1:XML) : void
      {
         var _loc2_:PetDialogInfo = new PetDialogInfo();
         _loc2_.id = uint(param1.attribute("ID"));
         _loc2_.slogan0 = param1.attribute("slogan0");
         _loc2_.slogan1 = param1.attribute("slogan1");
         _petDialogMap.add(_loc2_.id,_loc2_);
      }
      
      private static function parsePetDictionary(param1:XML) : void
      {
         var _loc2_:PetDictionaryInfo = new PetDictionaryInfo();
         _loc2_.id = uint(param1.attribute("ID"));
         _loc2_.isNew = param1.attribute("isNew");
         _loc2_.Height = param1.attribute("Height");
         _loc2_.Weight = param1.attribute("Weight");
         _loc2_.Features = param1.attribute("Features");
         _loc2_.emblemID = param1.attribute("emblemID");
         _loc2_.emblem2ID = param1.attribute("emblem2ID");
         _loc2_.Foundin = param1.attribute("Foundin");
         _loc2_.intro = param1.attribute("intro");
         _loc2_.chara = param1.attribute("chara");
         _loc2_.charaPoint = param1.attribute("charaPoint");
         _loc2_.superModule = param1.attribute("superModule");
         _loc2_.getWay = param1.attribute("getWay");
         _loc2_.recommendQuality = Vector.<String>(String(param1.attribute("recommendQuality")).split(","));
         _loc2_.recommendSkill = Vector.<String>(String(param1.attribute("recommendSkill")).split(","));
         _loc2_.getWay = param1.attribute("getWay");
         _loc2_.isClose = param1.attribute("isClose");
         _loc2_.fetter = param1.attribute("fetter");
         _loc2_.changeTip = param1.attribute("changeTip");
         _petDefinitonInfoMap.add(_loc2_.id,_loc2_);
      }
      
      private static function parsePet(param1:XML) : void
      {
         var _loc23_:String = null;
         var _loc24_:String = null;
         var _loc25_:String = null;
         var _loc26_:String = null;
         var _loc27_:String = null;
         var _loc28_:uint = 0;
         var _loc29_:uint = 0;
         var _loc30_:String = null;
         var _loc31_:String = null;
         var _loc32_:String = null;
         var _loc33_:String = null;
         var _loc34_:uint = 0;
         var _loc2_:uint = uint(param1.@NumbersID);
         var _loc3_:String = String(param1.@ID);
         var _loc4_:PetDictionaryInfo = getPetDefinitionInfo(int(_loc3_));
         var _loc5_:PetDialogInfo = getPetDialogInfo(int(_loc3_));
         var _loc6_:String = param1.@DefName;
         var _loc7_:uint = addUintPropertyToResult(param1.@Type);
         var _loc8_:uint = addUintPropertyToResult(param1.@GrowthType);
         var _loc9_:uint = addUintPropertyToResult(param1.@EvolvingLv);
         var _loc10_:uint = addUintPropertyToResult(param1.@CatchRate);
         var _loc11_:uint = addUintPropertyToResult(param1.@Features);
         var _loc12_:String = param1.@gender;
         var _loc13_:uint = addUintPropertyToResult(param1.@HP);
         var _loc14_:uint = addUintPropertyToResult(param1.@Atk);
         var _loc15_:uint = addUintPropertyToResult(param1.@SpAtk);
         var _loc16_:uint = addUintPropertyToResult(param1.@Def);
         var _loc17_:uint = addUintPropertyToResult(param1.@SpDef);
         var _loc18_:uint = addUintPropertyToResult(param1.@Spd);
         var _loc19_:Boolean = param1.@FreeForbidden == "0" ? true : false;
         var _loc20_:uint = uint(param1.@StarLv);
         var _loc21_:uint = addUintPropertyToResult(param1.@ChgMonId);
         var _loc22_:uint = uint(param1.@RealId);
         if(_loc5_)
         {
            _loc23_ = _loc5_.slogan0;
            _loc24_ = _loc5_.slogan1;
         }
         if(_loc4_)
         {
            _loc25_ = _loc4_.intro;
            _loc26_ = _loc4_.Foundin;
            _loc27_ = _loc4_.Features;
            _loc28_ = addUintPropertyToResult(_loc4_.emblemID);
            _loc29_ = addUintPropertyToResult(_loc4_.isNew);
            _loc30_ = _loc4_.Height;
            _loc31_ = _loc4_.Weight;
            _loc32_ = _loc4_.chara;
            _loc33_ = _loc4_.charaPoint;
            _loc34_ = addUintPropertyToResult(_loc4_.emblem2ID);
         }
         addPetDefinition(_loc2_,uint(_loc3_),_loc6_,_loc29_,_loc7_,_loc8_,_loc32_,_loc33_,_loc9_,_loc10_,_loc30_,_loc31_,_loc11_,_loc27_,_loc28_,_loc12_,_loc26_,_loc13_,_loc14_,_loc15_,_loc16_,_loc17_,_loc18_,_loc19_,_loc25_,[_loc23_,_loc24_],_loc20_,_loc21_,_loc22_,_loc34_);
      }
      
      private static function addPetDefinition(param1:uint, param2:uint, param3:String, param4:int, param5:uint, param6:uint, param7:String, param8:String, param9:uint, param10:uint, param11:String, param12:String, param13:uint, param14:String, param15:uint, param16:String, param17:String, param18:uint, param19:uint, param20:uint, param21:uint, param22:uint, param23:uint, param24:Boolean, param25:String, param26:Array, param27:uint, param28:uint, param29:uint, param30:uint) : void
      {
         if(_maxPetResourceId < param2 && (param2 <= 1000 || param2 >= 2500 && param2 <= 3000))
         {
            _maxPetResourceId = param2;
         }
         if(param4 == 1)
         {
            _petNewVec.push(param2);
         }
         _petDefinitionMap.add(param2,new PetDefinition(param1,param2,param3,param5,param6,param7,param8,param9,param10,param11,param12,param13,param14,param15,param16,param17,param18,param19,param20,param21,param22,param23,param24,param25,param26,param27,param28,param29,param30));
      }
      
      private static function addPetSkillSettingDefinition(param1:uint, param2:uint, param3:uint, param4:String, param5:String) : void
      {
         var _loc6_:String = param1 + "_" + param2;
         var _loc7_:PetSkillSettingDefinition = new PetSkillSettingDefinition(param2,param3,param4,param5);
         _bunchSkillSettingMap.add(param2,_loc7_);
         _bunchSkillSettingMap_2.add(_loc6_,_loc7_);
      }
      
      public static function getPetDialogInfo(param1:int) : PetDialogInfo
      {
         if(_petDialogMap.containsKey(param1))
         {
            return _petDialogMap.getValue(param1) as PetDialogInfo;
         }
         return null;
      }
      
      public static function getPetDefinitionInfo(param1:int) : PetDictionaryInfo
      {
         if(_petDefinitonInfoMap.containsKey(param1))
         {
            return _petDefinitonInfoMap.getValue(param1) as PetDictionaryInfo;
         }
         return null;
      }
      
      public static function getPetDefinition(param1:int) : PetDefinition
      {
         if(_petDefinitionMap.containsKey(param1))
         {
            return _petDefinitionMap.getValue(param1) as PetDefinition;
         }
         return null;
      }
      
      public static function getPetSkillSettingDefinition(param1:uint) : PetSkillSettingDefinition
      {
         var _loc2_:uint = param1;
         if(_bunchSkillSettingMap.containsKey(_loc2_))
         {
            return _bunchSkillSettingMap.getValue(_loc2_) as PetSkillSettingDefinition;
         }
         return null;
      }
      
      public static function getPetSkillSettingDefinitionVec(param1:uint) : Vector.<PetSkillSettingDefinition>
      {
         var _loc7_:String = null;
         var _loc8_:uint = 0;
         var _loc2_:Vector.<PetSkillSettingDefinition> = new Vector.<PetSkillSettingDefinition>();
         var _loc3_:String = param1.toString();
         var _loc4_:Array;
         var _loc5_:int = int((_loc4_ = _bunchSkillSettingMap_2.getKeys()).length);
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_)
         {
            _loc8_ = uint((_loc7_ = String(_loc4_[_loc6_])).indexOf("_"));
            if(_loc7_.substr(0,_loc8_) == param1.toString())
            {
               _loc2_.push(_bunchSkillSettingMap_2.getValue(_loc7_));
            }
            _loc6_++;
         }
         return _loc2_;
      }
      
      public static function getPetCount() : int
      {
         return _maxPetResourceId;
      }
      
      public static function isPetNew(param1:int) : Boolean
      {
         if(_petNewVec.indexOf(param1) != -1)
         {
            return true;
         }
         return false;
      }
      
      public static function get petDefinitionMap() : HashMap
      {
         return _petDefinitionMap;
      }
      
      public static function getPetListByBunchId(param1:int) : Vector.<PetDefinition>
      {
         var bunchId:int = param1;
         var petList:Vector.<PetDefinition> = new Vector.<PetDefinition>();
         var petMap:Array = _petDefinitionMap.getValues();
         var i:int = 0;
         while(i < petMap.length)
         {
            if((petMap[i] as PetDefinition).bunchId == bunchId)
            {
               petList.push(petMap[i]);
            }
            if(petList.length >= 3)
            {
               break;
            }
            i++;
         }
         petList.sort(function(param1:PetDefinition, param2:PetDefinition):int
         {
            return param1.resId - param2.resId;
         });
         return petList;
      }
      
      private static function parsePetBunchSkill(param1:XML) : void
      {
         var _loc4_:XML = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc2_:uint = uint(param1.@NumbersID);
         var _loc3_:XMLList = param1.descendants("Move");
         for each(_loc4_ in _loc3_)
         {
            _loc5_ = uint(_loc4_.@ID);
            _loc6_ = uint(_loc4_.@LearningLv);
            _loc7_ = _loc4_.@SoundID;
            _loc8_ = _loc4_.@EffectID;
            addPetSkillSettingDefinition(_loc2_,_loc5_,_loc6_,_loc7_,_loc8_);
         }
      }
      
      private static function addUintPropertyToResult(param1:String) : uint
      {
         if(param1 == "")
         {
            return 0;
         }
         return uint(param1);
      }
   }
}
