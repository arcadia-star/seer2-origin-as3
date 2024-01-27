package com.taomee.seer2.app.arena.decoration {
import com.taomee.seer2.app.arena.data.ArenaDataInfo;
import com.taomee.seer2.app.arena.data.FighterInfo;
import com.taomee.seer2.app.arena.resource.ResourceQueue;
import com.taomee.seer2.core.cache.CacheType;
import com.taomee.seer2.core.loader.ContentInfo;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.utils.clearTimeout;

import org.taomee.utils.DisplayUtil;

public class DecorationControl {

    public static var _isShowDecoration:Boolean = false;

    public static var _trunCount:int;

    private static var _arenaData:ArenaDataInfo;

    private static var _currCount:uint;

    private static var _endCount:uint;

    private static var _fightPetInfo:FighterInfo;

    private static var _mc:MovieClip;

    private static var _setTimeout:uint;


    public function DecorationControl() {
        super();
    }

    public static function set fightPetInfo(param1:FighterInfo):void {
        _fightPetInfo = param1;
        _isShowDecoration = true;
    }

    public static function set arenaData(param1:ArenaDataInfo):void {
        _arenaData = param1;
    }

    public static function start(param1:Sprite = null):void {
        if (_fightPetInfo.resourceId != 306 && _fightPetInfo.resourceId != 307) {
            if (param1 != null) {
                param1.addChild(_mc);
            } else {
                SceneManager.active.mapModel.front.addChild(_mc);
            }
        } else if (_fightPetInfo.resourceId == 307) {
            SceneManager.active.mapModel.ground.addChild(_mc);
            _mc.visible = false;
        } else {
            SceneManager.active.mapModel.content.addChild(_mc);
        }
        _endCount = 0;
        _currCount = 0;
    }

    public static function startLoad(param1:ResourceQueue):void {
        param1.addCache(CacheType.PET, URLUtil.getDecorationSwf(_fightPetInfo.resourceId), onLoadComplete);
    }

    public static function onLoadComplete(param1:ContentInfo):void {
        _mc = param1.content;
    }

    public static function get resId():uint {
        return _fightPetInfo.resourceId;
    }

    public static function update():void {
        var _loc1_:uint = 0;
        ++_endCount;
        if (_fightPetInfo.resourceId == 301 || _fightPetInfo.resourceId == 1296) {
            if (_fightPetInfo.maxHp / 2 < _fightPetInfo.hp && _endCount != 0 && _endCount % 5 == 0) {
                _mc.gotoAndStop(2);
            }
            if (_fightPetInfo.maxHp / 2 > _fightPetInfo.hp && _endCount != 0 && _endCount % 5 == 0) {
                _mc.gotoAndStop(3);
            }
        } else if (_fightPetInfo.resourceId == 302) {
            if (_endCount > 30) {
                _mc.gotoAndStop(30);
            } else {
                _mc.gotoAndStop(_endCount);
            }
        } else if (_fightPetInfo.resourceId == 304) {
            if (_endCount > 6) {
                _mc["bing"].gotoAndStop(6);
            } else {
                _mc["bing"].gotoAndStop(_endCount);
            }
            if (_endCount > 35) {
                _mc["wdj"].gotoAndStop(35);
            } else {
                _mc["wdj"].gotoAndStop(_endCount);
            }
        } else if (_fightPetInfo.resourceId == 306) {
            if (int(_endCount / 3) >= 17) {
                _mc["countMC"].gotoAndStop(17);
                _mc["bloodMC"].gotoAndStop(17);
            } else {
                _mc["countMC"].gotoAndStop(int(_endCount / 3) + 1);
                _mc["bloodMC"].gotoAndStop(int(_endCount / 3) + 1);
            }
            if (int(_endCount / 3) >= 10) {
                _mc["di"].gotoAndStop(10);
            } else {
                _mc["di"].gotoAndStop(int(_endCount / 3) + 1);
            }
        } else if (_fightPetInfo.resourceId == 305) {
            if (_endCount < 11) {
                _mc.gotoAndPlay(2);
                _mc["goldMC"].gotoAndStop(1);
            } else if (_endCount < 21) {
                _mc.gotoAndPlay(98);
                _mc["goldMC"].gotoAndStop(2);
            } else {
                _mc.gotoAndPlay(196);
                _mc["goldMC"].gotoAndStop(3);
            }
        } else if (_fightPetInfo.resourceId == 307) {
            if (_endCount < 6) {
                _mc.visible = false;
            } else {
                if (_endCount == 6) {
                    SceneManager.active.mapModel.ground.addChildAt(_mc, 0);
                    _mc.x = 80;
                }
                _loc1_ = uint(_endCount / 6);
                if (_loc1_ > 5) {
                    _loc1_ = 5;
                }
                _mc.visible = true;
                _mc.gotoAndStop(_loc1_);
            }
        } else if (_fightPetInfo.resourceId == 1276) {
            _mc.gotoAndStop(uint(_endCount / 6) + 1);
            if (_endCount >= 30) {
                _mc.gotoAndStop(5);
            }
        }
    }

    public static function checkMC():void {
        if (_endCount != 0 && _endCount % 5 == 0 && _mc && _fightPetInfo && _fightPetInfo.resourceId == 301) {
            _mc.gotoAndStop(1);
        }
    }

    public static function dispose():void {
        clearTimeout(_setTimeout);
        DisplayUtil.removeForParent(_mc);
        _isShowDecoration = false;
        _endCount = 0;
        _mc = null;
        _fightPetInfo = null;
    }
}
}
