package com.taomee.seer2.core.cookie {
import com.taomee.seer2.core.config.ClientConfig;
import com.taomee.seer2.core.log.Logger;

import flash.net.SharedObject;
import flash.utils.setTimeout;

public class SharedObjectManager {

    public static const VOTE:String = "vote";

    public static const ACTIVITY_ANIMATION:String = "activityAnimation";

    public static const CLIENT_LOGIN:String = "login";

    public static const USER_SETTING:String = "userSetting";

    public static const DIGGING:String = "digging";

    public static const DREAMING:String = "dreaming";

    public static const ACTIVITY:String = "activity";

    public static const SWAP:String = "swap";

    public static const BOARD_BOAT:String = "boardBoat";

    public static const TIMENEWS:String = "timeNews";

    public static const RAREPET:String = "rarePet";

    public static const NPC_MOUSE_CLICK:String = "npcMouseClick";

    public static const PET_STORAGE_TREASURE:String = "petStorageTreasure";

    public static const CHRISTMAS_PANEL_CLICK:String = "christmasPanelClick";

    public static const DOOR_DEFAULE_PETS:String = "doorDefaultPets";

    public static const SEER_GIFT_TV:String = "seerGiftTV";

    public static const SEER_GIFT_START:String = "seerGiftStart";

    public static const INVITIE_FIGHT:String = "invitieFight";

    public static const SEER_NEWS_TAG:String = "seerNewsTag";

    public static const SEER_NEWS_PAPER_TAG:String = "seerNewspaperTag";

    public static const SEER_NEWS_VIP_BTN:String = "seerNewsVipBtn";

    public static const IMAGE_LEVEL_INDEX:String = "imageLevelIndex";

    public static const IMAGE_FIGHT_LEVEL_INDEX:String = "imageFightLevelIndex";

    private static var _commonRoot:String;

    private static var _userRoot:String;

    private static var _logger:Logger;

    private static var _userId:uint;

    {
        initialize();
    }

    public function SharedObjectManager() {
        super();
    }

    private static function initialize():void {
        _commonRoot = ClientConfig.productName + "/common/";
        _logger = Logger.getLogger("SharedObjectManager");
    }

    public static function setUserId(param1:uint):void {
        _userId = param1;
        _userRoot = ClientConfig.productName + "/" + _userId + "/";
    }

    public static function getCommonSharedObject(param1:String):SharedObject {
        return SharedObject.getLocal(_commonRoot + param1, "/");
    }

    public static function getUserSharedObject(param1:String):SharedObject {
        return SharedObject.getLocal(_userRoot + param1, "/");
    }

    public static function flush(param1:SharedObject):void {
        var sharedObject:SharedObject = param1;
        setTimeout(function ():void {
            try {
                sharedObject.flush();
            } catch (e:Error) {
                _logger.error(sharedObject.toString() + " flush error" + e.message);
            }
        }, 1000);
    }
}
}
