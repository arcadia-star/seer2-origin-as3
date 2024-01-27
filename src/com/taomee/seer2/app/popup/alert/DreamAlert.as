package com.taomee.seer2.app.popup.alert {
import com.taomee.seer2.app.activeCount.ActiveCountManager;
import com.taomee.seer2.app.dialog.NpcDialog;
import com.taomee.seer2.app.dream.DreamMapInfo;
import com.taomee.seer2.app.dream.DreamMapOrganize;
import com.taomee.seer2.app.dream.DreamOneEntry;
import com.taomee.seer2.app.info.BuyPropInfo;
import com.taomee.seer2.app.info.DayLimitListInfo;
import com.taomee.seer2.app.inventory.ItemManager;
import com.taomee.seer2.app.inventory.events.ItemEvent;
import com.taomee.seer2.app.manager.DayLimitListManager;
import com.taomee.seer2.app.net.CommandSet;
import com.taomee.seer2.app.net.Connection;
import com.taomee.seer2.app.net.parser.Parser_1224;
import com.taomee.seer2.app.popup.AlertInfo;
import com.taomee.seer2.app.popup.AlertManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferManager;
import com.taomee.seer2.app.serverBuffer.ServerBufferType;
import com.taomee.seer2.app.shopManager.ShopManager;
import com.taomee.seer2.app.swap.SwapManager;
import com.taomee.seer2.app.swap.info.SwapInfo;
import com.taomee.seer2.app.swap.special.SpecialInfo;
import com.taomee.seer2.app.utils.ActsHelperUtil;
import com.taomee.seer2.core.config.DreamConfig;
import com.taomee.seer2.core.config.DreamInfo;
import com.taomee.seer2.core.config.FamilyInfo;
import com.taomee.seer2.core.module.ModuleManager;
import com.taomee.seer2.core.net.MessageEvent;
import com.taomee.seer2.core.scene.LayerManager;
import com.taomee.seer2.core.scene.SceneManager;
import com.taomee.seer2.core.scene.SceneType;
import com.taomee.seer2.core.ui.UIManager;
import com.taomee.seer2.core.utils.DisplayObjectUtil;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.display.SimpleButton;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.utils.IDataInput;

import org.taomee.filter.ColorFilter;

public class DreamAlert extends Sprite implements IAlert {


    private var _container:MovieClip;

    private var _closeBtn:SimpleButton;

    private var _nameTxt:TextField;

    private var _starMC:MovieClip;

    private var _pointTxtList:Vector.<TextField>;

    private var _conditionsList:Vector.<TextField>;

    private var _iconList:Vector.<DreamMiniPetIcon>;

    private var _itemList:Vector.<DreamMiniItemIcon>;

    private var _fightCountTxt:TextField;

    private var _fightCountBtn:SimpleButton;

    private var _entryFightBtn:SimpleButton;

    private var _autoFightBtn:SimpleButton;

    private var _dreamInfo:DreamInfo;

    private var _confirmHandler:Function;

    private var _cancelHandler:Function;

    private var _entryMapBtn:SimpleButton;

    private var _threeMC:MovieClip;

    private var _dreamOneMC:MovieClip;

    private var _dreamOneMC2:MovieClip;

    public function DreamAlert() {
        super();
        this.initialize();
    }

    private function initialize():void {
        this._container = UIManager.getMovieClip("UI_dream_mini_panel");
        addChild(this._container);
        this._closeBtn = this._container["closeBtn"];
        this._nameTxt = this._container["nameTxt"];
        this._pointTxtList = Vector.<TextField>([]);
        this._fightCountTxt = this._container["fightCountTxt"];
        this._fightCountBtn = this._container["fightCountBtn"];
        this._autoFightBtn = this._container["autoFightBtn"];
        this._starMC = this._container["starMC"];
        this._iconList = Vector.<DreamMiniPetIcon>([]);
        this._itemList = Vector.<DreamMiniItemIcon>([]);
        this._entryMapBtn = this._container["entryMapBtn"];
        this._threeMC = this._container["threeMC"];
        this._threeMC.visible = false;
        this._dreamOneMC = this._container["dreamOneMC"];
        this._dreamOneMC.mouseChildren = false;
        this._dreamOneMC.mouseEnabled = false;
        this._dreamOneMC.visible = false;
        this._dreamOneMC2 = this._container["dreamOneMC2"];
        this._dreamOneMC2.mouseChildren = false;
        this._dreamOneMC2.mouseEnabled = false;
        this._dreamOneMC2.visible = false;
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            this._iconList.push(new DreamMiniPetIcon(this._container["dreamMiniPet" + _loc1_]));
            this._itemList.push(new DreamMiniItemIcon(this._container["dreamMiniItem" + _loc1_]));
            this._pointTxtList.push(this._container["pointTxt" + _loc1_]);
            _loc1_++;
        }
        this.initEvent();
    }

    private function initEvent():void {
        this._closeBtn.addEventListener(MouseEvent.CLICK, this.onClickHandler);
        this._fightCountBtn.addEventListener(MouseEvent.CLICK, this.onFightCount);
        this._autoFightBtn.addEventListener(MouseEvent.CLICK, this.onAuto);
        this._entryMapBtn.addEventListener(MouseEvent.CLICK, this.onEntryMap);
    }

    private function onEntryMap(param1:MouseEvent):void {
        Connection.addCommandListener(CommandSet.DREAM_MAP_INFO_LIST_1562, this.onFamilyInfo);
        Connection.send(CommandSet.DREAM_MAP_INFO_LIST_1562);
    }

    private function onFamilyInfo(param1:MessageEvent):void {
        var data:IDataInput;
        var count:int;
        var i:int;
        var starCount:int;
        var currFamilyInfo:FamilyInfo = null;
        var familyInfo:FamilyInfo = null;
        var event:MessageEvent = param1;
        Connection.removeCommandListener(CommandSet.DREAM_MAP_INFO_LIST_1562, this.onFamilyInfo);
        data = event.message.getRawData();
        count = int(data.readUnsignedInt());
        i = 0;
        while (i < count) {
            familyInfo = DreamConfig.getFamily(i + 1);
            familyInfo.currStarCount = data.readUnsignedInt();
            if (i == this._dreamInfo.familyId - 1) {
                currFamilyInfo = familyInfo;
            }
            i++;
        }
        data.readUnsignedInt();
        starCount = this._dreamInfo.familyId == 4 ? 24 : 29;
        if (Boolean(this._dreamInfo.isWelfare) && currFamilyInfo.currStarCount < starCount) {
            AlertManager.showAlert("需要" + starCount + "颗星才能挑战");
            return;
        }
        this.currKeyCount(function (param1:int):void {
            var count:int = param1;
            if (count > 0) {
                Connection.addCommandListener(CommandSet.DREAM_ENTRY_MAP_1557, onEntryMap1557);
                if (ItemManager.getSpecialItem(605616)) {
                    SwapManager.swapItem(3834, 1, function (param1:IDataInput):void {
                        new SwapInfo(param1);
                        Connection.send(CommandSet.DREAM_ENTRY_MAP_1557, _dreamInfo.id);
                    }, null, new SpecialInfo(1, _dreamInfo.id));
                    return;
                }
                Connection.send(CommandSet.DREAM_ENTRY_MAP_1557, _dreamInfo.id);
            } else {
                AlertManager.showAlert("梦境钥匙不足");
            }
        });
    }

    private function onClickHandler(param1:MouseEvent):void {
        this.dispose();
        if (this._cancelHandler != null) {
            this._cancelHandler();
        }
    }

    private function onEntryMap1557(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DREAM_ENTRY_MAP_1557, this.onEntryMap1557);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:DreamMapInfo = new DreamMapInfo(_loc2_);
        DreamMapOrganize.setInfo(_loc3_);
        this.dispose();
        if (this._dreamOneMC2) {
            this._dreamOneMC2.visible = false;
            ServerBufferManager.updateServerBuffer(ServerBufferType.DREAM_ONE_ENTRY, 3, 1);
        }
        SceneManager.changeScene(SceneType.LOBBY, this._dreamInfo.mapId);
    }

    private function onFightCount(param1:MouseEvent):void {
        if (this._dreamInfo.isWelfare) {
            AlertManager.showAlert("福利关卡不能购买次数");
            return;
        }
        var _loc2_:BuyPropInfo = new BuyPropInfo();
        _loc2_.itemId = 605616;
        _loc2_.buyComplete = this.buyComplete;
        _loc2_.cancelFunc = this.onCancel;
        ShopManager.buyVirtualItem(_loc2_);
        this.visible = false;
    }

    private function onCancel():void {
        LayerManager.resetOperation();
    }

    private function buyComplete(param1:Parser_1224):void {
        var par:Parser_1224 = param1;
        SwapManager.swapItem(3834, 1, function (param1:IDataInput):void {
            new SwapInfo(param1);
            updateDream();
        }, null, new SpecialInfo(1, this._dreamInfo.id));
        this.visible = true;
    }

    private function onAuto(param1:MouseEvent):void {
        var event:MouseEvent = param1;
        if (this._dreamInfo.isWelfare) {
            AlertManager.showAlert("福利关卡不能自动对战");
            return;
        }
        this.currKeyCount(function (param1:int):void {
            var count:int = param1;
            if (count > 0) {
                ItemManager.requestItemList(function ():void {
                    if (ItemManager.getItemQuantityByReferenceId(401153) <= 0) {
                        AlertManager.showConfirm("没有自动挑战卷了！是否购买？", function ():void {
                            dispose();
                            ModuleManager.showModule(URLUtil.getAppModule("DreamCheckPanel"), "");
                        });
                        return;
                    }
                    Connection.addCommandListener(CommandSet.DREAM_AUTO_FIGHT_1559, onDreamAuto);
                    Connection.send(CommandSet.DREAM_AUTO_FIGHT_1559, _dreamInfo.id);
                });
            } else {
                AlertManager.showAlert("梦境钥匙不足");
            }
        });
    }

    private function currKeyCount(param1:Function):void {
        var fun:Function = param1;
        ActiveCountManager.requestActiveCount(250005, function (param1:uint, param2:uint):void {
            var type:uint = param1;
            var count:uint = param2;
            DayLimitListManager.getDaylimitList([1658, 1659], function (param1:DayLimitListInfo):void {
                var info:DayLimitListInfo = param1;
                ItemManager.requestItemList(function ():void {
                    fun(ActsHelperUtil.getCanNum(info.dayLimitList[0].count, count, 20));
                });
            });
        });
    }

    private function onDreamAuto(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DREAM_AUTO_FIGHT_1559, this.onDreamAuto);
        this.dispose();
        ModuleManager.closeAll();
        ModuleManager.showModule(URLUtil.getAppModule("DreamMainPanel"), "");
    }

    public function show(param1:AlertInfo):void {
        this._dreamInfo = DreamConfig.getMapInfo(uint(param1.initInfo.message));
        ItemManager.addEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.onSuccess);
        ItemManager.requestSpecialItemList();
        this._nameTxt.text = this._dreamInfo.name;
        if (this._dreamInfo.isWelfare) {
            this._pointTxtList[0].visible = false;
            this._pointTxtList[1].visible = false;
            this._pointTxtList[2].y = 153;
        } else {
            this._pointTxtList[0].visible = true;
            this._pointTxtList[1].visible = true;
            this._pointTxtList[2].y = 198;
        }
        AlertManager.addPopUp(param1, this);
        if (this._dreamInfo.id == 1) {
            this.updateDreamOne();
        }
    }

    private function updateDreamOne():void {
        this._dreamOneMC.visible = false;
        this._dreamOneMC2.visible = false;
        DreamOneEntry.getCurrQuestIndex(function (param1:int):void {
            var index:int = param1;
            if (index == 3) {
                _dreamOneMC.visible = true;
                NpcDialog.show(766, "小梦", [[0, "要在梦境中获得最高评价必须要达到规定的条件哦！带上我与你一起参战吧！"]], ["（带上小梦之后进入挑战）"], [function ():void {
                    _dreamOneMC.visible = false;
                    _dreamOneMC2.visible = true;
                }]);
            }
        });
    }

    private function onSuccess(param1:ItemEvent):void {
        ItemManager.removeEventListener1(ItemEvent.REQUEST_SPECIAL_ITEM_SUCCESS, this.onSuccess);
        this.updateDream();
    }

    private function updateDream():void {
        var _loc1_:int = 0;
        while (_loc1_ < 3) {
            if (this._dreamInfo.bossList.length > _loc1_) {
                this._iconList[_loc1_].setInfo(this._dreamInfo.bossList[_loc1_]);
            } else {
                this._iconList[_loc1_].dispose();
            }
            if (this._dreamInfo.itemList.length > _loc1_) {
                this._itemList[_loc1_].setInfo(this._dreamInfo.itemList[_loc1_]);
            } else {
                this._itemList[_loc1_].dispose();
            }
            _loc1_++;
        }
        if (this._dreamInfo.isWelfare) {
            this._pointTxtList[2].text = this._dreamInfo.threeStar;
        } else {
            this._pointTxtList[2].text = "3星条件：" + this._dreamInfo.threeStar;
        }
        Connection.addCommandListener(CommandSet.DREAM_MAP_INFO_ONE_1564, this.onDreamFamilyInfoOne);
        Connection.send(CommandSet.DREAM_MAP_INFO_ONE_1564, this._dreamInfo.id);
    }

    private function onDreamFamilyInfoOne(param1:MessageEvent):void {
        Connection.removeCommandListener(CommandSet.DREAM_MAP_INFO_ONE_1564, this.onDreamFamilyInfoOne);
        var _loc2_:IDataInput = param1.message.getRawData();
        var _loc3_:int = int(_loc2_.readUnsignedInt());
        var _loc4_:int = int(_loc2_.readUnsignedInt());
        this._starMC.gotoAndStop(_loc3_ + 1);
        var _loc5_:int = 0;
        while (_loc5_ < _loc3_) {
            ColorFilter.setGrayscale(this._pointTxtList[_loc5_]);
            _loc5_++;
        }
        var _loc6_:int = !!ItemManager.getSpecialItem(605616) ? int(ItemManager.getSpecialItem(605616).quantity) : 0;
        this._fightCountTxt.text = _loc4_ >= 999 ? "不限制次数" : "本关次数上限:" + String(_loc4_ + _loc6_);
        if ((_loc4_ += _loc6_) >= 999) {
            DisplayObjectUtil.disableButton(this._fightCountBtn);
        } else {
            DisplayObjectUtil.enableButton(this._fightCountBtn);
        }
        if (_loc4_ <= 0) {
            DisplayObjectUtil.disableButton(this._entryMapBtn);
        } else {
            DisplayObjectUtil.enableButton(this._entryMapBtn);
        }
        if (_loc3_ == 3) {
            DisplayObjectUtil.enableButton(this._autoFightBtn);
            this._threeMC.visible = false;
        } else {
            DisplayObjectUtil.disableButton(this._autoFightBtn);
            this._threeMC.visible = true;
        }
    }

    public function dispose():void {
        if (this._closeBtn) {
            this._closeBtn.removeEventListener(MouseEvent.CLICK, this.onClickHandler);
        }
        if (this._fightCountBtn) {
            this._fightCountBtn.removeEventListener(MouseEvent.CLICK, this.onFightCount);
        }
        if (this._autoFightBtn) {
            this._autoFightBtn.removeEventListener(MouseEvent.CLICK, this.onAuto);
        }
        this._closeBtn = null;
        this._fightCountBtn = null;
        this._autoFightBtn = null;
        AlertManager.removePopUp(this);
        this.dispatchEvent(new Event(Event.CLOSE));
    }
}
}

