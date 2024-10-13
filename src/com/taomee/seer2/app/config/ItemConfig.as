package com.taomee.seer2.app.config {
import com.taomee.seer2.app.config.item.BasisItemDefinition;
import com.taomee.seer2.app.config.item.CollectionItemDefinition;
import com.taomee.seer2.app.config.item.EmblemItemDefinition;
import com.taomee.seer2.app.config.item.EquipItemDefinition;
import com.taomee.seer2.app.config.item.MedalItemDefinition;
import com.taomee.seer2.app.config.item.PetItemDefinition;
import com.taomee.seer2.app.config.item.PetSpirtTrainItemDefinition;
import com.taomee.seer2.app.config.item.SuitDefinition;
import com.taomee.seer2.app.inventory.constant.ItemCategory;
import com.taomee.seer2.app.inventory.utils.ItemCategoryUtil;
import com.taomee.seer2.core.utils.URLUtil;

import org.taomee.ds.HashMap;

import seer2.next.entry.DynConfig;

public class ItemConfig {

    private static var _itemXmlClass:Class = ItemConfig__itemXmlClass;

    private static var _itemConfigXML:XML;

    private static var _medalXmlClass:Class = ItemConfig__medalXmlClass;

    private static var _medalConfigXML:XML;

    private static var _suitXmlClass:Class = ItemConfig__suitXmlClass;

    private static var _suitConfigXML:XML;

    private static const EQUIP_ITEM_MIN:uint = 100000;

    private static const PET_ITEM_MIN:uint = 200000;

    private static const EMBLEM_ITEM_MIN:uint = 300000;

    private static const COLLECTION_ITEM_MIN:uint = 400000;

    private static const MEDAL_ITEM_MIN:uint = 500000;

    private static const ITEM_MAX:uint = 700000;

    private static const ITEM_NEXT_MAX:uint = 750000;

    private static const PET_SPIRT_MAX:uint = 805999;

    private static var _basisMap:HashMap;

    private static var _equipMap:HashMap;

    private static var _petMap:HashMap;

    private static var _emblemMap:HashMap;

    private static var _collectionMap:HashMap;

    private static var _medalMap:HashMap;

    private static var _suitMap:HashMap;

    private static var _petSpirtTrainMap:HashMap;

    private static var _itemID:uint;

    private static var _previousType:String;

    private static var _itemType:String;

    {
        initialize();
    }

    public function ItemConfig() {
        super();
    }

    public static function initialize():void {
        _basisMap = new HashMap();
        _equipMap = new HashMap();
        _petMap = new HashMap();
        _emblemMap = new HashMap();
        _collectionMap = new HashMap();
        _medalMap = new HashMap();
        _suitMap = new HashMap();
        _petSpirtTrainMap = new HashMap();
        setup();
    }

    private static function setup():void {
        _itemConfigXML = DynConfig.itemConfigXML || XML(new _itemXmlClass());
        _medalConfigXML = XML(new _medalXmlClass());
        _suitConfigXML = XML(new _suitXmlClass());
        parseData(_itemConfigXML, _medalConfigXML, _suitConfigXML);
    }

    private static function parseData(param1:XML, param2:XML, param3:XML):void {
        parseItems(param1);
        parseSuits(param3);
    }

    private static function parseSuits(param1:XML):void {
        var _loc2_:XMLList = param1.descendants("Suit");
        for each(param1 in _loc2_) {
            parseSuit(param1);
        }
    }

    private static function parseSuit(param1:XML):void {
        var _loc2_:int = int(param1.attribute("id"));
        var _loc3_:String = "";
        _suitMap.add(_loc2_, new SuitDefinition(_loc2_, parseString(param1, "name")));
    }

    public static function parseItems(param1:XML):void {
        var _loc3_:XML = null;
        var _loc2_:XMLList = param1.descendants("Item");
        for each(_loc3_ in _loc2_) {
            parseItem(_loc3_);
        }
    }

    private static function parseItem(param1:XML):void {
        _itemID = int(param1.attribute("ID").toString());
        if (_itemID > 900000) {
            return;
        }
        _previousType = _itemType;
        _itemType = getItemType(param1);
        var _loc2_:String = "";
        _loc2_ += parseItemHeader(param1);
    }

    private static function parseChild(param1:XML, param2:String, param3:String = ""):String {
        var _loc4_:String;
        if ((_loc4_ = param1.elements(param2).toString()) == "") {
            _loc4_ = param3;
        }
        return _loc4_;
    }

    private static function parseInt(param1:XML, param2:String, param3:int = 0):int {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            return param3;
        }
        return int(_loc4_);
    }

    private static function parseString(param1:XML, param2:String, param3:String = ""):String {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            _loc4_ = param3;
        }
        return _loc4_;
    }

    private static function parseBool(param1:XML, param2:String, param3:Boolean):Boolean {
        var _loc4_:String;
        if ((_loc4_ = String(param1.attribute(param2))) == "") {
            return param3;
        }
        if (_loc4_ == "0") {
            return false;
        }
        return true;
    }

    private static function parseItemHeader(param1:XML):void {
        var _loc11_:int = 0;
        var _loc2_:int = parseInt(param1, "ID");
        var _loc3_:int = parseInt(param1.parent(), "ID");
        var _loc4_:String = parseString(param1, "Name");
        var _loc5_:int = parseInt(param1, "Price", 0);
        var _loc6_:int = parseInt(param1, "CurrencyType", 1);
        var _loc7_:int = parseInt(param1, "Tradability", 0);
        var _loc8_:int = parseInt(param1, "VipTradability", 0);
        var _loc9_:Boolean = parseBool(param1, "VipOnly", false);
        var _loc10_:Boolean = parseBool(param1, "isHide", false);
        if (param1.attribute("Max").toString() == "") {
            _loc11_ = parseInt(param1.parent(), "Max");
        } else {
            _loc11_ = parseInt(param1, "Max");
        }
        var _loc12_:String = parseChild(param1, "Tip");
        var _loc13_:int = parseInt(param1, "SlotIndex", 0);
        var _loc14_:int = parseInt(param1, "SuitID", 0);
        var _loc15_:int = parseInt(param1, "LifeTime", 0);
        var _loc16_:int = parseInt(param1, "TimeLimit", 0);
        var _loc17_:int = parseInt(param1, "Bonus", 0);
        var _loc18_:int = parseInt(param1, "HP", 0);
        var _loc19_:int = parseInt(param1, "Exp", 0);
        var _loc20_:String = parseString(param1, "LevelLimit");
        var _loc21_:int = parseInt(param1, "Type", 0);
        var _loc22_:int = parseInt(param1, "SellPrice", 0);
        var _loc23_:int = parseInt(param1, "SwapId", 0);
        var _loc24_:String = parseString(param1, "Rule");
        var _loc25_:int = parseInt(param1, "Level", 0);
        var _loc26_:String = parseString(param1, "Title");
        var _loc27_:int = parseInt(param1, "BreedTime", 0);
        var _loc28_:int = parseInt(param1, "BreedMonID", 0);
        var _loc29_:int = parseInt(param1, "BreedMonLv", 0);
        var _loc30_:int = parseInt(param1, "ExchangeItemID", 0);
        var _loc31_:int = parseInt(param1, "ExchangeCount", 0);
        var _loc32_:int = parseInt(param1, "MiBuyID");
        switch (_itemType) {
            case "characteristic":
                _basisMap.add(_itemID, new BasisItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_));
                break;
            case "equip":
                _equipMap.add(_itemID, new EquipItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc13_, _loc14_, _loc15_, _loc16_));
                break;
            case "emblemItem":
                _emblemMap.add(_itemID, new EmblemItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc32_));
                break;
            case "petItem":
                _petMap.add(_itemID, new PetItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc17_, _loc18_, _loc19_, _loc20_, _loc21_, _loc22_, _loc23_));
                break;
            case "collection":
                _collectionMap.add(_itemID, new CollectionItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc24_, _loc22_, _loc21_));
                break;
            case "medalItem":
                _medalMap.add(_itemID, new MedalItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc21_, _loc25_, _loc26_));
                break;
            case "petSpirtItem":
                _petSpirtTrainMap.add(_itemID, new PetSpirtTrainItemDefinition(_loc2_, _loc3_, _loc4_, _loc5_, _loc6_, _loc7_, _loc8_, _loc9_, _loc10_, _loc11_, _loc12_, _loc21_, _loc27_, _loc28_, _loc29_, _loc30_, _loc31_));
        }
    }

    private static function getItemType(param1:XML):String {
        var _loc2_:String = null;
        if (_itemID <= EQUIP_ITEM_MIN) {
            _loc2_ = "characteristic";
        } else if (EQUIP_ITEM_MIN < _itemID && _itemID <= PET_ITEM_MIN) {
            _loc2_ = "equip";
        } else if (PET_ITEM_MIN < _itemID && _itemID <= EMBLEM_ITEM_MIN) {
            _loc2_ = "petItem";
        } else if (EMBLEM_ITEM_MIN < _itemID && _itemID <= COLLECTION_ITEM_MIN) {
            _loc2_ = "emblemItem";
        } else if (COLLECTION_ITEM_MIN < _itemID && _itemID <= MEDAL_ITEM_MIN) {
            _loc2_ = "collection";
        } else if (MEDAL_ITEM_MIN < _itemID && _itemID <= ITEM_MAX) {
            _loc2_ = "medalItem";
        } else if (ITEM_MAX < _itemID && _itemID <= ITEM_NEXT_MAX) {
            _loc2_ = "emblemItem";
        } else if (ITEM_NEXT_MAX < _itemID && _itemID <= PET_SPIRT_MAX) {
            _loc2_ = "petSpirtItem";
        }
        return _loc2_;
    }

    public static function getBasisDefinition(param1:int):BasisItemDefinition {
        if (_basisMap.containsKey(param1)) {
            return _basisMap.getValue(param1) as BasisItemDefinition;
        }
        return null;
    }

    public static function getEquipDefinition(param1:int):EquipItemDefinition {
        if (_equipMap.containsKey(param1)) {
            return _equipMap.getValue(param1) as EquipItemDefinition;
        }
        return null;
    }

    public static function getPetDefinition(param1:int):PetItemDefinition {
        if (_petMap.containsKey(param1)) {
            return _petMap.getValue(param1) as PetItemDefinition;
        }
        return null;
    }

    public static function getAllPetItemDefinition():Vector.<PetItemDefinition> {
        return Vector.<PetItemDefinition>(_petMap.getValues());
    }

    public static function getEmblemDefinition(param1:int):EmblemItemDefinition {
        if (_emblemMap.containsKey(param1)) {
            return _emblemMap.getValue(param1) as EmblemItemDefinition;
        }
        return null;
    }

    public static function getAllCollectionDefinition():Vector.<CollectionItemDefinition> {
        return Vector.<CollectionItemDefinition>(_collectionMap.getValues());
    }

    public static function getCollectionDefinition(param1:int):CollectionItemDefinition {
        if (_collectionMap.containsKey(param1)) {
            return _collectionMap.getValue(param1) as CollectionItemDefinition;
        }
        return null;
    }

    public static function getAllMedalDefinition():Vector.<MedalItemDefinition> {
        return Vector.<MedalItemDefinition>(_medalMap.getValues());
    }

    public static function getMedalDefinition(param1:int):MedalItemDefinition {
        if (_medalMap.containsKey(param1)) {
            return _medalMap.getValue(param1) as MedalItemDefinition;
        }
        return null;
    }

    public static function getSuitDefinition(param1:int):SuitDefinition {
        if (_suitMap.containsKey(param1)) {
            return _suitMap.getValue(param1) as SuitDefinition;
        }
        return null;
    }

    public static function getPetSpirtTrainDefinition(param1:int):PetSpirtTrainItemDefinition {
        if (_petSpirtTrainMap.containsKey(param1)) {
            return _petSpirtTrainMap.getValue(param1) as PetSpirtTrainItemDefinition;
        }
        return null;
    }

    public static function getItemCategory(param1:uint):uint {
        return ItemCategoryUtil.findItemCategoryByReferenceId(param1);
    }

    public static function getItemDefinition(param1:uint):BasisItemDefinition {
        var _loc3_:BasisItemDefinition = null;
        var _loc2_:uint = getItemCategory(param1);
        switch (_loc2_) {
            case ItemCategory.BASIC:
                _loc3_ = getBasisDefinition(param1);
                break;
            case ItemCategory.COLLECTION:
                _loc3_ = getCollectionDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.EMBLEM:
                _loc3_ = getEmblemDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.EQUIP:
                _loc3_ = getEquipDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.MEDAL:
                _loc3_ = getMedalDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.PET_RELATE:
                _loc3_ = getPetDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.SPECIAL_ITEM:
                _loc3_ = getMedalDefinition(param1) as BasisItemDefinition;
                break;
            case ItemCategory.PET_SPIRT_TRAIN:
                _loc3_ = getPetSpirtTrainDefinition(param1) as BasisItemDefinition;
        }
        return _loc3_;
    }

    public static function getItemName(param1:uint):String {
        var _loc2_:uint = getItemCategory(param1);
        var _loc3_:String = "";
        switch (_loc2_) {
            case ItemCategory.BASIC:
                _loc3_ = getBasisDefinition(param1).name;
                break;
            case ItemCategory.COLLECTION:
                _loc3_ = getCollectionDefinition(param1).name;
                break;
            case ItemCategory.EMBLEM:
                _loc3_ = getEmblemDefinition(param1).name;
                break;
            case ItemCategory.EQUIP:
                _loc3_ = getEquipDefinition(param1).name;
                break;
            case ItemCategory.MEDAL:
                _loc3_ = getMedalDefinition(param1).name;
                break;
            case ItemCategory.PET_RELATE:
                _loc3_ = getPetDefinition(param1).name;
                break;
            case ItemCategory.SPECIAL_ITEM:
                _loc3_ = getMedalDefinition(param1).name;
                break;
            case ItemCategory.PET_SPIRT_TRAIN:
                _loc3_ = getPetSpirtTrainDefinition(param1).name;
        }
        return _loc3_;
    }

    public static function getSuitEquipList(param1:uint):Vector.<EquipItemDefinition> {
        var _loc4_:EquipItemDefinition = null;
        var _loc2_:Vector.<EquipItemDefinition> = Vector.<EquipItemDefinition>(_equipMap.getValues());
        var _loc3_:Vector.<EquipItemDefinition> = Vector.<EquipItemDefinition>([]);
        for each(_loc4_ in _loc2_) {
            if (_loc4_.suitId == param1) {
                _loc3_.push(_loc4_);
            }
        }
        return _loc3_;
    }

    public static function getItemIconUrl(param1:uint):String {
        var _loc2_:uint = getItemCategory(param1);
        var _loc3_:String = "";
        switch (_loc2_) {
            case ItemCategory.BASIC:
                _loc3_ = String(URLUtil.getItemIcon(param1));
                break;
            case ItemCategory.COLLECTION:
                _loc3_ = String(URLUtil.getCollectionIcon(param1));
                break;
            case ItemCategory.EMBLEM:
                _loc3_ = String(URLUtil.getEmblemIcon(param1));
                break;
            case ItemCategory.EQUIP:
                _loc3_ = String(URLUtil.getEquipIcon(param1));
                break;
            case ItemCategory.MEDAL:
                _loc3_ = String(URLUtil.getMedalIcon(param1));
                break;
            case ItemCategory.PET_RELATE:
                _loc3_ = String(URLUtil.getPetRelateIcon(param1));
                break;
            case ItemCategory.SPECIAL_ITEM:
                _loc3_ = String(URLUtil.getSpecialIcon(param1));
                break;
            case ItemCategory.PET_SPIRT_TRAIN:
                _loc3_ = String(URLUtil.getPetSpirtTrainIcon(param1));
        }
        if (param1 >= 102000 && param1 < 102999) {
            _loc3_ = String(URLUtil.getNonoEquipIconSwf(param1));
        }
        return _loc3_;
    }

    public static function getMeeItemIconUrl(param1:uint):String {
        return URLUtil.getMeeItemIcon(param1);
    }
}
}