import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.PetConfig;
import com.taomee.seer2.core.config.DreamPetInfo;
import com.taomee.seer2.core.utils.URLUtil;

import flash.display.MovieClip;
import flash.text.TextField;

import org.taomee.utils.DisplayUtil;

class DreamMiniPetIcon {


    private var _mc:MovieClip;

    private var _levelTxt:TextField;

    private var _nameTxt:TextField;

    private var _icon:IconDisplayer;

    public function DreamMiniPetIcon(param1:MovieClip) {
        super();
        this._mc = param1;
        this._levelTxt = param1["levelTxt"];
        this._nameTxt = param1["nameTxt"];
        this._icon = new IconDisplayer();
    }

    public function setInfo(param1:DreamPetInfo):void {
        this._icon.setIconUrl(URLUtil.getPetIcon(param1.id));
        this._icon.x = 4;
        this._icon.y = 3;
        this._mc["mc"].addChild(this._icon);
        this._levelTxt.text = param1.level.toString();
        this._nameTxt.text = PetConfig.getPetDefinition(param1.id).name;
    }

    public function dispose():void {
        DisplayUtil.removeForParent(this._icon);
        this._mc.visible = false;
    }
}

import com.taomee.seer2.app.component.IconDisplayer;
import com.taomee.seer2.app.config.ItemConfig;
import com.taomee.seer2.core.config.DreamItemInfo;
import com.taomee.seer2.core.ui.toolTip.TooltipManager;

import flash.display.MovieClip;

import org.taomee.utils.DisplayUtil;

class DreamMiniItemIcon {


    private var _mc:MovieClip;

    private var _icon:IconDisplayer;

    public function DreamMiniItemIcon(param1:MovieClip) {
        super();
        this._mc = param1;
        this._icon = new IconDisplayer();
        this._icon.scaleX = this._icon.scaleY = 1.5;
        this._icon.x = 3;
    }

    public function setInfo(param1:DreamItemInfo):void {
        this._icon.setIconUrl(ItemConfig.getItemIconUrl(param1.id));
        this._mc["mc"].addChild(this._icon);
        TooltipManager.addCommonTip(this._icon, ItemConfig.getItemName(param1.id));
    }

    public function dispose():void {
        DisplayUtil.removeForParent(this._icon);
        this._mc.visible = false;
    }
}
